delimiter $$
DROP PROCEDURE IF EXISTS `RecuperaScaffaleWithError` $$
CREATE DEFINER=`readonly`@`%` PROCEDURE `RecuperaScaffaleWithError`(

    IN sezione varchar(10) -- 01 / 02 .... 06
    
)
begin
	-- SHL.01A.R01A1
    declare strRicerca VARCHAR(50);
    declare tipoRep VARCHAR(5);
   	declare memTransiente VARCHAR(5);
    SET tipoRep = 'SHL';
    SET strRicerca = CONCAT('%',tipoRep,'.', sezione,'%');
    
    
    drop temporary table if exists RecordsTemp;
    create temporary table RecordsTemp as
    select 
        -- colonna tag repository
        r.tag,
        -- colonna piena
        case 
            when r.udc_now_id is null then 'NO'
            when r.udc_now_id is not null then 'SI'
        end as piena,
        -- colonna transiente
        @memTransiente := case
            when (
                not exists (
                    select 1 
                    from repository_hasmany_ingoing 
                    where repository_hasmany_ingoing.repository_id = r.id 
                      and repository_hasmany_ingoing.is_queued_op = false
                ) 
                and 
                not exists (
                    select 1 
                    from repository_hasmany_outgoing 
                    where repository_hasmany_outgoing.repository_id = r.id 
                      and repository_hasmany_outgoing.is_queued_op = false
                )
            ) then 'NO'
            when (
                exists (
                    select 1 
                    from repository_hasmany_ingoing 
                    where repository_hasmany_ingoing.repository_id = r.id 
                      and repository_hasmany_ingoing.is_queued_op = false
                ) 
                or 
                exists (
                    select 1 
                    from repository_hasmany_outgoing 
                    where repository_hasmany_outgoing.repository_id = r.id 
                      and repository_hasmany_outgoing.is_queued_op = false
                )
            ) then 'SI'
        end as transiente,
        -- colonna tag udc
        (select udc.tag 
         from udc 
         where udc.id = r.udc_now_id) as tag_udc,
         -- colonna errore
        case
            when exists (
                select 1 from activity
	    			where activity.id in (
	    			select activity_id from activity_uses_repository
	    			left join repository on activity_uses_repository.repository_id = repository.id
	    			where repository.tag = r.tag
	    		)
	    		and activity.run_state_enum <> 5
	    		and @memTransiente = 'SI') then 'SI'
            else 'NO'
        end as errore,
        -- colonna abilitata
         case 
	     	when r.is_disabled = 0 then 'SI'
            when r.is_disabled = 1 then 'NO'
       	 end as abilitata,
        -- colonna prenotata (placeholder, aggiungi logica se necessario)
        case  
            when exists  (
                select 1 
                from repository_hasmany_ingoing 
                where repository_hasmany_ingoing.repository_id = r.id 
                  and repository_hasmany_ingoing.is_queued_op = true
            ) 
            or exists (
                select 1 
                from repository_hasmany_outgoing 
                where repository_hasmany_outgoing.repository_id = r.id 
                  and repository_hasmany_outgoing.is_queued_op = true
            ) then 'SI'
            else 'NO'
        end as prenotata
    from 
        repository r
	where
		r.tag LIKE strRicerca;
        
       select * from RecordsTemp;
END
$$
delimiter ;
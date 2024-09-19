delimiter $$
DROP PROCEDURE IF EXISTS `RecuperaScaffale` $$

CREATE DEFINER=`readonly`@`%` PROCEDURE `RecuperaScaffale`(

    IN sezione varchar(10) -- 01 / 02 .... 06
    
)
begin
	-- SHL.01A.R01A1
    DECLARE strRicerca VARCHAR(50);
    DECLARE tipoRep VARCHAR(5);
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
        case
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
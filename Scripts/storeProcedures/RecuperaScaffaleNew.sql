delimiter $$

DROP PROCEDURE IF EXISTS `RecuperaScaffaleNew` $$
CREATE DEFINER=`readonly`@`%` PROCEDURE `RecuperaScaffaleNew`(

    IN settore varchar(10),
    IN scaffale varchar(10)
    
)
begin

    DECLARE strRicerca VARCHAR(50);

    SET strRicerca = CONCAT('%', settore, '%','%', scaffale, '%');
    
    
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
	     	when r.is_disabled = 1 then 'NO'
            when r.is_disabled = 0 then 'SI'
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
        
		select strRicerca;
       select * from RecordsTemp;
END
$$
delimiter ;
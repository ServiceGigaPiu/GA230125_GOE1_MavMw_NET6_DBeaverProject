delimiter $$
DROP PROCEDURE IF EXISTS `RecuperaRepoAssociato` $$
CREATE DEFINER=`readonly`@`%` PROCEDURE `RecuperaRepoAssociato`(
    IN input_tag VARCHAR(50)
)
BEGIN  
    DECLARE repo_id INT;
    declare udcId_in INT;
   	declare udcId_out INT;
   	declare udcToBeChecked INT;
    -- Prima query: recupero l'ID del repository in base al tag
    SELECT id
    INTO repo_id
    FROM devdb.repository
    WHERE tag = input_tag;
    -- Se l'ID del repository non è stato trovato, esco
    IF repo_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Repository not found';
    END IF;
    -- Seconda query: recupero tutte le righe da repository_hasmany_ingoing
    SELECT udc_id 
    into udcId_in
    FROM devdb.repository_hasmany_ingoing
    WHERE repository_id = repo_id;
    -- Terza query: recupero tutte le righe da repository_hasmany_outgoing
    SELECT udc_id 
    into udcId_out
    FROM devdb.repository_hasmany_outgoing
    WHERE repository_id = repo_id;
   -- Assegno a udcId il valore di repo_id o alternative_id usando il CASE
    SET udcToBeChecked = 
    		CASE 
                  WHEN udcId_in IS NOT NULL AND udcId_out IS NULL THEN udcId_in
                  WHEN udcId_out IS NOT NULL AND udcId_in IS NULL THEN udcId_out
                     ELSE NULL
            END;
    -- Quarta query: recupero il tag dall'UDC
    SELECT tag
    FROM devdb.udc
    WHERE id = udcToBeChecked;

END
$$
delimiter ;
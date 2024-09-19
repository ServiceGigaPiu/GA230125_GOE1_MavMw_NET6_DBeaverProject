delimiter $$
DROP PROCEDURE IF EXISTS `RecuperaScaffaleWithError` $$
CREATE DEFINER=`readonly`@`%` PROCEDURE `RecuperaScaffaleWithError`(

    IN laneIdxString varchar(10) -- 01 / 02 .... 06
    
)
BEGIN
	#SELECT repositories with at least 1 related ongoing activity
	DROP TEMPORARY TABLE IF EXISTS repo_with_activity;
	CREATE TEMPORARY TABLE repo_with_activity AS
		SELECT activity_uses_repository.*
		FROM activity_uses_repository
		LEFT JOIN activity ON activity.id = activity_uses_repository.activity_id
		LEFT JOIN repository ON repository.id = activity_uses_repository.repository_id
		WHERE activity.run_state_enum > 0 AND activity.run_state_enum < 5
	;
	
	#SELECT repositories with at least 1 ingoing or outgoing udc (transient)
	DROP TEMPORARY TABLE IF EXISTS transient_repo;
	CREATE TEMPORARY TABLE transient_repo AS
		SELECT
			COALESCE(repository_hasmany_ingoing.repository_id, repository_hasmany_outgoing.repository_id) AS repository_id
		FROM repository
		LEFT JOIN repository_hasmany_ingoing ON repository_hasmany_ingoing.repository_id = repository.id
		LEFT JOIN repository_hasmany_outgoing ON repository_hasmany_outgoing.repository_id = repository.id
		WHERE (NOT ISNULL(repository_hasmany_ingoing.id)) OR (NOT ISNULL(repository_hasmany_outgoing.id))
	;
	
	#aggregate results
	DROP TEMPORARY TABLE IF EXISTS result_table;
	CREATE TEMPORARY TABLE result_table AS
	SELECT
		repository.id,
		repository.tag,
		NOT ISNULL(repository.udc_now_id) AS is_full,
		udc.tag AS held_udc_tag,		
		NOT ISNULL(transient_repo.repository_id) AS is_transient,
		repository.is_disabled,
		(NOT ISNULL(transient_repo.repository_id)) AND ISNULL(repo_with_activity.repository_id) AS is_transient_and_dead
	FROM repository
	LEFT JOIN transient_repo ON transient_repo.repository_id = repository.id
	LEFT JOIN repo_with_activity ON repo_with_activity.repository_id = repository.id
	LEFT JOIN udc ON udc.id = repository.udc_now_id
	LEFT JOIN repositoryCoordinateRaw ON repositoryCoordinateRaw.repo_id = repository.id
	WHERE repositoryCoordinateRaw.laneIdx = laneIdxString
	;
	
	#format for API consumption
	SELECT 
		tag AS tag,
		IF(is_full, "SI", "NO") AS piena,
		IF(is_transient, "SI", "NO") AS transiente,
		held_udc_tag AS tag_udc,
		IF(is_transient_and_dead, "SI", "NO") AS errore,
		IF(NOT is_disabled, "SI", "NO") AS abilitata,
		IF(is_transient, "SI", "NO") AS prenotata
	FROM result_table
	;

END
$$
delimiter ;

CALL RecuperaScaffaleWithError('01');
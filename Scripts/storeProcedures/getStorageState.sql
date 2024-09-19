delimiter $$

DROP PROCEDURE IF EXISTS `getStorageState` $$
CREATE DEFINER=`readonly`@`%` PROCEDURE `devdb`.`getStorageState`(

    IN laneIdxString VARCHAR(10), -- 01 / 02 .... 06
    IN laneSideString VARCHAR(10) -- L / R
    
)
BEGIN
    -- Dichiarazione delle variabili
    DECLARE gialla INT DEFAULT 0;
    DECLARE arancio INT DEFAULT 0;

    -- Prima query per valutare la condizione 1
    SELECT 
        EXISTS (
            SELECT 1
            FROM repository
            LEFT JOIN repository_hasmany_ingoing ON repository_hasmany_ingoing.repository_id = repository.id
            LEFT JOIN repository_hasmany_outgoing ON repository_hasmany_outgoing.repository_id = repository.id
            LEFT JOIN activity_uses_repository ON activity_uses_repository.repository_id = repository.id
            LEFT JOIN activity ON activity.id = activity_uses_repository.activity_id
            LEFT JOIN repositoryCoordinateRaw ON repositoryCoordinateRaw.repo_id = repository.id
            WHERE (repository_hasmany_ingoing.id IS NOT NULL OR repository_hasmany_outgoing.id IS NOT NULL)
              AND (activity.run_state_enum > 0 AND activity.run_state_enum < 5)
              AND repositoryCoordinateRaw.laneIdx = laneIdxString
              AND repositoryCoordinateRaw.sideOfLane = laneSideString
        ) INTO gialla;

    -- Seconda query per valutare la condizione 2
    SELECT 
        EXISTS (
            SELECT 1
            FROM repository
            LEFT JOIN repository_hasmany_ingoing ON repository_hasmany_ingoing.repository_id = repository.id
            LEFT JOIN repository_hasmany_outgoing ON repository_hasmany_outgoing.repository_id = repository.id
            LEFT JOIN activity_uses_repository ON activity_uses_repository.repository_id = repository.id
            LEFT JOIN activity ON activity.id = activity_uses_repository.activity_id
            LEFT JOIN repositoryCoordinateRaw ON repositoryCoordinateRaw.repo_id = repository.id
            WHERE (repository_hasmany_ingoing.id IS NOT NULL OR repository_hasmany_outgoing.id IS NOT NULL)
              AND activity.run_state_enum IS NULL
              AND repositoryCoordinateRaw.laneIdx = laneIdxString
              AND repositoryCoordinateRaw.sideOfLane = laneSideString
        ) INTO arancio;

    -- Valutazione finale con IF
    IF gialla = 1 THEN
        SELECT 2 AS state;  -- Stato Giallo
    ELSEIF arancio = 1 THEN
        SELECT 3 AS state;  -- Stato Arancio
    ELSE
        SELECT 1 AS state;  -- Stato Celeste
    END IF;

END

$$
delimiter ;
delimiter $$

DROP PROCEDURE IF EXISTS `IsRepoStateAlterable_ByTag` $$
CREATE DEFINER=`readonly`@`%` PROCEDURE `IsRepoStateAlterable_ByTag`(
    IN repoTag varchar(32) -- SHL.01A.R01A1
    ,OUT isAlterableAndExists boolean
)
BEGIN
	-- run select, stored in IncompleteActivityOfRepoTag_tmp
	CALL allIncompleteActivityIdOfRepo_byTag(repoTag);
	
	-- alias result to current procedure name, for consistency's sake
   DROP TEMPORARY TABLE IF EXISTS IsRepoStateAlterable_ByTag_tmp;
   CREATE TEMPORARY TABLE IsRepoStateAlterable_ByTag_tmp AS SELECT * FROM allIncompleteActivityIdOfRepo_byTag_tmp;
	    
	#SET isAlterable = IF( (SELECT COUNT(*) FROM IsRepoStateAlterable_tmp) > 0, TRUE, FALSE);
	SET isAlterableAndExists = IF(EXISTS(SELECT 1 FROM IsRepoStateAlterable_ByTag_tmp), FALSE, TRUE) AND EXISTS(SELECT 1 FROM repository WHERE tag = repoTag);
	#SET existsAndIsAlterable = IF(EXISTS(SELECT 1 FROM repository WHERE tag = repoTag), existsAndIsAlterable, FALSE);
    
	SELECT * FROM IsRepoStateAlterable_ByTag_tmp;
END $$


delimiter ;
delimiter $$
DROP PROCEDURE IF EXISTS `getAllMissions` $$

CREATE DEFINER=`readonly`@`%` PROCEDURE `getAllMissions`()
begin
	SELECT 
	_id, 
	repo_tag, 
	udc_tag, 
	run_state, 
	ok
	FROM activitystatus a ;
END

$$
delimiter ;
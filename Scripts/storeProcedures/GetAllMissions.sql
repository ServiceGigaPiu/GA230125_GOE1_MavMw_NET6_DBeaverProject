delimiter $$
DROP PROCEDURE IF EXISTS `getAllMissions` $$

CREATE DEFINER=`readonly`@`%` PROCEDURE `getAllMissions`()
begin
	SELECT 
	tag, 
	run_state_enum, 
	error_code, 
	accept_dt, 
	start_dt, 
	end_dt, 
	expire_dt, 
	scheduled_order
	FROM devdb.activity;
END

$$
delimiter ;
delimiter $$

DROP PROCEDURE IF EXISTS `allExpirableActivityRow` $$
CREATE DEFINER=`readonly`@`%` PROCEDURE `allExpirableActivityRow`(
    IN repoTag varchar(32) -- SHL.01A.R01A1
)
BEGIN
    SELECT * FROM activity WHERE NOT ISNULL(expire_dt)
END $$

delimiter ;
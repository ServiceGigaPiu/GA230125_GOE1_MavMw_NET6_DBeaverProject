-- repository_type_dict --
INSERT INTO repository_type_dict (cid, tag) VALUES 
	('S', 'Shelf'),
	('I', 'InBay'),
	('O', 'OutBay')
	on DUPLICATE key update tag = VALUES(tag); #rename (prolly with same val, it s mainly meant to avoid a pointless error)

INSERT INTO ACTIVITY_TYPE_DICT (cid, tag) VALUES
	('I', 'InTake'),
	('O', 'OutTake'),
	('R', 'Relocate'),
	('C', 'Charge'),
	('P', 'Park')
	on DUPLICATE key update tag = VALUES(tag); #rename (prolly with same val, it s mainly meant to avoid a pointless error)

INSERT INTO RUN_STATE_ENUM (value, name, `desc`) VALUES
	(0, 'Unset', 	'in-progress activity creation'),
	(1, 'MwQueued', 	'Added to internal pending activities list'),
	(2, 'Sent', 	'Sent as job for a MAV to perform'),
	(3, 'FleetQueued', 	'Confirmed reception as job for a MAV to perform'),
	(4, 'Began', 	'Job began'),
	(5, 'Completed', 'Completed, with or without success')
	ON DUPLICATE key update name = VALUES(name); #rename (prolly with same val, it s mainly meant to avoid a pointless error)


INSERT INTO fleetgeonode (code) VALUES 
		(8),
		(10),
		(34),
		(30),
		(33),
		(29),
		(32),
		(31),
		(36),
		(35),
		(13),
		(3),

		(20),
		(39),
		(38),
		(40),
		(41),
		(37),
		(43),
		(42),
		(44),
		(45),
		(16),
		(5),

		(6),
		(49),
		(48),
		(50),
		(51),
		(47),
		(53),
		(52),
		(54),
		(55),
		(21),
		(23),

		(24),
		(59),
		(58),
		(60),
		(62),
		(57),
		(64),
		(63),
		(65),
		(66),
		(25),
		(46),
#bays
		(9),
		(26),
		(27),
		(28),
		(14),
#rots
		(61),
		(11),
		(4),
		(18)

ON DUPLICATE KEY UPDATE code = VALUES(code);

	
#INSERT INTO devdb.repository (tag, type_cid, udc_now_id, udc_next_id, is_disabled, is_uncertain) VALUES('myTag', 's', NULL, NULL, 0, 0)
#	on DUPLICATE key update type = values(type);

-- #Necessario alla rappresentazione di InGoing/OutGoing emptyness #negativo. la divisione in In/Out ovvia al problema
-- INSERT INTO devdb.udc (tag, jdata)VALUES
-- 		('virtualEmpty', null)
-- 	on DUPLICATE key update tag = VALUES(tag), jdata = VALUES(jdata);
	
INSERT INTO repository
(tag, type_cid, udc_now_id, is_disabled, is_uncertain)
VALUES
	
	('SHL.01A.L01A1', 'S', NULL, 0, 0),
	   ('SHL.01A.L01A2', 'S', NULL, 0, 0),
	   ('SHL.01A.L01A3', 'S', NULL, 0, 0),
	   ('SHL.01A.L01B1', 'S', NULL, 0, 0),
	   ('SHL.01A.L01B2', 'S', NULL, 0, 0),
	   ('SHL.01A.L01B3', 'S', NULL, 0, 0),
	   ('SHL.01A.L02A1', 'S', NULL, 0, 0),
	   ('SHL.01A.L02A2', 'S', NULL, 0, 0),
	   ('SHL.01A.L02A3', 'S', NULL, 0, 0),
	   ('SHL.01A.L02B1', 'S', NULL, 0, 0),
	   ('SHL.01A.L02B2', 'S', NULL, 0, 0),
	   ('SHL.01A.L02B3', 'S', NULL, 0, 0),
	   ('SHL.01A.L03A1', 'S', NULL, 0, 0),
	   ('SHL.01A.L03A2', 'S', NULL, 0, 0),
	   ('SHL.01A.L03A3', 'S', NULL, 0, 0),
	   ('SHL.01A.L03B1', 'S', NULL, 0, 0),
	   ('SHL.01A.L03B2', 'S', NULL, 0, 0),
	   ('SHL.01A.L03B3', 'S', NULL, 0, 0),
	   ('SHL.01B.L04A1', 'S', NULL, 0, 0),
	   ('SHL.01B.L04A2', 'S', NULL, 0, 0),
	   ('SHL.01B.L04A3', 'S', NULL, 0, 0),
	   ('SHL.01B.L04B1', 'S', NULL, 0, 0),
	   ('SHL.01B.L04B2', 'S', NULL, 0, 0),
	   ('SHL.01B.L04B3', 'S', NULL, 0, 0),
	   ('SHL.01B.L05A1', 'S', NULL, 0, 0),
	   ('SHL.01B.L05A2', 'S', NULL, 0, 0),
	   ('SHL.01B.L05A3', 'S', NULL, 0, 0),
	   ('SHL.01B.L05B1', 'S', NULL, 0, 0),
	   ('SHL.01B.L05B2', 'S', NULL, 0, 0),
	   ('SHL.01B.L05B3', 'S', NULL, 0, 0),
	   ('SHL.01B.L06A1', 'S', NULL, 0, 0),
	   ('SHL.01B.L06A2', 'S', NULL, 0, 0),
	   ('SHL.01B.L06A3', 'S', NULL, 0, 0),
	   ('SHL.01B.L06B1', 'S', NULL, 0, 0),
	   ('SHL.01B.L06B2', 'S', NULL, 0, 0),
	   ('SHL.01B.L06B3', 'S', NULL, 0, 0),
	   ('SHL.02A.R01A1', 'S', NULL, 0, 0),
	   ('SHL.02A.R01A2', 'S', NULL, 0, 0),
	   ('SHL.02A.R01A3', 'S', NULL, 0, 0),
	   ('SHL.02A.R01B1', 'S', NULL, 0, 0),
	   ('SHL.02A.R01B2', 'S', NULL, 0, 0),
	   ('SHL.02A.R01B3', 'S', NULL, 0, 0),
	   ('SHL.02A.R02A1', 'S', NULL, 0, 0),
	   ('SHL.02A.R02A2', 'S', NULL, 0, 0),
	   ('SHL.02A.R02A3', 'S', NULL, 0, 0),
	   ('SHL.02A.R02B1', 'S', NULL, 0, 0),
	   ('SHL.02A.R02B2', 'S', NULL, 0, 0),
	   ('SHL.02A.R02B3', 'S', NULL, 0, 0),
	   ('SHL.02A.R03A1', 'S', NULL, 0, 0),
	   ('SHL.02A.R03A2', 'S', NULL, 0, 0),
	   ('SHL.02A.R03A3', 'S', NULL, 0, 0),
	   ('SHL.02A.R03B1', 'S', NULL, 0, 0),
	   ('SHL.02A.R03B2', 'S', NULL, 0, 0),
	   ('SHL.02A.R03B3', 'S', NULL, 0, 0),
	   ('SHL.02B.R04A1', 'S', NULL, 0, 0),
	   ('SHL.02B.R04A2', 'S', NULL, 0, 0),
	   ('SHL.02B.R04A3', 'S', NULL, 0, 0),
	   ('SHL.02B.R04B1', 'S', NULL, 0, 0),
	   ('SHL.02B.R04B2', 'S', NULL, 0, 0),
	   ('SHL.02B.R04B3', 'S', NULL, 0, 0),
	   ('SHL.02B.R05A1', 'S', NULL, 0, 0),
	   ('SHL.02B.R05A2', 'S', NULL, 0, 0),
	   ('SHL.02B.R05A3', 'S', NULL, 0, 0),
	   ('SHL.02B.R05B1', 'S', NULL, 0, 0),
	   ('SHL.02B.R05B2', 'S', NULL, 0, 0),
	   ('SHL.02B.R05B3', 'S', NULL, 0, 0),
	   ('SHL.02B.R06A1', 'S', NULL, 0, 0),
	   ('SHL.02B.R06A2', 'S', NULL, 0, 0),
	   ('SHL.02B.R06A3', 'S', NULL, 0, 0),
	   ('SHL.02B.R06B1', 'S', NULL, 0, 0),
	   ('SHL.02B.R06B2', 'S', NULL, 0, 0),
	   ('SHL.02B.R06B3', 'S', NULL, 0, 0),
	   ('SHL.02A.L01A1', 'S', NULL, 0, 0),
	   ('SHL.02A.L01A2', 'S', NULL, 0, 0),
	   ('SHL.02A.L01A3', 'S', NULL, 0, 0),
	   ('SHL.02A.L01B1', 'S', NULL, 0, 0),
	   ('SHL.02A.L01B2', 'S', NULL, 0, 0),
	   ('SHL.02A.L01B3', 'S', NULL, 0, 0),
	   ('SHL.02A.L02A1', 'S', NULL, 0, 0),
	   ('SHL.02A.L02A2', 'S', NULL, 0, 0),
	   ('SHL.02A.L02A3', 'S', NULL, 0, 0),
	   ('SHL.02A.L02B1', 'S', NULL, 0, 0),
	   ('SHL.02A.L02B2', 'S', NULL, 0, 0),
	   ('SHL.02A.L02B3', 'S', NULL, 0, 0),
	   ('SHL.02A.L03A1', 'S', NULL, 0, 0),
	   ('SHL.02A.L03A2', 'S', NULL, 0, 0),
	   ('SHL.02A.L03A3', 'S', NULL, 0, 0),
	   ('SHL.02A.L03B1', 'S', NULL, 0, 0),
	   ('SHL.02A.L03B2', 'S', NULL, 0, 0),
	   ('SHL.02A.L03B3', 'S', NULL, 0, 0),
	   ('SHL.02B.L04A1', 'S', NULL, 0, 0),
	   ('SHL.02B.L04A2', 'S', NULL, 0, 0),
	   ('SHL.02B.L04A3', 'S', NULL, 0, 0),
	   ('SHL.02B.L04B1', 'S', NULL, 0, 0),
	   ('SHL.02B.L04B2', 'S', NULL, 0, 0),
	   ('SHL.02B.L04B3', 'S', NULL, 0, 0),
	   ('SHL.02B.L05A1', 'S', NULL, 0, 0),
	   ('SHL.02B.L05A2', 'S', NULL, 0, 0),
	   ('SHL.02B.L05A3', 'S', NULL, 0, 0),
	   ('SHL.02B.L05B1', 'S', NULL, 0, 0),
	   ('SHL.02B.L05B2', 'S', NULL, 0, 0),
	   ('SHL.02B.L05B3', 'S', NULL, 0, 0),
	   ('SHL.02B.L06A1', 'S', NULL, 0, 0),
	   ('SHL.02B.L06A2', 'S', NULL, 0, 0),
	   ('SHL.02B.L06A3', 'S', NULL, 0, 0),
	   ('SHL.02B.L06B1', 'S', NULL, 0, 0),
	   ('SHL.02B.L06B2', 'S', NULL, 0, 0),
	   ('SHL.02B.L06B3', 'S', NULL, 0, 0),
	   ('SHL.03A.R01A1', 'S', NULL, 0, 0),
	   ('SHL.03A.R01A2', 'S', NULL, 0, 0),
	   ('SHL.03A.R01A3', 'S', NULL, 0, 0),
	   ('SHL.03A.R01B1', 'S', NULL, 0, 0),
	   ('SHL.03A.R01B2', 'S', NULL, 0, 0),
	   ('SHL.03A.R01B3', 'S', NULL, 0, 0),
	   ('SHL.03A.R02A1', 'S', NULL, 0, 0),
	   ('SHL.03A.R02A2', 'S', NULL, 0, 0),
	   ('SHL.03A.R02A3', 'S', NULL, 0, 0),
	   ('SHL.03A.R02B1', 'S', NULL, 0, 0),
	   ('SHL.03A.R02B2', 'S', NULL, 0, 0),
	   ('SHL.03A.R02B3', 'S', NULL, 0, 0),
	   ('SHL.03A.R03A1', 'S', NULL, 0, 0),
	   ('SHL.03A.R03A2', 'S', NULL, 0, 0),
	   ('SHL.03A.R03A3', 'S', NULL, 0, 0),
	   ('SHL.03A.R03B1', 'S', NULL, 0, 0),
	   ('SHL.03A.R03B2', 'S', NULL, 0, 0),
	   ('SHL.03A.R03B3', 'S', NULL, 0, 0),
	   ('SHL.03B.R04A1', 'S', NULL, 0, 0),
	   ('SHL.03B.R04A2', 'S', NULL, 0, 0),
	   ('SHL.03B.R04A3', 'S', NULL, 0, 0),
	   ('SHL.03B.R04B1', 'S', NULL, 0, 0),
	   ('SHL.03B.R04B2', 'S', NULL, 0, 0),
	   ('SHL.03B.R04B3', 'S', NULL, 0, 0),
	   ('SHL.03B.R05A1', 'S', NULL, 0, 0),
	   ('SHL.03B.R05A2', 'S', NULL, 0, 0),
	   ('SHL.03B.R05A3', 'S', NULL, 0, 0),
	   ('SHL.03B.R05B1', 'S', NULL, 0, 0),
	   ('SHL.03B.R05B2', 'S', NULL, 0, 0),
	   ('SHL.03B.R05B3', 'S', NULL, 0, 0),
	   ('SHL.03B.R06A1', 'S', NULL, 0, 0),
	   ('SHL.03B.R06A2', 'S', NULL, 0, 0),
	   ('SHL.03B.R06A3', 'S', NULL, 0, 0),
	   ('SHL.03B.R06B1', 'S', NULL, 0, 0),
	   ('SHL.03B.R06B2', 'S', NULL, 0, 0),
	   ('SHL.03B.R06B3', 'S', NULL, 0, 0),
	   ('SHL.03A.L01A1', 'S', NULL, 0, 0),
	   ('SHL.03A.L01A2', 'S', NULL, 0, 0),
	   ('SHL.03A.L01A3', 'S', NULL, 0, 0),
	   ('SHL.03A.L01B1', 'S', NULL, 0, 0),
	   ('SHL.03A.L01B2', 'S', NULL, 0, 0),
	   ('SHL.03A.L01B3', 'S', NULL, 0, 0),
	   ('SHL.03A.L02A1', 'S', NULL, 0, 0),
	   ('SHL.03A.L02A2', 'S', NULL, 0, 0),
	   ('SHL.03A.L02A3', 'S', NULL, 0, 0),
	   ('SHL.03A.L02B1', 'S', NULL, 0, 0),
	   ('SHL.03A.L02B2', 'S', NULL, 0, 0),
	   ('SHL.03A.L02B3', 'S', NULL, 0, 0),
	   ('SHL.03A.L03A1', 'S', NULL, 0, 0),
	   ('SHL.03A.L03A2', 'S', NULL, 0, 0),
	   ('SHL.03A.L03A3', 'S', NULL, 0, 0),
	   ('SHL.03A.L03B1', 'S', NULL, 0, 0),
	   ('SHL.03A.L03B2', 'S', NULL, 0, 0),
	   ('SHL.03A.L03B3', 'S', NULL, 0, 0),
	   ('SHL.03B.L04A1', 'S', NULL, 0, 0),
	   ('SHL.03B.L04A2', 'S', NULL, 0, 0),
	   ('SHL.03B.L04A3', 'S', NULL, 0, 0),
	   ('SHL.03B.L04B1', 'S', NULL, 0, 0),
	   ('SHL.03B.L04B2', 'S', NULL, 0, 0),
	   ('SHL.03B.L04B3', 'S', NULL, 0, 0),
	   ('SHL.03B.L05A1', 'S', NULL, 0, 0),
	   ('SHL.03B.L05A2', 'S', NULL, 0, 0),
	   ('SHL.03B.L05A3', 'S', NULL, 0, 0),
	   ('SHL.03B.L05B1', 'S', NULL, 0, 0),
	   ('SHL.03B.L05B2', 'S', NULL, 0, 0),
	   ('SHL.03B.L05B3', 'S', NULL, 0, 0),
	   ('SHL.03B.L06A1', 'S', NULL, 0, 0),
	   ('SHL.03B.L06A2', 'S', NULL, 0, 0),
	   ('SHL.03B.L06A3', 'S', NULL, 0, 0),
	   ('SHL.03B.L06B1', 'S', NULL, 0, 0),
	   ('SHL.03B.L06B2', 'S', NULL, 0, 0),
	   ('SHL.03B.L06B3', 'S', NULL, 0, 0),
	   ('SHL.04A.R01A1', 'S', NULL, 0, 0),
	   ('SHL.04A.R01A2', 'S', NULL, 0, 0),
	   ('SHL.04A.R01A3', 'S', NULL, 0, 0),
	   ('SHL.04A.R01B1', 'S', NULL, 0, 0),
	   ('SHL.04A.R01B2', 'S', NULL, 0, 0),
	   ('SHL.04A.R01B3', 'S', NULL, 0, 0),
	   ('SHL.04A.R02A1', 'S', NULL, 0, 0),
	   ('SHL.04A.R02A2', 'S', NULL, 0, 0),
	   ('SHL.04A.R02A3', 'S', NULL, 0, 0),
	   ('SHL.04A.R02B1', 'S', NULL, 0, 0),
	   ('SHL.04A.R02B2', 'S', NULL, 0, 0),
	   ('SHL.04A.R02B3', 'S', NULL, 0, 0),
	   ('SHL.04A.R03A1', 'S', NULL, 0, 0),
	   ('SHL.04A.R03A2', 'S', NULL, 0, 0),
	   ('SHL.04A.R03A3', 'S', NULL, 0, 0),
	   ('SHL.04A.R03B1', 'S', NULL, 0, 0),
	   ('SHL.04A.R03B2', 'S', NULL, 0, 0),
	   ('SHL.04A.R03B3', 'S', NULL, 0, 0),
	   ('SHL.04B.R04A1', 'S', NULL, 0, 0),
	   ('SHL.04B.R04A2', 'S', NULL, 0, 0),
	   ('SHL.04B.R04A3', 'S', NULL, 0, 0),
	   ('SHL.04B.R04B1', 'S', NULL, 0, 0),
	   ('SHL.04B.R04B2', 'S', NULL, 0, 0),
	   ('SHL.04B.R04B3', 'S', NULL, 0, 0),
	   ('SHL.04B.R05A1', 'S', NULL, 0, 0),
	   ('SHL.04B.R05A2', 'S', NULL, 0, 0),
	   ('SHL.04B.R05A3', 'S', NULL, 0, 0),
	   ('SHL.04B.R05B1', 'S', NULL, 0, 0),
	   ('SHL.04B.R05B2', 'S', NULL, 0, 0),
	   ('SHL.04B.R05B3', 'S', NULL, 0, 0),
	   ('SHL.04B.R06A1', 'S', NULL, 0, 0),
	   ('SHL.04B.R06A2', 'S', NULL, 0, 0),
	   ('SHL.04B.R06A3', 'S', NULL, 0, 0),
	   ('SHL.04B.R06B1', 'S', NULL, 0, 0),
	   ('SHL.04B.R06B2', 'S', NULL, 0, 0),
	   ('SHL.04B.R06B3', 'S', NULL, 0, 0),
	   ('BAY.IN.01', 'I', NULL, 0, 0),
	   ('BAY.IN.02', 'I', NULL, 0, 0),
	   ('BAY.IN.03', 'I', NULL, 0, 0),
	   ('BAY.IN.04', 'I', NULL, 0, 0),
	   ('BAY.OUT.01', 'O', NULL, 0, 0)


ON DUPLICATE KEY UPDATE is_disabled = VALUES(is_disabled);

#defaults for shelves
INSERT INTO repository_has_maxvolume (repository_id, height, breadth, `depth`)
	SELECT id AS repository_id, 10, 11, 12
	FROM repository
	WHERE repository.type_cid = 'S'
ON DUPLICATE KEY UPDATE height = VALUES(height);


#defaults for non-shelves #not having a row is an option
INSERT INTO repository_has_maxvolume (repository_id, height, breadth, `depth`)
	SELECT id AS repository_id, NULL, NULL, NULL
	FROM repository
	WHERE type_cid IN (SELECT type_cid FROM repository_type_dict WHERE type_cid <> 'S')
ON DUPLICATE KEY UPDATE height = VALUES(height);

#DELETE FROM repository_has_maxvolume
#WHERE repository_id IN (SELECT id FROM repository WHERE type_cid IN (SELECT type_cid FROM repository_type_dict WHERE type_cid <> 'S'))



#hard-pair repository to fleetgeonode

delimiter $$

DROP PROCEDURE IF EXISTS FetchAllRepoIdToGeonodeIdPairs $$
CREATE DEFINER=`dev`@`%` PROCEDURE FetchAllRepoIdToGeonodeIdPairs()
BEGIN
	DECLARE bDone INT;
	
	DECLARE sRepositoryTag varchar(32);
	DECLARE iFleetgeonodeCode bigint;
	DECLARE iRepositoryAutoId INT UNSIGNED;
	DECLARE iFleetgeonodeAutoId INT UNSIGNED;

	DECLARE curs CURSOR FOR SELECT * FROM tblPairing; #as stated on stackOvfw: "seems illogical but it works"
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone = 1;
	
	
	DROP TEMPORARY TABLE IF EXISTS tblPairing; #OUTPUT destination FOR procedure
	CREATE TEMPORARY TABLE IF NOT EXISTS tblPairing  (
		`repository_tag` varchar(32),
		`fleetgeonode_code` bigint
	);

	INSERT INTO tblPairing (repository_tag, fleetgeonode_code)
	VALUES
					("SHL.01A.L01A1", 8),
			("SHL.01A.L01A2", 8),
			("SHL.01A.L01A3", 8),

			("SHL.01A.L01B1", 10),
			("SHL.01A.L01B2", 10),
			("SHL.01A.L01B3", 10),

			("SHL.01A.L02A1", 34),
			("SHL.01A.L02A2", 34),
			("SHL.01A.L02A3", 34),

			("SHL.01A.L02B1", 30),
			("SHL.01A.L02B2", 30),
			("SHL.01A.L02B3", 30),

			("SHL.01A.L03A1", 33),
			("SHL.01A.L03A2", 33),
			("SHL.01A.L03A3", 33),

			("SHL.01A.L03B1", 29),
			("SHL.01A.L03B2", 29),
			("SHL.01A.L03B3", 29),

			("SHL.01B.L04A1", 32),
			("SHL.01B.L04A2", 32),
			("SHL.01B.L04A3", 32),

			("SHL.01B.L04B1", 31),
			("SHL.01B.L04B2", 31),
			("SHL.01B.L04B3", 31),

			("SHL.01B.L05A1", 36),
			("SHL.01B.L05A2", 36),
			("SHL.01B.L05A3", 36),

			("SHL.01B.L05B1", 35),
			("SHL.01B.L05B2", 35),
			("SHL.01B.L05B3", 35),

			("SHL.01B.L06A1", 13),
			("SHL.01B.L06A2", 13),
			("SHL.01B.L06A3", 13),

			("SHL.01B.L06B1", 3),
			("SHL.01B.L06B2", 3),
			("SHL.01B.L06B3", 3),




			("SHL.02A.R01A1", 20),
			("SHL.02A.R01A2", 20),
			("SHL.02A.R01A3", 20),

			("SHL.02A.R01B1", 39),
			("SHL.02A.R01B2", 39),
			("SHL.02A.R01B3", 39),

			("SHL.02A.R02A1", 38),
			("SHL.02A.R02A2", 38),
			("SHL.02A.R02A3", 38),

			("SHL.02A.R02B1", 40),
			("SHL.02A.R02B2", 40),
			("SHL.02A.R02B3", 40),

			("SHL.02A.R03A1", 41),
			("SHL.02A.R03A2", 41),
			("SHL.02A.R03A3", 41),

			("SHL.02A.R03B1", 37),
			("SHL.02A.R03B2", 37),
			("SHL.02A.R03B3", 37),

			("SHL.02B.R04A1", 43),
			("SHL.02B.R04A2", 43),
			("SHL.02B.R04A3", 43),

			("SHL.02B.R04B1", 42),
			("SHL.02B.R04B2", 42),
			("SHL.02B.R04B3", 42),

			("SHL.02B.R05A1", 44),
			("SHL.02B.R05A2", 44),
			("SHL.02B.R05A3", 44),

			("SHL.02B.R05B1", 45),
			("SHL.02B.R05B2", 45),
			("SHL.02B.R05B3", 45),

			("SHL.02B.R06A1", 16),
			("SHL.02B.R06A2", 16),
			("SHL.02B.R06A3", 16),

			("SHL.02B.R06B1", 5),
			("SHL.02B.R06B2", 5),
			("SHL.02B.R06B3", 5),





			("SHL.02A.L01A1", 20),
			("SHL.02A.L01A2", 20),
			("SHL.02A.L01A3", 20),

			("SHL.02A.L01B1", 39),
			("SHL.02A.L01B2", 39),
			("SHL.02A.L01B3", 39),

			("SHL.02A.L02A1", 38),
			("SHL.02A.L02A2", 38),
			("SHL.02A.L02A3", 38),

			("SHL.02A.L02B1", 40),
			("SHL.02A.L02B2", 40),
			("SHL.02A.L02B3", 40),

			("SHL.02A.L03A1", 41),
			("SHL.02A.L03A2", 41),
			("SHL.02A.L03A3", 41),

			("SHL.02A.L03B1", 37),
			("SHL.02A.L03B2", 37),
			("SHL.02A.L03B3", 37),

			("SHL.02B.L04A1", 43),
			("SHL.02B.L04A2", 43),
			("SHL.02B.L04A3", 43),

			("SHL.02B.L04B1", 42),
			("SHL.02B.L04B2", 42),
			("SHL.02B.L04B3", 42),

			("SHL.02B.L05A1", 44),
			("SHL.02B.L05A2", 44),
			("SHL.02B.L05A3", 44),

			("SHL.02B.L05B1", 45),
			("SHL.02B.L05B2", 45),
			("SHL.02B.L05B3", 45),

			("SHL.02B.L06A1", 16),
			("SHL.02B.L06A2", 16),
			("SHL.02B.L06A3", 16),

			("SHL.02B.L06B1", 5),
			("SHL.02B.L06B2", 5),
			("SHL.02B.L06B3", 5),




			("SHL.03A.R01A1", 6),
			("SHL.03A.R01A2", 6),
			("SHL.03A.R01A3", 6),

			("SHL.03A.R01B1", 49),
			("SHL.03A.R01B2", 49),
			("SHL.03A.R01B3", 49),

			("SHL.03A.R02A1", 48),
			("SHL.03A.R02A2", 48),
			("SHL.03A.R02A3", 48),

			("SHL.03A.R02B1", 50),
			("SHL.03A.R02B2", 50),
			("SHL.03A.R02B3", 50),

			("SHL.03A.R03A1", 51),
			("SHL.03A.R03A2", 51),
			("SHL.03A.R03A3", 51),

			("SHL.03A.R03B1", 47),
			("SHL.03A.R03B2", 47),
			("SHL.03A.R03B3", 47),

			("SHL.03B.R04A1", 53),
			("SHL.03B.R04A2", 53),
			("SHL.03B.R04A3", 53),

			("SHL.03B.R04B1", 52),
			("SHL.03B.R04B2", 52),
			("SHL.03B.R04B3", 52),

			("SHL.03B.R05A1", 54),
			("SHL.03B.R05A2", 54),
			("SHL.03B.R05A3", 54),

			("SHL.03B.R05B1", 55),
			("SHL.03B.R05B2", 55),
			("SHL.03B.R05B3", 55),

			("SHL.03B.R06A1", 21),
			("SHL.03B.R06A2", 21),
			("SHL.03B.R06A3", 21),

			("SHL.03B.R06B1", 23),
			("SHL.03B.R06B2", 23),
			("SHL.03B.R06B3", 23),



			("SHL.03A.L01A1", 6),
			("SHL.03A.L01A2", 6),
			("SHL.03A.L01A3", 6),

			("SHL.03A.L01B1", 49),
			("SHL.03A.L01B2", 49),
			("SHL.03A.L01B3", 49),

			("SHL.03A.L02A1", 48),
			("SHL.03A.L02A2", 48),
			("SHL.03A.L02A3", 48),

			("SHL.03A.L02B1", 50),
			("SHL.03A.L02B2", 50),
			("SHL.03A.L02B3", 50),

			("SHL.03A.L03A1", 51),
			("SHL.03A.L03A2", 51),
			("SHL.03A.L03A3", 51),

			("SHL.03A.L03B1", 47),
			("SHL.03A.L03B2", 47),
			("SHL.03A.L03B3", 47),

			("SHL.03B.L04A1", 53),
			("SHL.03B.L04A2", 53),
			("SHL.03B.L04A3", 53),

			("SHL.03B.L04B1", 52),
			("SHL.03B.L04B2", 52),
			("SHL.03B.L04B3", 52),

			("SHL.03B.L05A1", 54),
			("SHL.03B.L05A2", 54),
			("SHL.03B.L05A3", 54),

			("SHL.03B.L05B1", 55),
			("SHL.03B.L05B2", 55),
			("SHL.03B.L05B3", 55),

			("SHL.03B.L06A1", 21),
			("SHL.03B.L06A2", 21),
			("SHL.03B.L06A3", 21),

			("SHL.03B.L06B1", 23),
			("SHL.03B.L06B2", 23),
			("SHL.03B.L06B3", 23),





			("SHL.04A.R01A1", 24),
			("SHL.04A.R01A2", 24),
			("SHL.04A.R01A3", 24),

			("SHL.04A.R01B1", 59),
			("SHL.04A.R01B2", 59),
			("SHL.04A.R01B3", 59),

			("SHL.04A.R02A1", 58),
			("SHL.04A.R02A2", 58),
			("SHL.04A.R02A3", 58),

			("SHL.04A.R02B1", 60),
			("SHL.04A.R02B2", 60),
			("SHL.04A.R02B3", 60),

			("SHL.04A.R03A1", 62),
			("SHL.04A.R03A2", 60),
			("SHL.04A.R03A3", 60),

			("SHL.04A.R03B1", 57),
			("SHL.04A.R03B2", 57),
			("SHL.04A.R03B3", 57),

			("SHL.04B.R04A1", 64),
			("SHL.04B.R04A2", 64),
			("SHL.04B.R04A3", 64),

			("SHL.04B.R04B1", 63),
			("SHL.04B.R04B2", 63),
			("SHL.04B.R04B3", 63),

			("SHL.04B.R05A1", 65),
			("SHL.04B.R05A2", 65),
			("SHL.04B.R05A3", 65),

			("SHL.04B.R05B1", 66),
			("SHL.04B.R05B2", 66),
			("SHL.04B.R05B3", 66),

			("SHL.04B.R06A1", 25),
			("SHL.04B.R06A2", 25),
			("SHL.04B.R06A3", 25),

			("SHL.04B.R06B1", 46),
			("SHL.04B.R06B2", 46),
			("SHL.04B.R06B3", 46),

			("BAY.IN.01", 9),
			("BAY.IN.02", 26),
			("BAY.IN.03", 27),
			("BAY.IN.04", 28),
			("BAY.OUT.01", 14)

	ON DUPLICATE KEY UPDATE fleetgeonode_code = VALUES(fleetgeonode_code);
	
	
	OPEN curs;
	SET bDone = 0;
	REPEAT
		FETCH curs INTO sRepositoryTag, iFleetgeonodeCode;
		SET iRepositoryAutoId = (SELECT id FROM repository WHERE tag = sRepositoryTag LIMIT 1);
		SET iFleetgeonodeAutoId = (SELECT id FROM fleetgeonode WHERE code = iFleetgeonodeCode LIMIT 1);

		INSERT INTO tblResults (repository_id, repository_tag, fleetgeonode_id, fleetgeonode_code)
		VALUES (iRepositoryAutoId, sRepositoryTag, iFleetgeonodeAutoId, iFleetgeonodeCode);

	UNTIL bDone END REPEAT;
	
	SELECT * FROM tblResults;
END $$

delimiter ;
;


DROP TEMPORARY TABLE IF EXISTS tblResults;
CREATE TEMPORARY TABLE IF NOT EXISTS tblResults (
	repository_id INT UNSIGNED NOT NULL,
	repository_tag varchar(32),
	
	fleetgeonode_id INT UNSIGNED NOT NULL,
	fleetgeonode_code bigint
);

CALL FetchAllRepoIdToGeonodeIdPairs();
INSERT INTO repository_has_fleetgeonode (repository_id, fleetgeonode_id)
	SELECT repository_id, fleetgeonode_id
	FROM	tblResults
ON DUPLICATE KEY UPDATE fleetgeonode_id = VALUES(fleetgeonode_id);

DROP PROCEDURE FetchAllRepoIdToGeonodeIdPairs;
DROP TEMPORARY TABLE tblResults;


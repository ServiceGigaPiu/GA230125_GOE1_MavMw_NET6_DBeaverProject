delimiter $$

-- UTILS LIB --

DROP FUNCTION IF EXISTS charIdxOf$$
CREATE FUNCTION charIdxOf (charIdx char, zeroAt char)
RETURNS int
BEGIN
	RETURN ORD(charIdx) - ORD(zeroAt);
END$$


-- END UTILS LIB --

delimiter ;
;
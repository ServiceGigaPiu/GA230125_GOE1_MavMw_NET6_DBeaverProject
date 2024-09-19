
/**/
UPDATE repository
SET is_disabled = 0
WHERE tag IN (
	'SHL.01A.L01A3',
	'SHL.01A.L01B3',
	'SHL.01A.L02A3',
	'SHL.01A.L02B3',
	'SHL.01A.L03A3',
	'SHL.01A.L03B3',
	'SHL.01B.L04A3',
	'SHL.01B.L04B3',
	'SHL.01B.L05A3',
	'SHL.01B.L05B3',
	'SHL.01B.L06A3',
	'SHL.01B.L06B3',
	'SHL.02A.R01A3',
	'SHL.02A.R01B3',
	'SHL.02A.R02A3',
	'SHL.02A.R02B3',
	'SHL.02A.R03A3',
	'SHL.02A.R03B3',
	'SHL.02B.R04A3',
	'SHL.02B.R04B3',
	'SHL.02B.R05A3',
	'SHL.02B.R05B3',
	'SHL.02B.R06A3',
	'SHL.02B.R06B3',
	'SHL.02A.L01A3',
	'SHL.02A.L01B3',
	'SHL.02A.L02A3',
	'SHL.02A.L02B3',
	'SHL.02A.L03A3',
	'SHL.02A.L03B3',
	'SHL.02B.L04A3',
	'SHL.02B.L04B3',
	'SHL.02B.L05A3',
	'SHL.02B.L05B3',
	'SHL.02B.L06A3',
	'SHL.02B.L06B3',
	'SHL.03A.R01A3',
	'SHL.03A.R01B3',
	'SHL.03A.R02A3',
	'SHL.03A.R02B3',
	'SHL.03A.R03A3',
	'SHL.03A.R03B3',
	'SHL.03B.R04A3',
	'SHL.03B.R04B3',
	'SHL.03B.R05A3',
	'SHL.03B.R05B3',
	'SHL.03B.R06A3',
	'SHL.03B.R06B3',
	'SHL.03A.L01A3',
	'SHL.03A.L01B3',
	'SHL.03A.L02A3',
	'SHL.03A.L02B3',
	'SHL.03A.L03A3',
	'SHL.03A.L03B3',
	'SHL.03B.L04A3',
	'SHL.03B.L04B3',
	'SHL.03B.L05A3',
	'SHL.03B.L05B3',
	'SHL.03B.L06A3',
	'SHL.03B.L06B3',
	'SHL.04A.R01A3',
	'SHL.04A.R01B3',
	'SHL.04A.R02A3',
	'SHL.04A.R02B3',
	'SHL.04A.R03A3',
	'SHL.04A.R03B3',
	'SHL.04B.R04A3',
	'SHL.04B.R04B3',
	'SHL.04B.R05A3',
	'SHL.04B.R05B3',
	'SHL.04B.R06A3',
	'SHL.04B.R06B3'
);
/**/
/** /
UPDATE repository
SET is_disabled = 1
WHERE tag IN (
	'SHL.01A.L03B2',
	'SHL.01B.L06B1',
	'SHL.02B.R05A2',
	'SHL.02A.L02B2',
	'SHL.03B.R05A2',
	'SHL.03B.R05B1',
	'SHL.03A.L02B1',
	'SHL.03A.L02B2',
	'SHL.04A.R03B2',
	
	'SHL.01B.L04A2',
	'SHL.01B.L04A1',
	'SHL.02A.L03A1',
	
	'SHL.02B.R05B1',
	'SHL.01B.L04B1'
);/**/

/** /
-- all 2° and 3° row
 UPDATE repository SET is_disabled = 0
 WHERE tag IN (
	'SHL.01A.L01A2',
	'SHL.01A.L01A3',
	'SHL.01A.L01B2',
	'SHL.01A.L01B3',
	'SHL.01A.L02A2',
	'SHL.01A.L02A3',
	'SHL.01A.L02B2',
	'SHL.01A.L02B3',
	'SHL.01A.L03A2',
	'SHL.01A.L03A3',
	'SHL.01A.L03B2',
	'SHL.01A.L03B3',
	'SHL.01B.L04A2',
	'SHL.01B.L04A3',
	'SHL.01B.L04B2',
	'SHL.01B.L04B3',
	'SHL.01B.L05A2',
	'SHL.01B.L05A3',
	'SHL.01B.L05B2',
	'SHL.01B.L05B3',
	'SHL.01B.L06A2',
	'SHL.01B.L06A3',
	'SHL.01B.L06B2',
	'SHL.01B.L06B3',
	'SHL.02A.R01A2',
	'SHL.02A.R01A3',
	'SHL.02A.R01B2',
	'SHL.02A.R01B3',
	'SHL.02A.R02A2',
	'SHL.02A.R02A3',
	'SHL.02A.R02B2',
	'SHL.02A.R02B3',
	'SHL.02A.R03A2',
	'SHL.02A.R03A3',
	'SHL.02A.R03B2',
	'SHL.02A.R03B3',
	'SHL.02B.R04A2',
	'SHL.02B.R04A3',
	'SHL.02B.R04B2',
	'SHL.02B.R04B3',
	'SHL.02B.R05A2',
	'SHL.02B.R05A3',
	'SHL.02B.R05B2',
	'SHL.02B.R05B3',
	'SHL.02B.R06A2',
	'SHL.02B.R06A3',
	'SHL.02B.R06B2',
	'SHL.02B.R06B3',
	'SHL.02A.L01A2',
	'SHL.02A.L01A3',
	'SHL.02A.L01B2',
	'SHL.02A.L01B3',
	'SHL.02A.L02A2',
	'SHL.02A.L02A3',
	'SHL.02A.L02B2',
	'SHL.02A.L02B3',
	'SHL.02A.L03A2',
	'SHL.02A.L03A3',
	'SHL.02A.L03B2',
	'SHL.02A.L03B3',
	'SHL.02B.L04A2',
	'SHL.02B.L04A3',
	'SHL.02B.L04B2',
	'SHL.02B.L04B3',
	'SHL.02B.L05A2',
	'SHL.02B.L05A3',
	'SHL.02B.L05B2',
	'SHL.02B.L05B3',
	'SHL.02B.L06A2',
	'SHL.02B.L06A3',
	'SHL.02B.L06B2',
	'SHL.02B.L06B3',
	'SHL.03A.R01A2',
	'SHL.03A.R01A3',
	'SHL.03A.R01B2',
	'SHL.03A.R01B3',
	'SHL.03A.R02A2',
	'SHL.03A.R02A3',
	'SHL.03A.R02B2',
	'SHL.03A.R02B3',
	'SHL.03A.R03A2',
	'SHL.03A.R03A3',
	'SHL.03A.R03B2',
	'SHL.03A.R03B3',
	'SHL.03B.R04A2',
	'SHL.03B.R04A3',
	'SHL.03B.R04B2',
	'SHL.03B.R04B3',
	'SHL.03B.R05A2',
	'SHL.03B.R05A3',
	'SHL.03B.R05B2',
	'SHL.03B.R05B3',
	'SHL.03B.R06A2',
	'SHL.03B.R06A3',
	'SHL.03B.R06B2',
	'SHL.03B.R06B3',
	'SHL.03A.L01A2',
	'SHL.03A.L01A3',
	'SHL.03A.L01B2',
	'SHL.03A.L01B3',
	'SHL.03A.L02A2',
	'SHL.03A.L02A3',
	'SHL.03A.L02B2',
	'SHL.03A.L02B3',
	'SHL.03A.L03A2',
	'SHL.03A.L03A3',
	'SHL.03A.L03B2',
	'SHL.03A.L03B3',
	'SHL.03B.L04A2',
	'SHL.03B.L04A3',
	'SHL.03B.L04B2',
	'SHL.03B.L04B3',
	'SHL.03B.L05A2',
	'SHL.03B.L05A3',
	'SHL.03B.L05B2',
	'SHL.03B.L05B3',
	'SHL.03B.L06A2',
	'SHL.03B.L06A3',
	'SHL.03B.L06B2',
	'SHL.03B.L06B3',
	'SHL.04A.R01A2',
	'SHL.04A.R01A3',
	'SHL.04A.R01B2',
	'SHL.04A.R01B3',
	'SHL.04A.R02A2',
	'SHL.04A.R02A3',
	'SHL.04A.R02B2',
	'SHL.04A.R02B3',
	'SHL.04A.R03A2',
	'SHL.04A.R03A3',
	'SHL.04A.R03B2',
	'SHL.04A.R03B3',
	'SHL.04B.R04A2',
	'SHL.04B.R04A3',
	'SHL.04B.R04B2',
	'SHL.04B.R04B3',
	'SHL.04B.R05A2',
	'SHL.04B.R05A3',
	'SHL.04B.R05B2',
	'SHL.04B.R05B3',
	'SHL.04B.R06A2',
	'SHL.04B.R06A3',
	'SHL.04B.R06B2',
	'SHL.04B.R06B3'); 
/**/

	-- 'SHL.01A.L03B2',
	-- 'SHL.01B.L06B1',
	-- 'SHL.02B.R05A2',
	-- 'SHL.02A.L02B2',
	-- 'SHL.03B.R05A2',
	-- 'SHL.03B.R05B1',
	-- 'SHL.03A.L02B1',
	-- 'SHL.03A.L02B2',
	-- 'SHL.04A.R03B2',
	
	-- 'SHL.01B.L04A2',
	-- 'SHL.01B.L04A1',
	-- 'SHL.02A.L03A1',
	
	-- 'SHL.02B.R05B1',
	-- 'SHL.01B.L04B1'

-- DELETE FROM activity WHERE run_state_enum != 5;
-- DELETE FROM repository_hasmany_ingoing;

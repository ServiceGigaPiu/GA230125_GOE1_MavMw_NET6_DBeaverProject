
DROP VIEW IF EXISTS view_repo_status;
CREATE DEFINER=`dev`@`%` VIEW view_repo_status AS
SELECT repository.tag, udc.tag AS "held",
	IF(ISNULL(ing_exists),"TRUE","FALSE") AS HasIngoing,
	IF(ISNULL(outg_exists),"TRUE","FALSE") AS HasOutgoing,
	IF(ISNULL(outg_exists),IF(ISNULL(ing_exists),"FALSE","TRUE"), "TRUE") AS IsTransient,
	IF(ISNULL(udc.tag),"TRUE","FALSE") AS IsEmpty
FROM repository
LEFT JOIN udc ON repository.udc_now_id = udc.id
LEFT JOIN (
	SELECT DISTINCT is_queued_op AS ing_exists, repository_id
	FROM repository_hasmany_outgoing
	WHERE is_queued_op = FALSE
) AS outgoing ON repository.id = outgoing.repository_id
LEFT JOIN (
	SELECT DISTINCT is_queued_op AS outg_exists, repository_id
	FROM repository_hasmany_ingoing
	WHERE is_queued_op = FALSE
) AS ingoing ON repository.id = ingoing.repository_id;


DROP VIEW IF EXISTS view_repo_status_filtered;
CREATE DEFINER=`dev`@`%` VIEW view_repo_status_filtered AS
SELECT * FROM view_repo_status
WHERE held IS NOT NULL
	OR HasIngoing = "TRUE"
	OR HasOutgoing = "TRUE"
	OR IsTransient = "TRUE"
	OR IsEmpty = "FALSE";
	

-- SELECT * FROM repository
-- LEFT JOIN repository_hasmany_ingoing ON repository.id = repository_hasmany_ingoing.repository_id
-- LEFT JOIN repository_hasmany_outgoing ON repository.id = repository_hasmany_outgoing.repository_id
-- LEFT JOIN udc ON repository.udc_now_id = udc.id
-- LEFT JOIN udc AS udc_in ON repository_hasmany_ingoing.udc_id = udc_in.id
-- LEFT JOIN udc AS udc_out ON repository_hasmany_outgoing.udc_id = udc_out.id;
#WHERE repository_hasmany_ingoing.id IS NOT NULL OR repository_hasmany_outgoing.id IS NOT NULL



DROP VIEW IF EXISTS rawjointdata;
CREATE DEFINER=`dev`@`%` VIEW rawjointdata AS
SELECT
	repository.id AS repo_id,
		repository.tag AS repo_tag,
		repository.type_cid AS repo_type_cid,
		repository.udc_now_id AS repo_udc_now_id,
		repository.is_disabled AS repo_is_disabled,
		repository.is_uncertain AS repo_is_uncertain,
	repository_hasmany_ingoing.id AS ing_id,
		repository_hasmany_ingoing.repository_id AS ing_repository_id,
		repository_hasmany_ingoing.udc_id AS ing_udc_id,
		repository_hasmany_ingoing.is_queued_op AS ing_is_queued_op,
	repository_hasmany_outgoing.id AS outg_id,
		repository_hasmany_outgoing.repository_id AS outg_repository_id,
		repository_hasmany_outgoing.udc_id AS outg_udc_id,
		repository_hasmany_outgoing.is_queued_op AS outg_is_queued_op,
	udc_held.id AS udc_held_id,
		udc_held.tag AS udc_held_tag,
		udc_held.jdata AS udc_held_jdata,
	udc_in.id AS udc_in_id,
		udc_in.tag AS udc_in_tag,
		udc_in.jdata AS udc_in_jdata,
	udc_out.id AS udc_out_id,
		udc_out.tag AS udc_out_tag,
		udc_out.jdata AS udc_out_jdata
FROM repository
LEFT JOIN repository_hasmany_ingoing ON repository.id = repository_hasmany_ingoing.repository_id
LEFT JOIN repository_hasmany_outgoing ON repository.id = repository_hasmany_outgoing.repository_id
LEFT JOIN udc AS udc_held ON repository.udc_now_id = udc_held.id
LEFT JOIN udc AS udc_in ON repository_hasmany_ingoing.udc_id = udc_in.id
LEFT JOIN udc AS udc_out ON repository_hasmany_outgoing.udc_id = udc_out.id;



DROP VIEW IF EXISTS transferInfoDump;
CREATE DEFINER=`dev`@`%` VIEW transferInfoDump AS
SELECT
	repo_id, repo_tag,
	IF(ISNULL(repo_udc_now_id), NULL, COALESCE(udc_held_tag,"MISSING!")) AS held,
	repo_is_disabled AS DSBL,
	#IF(ISNULL(COALESCE(ing_id, outg_id)), NULL, IF(ISNULL(ing_id), "OUT", "IN")) AS TRANS,
	IF(ISNULL(ing_id), IF(ISNULL(outg_id), "NONE", "OUT"), IF(ISNULL(outg_id), "IN", "BOTH!")) AS TRANS,
	COALESCE(ing_is_queued_op, outg_is_queued_op, "NONE") AS T_Queue,
	COALESCE(udc_in_tag, udc_out_tag, "NONE") AS T_Tag,
	COALESCE(udc_held_jdata, udc_in_jdata, udc_out_jdata) AS jdata,
	#show raw data anyway
	ing_is_queued_op, outg_is_queued_op,
	udc_held_tag, udc_held_id, udc_in_id, udc_out_id,
	udc_in_tag, udc_out_tag,
	udc_held_jdata, udc_in_jdata, udc_out_jdata
FROM rawjointdata
WHERE	ing_id IS NOT NULL
	OR outg_id IS NOT NULL
	OR repo_udc_now_id IS NOT NULL;




DELIMITER $$
DROP FUNCTION IF EXISTS charIdxOf$$
CREATE FUNCTION charIdxOf (charIdx char, zeroAt char)
RETURNS int
BEGIN
	RETURN ORD(charIdx) - ORD(zeroAt);
END$$
DELIMITER ;



DROP VIEW IF EXISTS repositoryCoordinateRaw;
CREATE DEFINER=`readonly`@`%` VIEW repositoryCoordinateRaw AS
SELECT
	id AS repo_id
	,tag AS repo_tag
	,SUBSTRING(tag,5,2) as laneIdx
	,SUBSTRING(tag,7,1) as laneSubSection
	,SUBSTRING(tag,9,1) as sideOfLane
	,SUBSTRING(tag,10,2) as rackIdx
	,SUBSTRING(tag,12,1) as colCharIdx
	,SUBSTRING(tag,13,1) as rowIdx
FROM repository 
WHERE type_cid = 'S';



DROP VIEW IF EXISTS repositoryCoordinate;
CREATE DEFINER=`readonly`@`%` VIEW repositoryCoordinate AS
SELECT
	repo_id
	,repo_tag
	,laneIdx + 0 - 1 as lane0Idx
	,laneSubSection
	,sideOfLane
	,(rackIdx + 0 - 1) AS rack0Idx
	,colCharIdx AS colCharIdx
	,charIdxOf(colCharIdx, 'A') AS col0Idx
	,(rowIdx + 0 -1) AS row0Idx
	,((laneIdx - 1) * 2 + IF(sideOfLane = 'R', 0, 1) - 1) AS rackline0Idx
	,((rackIdx -1) * 2 + charIdxOf(colCharIdx, 'A')) AS absCol0Idx
FROM repositoryCoordinateRaw;



DROP VIEW IF EXISTS activityStatus;
CREATE DEFINER=`dev`@`%` VIEW activityStatus AS
SELECT
	activity.id AS _id,
	act_repo.tag AS repo_tag,
	act_udc.tag AS udc_tag,
	run_state_enum.name AS run_state,
	IF(activity.error_code = 0, "ok", "fail") AS ok,
	activity_uses_fleettag.fleettag AS fleettag,
	activity_hasunique_fleettag.fleettag AS fleettag_uq,
	activity_hasunique_clienttag.clienttag AS clienttag_uq,
	activity.*
FROM activity
LEFT JOIN (
	SELECT activity_uses_repository.activity_id, repository.tag FROM activity_uses_repository
	LEFT JOIN repository ON activity_uses_repository.repository_id = repository.id
	WHERE repository.type_cid = "S"
) AS act_repo	ON activity.id = act_repo.activity_id
LEFT JOIN (
	SELECT activity_uses_udc.activity_id, udc.tag FROM activity_uses_udc
	LEFT JOIN udc ON activity_uses_udc.udc_id = udc.id
) AS act_udc ON activity.id = act_udc.activity_id
LEFT JOIN run_state_enum ON activity.run_state_enum = run_state_enum.value
LEFT JOIN activity_uses_fleettag ON activity.id = activity_uses_fleettag.activity_id
LEFT JOIN activity_hasunique_fleettag ON activity.id = activity_hasunique_fleettag.activity_id
LEFT JOIN activity_hasunique_clienttag ON activity.id = activity_hasunique_clienttag.activity_id
ORDER BY activity.id;


SELECT * FROM activityStatus;











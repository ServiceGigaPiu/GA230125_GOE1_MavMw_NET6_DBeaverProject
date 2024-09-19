SELECT * FROM repository
LEFT JOIN repositorycoordinate ON repositorycoordinate.repo_id = repository.id
WHERE is_disabled <> 0 AND repositorycoordinate.row0Idx < 2
;




SELECT repo_id, repo_tag, activity.run_state_enum FROM rawjointdata
LEFT JOIN activity_uses_repository ON rawjointdata.repo_id = activity_uses_repository.repository_id
LEFT JOIN activity ON activity_uses_repository.activity_id = activity.id
WHERE (repo_is_uncertain = 1 OR (ing_id IS NOT NULL AND ing_is_queued_op = 0) OR (ing_id IS NOT NULL AND ing_is_queued_op = 0))
	

	
;
SELECT * FROM activity WHERE
	EXISTS(
		SELECT 1 FROM activity
		LEFT JOIN activity_uses_repository ON activity_uses_repository.activity_id = activity.id
		left join repository on activity_uses_repository.repository_id = repository.id
	   WHERE repository.tag = "SHL.01B.L05A1" AND activity.run_state_enum < 5
	);

	
	SELECT * FROM repository
	LEFT JOIN repository_hasmany_ingoing ON repository_hasmany_ingoing.repository_id = repository.id
	LEFT JOIN repository_hasmany_outgoing ON repository_hasmany_outgoing.repository_id = repository.id
	WHERE (ISNULL(repository_hasmany_ingoing.id) OR (ISNULL(repository_hasmany_outgoing.id))) = 1 #repository NON è transiente (non ha righe ne in in ne in out)
	
	
	
;
SELECT repository.* FROM repository
LEFT JOIN repositorycoordinate ON repository.id = repositorycoordinate.repo_id
WHERE repository.is_disabled = 0 AND row0Idx > 0;

SELECT * FROM repository_hasmany_ingoing
UNION
SELECT * FROM repository_hasmany_outgoing





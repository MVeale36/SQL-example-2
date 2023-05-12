SELECT description, RobberId, Nickname
	FROM hasSkills
	NATURAL JOIN skills
	NATURAL JOIN Robbers
	ORDER BY description;
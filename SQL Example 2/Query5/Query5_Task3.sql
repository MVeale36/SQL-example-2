SELECT a.RobberId, d.Nickname, c.description
	FROM (
		SELECT robberId, MAX(Preference) AS pref
		FROM hasSkills
		GROUP BY robberId
		) b
	JOIN hasSkills a ON a.RobberId = b.RobberId AND b.pref = a.Preference 
	JOIN skills c ON a.skillid = c.skillid
	JOIN robbers d ON a.RobberId = d.RobberId;
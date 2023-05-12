/* 2 */

SELECT a.RobberId, a.Nickname, a.Age, b.description 
	FROM robbers a
	INNER JOIN hasSkills c ON c.RobberId = a.RobberId
	INNER JOIN skills b ON c.skillId = b.skillId
	WHERE a.age > 40
	GROUP BY a.RobberId, b.description;
SELECT RobberId, Nickname, Earn 
	FROM(
		SELECT RobberId, SUM(Share) 
		AS Earn FROM Accomplices 
		GROUP BY RobberId) 
	AS TotalEarn
	NATURAL JOIN Robbers
	WHERE Earn > 40000
	ORDER BY Earn DESC;
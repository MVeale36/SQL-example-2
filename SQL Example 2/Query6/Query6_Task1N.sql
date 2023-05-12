SELECT nickName, SUM(Share) as ShareSum
	FROM Robbers
	NATURAL JOIN Accomplices
	WHERE noYears = 0
	GROUP BY RobberId, Nickname HAVING COUNT(*) > (
		SELECT AVG(a)
			FROM (
				SELECT COUNT(*) AS a
					FROM Accomplices
					GROUP BY RobberId
				)
			AS b
		)
	ORDER BY SUM(Share) DESC;
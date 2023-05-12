DROP VIEW IF EXISTS RobbersShare CASCADE;

CREATE VIEW RobbersShare AS 
	SELECT nickname, SUM(Share) as SumMoney, COUNT(*) as noRobs
		FROM Accomplices
		NATURAL JOIN Robbers
		GROUP BY nickname;
	
SELECT * FROM RobbersShare;

CREATE VIEW noArrested AS
	SELECT DISTINCT a.nickname, a.SumMoney
		FROM RobbersShare a, Robbers b
		WHERE a.nickname = b.nickname AND b.noYears = 0
		GROUP BY a.nickname, a.SumMoney, a.noRobs
		HAVING a.noRobs > (SELECT AVG(noRobs) FROM RobbersShare)
	ORDER BY a.SumMoney DESC;
		
SELECT * FROM noArrested;
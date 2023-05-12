DROP VIEW IF EXISTS bankData CASCADE;

CREATE VIEW bankData AS
	SELECT * 
		FROM Bank
		NATURAL JOIN Robberies;
		
SELECT * FROM bankData;

CREATE VIEW securityVal AS
	SELECT Security, Count(Security) AS NumRob, AVG(Amount) as avgStolen
		FROM bankData
		GROUP BY Security;
		
SELECT * FROM securityVal;


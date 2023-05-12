/* 1 */
SELECT bankName, city FROM bank WHERE (bankName, city) NOT IN (SELECT bankName, city FROM Robberies);

/* 2 */

SELECT a.RobberId, a.Nickname, a.Age, b.description 
	FROM robbers a
	INNER JOIN hasSkills c ON c.RobberId = a.RobberId
	INNER JOIN skills b ON c.skillId = b.skillId
	WHERE a.age > 40
	GROUP BY a.RobberId, b.description;
	
/* 3 */
SELECT bankName, city
	FROM Bank
	NATURAL JOIN HasAccounts
	NATURAL JOIN Robbers
	WHERE Nickname = 'Al Capone';
	
/* 4 */
SELECT bankName, city, noAccounts
	FROM Bank
	WHERE (city != 'Chicago')
	ORDER BY noAccounts;
	
/* 5 */
SELECT RobberId, Nickname, Earn 
	FROM(
		SELECT RobberId, SUM(Share) 
		AS Earn FROM Accomplices 
		GROUP BY RobberId) 
	AS TotalEarn
	NATURAL JOIN Robbers
	WHERE Earn > 40000
	ORDER BY Earn DESC;
	
/* 6 */ 
SELECT RobberId, Nickname, noYears
	FROM Robbers
	WHERE noYears > 10;
	
/* 7 */
SELECT RobberId, Nickname, (age-noYears) AS Years
	FROM Robbers 
	WHERE noYears > (age/2);
	
/* 8 */ 
SELECT description, RobberId, Nickname
	FROM hasSkills
	NATURAL JOIN skills
	NATURAL JOIN Robbers
	ORDER BY description;
	
/* PART 5 */

/* 1 */
SELECT a.bankName, a.city 
	FROM Robberies a, Plans b
	WHERE EXTRACT(YEAR FROM a.Date) != EXTRACT(YEAR FROM b.Date) AND a.city = b.city AND a.bankName = b.bankName
	
/* 2 */
Select Distinct RobberId, Nickname
	FROM Accomplices
	NATURAL JOIN Robbers
	WHERE RobberId NOT IN (
		Select a.RobberId FROM Accomplices b, hasAccounts a WHERE b.RobberId = a.RobberID AND a.bankName = b.bankName AND a.city = b.city
		)
	;
	
/* 4 */ 
select DISTINCT a.bankname, a.city, a.Date
	FROM Accomplices a, (SELECT City, Share FROM Accomplices WHERE Share = (SELECT MAX(Share) FROM Accomplices)) b, robberies c
	WHERE a.city = b.city;
	
/* 5 */


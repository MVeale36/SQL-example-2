/* 3 */
SELECT bankName, city
	FROM Bank
	NATURAL JOIN HasAccounts
	NATURAL JOIN Robbers
	WHERE Nickname = 'Al Capone';
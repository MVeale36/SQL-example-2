/* 4 */
SELECT bankName, city, noAccounts
	FROM Bank
	WHERE (city != 'Chicago')
	ORDER BY noAccounts;
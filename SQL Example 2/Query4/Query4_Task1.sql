/* 1 */
SELECT bankName, city FROM bank WHERE (bankName, city) NOT IN (SELECT bankName, city FROM Robberies);
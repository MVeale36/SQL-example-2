SELECT a.bankName, a.city 
	FROM Robberies a, Plans b
	WHERE EXTRACT(YEAR FROM a.Date) != EXTRACT(YEAR FROM b.Date) AND a.city = b.city AND a.bankName = b.bankName
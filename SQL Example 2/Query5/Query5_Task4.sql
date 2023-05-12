select DISTINCT a.bankname, a.city, a.Date
	FROM Accomplices a, (SELECT City, Share FROM Accomplices WHERE Share = (SELECT MAX(Share) FROM Accomplices)) b, robberies c
	WHERE a.city = b.city;

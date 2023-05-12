Select Distinct RobberId, Nickname
	FROM Accomplices
	NATURAL JOIN Robbers
	WHERE RobberId NOT IN (
		Select a.RobberId FROM Accomplices b, hasAccounts a WHERE b.RobberId = a.RobberID AND a.bankName = b.bankName AND a.city = b.city
		)
	;
SELECT RobberId, Nickname, (age-noYears) AS YearsNotInPrison
	FROM Robbers 
	WHERE noYears > (age/2);
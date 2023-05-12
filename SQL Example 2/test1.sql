explain analyze
Select clb.f_name, clb.l_name, noofbooks
FROM( 
	SELECT f_name, l_name, count(*) as noofbooks 
	FROM customer natural join loaned_book
	GROUP BY f_name, l_name
	ORDER BY noofbooks DESC
	) as clb
WHERE noofbooks >= 3;
	
	
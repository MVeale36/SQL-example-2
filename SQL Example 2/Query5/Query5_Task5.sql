/* Didnt work as Totalrobbers wouldnt register but expected correct result
SELECT a.bankName, a.city, COUNT(DISTINCT a.*) as TotalRobbers
FROM Accomplices a, robbers b
WHERE TotalRobbers > COUNT(DISTINCT b.*)
GROUP BY a.bankName, a.city;
*/

/* works expected result not sure if found in correct way as having is after group so may give wrong result if cases actually met */
SELECT a.bankName, a.city
FROM Accomplices a, robbers b
GROUP BY a.bankName, a.city
HAVING COUNT(DISTINCT a.*) > COUNT(DISTINCT b.*);
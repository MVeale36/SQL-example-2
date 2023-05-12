/* 1 */
INSERT INTO Skills(skillid, description) VALUES (21, 'Driving');

/* 2 */ 
INSERT INTO bank(bankname, city, noAccounts, security) VALUES ('Loanshark Bank','Evanston',100, 'very good');
INSERT INTO bank(bankname, city, noAccounts, security) VALUES ('EasyLoan Bank','Evanston',-5, 'very good');
INSERT INTO bank(bankname, city, noAccounts, security) VALUES ('EasyLoan Bank','Evanston',100, 'poor');

/* 3 */ 
INSERT INTO Robberies(bankname,city, Date, Amount) VALUES ('NXP Bank', 'Chicago', '2019-01-08', 1000);

/* 4 */
DELETE FROM skills WHERE skillid = 1 and description = 'Driving';

/* 5 */ 
DELETE FROM bank WHERE bankname = 'PickPocket Bank' and city = 'Evanston' and noAccounts = 2000 and security = 'very good';

/* 6 */
DELETE FROM Robberies WHERE bankname = 'PickPocket Bank' and city = 'Evanston' and Date = '' and Amount = '';

/* 7 */
INSERT INTO Robbers(RobberId, Nickname, age, noYears) VALUES (1, 'Shotgun', 70, 0);
INSERT INTO Robbers(RobberId, Nickname, age, noYears) VALUES (333, 'Jail Mouse', 25, 35);

/* 8 */
INSERT INTO HasSkills(RobberID, SkillId, Preference, Grade) VALUES (1, 7, 1, 'A+');
INSERT INTO HasSkills(RobberID, SkillId, Preference, Grade) VALUES (1, 2, 0, 'A');
INSERT INTO HasSkills(RobberID, SkillId, Preference, Grade) VALUES (333, 1, 1, 'B-');
INSERT INTO HasSkills(RobberID, SkillId, Preference, Grade) VALUES (3, 20, 3, 'B+');

/* 9 */ 
DELETE FROM Robbers WHERE RobberID = 1 and Nickname = 'Al Capone' and age = 31 and noYears = 2;
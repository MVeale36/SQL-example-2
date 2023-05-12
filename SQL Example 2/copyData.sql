/*bank*/
\copy Bank(bankName, city, noAccounts,security) from 'C:\\Users\\matth\\Desktop\\Uni 2022\\SWEN\\Data\\banks_22.data'

/*Plan*/
\copy Plans(bankName, city, Date, noRobbers) from 'C:\\Users\\matth\\Desktop\\Uni 2022\\SWEN\\Data\\plans_22.data'

/*Robberies*/
\copy Robberies(bankName, city, Date, Amount) from 'C:\\Users\\matth\\Desktop\\Uni 2022\\SWEN\\Data\\robberies_22.data'

/*Robbers*/
\copy Robbers(Nickname, Age, noYears) from 'C:\\Users\\matth\\Desktop\\Uni 2022\\SWEN\\Data\\robbers_22.data'

/*hasAccount*/

CREATE TABLE tempHasAccount(
	Nickname VARCHAR(50) NOT NULL,
	bankName VARCHAR(50),
	city VARCHAR(50)
);

\copy tempHasAccount(Nickname, bankName, city) from 'C:\\Users\\matth\\Desktop\\Uni 2022\\SWEN\\Data\\hasaccounts_22.data'

INSERT INTO hasAccounts( SELECT a.RobberId, b.bankName, b.city FROM Robbers a, tempHasAccount b WHERE a.Nickname = b.Nickname);

DROP TABLE tempHasAccount;

/*Accomp*/

CREATE TABLE tempAccomp(
	Nickname VARCHAR(50) NOT NULL,
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	Date DATE NOT NULL,
	Share DECIMAL(20,2) NOT NULL CHECK(Share > 0)
);

\copy tempAccomp(Nickname, bankName, city, Date, Share) from 'C:\\Users\\matth\\Desktop\\Uni 2022\\SWEN\\Data\\accomplices_22.data'

INSERT INTO Accomplices( SELECT a.RobberId, b.bankName, b.city, b.Date, b.Share FROM Robbers a, tempAccomp b WHERE a.Nickname = b.Nickname);

DROP TABLE tempAccomp;

/*hasSkills + Skills*/

CREATE TABLE tempSkills(
	Nickname VARCHAR(50) NOT NULL,
	Description VARCHAR(50) NOT NULL,
	Preference INTEGER NOT NULL,
	Grade VARCHAR(3) NOT NULL
);

\copy tempSkills(Nickname, Description, Preference, Grade) From 'C:\\Users\\matth\\Desktop\\Uni 2022\\SWEN\\Data\\hasskills_22.data'

CREATE VIEW DisSkills AS SELECT DISTINCT Description FROM tempSkills;

INSERT INTO Skills(SELECT nextval('skills_skillid_seq'), Description FROM DisSkills);

INSERT INTO hasSkills( SELECT a.RobberID, b.SkillId, c.Preference, c.Grade FROM Robbers a, Skills b, tempSkills c WHERE a.Nickname = c.Nickname AND b.Description = c.Description);

DROP VIEW DisSkills;
DROP TABLE tempSkills;


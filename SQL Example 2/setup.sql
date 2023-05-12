/* reset for test 
drop table if exists HasAccounts;
drop table if exists Accomplices;
drop table if exists hasSkills;
drop table if exists Plans;
drop table if exists Robberies;
drop table if exists Skills;
drop table if exists Robbers;
drop table if exists bank;
*/

/* Create */
CREATE TABLE Bank(
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	noAccounts INTEGER NOT NULL CHECK(noAccounts > 0),
	security VARCHAR(50) NOT NULL CHECK(Security IN('excellent','very good', 'good', 'weak')),
	PRIMARY KEY(bankName, city)
);

CREATE TABLE Robbers(
	RobberId BIGSERIAL PRIMARY KEY,
	Nickname VARCHAR(50) NOT NULL,
	age INTEGER NOT NULL CHECK(age > 0),
	noYears INTEGER NOT NULL CHECK(noYears >= 0),
	CHECK (age > noYears)
);

CREATE TABLE Skills(
	SkillId BIGSERIAL PRIMARY KEY,
	Description VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Robberies(
	Date DATE NOT NULL,
	Amount DECIMAL(20,2) NOT NULL CHECK (Amount > 0),
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	PRIMARY KEY(bankName, city, Date),
	FOREIGN KEY(bankName, city) REFERENCES Bank(bankName, city) ON DELETE RESTRICT ON UPDATE CASCADE
);
	
CREATE TABLE Plans(
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	noRobbers INTEGER NOT NULL CHECK (noRobbers > 0),
	Date DATE NOT NULL,
	PRIMARY KEY(bankName, city, Date),
	FOREIGN KEY(bankName, city) REFERENCES Bank(bankName, city) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE HasSkills(
	RobberId BIGINT NOT NULL,
	SkillId BIGINT NOT NULL,
	Preference INTEGER NOT NULL CHECK (preference > 0 AND Preference < 4),
	Grade VARCHAR(2) NOT NULL CHECK (Grade IN('C-', 'C ','C', 'C+', 'B-', 'B ', 'B' , 'B+', 'A-', 'A ', 'A', 'A+')), /* Assumes - grades exist */
	PRIMARY KEY(RobberID, SkillId),
	FOREIGN KEY(RobberId) REFERENCES Robbers(RobberId) ON UPDATE CASCADE,
	FOREIGN KEY(SkillId) REFERENCES Skills(SkillId) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE HasAccounts(
	RobberId BIGINT NOT NULL,
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	PRIMARY KEY(RobberId, bankName, city),
	FOREIGN KEY(RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(bankName, city) REFERENCES Bank(bankName, city) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Accomplices(
	RobberId BIGINT NOT NULL,
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	Date DATE NOT NULL,
	Share INTEGER NOT NULL CHECK(Share > 0),
	PRIMARY KEY(RobberId, bankName, city, Date),
	FOREIGN KEY(RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(bankName, city) REFERENCES Bank(bankName, city) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Copy Data */

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

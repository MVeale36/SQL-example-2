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
	Grade VARCHAR(3) NOT NULL,
	PRIMARY KEY(RobberID, SkillId),
	FOREIGN KEY(RobberId) REFERENCES Robbers(RobberId),
	FOREIGN KEY(SkillId) REFERENCES Skills(SkillId)
);

CREATE TABLE HasAccounts(
	RobberId BIGINT NOT NULL,
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	PRIMARY KEY(RobberId, bankName, city),
	FOREIGN KEY(RobberId) REFERENCES Robbers(RobberId),
	FOREIGN KEY(bankName, city) REFERENCES Bank(bankName, city) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Accomplices(
	RobberId BIGINT NOT NULL,
	bankName VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	Date DATE NOT NULL,
	Share INTEGER NOT NULL CHECK(Share > 0),
	PRIMARY KEY(RobberId, bankName, city, Date),
	FOREIGN KEY(RobberId) REFERENCES Robbers(RobberId),
	FOREIGN KEY(bankName, city) REFERENCES Bank(bankName, city) ON DELETE RESTRICT ON UPDATE CASCADE
);
 ---------------------------------------------------------------
 --        Script Oracle.  
 ---------------------------------------------------------------


------------------------------------------------------------
-- Table: Player
------------------------------------------------------------
CREATE TABLE Player(
	idJ         NUMBER NOT NULL ,
	pLogin      VARCHAR2 (25)NOT NULL  ,
	pFirst      VARCHAR2 (25)  ,
	pLast       VARCHAR2 (25)  ,
	pBirthYear  NUMBER(10,0)   ,
	tId         NUMBER(10,0)   ,
	CONSTRAINT Player_Pk PRIMARY KEY (idJ) ,
	CONSTRAINT Player_Uniq UNIQUE (pLogin)
);

------------------------------------------------------------
-- Table: Surface
------------------------------------------------------------
CREATE TABLE Surface(
	surfName  VARCHAR2 (25) NOT NULL  ,
	CONSTRAINT Surface_Pk PRIMARY KEY (surfName)
);

------------------------------------------------------------
-- Table: Team
------------------------------------------------------------
CREATE TABLE Team(
	tId            NUMBER NOT NULL ,
	Tname          VARCHAR2 (25)NOT NULL  ,
	TCreationDate  DATE  NOT NULL  ,
	CONSTRAINT Team_Pk PRIMARY KEY (tId) ,
	CONSTRAINT Team_Uniq UNIQUE (Tname)
);

------------------------------------------------------------
-- Table: Fixture
------------------------------------------------------------
CREATE TABLE Fixture(
	FId    NUMBER NOT NULL ,
	fDate  DATE  NOT NULL  ,
	CONSTRAINT Fixture_Pk PRIMARY KEY (FId)
);

------------------------------------------------------------
-- Table: Site
------------------------------------------------------------
CREATE TABLE Site(
	sName         VARCHAR2 (25) NOT NULL  ,
	SAdrNumber    VARCHAR2 (25)  ,
	SAdrStreet    VARCHAR2 (25) NOT NULL  ,
	sAdrPostCode  NUMBER(10,0)   ,
	sAdrCity      VARCHAR2 (25) NOT NULL  ,
	CONSTRAINT Site_Pk PRIMARY KEY (sName)
);

------------------------------------------------------------
-- Table: Confrontation
------------------------------------------------------------
CREATE TABLE Confrontation(
	tId       NUMBER(10,0)  NOT NULL  ,
	FId       NUMBER(10,0)  NOT NULL  ,
	tId_Team  NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT Confrontation_Pk PRIMARY KEY (tId,FId,tId_Team)
);

------------------------------------------------------------
-- Table: Host
------------------------------------------------------------
CREATE TABLE Host(
	FId       NUMBER(10,0)  NOT NULL  ,
	sName     VARCHAR2 (25) NOT NULL  ,
	surfName  VARCHAR2 (25) NOT NULL  ,
	CONSTRAINT Host_Pk PRIMARY KEY (FId,sName,surfName)
);

------------------------------------------------------------
-- Table: Proposes
------------------------------------------------------------
CREATE TABLE Proposes(
	surfName  VARCHAR2 (25) NOT NULL  ,
	sName     VARCHAR2 (25) NOT NULL  ,
	CONSTRAINT Proposes_Pk PRIMARY KEY (surfName,sName)
);




ALTER TABLE Player ADD FOREIGN KEY (tId) REFERENCES Team(tId);
ALTER TABLE Confrontation ADD FOREIGN KEY (tId) REFERENCES Team(tId);
ALTER TABLE Confrontation ADD FOREIGN KEY (FId) REFERENCES Fixture(FId);
ALTER TABLE Confrontation ADD FOREIGN KEY (tId_Team) REFERENCES Team(tId);
ALTER TABLE Host ADD FOREIGN KEY (FId) REFERENCES Fixture(FId);
ALTER TABLE Host ADD FOREIGN KEY (sName) REFERENCES Site(sName);
ALTER TABLE Host ADD FOREIGN KEY (surfName) REFERENCES Surface(surfName);
ALTER TABLE Proposes ADD FOREIGN KEY (surfName) REFERENCES Surface(surfName);
ALTER TABLE Proposes ADD FOREIGN KEY (sName) REFERENCES Site(sName);

CREATE SEQUENCE Seq_Player_idJ START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_Team_tId START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_Fixture_FId START WITH 1 INCREMENT BY 1 NOCYCLE;


CREATE OR REPLACE TRIGGER Player_idJ
	BEFORE INSERT ON Player 
  FOR EACH ROW 
	WHEN (NEW.idJ IS NULL) 
	BEGIN
		 select Seq_Player_idJ.NEXTVAL INTO :NEW.idJ from DUAL; 
	END;
CREATE OR REPLACE TRIGGER Team_tId
	BEFORE INSERT ON Team 
  FOR EACH ROW 
	WHEN (NEW.tId IS NULL) 
	BEGIN
		 select Seq_Team_tId.NEXTVAL INTO :NEW.tId from DUAL; 
	END;
CREATE OR REPLACE TRIGGER Fixture_FId
	BEFORE INSERT ON Fixture 
  FOR EACH ROW 
	WHEN (NEW.FId IS NULL) 
	BEGIN
		 select Seq_Fixture_FId.NEXTVAL INTO :NEW.FId from DUAL; 
	END;


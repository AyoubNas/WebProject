------------------------------------------------------------
--        Script Postgre 
------------------------------------------------------------



------------------------------------------------------------
-- Table: Player
------------------------------------------------------------
CREATE TABLE public.Player(
	idJ        SERIAL NOT NULL ,
	pLogin     VARCHAR (25) NOT NULL UNIQUE,
	pFirst     VARCHAR (25)  ,
	pLast      VARCHAR (25)  ,
	pBirthYear INT   ,
	tId        INT   ,
	CONSTRAINT prk_constraint_Player PRIMARY KEY (idJ)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: Surface
------------------------------------------------------------
CREATE TABLE public.Surface(
	surfName VARCHAR (25) NOT NULL ,
	CONSTRAINT prk_constraint_Surface PRIMARY KEY (surfName)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: Team
------------------------------------------------------------
CREATE TABLE public.Team(
	tId           SERIAL NOT NULL ,
	Tname         VARCHAR (25) NOT NULL UNIQUE,
	TCreationDate DATE  NOT NULL ,
	CONSTRAINT prk_constraint_Team PRIMARY KEY (tId)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: Fixture
------------------------------------------------------------
CREATE TABLE public.Fixture(
	FId   SERIAL NOT NULL ,
	fDate DATE  NOT NULL ,
	CONSTRAINT prk_constraint_Fixture PRIMARY KEY (FId)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: Site
------------------------------------------------------------
CREATE TABLE public.Site(
	sName        VARCHAR (25) NOT NULL ,
	SAdrNumber   VARCHAR (25)  ,
	SAdrStreet   VARCHAR (25) NOT NULL ,
	sAdrPostCode INT   ,
	sAdrCity     VARCHAR (25) NOT NULL ,
	CONSTRAINT prk_constraint_Site PRIMARY KEY (sName)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: Confrontation
------------------------------------------------------------
CREATE TABLE public.Confrontation(
	tId      INT  NOT NULL ,
	FId      INT  NOT NULL ,
	tId_Team INT  NOT NULL ,
	CONSTRAINT prk_constraint_Confrontation PRIMARY KEY (tId,FId,tId_Team)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: Host
------------------------------------------------------------
CREATE TABLE public.Host(
	FId      INT  NOT NULL ,
	sName    VARCHAR (25) NOT NULL ,
	surfName VARCHAR (25) NOT NULL ,
	CONSTRAINT prk_constraint_Host PRIMARY KEY (FId,sName,surfName)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: Proposes
------------------------------------------------------------
CREATE TABLE public.Proposes(
	surfName VARCHAR (25) NOT NULL ,
	sName    VARCHAR (25) NOT NULL ,
	CONSTRAINT prk_constraint_Proposes PRIMARY KEY (surfName,sName)
)WITHOUT OIDS;



ALTER TABLE public.Player ADD CONSTRAINT FK_Player_tId FOREIGN KEY (tId) REFERENCES public.Team(tId);
ALTER TABLE public.Confrontation ADD CONSTRAINT FK_Confrontation_tId FOREIGN KEY (tId) REFERENCES public.Team(tId);
ALTER TABLE public.Confrontation ADD CONSTRAINT FK_Confrontation_FId FOREIGN KEY (FId) REFERENCES public.Fixture(FId);
ALTER TABLE public.Confrontation ADD CONSTRAINT FK_Confrontation_tId_Team FOREIGN KEY (tId_Team) REFERENCES public.Team(tId);
ALTER TABLE public.Host ADD CONSTRAINT FK_Host_FId FOREIGN KEY (FId) REFERENCES public.Fixture(FId);
ALTER TABLE public.Host ADD CONSTRAINT FK_Host_sName FOREIGN KEY (sName) REFERENCES public.Site(sName);
ALTER TABLE public.Host ADD CONSTRAINT FK_Host_surfName FOREIGN KEY (surfName) REFERENCES public.Surface(surfName);
ALTER TABLE public.Proposes ADD CONSTRAINT FK_Proposes_surfName FOREIGN KEY (surfName) REFERENCES public.Surface(surfName);
ALTER TABLE public.Proposes ADD CONSTRAINT FK_Proposes_sName FOREIGN KEY (sName) REFERENCES public.Site(sName);

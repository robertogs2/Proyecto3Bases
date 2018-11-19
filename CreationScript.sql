USE master;
GO
DROP DATABASE GREENTEC;
CREATE DATABASE GREENTEC;
USE GREENTEC;
GO

IF OBJECT_ID('dbo.Visitor', 'U') IS NOT NULL DROP TABLE dbo.Visitor; -- Drop Visitor table in case it already exists
IF OBJECT_ID('dbo.VehicleXEmployee', 'U') IS NOT NULL DROP TABLE dbo.VehicleXEmployee; -- Drop VehicleXEmployee table in case it already exists
IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL DROP TABLE dbo.Employee; -- Drop Employee table in case it already exists
IF OBJECT_ID('dbo.Person', 'U') IS NOT NULL DROP TABLE dbo.Person; -- Drop Person table in case it already exists
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL DROP TABLE dbo."Location"; -- Drop Location table in case it already exists
IF OBJECT_ID('dbo.City', 'U') IS NOT NULL DROP TABLE dbo.City; -- Drop City table in case it already exists
IF OBJECT_ID('dbo.State', 'U') IS NOT NULL DROP TABLE dbo."State"; -- Drop State table in case it already exists
IF OBJECT_ID('dbo.Country', 'U') IS NOT NULL DROP TABLE dbo.Country; -- Drop Country table in case it already exists
IF OBJECT_ID('dbo.Community', 'U') IS NOT NULL DROP TABLE dbo.Community; -- Drop Community table in case it already exists
IF OBJECT_ID('dbo.Park', 'U') IS NOT NULL DROP TABLE dbo.Park; -- Drop Park table in case it already exists
IF OBJECT_ID('dbo.CommunityXPark', 'U') IS NOT NULL DROP TABLE dbo.CommunityXPark; -- Drop CommunityXPark table in case it already exists
IF OBJECT_ID('dbo.Area', 'U') IS NOT NULL DROP TABLE dbo.Area; -- Drop Area table in case it already exists
IF OBJECT_ID('dbo.Vehicle', 'U') IS NOT NULL DROP TABLE dbo.Vehicle; -- Drop Vehicle table in case it already exists
IF OBJECT_ID('dbo.AssignedArea', 'U') IS NOT NULL DROP TABLE dbo.AssignedArea; -- Drop AssignedArea table in case it already exists
IF OBJECT_ID('dbo.Speciality', 'U') IS NOT NULL DROP TABLE dbo.Speciality; -- Drop Speciality table in case it already exists
IF OBJECT_ID('dbo.ResearchProject', 'U') IS NOT NULL DROP TABLE dbo.ResearchProject; -- Drop ResearchProject table in case it already exists
IF OBJECT_ID('dbo.ResearchProjectXEmployee', 'U') IS NOT NULL DROP TABLE dbo.ResearchProjectXEmployee; -- Drop ResearchProjectXEmployee table in case it already exists
IF OBJECT_ID('dbo.Profession', 'U') IS NOT NULL DROP TABLE dbo.Profession; -- Drop Profession table in case it already exists
IF OBJECT_ID('dbo.Accommodation', 'U') IS NOT NULL DROP TABLE dbo.Accommodation; -- Drop Accommodation table in case it already exists
IF OBJECT_ID('dbo.Tour', 'U') IS NOT NULL DROP TABLE dbo.Tour; -- Drop Tour table in case it already exists
IF OBJECT_ID('dbo.AccommodationXTour', 'U') IS NOT NULL DROP TABLE dbo.AccommodationXTour; -- Drop AccommodationXTour table in case it already exists
-- Country table creation.
CREATE TABLE Country(
	idCountry INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL
);

-- State table creation.
CREATE TABLE "State"( -- Double quotes because state is a key word
	idState INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	fk_idCountry INT FOREIGN KEY REFERENCES Country(idCountry) NOT NULL
);

-- State table creation.
CREATE TABLE City(
	idCity INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	fk_idState INT FOREIGN KEY REFERENCES "State"(idState) NOT NULL-- Double quotes because state is a key word
);

-- Location table creation.
CREATE TABLE "Location"(-- Double quotes because location is a key word
	idLocation INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idCity INT FOREIGN KEY REFERENCES City(idCity) NOT NULL,
	"Description" VARCHAR(50) NULL -- Null as default value, and double quotation as description is a keyword
);

-- Community table creation.
CREATE TABLE Community(
	idCommunity INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	fk_idState INT FOREIGN KEY REFERENCES "State"(idState) NOT NULL,
	NumberOfParks INT NULL,	-- Null as default value, this data is included for high performance query
	TotalProtectedArea FLOAT NULL	-- Null as default value, this data is include for high performance query
);

CREATE INDEX community_index
ON Community (NumberOfParks, TotalProtectedArea);

-- Natural park table creation.
CREATE TABLE Park(
	idPark INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(50) NOT NULL, -- Double quotes because name is a key word
	foundationDate VARCHAR(15)	NOT NULL
);

-- CommunityXPark table creation.
CREATE TABLE CommunityXPark(
	fk_idCommunity INT FOREIGN KEY REFERENCES Community(idCommunity) NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL
);

-- Area table creation.
CREATE TABLE Area(
	idArea INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	Size INT	NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark)
);

-- Person table creation
CREATE TABLE Person(
	idPerson INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	IdNumber INT UNIQUE NOT NULL,
	"Name" VARCHAR(15) NOT NULL,
	LastName VARCHAR(15) NOT NULL,
	fk_idLocation INT FOREIGN KEY REFERENCES "Location"(idLocation) NULL,
	PhoneNumber INT NULL
);

-- Profession table clreation
CREATE TABLE Profession(
	idProfession INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(25) NOT NULL
);

-- AssignedArea table creation
CREATE TABLE AssignedArea(
	idAssignedArea INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(25) NOT NULL
);

-- Speciality table creation
CREATE TABLE Speciality(
	idSpeciality INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(25)
);

-- Employee table creation

CREATE TABLE Employee(
	idEmployee INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idPerson INT FOREIGN KEY REFERENCES Person(idPerson) NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL,
	fk_idProfession INT FOREIGN KEY REFERENCES Profession(idProfession) NOT NULL,
	fk_idAssignedArea INT FOREIGN KEY REFERENCES AssignedArea(idAssignedArea) NULL,
	fk_idSpeciality INT FOREIGN KEY REFERENCES Speciality(idSpeciality) NULL,
	Salary INT
);


-- Vehicle table creation
CREATE TABLE Vehicle(
	idVehicle INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	"Type" VARCHAR(15) NOT NULL,
	RegistrationPlate VARCHAR(15) NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL
);

-- VehicleXEmployee table creation
CREATE TABLE VehicleXEmployee(
	fk_idVehicle INT FOREIGN KEY REFERENCES Vehicle(idVehicle) NOT NULL,
	fk_idEmployee INT FOREIGN KEY REFERENCES Employee(idEmployee) NOT NULL,
	LoanDate DATETIME
);

-- InvestigationProject table creation
CREATE TABLE ResearchProject(
	idResearchProject INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	Budget INT NOT NULL,
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NULL,
	"Description" VARCHAR(50)
);

-- ResearchProjectXEmployee table creation
CREATE TABLE ResearchProjectXEmployee(
	fk_idResearchProject INT FOREIGN KEY REFERENCES ResearchProject(idResearchProject) NOT NULL,
	fk_idEmployee INT FOREIGN KEY REFERENCES Employee(idEmployee) NOT NULL,
	ColabStartTime DATETIME NOT NULL,
	ColabEndTime DATETIME NULL
);

-- Accommodation table creation
CREATE TABLE Accommodation(
	idAccommodation INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL,
	Category VARCHAR(15) NOT NULL,
	Capacity  INT NOT NULL,
	BasePrice INT DEFAULT 0
);

-- Visitor table creation
CREATE TABLE Visitor(
	idVisitor INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idPerson INT FOREIGN KEY REFERENCES Person(idPerson) NOT NULL,
	fk_idProfession INT FOREIGN KEY REFERENCES Profession(idProfession) NULL
);


CREATE TABLE TourType(
	idTourType INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	"Description"  VARCHAR(50) NULL
);

-- Tour table creation
CREATE TABLE Tour(
	idTour INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NULL, -- Double quotes because name is a key word
	"Description" VARCHAR(50) NULL, -- Double quotes because description is a key word
	Price INT NULL,
	Capacity INT NULL,
	fk_idVehicle INT FOREIGN KEY REFERENCES Vehicle(idVehicle),
	fk_idTourType INT FOREIGN KEY REFERENCES TourType(idTourType),
	fk_idArea INT FOREIGN KEY REFERENCES Area(idArea)
); 

-- AccommodationXTour table creation
CREATE TABLE AccommodationXTour(
	fk_idAccommodation INT FOREIGN KEY REFERENCES Accommodation(idAccommodation) NOT NULL,
	fk_idTour INT FOREIGN KEY REFERENCES Tour(idTour) NOT NULL,
	Schedule DATETIME
);

-- Visit table creation
CREATE TABLE Visit(
	idVisit INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idVisitor INT FOREIGN KEY REFERENCES Visitor(idVisitor) NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL,
	fk_idAccommodation INT FOREIGN KEY REFERENCES Accommodation(idAccommodation) NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL
);
USE master;
GO
DROP DATABASE GREENTECDW;
CREATE DATABASE GREENTECDW;
USE GREENTECDW;
GO

IF OBJECT_ID('dbo.Zone', 'U') IS NOT NULL DROP TABLE dbo."Zone";
IF OBJECT_ID('dbo.Income', 'U') IS NOT NULL DROP TABLE dbo.Income;
IF OBJECT_ID('dbo.Outcome', 'U') IS NOT NULL DROP TABLE dbo.Outcome;
IF OBJECT_ID('dbo.TimeStamp', 'U') IS NOT NULL DROP TABLE dbo."TimeStamp";
IF OBJECT_ID('dbo.Record', 'U') IS NOT NULL DROP TABLE dbo.Record;

CREATE TABLE "Zone" (
	pk_idZone INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	Park VARCHAR(50) Not Null,
	Area VARCHAR(50) Not Null,
	Accomodation VARCHAR(50) Not Null
);

CREATE TABLE Income (
	pk_idIncome INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	AccommodationIncome FLOAT,
	ToursIncome FLOAT
);

CREATE TABLE Outcome (
	pk_idOutcome INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	AccomodationOutcome FLOAT,
	TourCost FLOAT,
	EmployeesCost FLOAT
);

CREATE TABLE "TimeStamp" (
	pk_idTimeStamp INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Time" DATETIME
);

CREATE TABLE Record (
	pk_idRecord INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idZone INT FOREIGN KEY REFERENCES "Zone"(pk_idZone) NOT NULL,
	fk_idIncome INT FOREIGN KEY REFERENCES Income(pk_idIncome) NOT NULL,
	fk_idOutcome INT FOREIGN KEY REFERENCES Outcome(pk_idOutcome) NOT NULL,
	fk_idTimeStamp INT FOREIGN KEY REFERENCES "TimeStamp"(pk_idTimeStamp) NOT NULL,
	
);
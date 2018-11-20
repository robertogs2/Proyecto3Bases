USE master;
GO
DROP DATABASE GREENTECDW;
CREATE DATABASE GREENTECDW;
USE GREENTECDW;
GO

IF OBJECT_ID('dbo.Entry', 'U') IS NOT NULL DROP TABLE dbo."Entry";
IF OBJECT_ID('dbo.Service', 'U') IS NOT NULL DROP TABLE dbo."Service";
IF OBJECT_ID('dbo.Date', 'U') IS NOT NULL DROP TABLE dbo."Date";
CREATE TABLE "Date" (
	pk_idDate INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Time" DATE,
	"Week" INT,
	"Month" VARCHAR(15),
	"Year" INT,
	"Quarter" INT,
	"Weekday" VARCHAR(15)
);

CREATE TABLE "Service" (
	pk_idService INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	Park VARCHAR(70) NOT NULL, --name of the park
	ZoneType VARCHAR(70) NOT NULL, -- accommodation, tour, worker
	Area VARCHAR(70) NOT NULL, -- area of the tour
	"Description" VARCHAR(70) NOT NULL -- type of the tour
);


CREATE TABLE "Entry" (
	pk_idEntry INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idService INT FOREIGN KEY REFERENCES "Service"(pk_idService) NOT NULL,
	fk_idDate INT FOREIGN KEY REFERENCES "Date"(pk_idDate) NOT NULL,
	PricePayed DECIMAL(18,0), --income
	EmployeeSalary  DECIMAL(18,0), -- outcome
	Maintenance  DECIMAL(18,0), -- outcome
);





USE master;
GO
DROP DATABASE GREENTECDW;
CREATE DATABASE GREENTECDW;
USE GREENTECDW;
GO

IF OBJECT_ID('dbo.Resource', 'U') IS NOT NULL DROP TABLE dbo."Resource";
IF OBJECT_ID('dbo.Utility', 'U') IS NOT NULL DROP TABLE dbo."Utility";
IF OBJECT_ID('dbo.TimeStamp', 'U') IS NOT NULL DROP TABLE dbo."TimeStamp";
IF OBJECT_ID('dbo.Record', 'U') IS NOT NULL DROP TABLE dbo.Record;

CREATE TABLE "Date" (
	pk_idTimeStamp INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Time" DATE
);

CREATE TABLE "Resource" (
	pk_idResource INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	Park VARCHAR(50) NOT NULL, --name of the park
	ZoneType INT NOT NULL, -- accommodation, tour, worker
	Area VARCHAR(50) NOT NULL, -- area of the tour
	"Description" VARCHAR(50) NOT NULL -- type of the tour
);

CREATE TABLE Utility (
	pk_idUtility INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	PricePayed FLOAT, --income
	EmployeeSalary INT, -- outcome
	Maintenance INT -- outcome
);

CREATE TABLE Record (
	pk_idRecord INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idResource INT FOREIGN KEY REFERENCES "Resource"(pk_idResource) NOT NULL,
	fk_idUtility INT FOREIGN KEY REFERENCES Utility(pk_idUtility) NOT NULL,
	fk_idTimeStamp INT FOREIGN KEY REFERENCES "TimeStamp"(pk_idTimeStamp) NOT NULL
);




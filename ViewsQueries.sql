USE GREENTEC
GO

DROP VIEW DateView
CREATE VIEW DateView AS

WITH RS AS (
	(--Tour
		SELECT CONVERT(DATE, Schedule) AS "Time"
		FROM AccommodationXTour
		INNER JOIN Tour ON AccommodationXTour.fk_idTour = idTour
	)
	UNION ALL
	(--Accommodation
		SELECT  CONVERT(DATE, StartDate) AS "Time"
		FROM Visit
	)
	)
SELECT "Time", ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS pk_idDate FROM RS


DROP VIEW UtilityView
CREATE VIEW UtilityView AS

WITH RS AS (
	(--Accommodation
		SELECT Accommodation.BasePrice * DATEDIFF(DAY, StartDate, EndDate) AS PricePayed, 
		CASE Accommodation.Category
			 WHEN 'Gold' THEN 5000*DATEDIFF(DAY, StartDate, EndDate)  
			 WHEN 'Silver' THEN 2000*DATEDIFF(DAY, StartDate, EndDate) 
			 ELSE 1000*DATEDIFF(DAY, StartDate, EndDate)
		END AS Maintenance, 
		Employee.Salary*1/80*DATEDIFF(DAY, StartDate, EndDate) AS EmployeeSalary
		FROM Visit
		INNER JOIN Accommodation ON Accommodation.idAccommodation = fk_idAccommodation
		INNER JOIN Employee ON Employee.idEmployee = (select CAST(700 *  sqrt(exp(cos(idVisit))) AS INT) % 700)
	)
	UNION ALL
	(--Tour
		SELECT Price*630 AS PricePayed, --dollar transform
		CASE TourType.idTourType
			 WHEN 1 THEN 5000
			 WHEN 2 THEN 2000
			 ELSE 1000
		END AS Maintenance, 
		Employee.Salary*1/80 AS EmployeeSalary
		FROM AccommodationXTour
		INNER JOIN Tour ON AccommodationXTour.fk_idTour = idTour
		INNER JOIN TourType ON TourType.idTourType = fk_idTourType
		INNER JOIN Employee ON Employee.idEmployee = (select CAST(700 *  sqrt(exp(cos(idTour))) AS INT) % 700)
	)
)
SELECT PricePayed, Maintenance, EmployeeSalary, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS pk_idUtility FROM RS

DROP VIEW ResourceView
CREATE VIEW ResourceView AS
WITH RS AS (
	(--Accommodation
		SELECT Park.Name AS ParkName,
		'Accommodation' AS ZoneType,
		'None' AS AreaName,
		'Capacity: ' + STR(Accommodation.Capacity+1) AS "Description"
		FROM Visit
		INNER JOIN Accommodation ON Accommodation.idAccommodation = fk_idAccommodation
		INNER JOIN Park ON Park.idPark = Visit.fk_idPark
	)
	UNION ALL
	(--Tour
		SELECT Park."Name" AS ParkName,
		'Tour' AS ZoneType, Area."Name" AS AreaName,
		TourType."Description" + ' ' + Tour."Name" AS "Description"
		FROM AccommodationXTour
		INNER JOIN Tour ON AccommodationXTour.fk_idTour = idTour
		INNER JOIN Area ON Area.idArea = fk_idArea
		INNER JOIN Park ON Park.idPark = fk_idPark
		INNER JOIN TourType ON TourType.idTourType = fk_idTourType
	)
)
SELECT ParkName, ZoneType, AreaName, "Description", ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS pk_idService FROM RS
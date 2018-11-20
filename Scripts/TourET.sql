SELECT Park."Name" AS ParkName, CONVERT(DATE, Schedule) AS "Time",
Price*630 AS PricePayed,
CASE TourType.idTourType
     WHEN 1 THEN 5000
	 WHEN 2 THEN 2000
     ELSE 1000
END AS Maintenance, 
Employee.Salary*1/80 AS EmployeeSalary,
'Tour' AS ZoneType, Area."Name" AS AreaName,
TourType."Description" + ' ' + Tour."Name" AS Description
FROM AccommodationXTour
INNER JOIN Tour ON AccommodationXTour.fk_idTour = idTour
INNER JOIN Area ON Area.idArea = fk_idArea
INNER JOIN Park ON Park.idPark = fk_idPark
INNER JOIN TourType ON TourType.idTourType = fk_idTourType
INNER JOIN Employee ON Employee.idEmployee = (select CAST(700 *  sqrt(exp(cos(Park.idPark))) AS INT) % 700)

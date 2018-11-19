SELECT Park.Name AS ParkName, CONVERT(DATE, StartDate) AS "Time", Accommodation.BasePrice * DATEDIFF(DAY, StartDate, EndDate) AS PricePayed, 
CASE Accommodation.Category
     WHEN 'Gold' THEN 20000  
	 WHEN 'Silver' THEN 5000  
     ELSE 1000
END AS Maintenance, 
Employee.Salary*1/80 AS EmployeeSalary,
'Accommodation' AS ZoneType,
'None' AS AreaName,
'Capacity: ' + STR(Accommodation.Capacity+1) AS "Description"
FROM Visit
INNER JOIN Accommodation ON Accommodation.idAccommodation = fk_idAccommodation
INNER JOIN Park ON Park.idPark = Visit.fk_idPark
INNER JOIN Employee ON Employee.idEmployee = (select CAST(700 *  sqrt(exp(cos(Park.idPark))) AS INT) % 700)

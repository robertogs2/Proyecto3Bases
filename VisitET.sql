SELECT Park.Name AS ParkName, CONVERT(DATE, StartDate) AS "Time", Accommodation.BasePrice * DATEDIFF(DAY, StartDate, EndDate) AS Price
FROM Visit
INNER JOIN Accommodation ON Accommodation.idAccommodation = fk_idAccommodation
INNER JOIN Park ON Park.idPark = Visit.fk_idPark;
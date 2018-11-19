SELECT idTour, Area."Name" AS AreaName, Park."Name" AS ParkName, Price*630 AS Income, TourType."Description" + ' ' + Tour."Name" AS TourName
FROM Tour
INNER JOIN Area ON Area.idArea = fk_idArea
INNER JOIN Park ON Park.idPark = fk_idPark
INNER JOIN TourType ON TourType.idTourType = fk_idTourType

SELECT * FROM TourType
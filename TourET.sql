SELECT idTour, Area."Name" AS AreaName, Park."Name" AS ParkName, Price, TourType."Description"
FROM Tour
INNER JOIN Area ON Area.idArea = fk_idArea
INNER JOIN Park ON Park.idPark = fk_idPark
INNER JOIN TourType ON TourType.idTourType = fk_idTourType
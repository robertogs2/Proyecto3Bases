USE BASESTEC;

-- setup a variable to take the file data
DECLARE @fileData  XML

-- import the file contents into the variable
SELECT @fileData=BulkColumn FROm OpenRowSet(Bulk'\\DEVSQLCLU\openfolder\DB.xml',Single_blob) x;


-- insert the xml data into our Country table (Name)
INSERT INTO Country
      ("Name") -- Double quotes because name is a sql keyword, so it can be used as column name.
SELECT
   xData.value('Name[1]','VARCHAR(15)') "Name"        -- 'xData' is our xml content alias
FROM @fileData.nodes('/DB/Countries/Country') AS x(xData)-- this is the xpath to the individual records we want to extract

-- insert the xml data into our State table (fk_idCountry, Name)
INSERT INTO "State"
	("Name", fk_idCountry)
SELECT
	xData.value('Name[1]', 'VARCHAR(15)') "Name", -- 'xData' is our xml content alias
	xData.value('CountryId[1]', 'int') fk_idCountry
FROM @fileData.nodes('/DB/States/State') AS x(xData)

-- insert the xml data into our City table (fk_idState, Name)
INSERT INTO City
	("Name", fk_idState)
SELECT
	xData.value('Name[1]', 'VARCHAR(15)') "Name", -- 'xData' is our xml content alias
	xData.value('StateId[1]', 'int') fk_idState
FROM @fileData.nodes('/DB/Cities/City') AS x(xData)

-- insert the xml data into our Community table (Name, fk_idState, NumberOfParks, TotalProtectedArea)
INSERT INTO Community
	("Name", fk_idState, NumberOfParks, TotalProtectedArea)
SELECT
	xData.value('Name[1]', 'VARCHAR(15)') "Name", -- 'xData' is our xml content alias
	xData.value('StateId[1]', 'int') fk_idState,
	xData.value('NumberOfParks[1]', 'int') NumberOfParks,
	xData.value('TotalProtectedArea[1]', 'float') TotalProtectedArea
FROM @fileData.nodes('/DB/Communities/Community') AS x(xData)

-- insert the xml data into our Park table (Name, foundationDate)
INSERT INTO Park
	("Name", foundationDate)
SELECT
	xData.value('Name[1]', 'VARCHAR(50)') "Name", -- 'xData' is our xml content alias
	xData.value('FoundationDate[1]', 'VARCHAR(15)') foundationDate
FROM @fileData.nodes('/DB/Parks/Park') AS x(xData)

-- insert the xml data into our CommunityXPark table (fk_idCommunity, fk_idPark)
INSERT INTO CommunityXPark
	(fk_idCommunity, fk_idPark)
SELECT
	xData.value('CommunityId[1]', 'int') fk_idCommunity, -- 'xData' is our xml content alias
	xData.value('ParkId[1]', 'int') fk_idPark
FROM @fileData.nodes('/DB/CommunitiesXParks/CommunityXPark') AS x(xData)

-- insert the xml data into our Vehicle table (Type, RegistrationPlate, fk_idPark)
INSERT INTO Vehicle
	("Type", RegistrationPlate, fk_idPark)
SELECT
	xData.value('Type[1]', 'VARCHAR(15)') "Type", -- 'xData' is our xml content alias
	xData.value('RegistrationNumber[1]', 'VARCHAR(15)') RegistrationPlate,
	xData.value('ParkId[1]', 'int') fk_idPark
FROM @fileData.nodes('/DB/Vehicles/Vehicle') AS x(xData)

-- insert the xml data into our Location table (fk_idCity, Description)
INSERT INTO "Location"
	(fk_idCity, "Description")
SELECT
	xData.value('CityId[1]', 'int') fk_idCity, -- 'xData' is our xml content alias
	xData.value('Description[1]', 'VARCHAR(50)') "Description"
FROM @fileData.nodes('/DB/Locations/Location') AS x(xData)

-- insert the xml data into our Person table (IdNumber, Name, Surname, fk_idLocation, PhoneNumber)
INSERT INTO Person
	(IdNumber, "Name", LastName, fk_idLocation, PhoneNumber)
SELECT
	xData.value('IdNumber[1]', 'int') idNumber, -- 'xData' is our xml content alias
	xData.value('Name[1]', 'VARCHAR(15)') "Name",
	xData.value('Surname[1]', 'VARCHAR(15)') LastName,
	xData.value('LocationId[1]', 'int') fk_idLocation,
	xData.value('PhoneNumber[1]', 'int') PhoneNumber
FROM @fileData.nodes('/DB/People/Person') AS x(xData)

-- insert the xml data into our Profession table ("Name")
INSERT INTO Profession
	("Name")
SELECT
	xData.value('Name[1]', 'VARCHAR(25)') "Name" -- 'xData' is our xml content alias
FROM @fileData.nodes('/DB/Professions/Profession') AS x(xData)

-- insert the xml data into our AssignedArea table ("Name")
INSERT INTO AssignedArea
	("Name")
SELECT
	xData.value('Name[1]', 'VARCHAR(25)') "Name" -- 'xData' is our xml content alias
FROM @fileData.nodes('/DB/AssignedAreas/AssignedArea') AS x(xData)

-- insert the xml data into our Speciality table ("Name")
INSERT INTO Speciality
	("Name")
SELECT
	xData.value('Name[1]', 'VARCHAR(25)') "Name" -- 'xData' is our xml content alias
FROM @fileData.nodes('/DB/Specialities/Speciality') AS x(xData)

-- insert the xml data into our Employee table (fk_idPerson, fk_idPark)
INSERT INTO Employee
	(fk_idPerson, fk_idPark, fk_idProfession, fk_idAssignedArea, fk_idSpeciality)
SELECT
	xData.value('PersonId[1]', 'int') fk_idPerson, -- 'xData' is our xml content alias
	xData.value('ParkId[1]', 'int') fk_idPark,
	xData.value('ProfessionId[1]', 'int') fk_idProfession,
	xData.value('AssignedArea[1][not(@xsi:nil = "true")]', 'int') fk_idAssignedArea,
	xData.value('SpecialityId[1][not(@xsi:nil = "true")]', 'int') fk_idSpeciality
FROM @fileData.nodes('/DB/Employees/Employee') AS x(xData)


-- insert the xml data into our Visitor table (fk_idPerson, Profession)
INSERT INTO Visitor
	(fk_idPerson, fk_idProfession)
SELECT
	xData.value('PersonId[1]', 'int') fk_idPerson, -- 'xData' is our xml content alias
	xData.value('Profession[1]', 'VARCHAR(15)') Profession
FROM @fileData.nodes('/DB/Visitors/Visitor') AS x(xData)

-- insert the xml data into our Accommodation table (fk_idPark, Category, Capacity)
INSERT INTO Accommodation
	(fk_idPark, Category, Capacity)
SELECT
	xData.value('ParkId[1]', 'int') fk_idPark, -- 'xData' is our xml content alias
	xData.value('Category[1]', 'VARCHAR(15)') Category,
	xData.value('Capacity[1]', 'int') Capacity
FROM @fileData.nodes('/DB/Accommodations/Accommodation') AS x(xData)

-- insert the xml data into our Visit table (fk_idVisitor, fk_idPark, fk_idAccommodation, StartDate, EndDate)
INSERT INTO Visit
	(fk_idVisitor, fk_idPark, fk_idAccommodation, StartDate, EndDate)
SELECT
	xData.value('VisitorId[1]', 'int') fk_idVisitor, -- 'xData' is our xml content alias
	xData.value('ParkId[1]', 'int') fk_idPark,
	xData.value('AccommodationId[1]', 'int') fk_idAccommodation,
	xData.value('StartDate[1]', 'DATETIME') StartDate,
	xData.value('EndDate[1]', 'DATETIME') EndDate
FROM @fileData.nodes('/DB/Visits/Visit') AS x(xData)

-- insert the xml data into our Excursion table ("Name", "Description", Price, Capacity, fk_idVehicle)
INSERT INTO Tour
	("Name", "Description", Price, Capacity)
SELECT
	xData.value('Name[1]', 'VARCHAR(15)') "Name", -- 'xData' is our xml content alias
	xData.value('Description[1]', 'VARCHAR(50)') "Description",
	xData.value('Price[1]', 'int') Price,
	xData.value('Capacity[1]', 'int') Capacity
FROM @fileData.nodes('/DB/Excursions/Excursion') AS x(xData)

-- insert the xml data into our AccommodationXExcursion table (fk_idAccommodation, fk_idExcursion, "Day", "Hour")
INSERT INTO AccommodationXTour
	(fk_idAccommodation, fk_idTour, "Day", "Hour")
SELECT
	xData.value('AccommodationId[1]', 'int') fk_idAccommodation, -- 'xData' is our xml content alias
	xData.value('ExcursionId[1]', 'int') fk_idExcursion,
	xData.value('Date[1]', 'VARCHAR(15)') "Day",
	xData.value('Hour[1]', 'VARCHAR(15)') "Hour"
FROM @fileData.nodes('/DB/AcommodationsXExcursions/AccomodationXExcursion') AS x(xData)


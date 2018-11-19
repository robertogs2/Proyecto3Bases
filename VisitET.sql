
--Query to select everything by rows



-- Query to separate visits



-- Create View First
--Table of visits without days, and cost by day
CREATE VIEW VisitFiltered AS
	SELECT idVisit, Visit.fk_idPark, fk_idAccommodation, Accommodation.BasePrice
	FROM Visit
	INNER JOIN Accommodation ON Accommodation.idAccommodation = fk_idAccommodation

CREATE PROCEDURE SeparateVisit
AS BEGIN

	DECLARE @visit_sdate DATE
	DECLARE @visit_edate DATE
	DECLARE @visit_id INT
	DECLARE visit_cursor CURSOR FAST_FORWARD
	FOR SELECT StartDate, EndDate, idVisit FROM Visit

	OPEN visit_cursor
	FETCH NEXT FROM visit_cursor INTO @visit_sdate, @visit_edate, @visit_id

	--Table for full row concatenation
	DECLARE @result TABLE (idVisit INT, idPark INT, idAccommodation INT, BasePrice INT, DayDate DATE)

	WHILE @@FETCH_STATUS = 0 BEGIN
		--Creates dataset with each day
		DECLARE @t TABLE (DayDate DATE)
		INSERT @t (DayDate) EXEC SeparateDayRange @visit_sdate, @visit_edate

		--Takes the information for that single visit
		SELECT * FROM VisitFiltered 
		WHERE @visit_id  = VisitFiltered.idVisit
		--Unifies that information in columnss
		CROSS JOIN @t -- need to check

		--Adds to the result table, in rows
		INSERT INTO @result
		SELECT * FROM @t

		FETCH NEXT FROM visit_cursor INTO @visit_sdate, @visit_edate --Takes next date
	END

	SELECT * FROM @result
END
GO

--Sp to separate day range
CREATE PROCEDURE SeparateDayRange
	@sdate DATE,
	@edate DATE
AS BEGIN
	WITH rs
	AS
	(
	SELECT @sdate dt
		UNION all
	SELECT DATEADD(d,1,dt)    FROM rs WHERE dt<@edate
	)
	SELECT * FROM rs
	option (maxrecursion 0)
END
GO

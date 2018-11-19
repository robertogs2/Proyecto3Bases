
SELECT * FROM Visit

-- Create View First
--Table of visits without days, and cost by day
CREATE VIEW VisitFiltered AS
	SELECT idVisit, Visit.fk_idPark, fk_idAccommodation, Accommodation.BasePrice
	FROM Visit
	INNER JOIN Accommodation ON Accommodation.idAccommodation = fk_idAccommodation
	
-- Query to separate visits
CREATE PROCEDURE SeparateVisit
AS BEGIN

	DECLARE @visit_sdate DATE
	DECLARE @visit_edate DATE
	DECLARE @visit_id INT

	IF CURSOR_STATUS('global','visit_cursor')>=-1
	BEGIN
	 DEALLOCATE visit_cursor
	END

	DECLARE visit_cursor CURSOR FAST_FORWARD
	FOR SELECT CONVERT(DATE, StartDate), CONVERT(DATE, EndDate), idVisit FROM Visit

	OPEN visit_cursor
	FETCH NEXT FROM visit_cursor INTO @visit_sdate, @visit_edate, @visit_id

	--Table for full row concatenation
	DECLARE @result TABLE (idVisit INT, idPark INT, idAccommodation INT, BasePrice INT, DayDate DATE)

	WHILE @@FETCH_STATUS = 0 BEGIN
		--Creates dataset with each day
		DECLARE @t TABLE (DayDate DATE)
		INSERT @t (DayDate) EXEC SeparateDayRange @visit_sdate, @visit_edate
		SELECT * FROM @t;

		--Takes the information for that single visit
		WITH rs
		AS(
			SELECT * FROM VisitFiltered 
			CROSS JOIN @t -- need to check --Unifies that information in columnss
			WHERE @visit_id  = VisitFiltered.idVisit
		)
		--Adds to the result table, in rows
		INSERT INTO @result
		SELECT * FROM rs

		FETCH NEXT FROM visit_cursor INTO @visit_sdate, @visit_edate, @visit_id --Takes next date
	END

	SELECT * FROM @result
END
GO
EXEC SeparateVisit
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


DECLARE @t TABLE (DayDate DATE)
INSERT @t (DayDate) EXEC SeparateDayRange '2013-04-11', '2013-04-27'

SELECT * FROM @t

SELECT * FROM Visit
USE PV_319_Import;
GO

ALTER FUNCTION GetEasterDate(@year AS SMALLINT) RETURNS DATE
BEGIN
	DECLARE @easter_date AS DATE,
			@a AS TINYINT = @year % 19,
			@b AS TINYINT = @year % 4,
			@c AS TINYINT = @year % 7;

	DECLARE @d AS TINYINT = (19 * @a + 15)%30;
	DECLARE @e AS TINYINT = (2*@b + 4*@c + 6*@d + 6)%7;
	DECLARE @f AS TINYINT = @d+@e;

	IF(@f <= 9)
	BEGIN
		SET @easter_date = DATEFROMPARTS(@year, 03, (22 + @f));
	END
	ELSE
	BEGIN
		SET @easter_date = DATEFROMPARTS(@year, 04, (@f - 9));
	END
	
	SET @easter_date = DATEADD(DAY, 13, @easter_date);

	RETURN @easter_date;
END
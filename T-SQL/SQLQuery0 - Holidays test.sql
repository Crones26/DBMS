USE PV_319_Import;
SET DATEFIRST 1;
GO

--SELECT * FROM DaysOFF;

--EXEC sp_AddAllHolidaysFor 2023;

SELECT
		[Дата]		=	[date],
		[Праздник]	=	holiday_name
FROM	DaysOFF, Holidays
WHERE	holiday=holiday_id;
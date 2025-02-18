USE PV_319_Import;
GO

ALTER PROCEDURE sp_AlternateDisciplines
    @group_name NVARCHAR(16),
    @discipline1_name NVARCHAR(150),
    @discipline2_name NVARCHAR(150),
    @teacher_last_name NVARCHAR(50),
    @start_date DATE,
    @time TIME(0)
AS
BEGIN
    SET DATEFIRST 1;

    DECLARE @group INT = (SELECT group_id FROM Groups WHERE group_name = @group_name);
    DECLARE @discipline1 SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE @discipline1_name);
    DECLARE @discipline2 SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE @discipline2_name);
    DECLARE @teacher SMALLINT = (SELECT teacher_id FROM Teachers WHERE last_name = @teacher_last_name);
    DECLARE @date DATE = @start_date;
    DECLARE @lesson TINYINT = 1;
    DECLARE @current_discipline SMALLINT;
    
    WHILE (@lesson <= 1)
    BEGIN
        SET @current_discipline = CASE WHEN @lesson % 4 IN (1,2) THEN @discipline1 ELSE @discipline2 END;
        
        -- Первый урок
        IF NOT EXISTS (SELECT * FROM Schedule WHERE [group] = @group AND discipline = @current_discipline AND [date] = @date AND [time] = @time)
        BEGIN
            INSERT INTO Schedule ([group], discipline, teacher, [date], [time], spent)
            VALUES (@group, @current_discipline, @teacher, @date, @time, IIF(@date < GETDATE(), 1, 0));
        END
        
        SET @lesson = @lesson + 1;
        
        -- Второй урок
        IF NOT EXISTS (SELECT * FROM Schedule WHERE [group] = @group AND discipline = @current_discipline AND [date] = @date AND [time] = DATEADD(MINUTE, 95, @time))
        BEGIN
            INSERT INTO Schedule ([group], discipline, teacher, [date], [time], spent)
            VALUES (@group, @current_discipline, @teacher, @date, DATEADD(MINUTE, 95, @time), IIF(@date < GETDATE(), 1, 0));
        END
        
        SET @lesson = @lesson + 1;
        
        -- Переключение даты
        IF (DATEPART(WEEKDAY, @date) = 6)
            SET @date = DATEADD(DAY, 3, @date);
        ELSE
            SET @date = DATEADD(DAY, 2, @date);
    END
END;


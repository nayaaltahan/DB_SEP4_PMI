USE Stage_SEP4_PMI

--------------------------------UPDATING THE STAGE FACT CO2 WITH SURROGATE KEY FROM THE DW-------------------------------------

UPDATE [Stage_Fact_CO2]
	SET Su_User_ID = (
	SELECT TOP 1 Su_User_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Users u
	WHERE u.[User_ID] = [Stage_Fact_CO2].[User_ID]
	AND u.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_CO2]
	SET Su_Plant_ID = (
	SELECT TOP 1 Su_Plant_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Plant p
	WHERE p.[Plant_ID] = [Stage_Fact_CO2].[Plant_ID]
	AND p.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_CO2]
	SET Su_Profile_ID = (
	SELECT TOP 1 Su_Profile_ID
	FROM Dim_SEP4_PMI.dbo.Dim_PlantProfile pp
	WHERE pp.[Profile_ID] = [Stage_Fact_CO2].[Profile_ID]
	AND pp.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_CO2]
	SET Su_Date_ID = (
	SELECT TOP 1 Su_Date_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Calendar d
	WHERE d.[CalendarDate] = [Stage_Fact_CO2].[Date]
	);

UPDATE [Stage_Fact_CO2]
	SET Su_Time_ID = (
	SELECT TOP 1 Su_Time_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Time t
	WHERE t.[Time] = [Stage_Fact_CO2].[Time]
	);

SELECT * FROM Stage_Fact_CO2;


--------------------------------UPDATING THE STAGE FACT HUM WITH SURROGATE KEY FROM THE DW-------------------------------------

UPDATE [Stage_Fact_Hum]
	SET Su_User_ID = (
	SELECT TOP 1 Su_User_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Users u
	WHERE u.[User_ID] = [Stage_Fact_Hum].[User_ID]
	AND u.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Hum]
	SET Su_Plant_ID = (
	SELECT TOP 1 Su_Plant_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Plant p
	WHERE p.[Plant_ID] = [Stage_Fact_Hum].[Plant_ID]
	AND p.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Hum]
	SET Su_Profile_ID = (
	SELECT TOP 1 Su_Profile_ID
	FROM Dim_SEP4_PMI.dbo.Dim_PlantProfile pp
	WHERE pp.[Profile_ID] = [Stage_Fact_Hum].[Profile_ID]
	AND pp.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Hum]
	SET Su_Date_ID = (
	SELECT TOP 1 Su_Date_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Calendar d
	WHERE d.[CalendarDate] = [Stage_Fact_Hum].[Date]
	);

UPDATE [Stage_Fact_Hum]
	SET Su_Time_ID = (
	SELECT TOP 1 Su_Time_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Time t
	WHERE t.[Time] = [Stage_Fact_Hum].[Time]
	);

SELECT * FROM Stage_Fact_Hum;



--------------------------------UPDATING THE STAGE FACT LIGHT WITH SURROGATE KEY FROM THE DW-------------------------------------

UPDATE [Stage_Fact_Light]
	SET Su_User_ID = (
	SELECT TOP 1 Su_User_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Users u
	WHERE u.[User_ID] = [Stage_Fact_Light].[User_ID]
	AND u.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Light]
	SET Su_Plant_ID = (
	SELECT TOP 1 Su_Plant_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Plant p
	WHERE p.[Plant_ID] = [Stage_Fact_Light].[Plant_ID]
	AND p.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Light]
	SET Su_Profile_ID = (
	SELECT TOP 1 Su_Profile_ID
	FROM Dim_SEP4_PMI.dbo.Dim_PlantProfile pp
	WHERE pp.[Profile_ID] = [Stage_Fact_Light].[Profile_ID]
	AND pp.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Light]
	SET Su_Date_ID = (
	SELECT TOP 1 Su_Date_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Calendar d
	WHERE d.[CalendarDate] = [Stage_Fact_Light].[Date]
	);

UPDATE [Stage_Fact_Light]
	SET Su_Time_ID = (
	SELECT TOP 1 Su_Time_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Time t
	WHERE t.[Time] = [Stage_Fact_Light].[Time]
	);

SELECT * FROM Stage_Fact_Light;





--------------------------------UPDATING THE STAGE FACT TEM WITH SURROGATE KEY FROM THE DW-------------------------------------

UPDATE [Stage_Fact_Tem]
	SET Su_User_ID = (
	SELECT TOP 1 Su_User_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Users u
	WHERE u.[User_ID] = [Stage_Fact_Tem].[User_ID]
	AND u.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Tem]
	SET Su_Plant_ID = (
	SELECT TOP 1 Su_Plant_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Plant p
	WHERE p.[Plant_ID] = [Stage_Fact_Tem].[Plant_ID]
	AND p.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Tem]
	SET Su_Profile_ID = (
	SELECT TOP 1 Su_Profile_ID
	FROM Dim_SEP4_PMI.dbo.Dim_PlantProfile pp
	WHERE pp.[Profile_ID] = [Stage_Fact_Tem].[Profile_ID]
	AND pp.[ValidTo] > GETDATE());

UPDATE [Stage_Fact_Tem]
	SET Su_Date_ID = (
	SELECT TOP 1 Su_Date_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Calendar d
	WHERE d.[CalendarDate] = [Stage_Fact_Tem].[Date]
	);

UPDATE [Stage_Fact_Tem]
	SET Su_Time_ID = (
	SELECT TOP 1 Su_Time_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Time t
	WHERE t.[Time] = [Stage_Fact_Tem].[Time]
	);

SELECT * FROM Stage_Fact_Tem;



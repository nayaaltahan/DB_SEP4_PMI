drop table if exists Temp_Fact_CO2;


--if not already created, create a Temporary fact table for co2
create table Temp_Fact_CO2
(
	Su_Plant_ID int,
	Su_Profile_ID int,
	Su_User_ID int,
	Su_Date_ID int,
	Su_Time_ID int,
	Plant_ID int,
	Profile_ID int,
	User_ID int,
	Time Time,
	Date DATE,
	Sensor_Value decimal(6,3),
	CO2_Status int
);

DELETE FROM Temp_Fact_CO2;

insert into Temp_Fact_CO2 (Plant_ID, Profile_ID, [Date] , User_ID , [Time], [Sensor_Value] , CO2_Status)

select Plant.Plant_ID, PlantProfile.Profile_ID, CAST([TimeStamp] AS DATE), Users.[User_ID]
       ,FORMAT([TimeStamp],'HH:mm')
       ,PlantData.Sensor_Value,
													case
													when Sensor_Value < CO2_Min then 1
													when Sensor_Value > CO2_Min and Sensor_Value < CO2_Max then 2
                                                    when Sensor_Value > CO2_Max then 3
										            end as CO2_Status

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.PlantData on PlantData.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantData.Sensor_Type = 'CO2'
AND CAST(PlantData.TimeStamp AS DATETIME) > (select last_updated from Dim_SEP4_PMI.dbo.Last_Updated);

select * from Temp_Fact_CO2;


------------------------------------------------------------------------------------------------------------------------------
USE Stage_SEP4_PMI

--------------------------------UPDATING THE TEMP FACT CO2 WITH SURROGATE KEY FROM THE DW-------------------------------------

UPDATE Temp_Fact_CO2
	SET Su_User_ID = (
	SELECT TOP 1 Su_User_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Users u
	WHERE u.[User_ID] = Temp_Fact_CO2.[User_ID]
	AND u.[ValidTo] > GETDATE());

UPDATE Temp_Fact_CO2
	SET Su_Plant_ID = (
	SELECT TOP 1 Su_Plant_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Plant p
	WHERE p.[Plant_ID] = Temp_Fact_CO2.[Plant_ID]
	AND p.[ValidTo] > GETDATE());

UPDATE Temp_Fact_CO2
	SET Su_Profile_ID = (
	SELECT TOP 1 Su_Profile_ID
	FROM Dim_SEP4_PMI.dbo.Dim_PlantProfile pp
	WHERE pp.[Profile_ID] = Temp_Fact_CO2.[Profile_ID]
	AND pp.[ValidTo] > GETDATE());

UPDATE Temp_Fact_CO2
	SET Su_Date_ID = (
	SELECT TOP 1 Su_Date_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Calendar d
	WHERE d.[CalendarDate] = Temp_Fact_CO2.[Date]
	);

UPDATE Temp_Fact_CO2
	SET Su_Time_ID = (
	SELECT TOP 1 Su_Time_ID
	FROM Dim_SEP4_PMI.dbo.Dim_Time t
	WHERE t.[Time] = Temp_Fact_CO2.[Time]
	);

SELECT * FROM Temp_Fact_CO2;

-----------------------------POPULATING THE CO2 FACT IN THE DW WITH THE NEW ROWS---------------------------

INSERT INTO Dim_SEP4_PMI.dbo.Dim_Fact_CO2
    (Su_Plant_ID, Su_Profile_ID, Su_Date_ID, Su_Time_ID, Su_User_ID, Sensor_Value, CO2_Status)
    SELECT Su_Plant_ID ,Su_Profile_ID, Su_Date_ID, Su_Time_ID, Su_User_ID, Sensor_Value, CO2_Status FROM Temp_Fact_CO2;

-----------------------------------------------------------------------------------------------------------
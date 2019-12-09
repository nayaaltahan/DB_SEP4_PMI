create database Stage_SEP4_PMI

drop database Stage_SEP4_PMI

use Stage_SEP4_PMI 

--drop table if exists stage_dim_Users

----Extracting user data from source 

create table stage_dim_Users (
    [User_ID] int NULL,
    [Email] varchar(50) NULL ,
)

insert into stage_dim_Users(User_ID, Email)
select [User_ID], email from SEP4_PMI.dbo.Users

select * from stage_dim_Users

----------------------------------------------------
create table stage_dim_PlantProfile (
Profile_ID int null,
Profile_Name varchar(50) null,
CO2_Max decimal null,
CO2_Min decimal null,
Hum_Max decimal null,
Hum_Min decimal null,
Tem_Max decimal null,
Tem_Min decimal null,
Light_Max decimal null,
Light_Min decimal null
)

insert into stage_dim_PlantProfile (Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max , Light_Min)
select                            Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max ,Light_Min
from SEP4_PMI.dbo.PlantProfile

--drop table if exists stage_dim_PlantProfile
select * from stage_dim_PlantProfile
---------------------------------------------------------------
create table stage_dim_Plant (
Plant_ID int null,
[Device_ID] varchar(50) null,
Plant_Name varchar(50) null
)

insert into stage_dim_Plant (Plant_ID,[Device_ID], Plant_Name)
select Plant_ID, [Device_ID], PlantName
from SEP4_PMI.dbo.Plant


select * from stage_dim_Plant

----------------------------------------------------------- 

drop table if exists stage_dim_Calendar

CREATE TABLE stage_dim_Calendar
(
[CalendarDate] DATE null,
WeekDayName nvarchar(50) null,
MonthName nvarchar(50) null,
)

--Filling up stage_dim_calendar with dates
GO
DECLARE @StartDate DATE
DECLARE @EndDate DATE
SET @StartDate = '2019-01-01'
SET @EndDate = DATEADD(d, 1095, @StartDate)

WHILE @StartDate <= @EndDate
	BEGIN
		INSERT INTO [stage_dim_Calendar]
		(
			CalendarDate,
			WeekDayName,
			MonthName
		)
		SELECT @StartDate
		, DATENAME (weekday, @StartDate)
		, DATENAME (month, @StartDate)

		SET @StartDate = DATEADD (dd,1,@StartDate)
	END



select * from stage_dim_Calendar


CREATE TABLE stage_dim_Time
(
[Time] TIME null, --changed to not null -- should be id
)

--Filling up stage_dim_calendar with dates
GO
DECLARE @StartTime TIME
DECLARE @EndTime TIME
SET @StartTime = TIMEFROMPARTS(0,0,0,0,1)
SET @EndTime = DATEADD(mi, 1439, @StartTime)

WHILE @StartTime < @EndTime
	BEGIN
		INSERT INTO [stage_dim_Time]
		(
			[Time]
		)
		SELECT @StartTime

		SET @StartTime = DATEADD (mi,1, @StartTime)
	END
INSERT INTO [stage_dim_Time] (Time) values (TIMEFROMPARTS(23,59,00,0,1));



select top 200 * from stage_dim_Time order by Time desc ;
drop table if exists stage_dim_Time;
-------------------------------------------------------------------------------------------
drop table if exists Stage_Fact_CO2;

create table Stage_Fact_CO2 (
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
Su_Date int null,   ---- surrogate key
Su_Time int null,   ---- surrogate key
Plant_ID int null,
Profile_ID int null,
[Date] DATE null,
[Time] Time null,
User_ID Varchar(50) null,
[Sensor_Value] decimal(6,3) null,
CO2_Status varchar(50) null
)

insert into Stage_Fact_CO2 (Plant_ID, Profile_ID, [Date] , User_ID , [Time], [Sensor_Value] , CO2_Status)
                                           
select Plant.Plant_ID, PlantProfile.Profile_ID, CAST([TimeStamp] AS DATE), Users.[User_ID]
       ,FORMAT([TimeStamp],'HH:mm')
       ,PlantData.Sensor_Value,
													case 
													when Sensor_Value < CO2_Min then 'CO2 value is low'
													when Sensor_Value > CO2_Min and Sensor_Value < CO2_Max then 'CO2 value is normal'
                                                    when Sensor_Value > CO2_Max then 'CO2 value is high'
										            end as CO2_Status   

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.PlantData on PlantData.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantData.Sensor_Type = 'CO2'

delete from Stage_Fact_CO2;
--drop table Stage_Fact_CO2
select * from Stage_Fact_CO2

-----------------------------------------------------------------------------------------------------------


--drop table Stage_Fact_Hum
create table Stage_Fact_Hum (
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
Su_CalendarDate int null,   ---- surrogate key
Su_Timestamp int null,   ---- surrogate key
Plant_ID int null,
Profile_ID int null,
User_ID Varchar(50) null,
[Date] DATE null,
[Time] TIME null,
[Sensor_Value] decimal(6,3) null,
Hum_Status varchar(50) null
)

insert into Stage_Fact_Hum (Plant_ID, Profile_ID, [Date], User_ID , [Time], [Sensor_Value] , Hum_Status)
                                           
select Plant.Plant_ID, PlantProfile.Profile_ID, CAST([TimeStamp] AS DATE), Users.[User_ID]
       ,FORMAT([TimeStamp],'HH:mm')
       ,PlantData.Sensor_Value,
       case
													when Sensor_Value < Hum_Min then 'Humidity value is low'
													when Sensor_Value > Hum_Min and Sensor_Value < Hum_Max then 'Humidity value is normal'
                                                    when Sensor_Value > Hum_Max then 'Humidity value is high'
										            end as Hum_Status  

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.PlantData on PlantData.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantData.Sensor_Type = 'Humidity'

select * from Stage_Fact_Hum
--drop table Stage_Fact_Hum
-----------------------------------------------------------------------------------------------------

--drop table Stage_Fact_Light
create table Stage_Fact_Light (
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
Su_CalendarDate int null,   ---- surrogate key
Su_Timestamp int null,   ---- surrogate key
Plant_ID int null,
Profile_ID int null,
User_ID Varchar(50) null,
[Date] Date null,
[Time] TIME null,
[Sensor_Value] decimal(6,3) null,
Light_Status varchar(50) null
)

insert into Stage_Fact_Light(Plant_ID, Profile_ID, [Date], User_ID , [Time], [Sensor_Value] , Light_Status)

select Plant.Plant_ID, PlantProfile.Profile_ID, CAST([TimeStamp] AS DATE), Users.[User_ID]
       ,FORMAT([TimeStamp],'HH:mm')
       ,PlantData.Sensor_Value,                                                    case
													when Sensor_Value <Light_Min then 'Light value is low'
													when Sensor_Value > Light_Min and Sensor_Value < Light_Max then 'Light value is normal'
                                                    when Sensor_Value > Light_Max then 'Light value is high'
										            end as Light_Status

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.PlantData on PlantData.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantData.Sensor_Type = 'Light'

select * from Stage_Fact_Light
--drop table Stage_Fact_Light

---------------------------------------------------------------------------------------------------------------

--DROP TABLE Stage_Fact_Tem
create table Stage_Fact_Tem (
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
Su_CalendarDate int null,   ---- surrogate key
Su_Timestamp int null,   ---- surrogate key
Plant_ID int null,
Profile_ID int null,
User_ID Varchar(50) null,
[Date] DATE null,
[Time] TIME null,
[Sensor_Value] decimal(6,3) null,
Tem_Status varchar(50) null
)

insert into Stage_Fact_Tem (Plant_ID, Profile_ID, [Date], User_ID , [Time], [Sensor_Value] , Tem_Status)
                                           
select Plant.Plant_ID, PlantProfile.Profile_ID, CAST([TimeStamp] AS DATE), Users.[User_ID]
       ,FORMAT([TimeStamp],'HH:mm')
       ,PlantData.Sensor_Value,												    case
													when Sensor_Value <Tem_Min then 'temperature value is low' 
													when Sensor_Value > Tem_Min and Sensor_Value < Tem_Max then 'Temperature value is normal'
                                                    when Sensor_Value > Tem_Max then 'Temperature value is high'
										            end as Tem_Status    

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.PlantData on PlantData.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantData.Sensor_Type = 'Temperature'

select * from Stage_Fact_Tem
--drop table Stage_Fact_Tem
create database Stage_SEP4_PMI

use Stage_SEP4_PMI 

--drop table if exists stage_dim_Users

----Extracting user data from source 

create table stage_dim_Users (
User_ID varchar(50) NULL ,
[Password] varchar (50) NULL
)
insert into stage_dim_Users(User_ID, [Password])
select [User_ID], [Password] from SEP4_PMI.dbo.Users

select * from stage_dim_Users

----------------------------------------------------
create table stage_dim_PlantProfile (
Profile_ID int null,
[User_ID] varchar(50) null ,
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

insert into stage_dim_PlantProfile (Profile_ID, [User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max , Light_Min)
select                            Profile_ID, [User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max ,Light_Min 
from SEP4_PMI.dbo.PlantProfile

--drop table if exists stage_dim_PlantProfile
select * from stage_dim_PlantProfile
---------------------------------------------------------------
create table stage_dim_Plant (
Plant_ID int null,
Profile_ID int null,
Plant_Name varchar(50) null
)

insert into stage_dim_Plant (Plant_ID, Profile_ID, Plant_Name)
select Plant_ID, Profile_ID, PlantName 
from SEP4_PMI.dbo.Plant


select * from stage_dim_Plant
-----------------------------------------------------------------
drop table if exists stage_dim_PlantData



insert into stage_dim_PlantData(S_Info_ID, Plant_ID,Sensor_Type, Sensor_Value, [Timestamp])
select Info_ID, Plant_ID, Sensor_Type, Sensor_Value, [Timestamp]
from SEP4_PMI.dbo.PlantInfo


select * from stage_dim_PlantData

----------------------------------------------------------- 

drop table stage_dim_Calendar

CREATE TABLE stage_dim_Calendar
(
[CalendarDate] DATETIME null,
WeekDayName nvarchar(50) null,
MonthName nvarchar(50) null,
)

--Filling up stage_dim_calendar with dates
GO
DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = '1996-01-01'
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

-------------------------------------------------------------------------------------------

create table Stage_Fact_CO2 (
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
Su_CalendarDate int null,   ---- surrogate key
Su_Timestamp int null,   ---- surrogate key
Plant_ID int null,
Profile_ID int null,
CalendarDate int null,
User_ID Varchar(50) null,
[TimeStamp] DateTime null,
[Sensor_Value] decimal(3,3) null,
CO2_Status varchar(50) null
)

insert into Stage_Fact_CO2 (Plant_ID, Profile_ID, CalendarDate, User_ID , [TimeStamp], [Sensor_Value] , CO2_Status)
                                           
select PlantInfo.Info_ID, Plant.Plant_ID, PlantProfile.Profile_ID, CONVERT(VARCHAR(10), PlantInfo.timestamp, 111), Users.[User_ID],  CAST(PlantInfo.[TimeStamp] AS TIME),
													case 
													when Sensor_Value < CO2_Min then 'CO2 value is low'
													when Sensor_Value > CO2_Min and Sensor_Value < CO2_Max then 'CO2 value is low'
                                                    when Sensor_Value > CO2_Max then 'CO2 value is high'
										            end as CO2_Status   

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.PlantInfo on PlantInfo.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantInfo.Sensor_Type = 'CO2'

--drop table Stage_Fact_CO2
select * from Stage_Fact_CO2

-----------------------------------------------------------------------------------------------------------



create table Stage_Fact_Hum (
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
Su_CalendarDate int null,   ---- surrogate key
Su_Timestamp int null,   ---- surrogate key
Plant_ID int null,
Profile_ID int null,
User_ID Varchar(50) null,
CalendarDate int null,
[TimeStamp] DateTime null,
[Sensor_Value] decimal(3,3) null,
Hum_Status varchar(50) null
)

insert into Stage_Fact_Hum (S_Info_ID, S_Plant_ID, S_Profile_ID, S_DateID, S_User_ID, [TimeStamp], Hum_Status)
                                           
select PlantInfo.Info_ID, Plant.Plant_ID, PlantProfile.Profile_ID, Calendar.DateID, Users.[User_ID], PlantInfo.[TimeStamp],
													case 
													when Sensor_Value <Hum_Min then 'Humidity value is low' 
													when Sensor_Value > Hum_Min and Sensor_Value < Hum_Max then 'Humidity value is low'
                                                    when Sensor_Value > Hum_Max then 'Humidity value is high'
										            end as Hum_Status  

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.Calendar on Calendar.DateID = Calendar.DateID
join SEP4_PMI.dbo.PlantInfo on PlantInfo.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantInfo.Sensor_Type = 'Humidity' and Calendar.DateID = PlantInfo.Info_ID

select * from Stage_Fact_Hum
drop table Stage_Fact_Hum
-----------------------------------------------------------------------------------------------------


create table Stage_Fact_Light (
Su_Info_ID int null,   ---- surrogate key
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_DateID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
S_Info_ID int null,
S_Plant_ID int null,
S_Profile_ID int null,
S_DateID int null,
S_User_ID Varchar(50) null,
[TimeStamp] DateTime null,
Light_Status varchar(50) null
)

insert into Stage_Fact_Light(S_Info_ID, S_Plant_ID, S_Profile_ID, S_DateID, S_User_ID, [TimeStamp], Light_Status)
                                           
select PlantInfo.Info_ID, Plant.Plant_ID, PlantProfile.Profile_ID, Calendar.DateID, Users.[User_ID], PlantInfo.[TimeStamp],
													case 
													when Sensor_Value <Light_Min then 'Light value is low' 
													when Sensor_Value > Light_Min and Sensor_Value < Light_Max then 'Light value is low'
                                                    when Sensor_Value > Light_Max then 'Light value is high'
										            end as Light_Status  

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.Calendar on Calendar.DateID = Calendar.DateID
join SEP4_PMI.dbo.PlantInfo on PlantInfo.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantInfo.Sensor_Type = 'Light' and Calendar.DateID = PlantInfo.Info_ID

select * from Stage_Fact_Light
drop table Stage_Fact_Light

---------------------------------------------------------------------------------------------------------------


create table Stage_Fact_Tem (
Su_Info_ID int null,   ---- surrogate key
Su_Plant_ID int null,   ---- surrogate key
Su_Profile_ID int null,   ---- surrogate key
Su_DateID int null,   ---- surrogate key
Su_User_ID varchar(50) null, ---- surrogate key
S_Info_ID int null,
S_Plant_ID int null,
S_Profile_ID int null,
S_DateID int null,
S_User_ID Varchar(50) null,
[TimeStamp] DateTime null,
Tem_Status varchar(50) null
)

insert into Stage_Fact_Tem (S_Info_ID, S_Plant_ID, S_Profile_ID, S_DateID, S_User_ID, [TimeStamp], Tem_Status)
                                           
select PlantInfo.Info_ID, Plant.Plant_ID, PlantProfile.Profile_ID, Calendar.DateID, Users.[User_ID], PlantInfo.[TimeStamp],
												    case 
													when Sensor_Value <Tem_Min then 'temperature value is low' 
													when Sensor_Value > Tem_Min and Sensor_Value < Tem_Max then 'Temperature value is low'
                                                    when Sensor_Value > Tem_Max then 'Temperature value is high'
										            end as Tem_Status    

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.Calendar on Calendar.DateID = Calendar.DateID
join SEP4_PMI.dbo.PlantInfo on PlantInfo.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantInfo.Sensor_Type = 'Temperature' and Calendar.DateID = PlantInfo.Info_ID

select * from Stage_Fact_Tem
drop table Stage_Fact_Tem
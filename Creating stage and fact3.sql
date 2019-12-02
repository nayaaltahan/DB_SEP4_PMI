create database Stage_SEP4_PMI

use Stage_SEP4_PMI 

drop table if exists Stage_Users

----Extracting user data from source 

create table Stage_Users (
S_User_ID varchar(50) not null primary key,
[Password] varchar (50) not null
)
insert into Stage_Users(S_User_ID, [Password]) 
select [User_ID], [Password] from SEP4_PMI.dbo.Users

select * from Stage_Users 

----------------------------------------------------
create table Stage_PlantProfile (
S_Profile_ID int not null primary key,
[User_ID] varchar(50) not null ,
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
insert into Stage_PlantProfile (S_Profile_ID, [User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max ,Light_Min)
select                            Profile_ID, [User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max ,Light_Min 
from SEP4_PMI.dbo.PlantProfile

drop table if exists Stage_PlantProfile
select * from Stage_PlantProfile
---------------------------------------------------------------
create table Stage_Plant (
Plant_ID int not null primary key,
Profile_ID int not null,
PlantName varchar(50) null
)

insert into Stage_Plant (Plant_ID, Profile_ID, PlantName)
select Plant_ID, Profile_ID, PlantName 
from SEP4_PMI.dbo.Plant


select * from Stage_Plant
-----------------------------------------------------------------
drop table if exists Stage_PlantInfo

create table Stage_PlantInfo (
S_Info_ID int not null primary key,
Plant_ID int not null,
Sensor_Type varchar (50) null,
Sensor_Value decimal (6,3) not null,
[TimeStamp] DateTime not null
   
)

insert into Stage_PlantInfo(S_Info_ID, Plant_ID,Sensor_Type, Sensor_Value, [Timestamp])
select Info_ID, Plant_ID, Sensor_Type, Sensor_Value, [Timestamp]
from SEP4_PMI.dbo.PlantInfo


select * from Stage_PlantInfo

----------------------------------------------------------- 

drop table Stage_Calendar

CREATE TABLE Stage_Calendar
(
DateID int not null primary key,
CalendarDate DATETIME not null,
WeekDayName nvarchar(50) not null,
MonthName nvarchar(50) not null,

)


insert into Stage_Calendar (DateID, CalendarDate, WeekDayName, MonthName)
select DateID, CalendarDate, WeekDayName, MonthName
from SEP4_PMI.dbo.Calendar

select * from Stage_Calendar

-------------------------------------------------------------------------------------------

create table Stage_Fact_CO2 (
Su_Info_ID int null,  ---- surrogate key
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
CO2_Status varchar(50) null
)

insert into Stage_Fact_CO2 (S_Info_ID, S_Plant_ID, S_Profile_ID, S_DateID, S_User_ID , [TimeStamp], CO2_Status)
                                           
select PlantInfo.Info_ID, Plant.Plant_ID, PlantProfile.Profile_ID, Calendar.DateID, Users.[User_ID],  PlantInfo.[TimeStamp],
													case 
													when Sensor_Value <CO2_Min then 'CO2 value is low' 
													when Sensor_Value > CO2_Min and Sensor_Value < CO2_Max then 'CO2 value is low'
                                                    when Sensor_Value > CO2_Max then 'CO2 value is high'
										            end as CO2_Status   

from SEP4_PMI.dbo.Plant
join SEP4_PMI.dbo.PlantProfile on SEP4_PMI.dbo.Plant.Profile_ID = SEP4_PMI.dbo.PlantProfile.Profile_ID
join SEP4_PMI.dbo.Calendar on Calendar.DateID = Calendar.DateID
join SEP4_PMI.dbo.PlantInfo on PlantInfo.Plant_ID = Plant.Plant_ID
join SEP4_PMI.dbo.Users on PlantProfile.[User_ID] = Users.[User_ID]
where PlantInfo.Sensor_Type = 'CO2' and Calendar.DateID = PlantInfo.Info_ID 

drop table Stage_Fact_CO2
select * from Stage_Fact_CO2
delete from Stage_Fact_CO2

-----------------------------------------------------------------------------------------------------------



create table Stage_Fact_Hum (
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
delete from Stage_Fact_Light

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
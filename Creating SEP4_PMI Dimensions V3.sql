------------------------------Dimension tables------------------------------------------------
create database Dim_SEP4_PMI;

use Dim_SEP4_PMI;

--**************************************Dim_Users***********************************--
DROP TABLE IF EXISTS Dim_Users;

create table Dim_Users (
Su_User_ID int identity(1,1) not null primary key,
User_ID int not null,
[Email] varchar(50) not null,
[ValidFrom] DATE not null DEFAULT getdate(),
[ValidTo] DATE not null DEFAULT '9999-12-31'
);

--DROP TABLE Dim_USERs;
-- loading data from the staging area to the warehouse

insert into Dim_Users([Email], [User_ID])
select [Email], [User_ID]
from Stage_SEP4_PMI.dbo.stage_dim_Users;

select * from Dim_Users;
--**************************************Dim_Date_Calendar******************************--

DROP TABLE IF EXISTS Dim_Calendar;

create table Dim_Calendar
(
 Su_Date_ID int identity (1, 1) NOT NULL primary key,
 [CalendarDate] DATETIME,
 WeekDayName nvarchar(50),
 MonthName nvarchar(50)
)


-- loading data from the staging area to the warehouse

insert into Dim_Calendar ([CalendarDate], WeekDayName,  MonthName)
select [CalendarDate], WeekDayName, MonthName
from Stage_SEP4_PMI.dbo.stage_dim_Calendar;

select * from Dim_Calendar;
--**************************************Dim_Time******************************--

DROP TABLE IF EXISTS Dim_Time;

create table Dim_Time
(
 Su_Time_ID int identity (1, 1) NOT NULL primary key,
 [Time] TIME
);


-- loading data from the staging area to the warehouse

insert into Dim_Time ([Time])
select [Time]
from Stage_SEP4_PMI.dbo.stage_dim_Time;

select * from Dim_Time;
--**************************************Dim_PlantProfile********************************--

DROP TABLE IF EXISTS Dim_PlantProfile;
CREATE TABLE dbo.Dim_PlantProfile(
	Su_Profile_ID int identity (1,1) not null primary key, ---surrogate key
	Profile_ID int				     not null,             ---refers to the PlantProfile in the business database
	Profile_Name varchar(50)		 not null,
	CO2_Max decimal			         not null,
	CO2_Min decimal			         not null,
	Hum_Max decimal			         not null,
	Hum_Min decimal 		         not null,
	Tem_Max decimal			         not null,
	Tem_Min decimal			         not null,
	Light_Max decimal		         not null,
	Light_Min decimal		         not null,
    [ValidFrom] DATE                 not null DEFAULT getdate(),
    [ValidTo] DATE                   not null DEFAULT '9999-12-31'
) ;

-- loading data from the staging area to the warehouse

insert into Dim_PlantProfile (Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min)
select Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min
from Stage_SEP4_PMI.dbo.stage_dim_PlantProfile;

select * from Dim_PlantProfile;


--**********************************************DIm_Plant***************************************************--
DROP Table if exists Dim_Plant;
create table Dim_Plant (
	Su_Plant_ID int identity (1,1) not null primary key, ---surrogate key
	[Plant_ID] int				   not null,             ---refers to the Plant in the business database
	[Device_ID] varchar(50)         not null,
	[Plant_Name] varchar(50)         not null,
	[ValidFrom] DATE                 not null DEFAULT getdate(),
    [ValidTo] DATE                   not null DEFAULT '9999-12-31'
);

-- loading data from the staging area to the warehouse

insert into Dim_Plant (Plant_ID, Plant_Name, [Device_ID])
select Plant_ID, Plant_Name, [Device_ID]
from Stage_SEP4_PMI.dbo.stage_dim_Plant;

select * from Dim_Plant;

---Creating status junk table holding the status values

drop table if exists status_junk_dim;

create table status_junk_dim (
    status_id int primary key ,
    status_value varchar(50)
);

insert into status_junk_dim (status_id, status_value)
select status_id,status_value
from Stage_SEP4_PMI.dbo.stage_status_dim;

SELECT * FROM status_junk_dim;
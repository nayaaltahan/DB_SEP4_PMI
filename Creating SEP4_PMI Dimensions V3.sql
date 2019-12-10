------------------------------Dimension tables------------------------------------------------
create database Dim_SEP4_PMI;

use Dim_SEP4_PMI;

--**************************************Dim_Users***********************************--
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
from Stage_SEP4_PMI.dbo.stage_dim_Calendar

select * from Dim_Calendar;
--**************************************Dim_Time******************************--

create table Dim_Time
(
 Su_Time_ID int identity (1, 1) NOT NULL primary key,
 [Time] TIME
)


-- loading data from the staging area to the warehouse

insert into Dim_Time ([Time])
select [Time]
from Stage_SEP4_PMI.dbo.stage_dim_Time;

select * from Dim_Time;
--DROP TABLE Dim_Time;
--**************************************Dim_PlantProfile********************************--

CREATE TABLE dbo.Dim_PlantProfile(
	Su_Profile_ID int identity (1,1) not null primary key, ---surrogate key
	Profile_ID int				     not null,             ---refers to the PlantProfile in the business database
	Profile_Name varchar(50)		 not null,
	CO2_Max decimal(6,3)			 not null,
	CO2_Min decimal(6,3)			 not null,
	Hum_Max decimal(6,3)			 not null,
	Hum_Min decimal(6,3)			 not null,
	Tem_Max decimal(6,3)			 not null,
	Tem_Min decimal(6,3)			 not null,
	Light_Max decimal(6,3)		 not null,
	Light_Min decimal(6,3)		 not null,
    [ValidFrom] DATE                 not null DEFAULT getdate(),
    [ValidTo] DATE                   not null DEFAULT '9999-12-31'
) ;

-- loading data from the staging area to the warehouse

insert into Dim_PlantProfile (Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min)
select Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min
from Stage_SEP4_PMI.dbo.stage_dim_PlantProfile;

select * from Dim_PlantProfile;

--**********************************************DIm_Plant***************************************************--
create table Dim_Plant (
	Su_Plant_ID int identity (1,1) not null primary key, ---surrogate key
	[Plant_ID] int				   not null,             ---refers to the Plant in the business database
	[Plant_Name] varchar(50)         not null,
	[ValidFrom] DATE                 not null DEFAULT getdate(),
    [ValidTo] DATE                   not null DEFAULT '9999-12-31'
);

-- loading data from the staging area to the warehouse

insert into Dim_Plant (Plant_ID, Plant_Name)
select Plant_ID, Plant_Name
from Stage_SEP4_PMI.dbo.stage_dim_Plant;

select * from Dim_Plant;

-----------------------------Creating source tables-------------------------------------
create database SEP4_PMI

use SEP4_PMI        

drop table if exists [Users] 
drop table if exists PlantProfile
drop table if exists Plant
drop table if exists PlantInfo
drop table if exists Calendar

------------------------------------Users Table-----------------------------------------
create table Users (
[User_ID] varchar(50) not null primary key,
[Password] varchar (50) not null
)

insert into dbo.Users (
[User_ID],
[Password])

values 
('gwan777@yahoo.com' , '12345'),
('ziad7777@gmail.com' , '23456'),
('naya7777@gmail.com', '34567')

-----------------------------------PlantProfile-------------------------------

create table PlantProfile (
Profile_ID int identity (1, 1) not null primary key,
[User_ID] varchar(50),
Profile_Name varchar(50) null,
CO2_Max decimal null,
CO2_Min decimal null,
Hum_Max decimal null,
Hum_Min decimal null,
Tem_Max decimal null,
Tem_Min decimal null,
Light_Max decimal null,
Light_Min decimal null
foreign key ("User_ID")   references dbo.Users ("User_ID")
)


insert into PlantProfile ( [User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max ,Light_Min)
values ((select [User_ID] from dbo.Users where [User_ID] = 'gwan777@yahoo.com'), 'flower1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 'ziad7777@gmail.com'), 'flower2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	   ( (select [User_ID] from dbo.Users where [User_ID] = 'naya7777@gmail.com'), 'flower3' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 'naya7777@gmail.com'), 'flower4' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	    ( (select [User_ID] from dbo.Users where [User_ID] = 'naya7777@gmail.com'), 'flower5' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 'gwan777@yahoo.com'), 'flower6' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 'ziad7777@gmail.com'), 'flower7' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 'gwan777@yahoo.com'), 'flower8' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100)

--select * from PlantProfile
	  
-----------------------------------Plant--------------------------------------

create table Plant (
Plant_ID int identity (1,1) not null primary key,
Profile_ID int not null,
PlantName varchar(50) null
foreign key ("Profile_ID")   references dbo.PlantProfile ("Profile_ID")
)

insert into dbo.Plant (Profile_ID, PlantName)
values  ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 1),'flowerA'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 2),'flowerB'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 3),'flowerC'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 4),'flowerC'),
		( (select Profile_ID from dbo.PlantProfile where Profile_ID = 5),'flowerD'),
		( (select Profile_ID from dbo.PlantProfile where Profile_ID = 6),'flowerE'),
		( (select Profile_ID from dbo.PlantProfile where Profile_ID = 7),'flowerF'),
		( (select Profile_ID from dbo.PlantProfile where Profile_ID = 8),'flowerG')


---------------------------------Device--------------------------------------

create table PlantInfo (
Info_ID int identity(1,1) not null primary key,
Plant_ID int not null,
Sensor_Type varchar (50) null,
Sensor_Value decimal (6,3) not null,
[TimeStamp] DateTime not null
    foreign key ("Plant_ID") references dbo.Plant ("Plant_ID")
)


insert into dbo.PlantInfo(Plant_ID, Sensor_Type, Sensor_Value, [Timestamp])
    values ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 120, '2008-01-01 00:00:01'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.30, '2008-01-01 00:00:01'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature' , 25, '2008-01-01 00:00:01'),
           (  (select Plant_ID from dbo.Plant where Plant_ID = 4), 'Light' , 80, '2008-01-01 00:00:01'),
		   (  (select Plant_ID from dbo.Plant where Plant_ID = 5), 'Light' , 30, '2008-01-01 00:00:01'),
		   (  (select Plant_ID from dbo.Plant where Plant_ID = 6), 'CO2' , 150, '2008-01-01 00:00:01'),
		      (  (select Plant_ID from dbo.Plant where Plant_ID = 7), 'CO2' , 10, '2008-01-01 00:00:01'),
			     (  (select Plant_ID from dbo.Plant where Plant_ID = 8), 'CO2' , 12, '2008-01-01 00:00:01')

--select * from PlantInfo
		
------------------------------------------------------------------------------------------------------------


CREATE TABLE Calendar
(
DateID int identity (1,1) not null primary key,
CalendarDate DATETIME not null,
WeekDayName nvarchar(50) not null,
MonthName nvarchar(50) not null,

)
go
DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = '2019-11-04'
SET @EndDate = DATEADD(d, 90,
@StartDate)
WHILE @StartDate <= @EndDate
BEGIN
INSERT INTO Calendar
(
CalendarDate
,WeekDayName
,MonthName
)
SELECT
@StartDate
,DATENAME(weekday,@startDate)
,DATENAME(month, @StartDate )
SET @StartDate = DATEADD(dd, 1, @StartDate)
END
-------------------------------------------------------------------------------------

select * from dbo.PlantProfile
select * from dbo.PlantInfo
select * from dbo.Plant
select * from dbo.Users

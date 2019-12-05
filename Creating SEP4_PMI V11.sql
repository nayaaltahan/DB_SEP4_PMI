-----------------------------Creating source tables-------------------------------------
create database SEP4_PMI

use SEP4_PMI   

drop table if exists [Time]
drop table if exists [Users] 
drop table if exists PlantProfile
drop table if exists Plant
drop table if exists PlantInfo

------------------------------------Users Table-----------------------------------------
create table Users (
[User_ID] int identity (1, 1) not null primary key,
[Email] varchar(50) not null unique,
[Password] varchar (50) not null
)

insert into dbo.Users (
[Email],
[Password])

values 
('gwan777@yahoo.com' , '12345'),
('ziad7777@gmail.com' , '23456'),
('naya7777@gmail.com', '34567')

select * from Users
-----------------------------------PlantProfile-------------------------------

create table PlantProfile (
Profile_ID int identity (1, 1) not null primary key,
[User_ID] int not null,
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
delete from PlantProfile

insert into PlantProfile ( [User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max ,Light_Min)
values ((select [User_ID] from dbo.Users where [User_ID] = 1), 'flower1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 2), 'flower2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	   ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'flower3' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'flower4' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	    ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'flower5' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 1), 'flower6' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 2), 'flower7' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 1), 'flower8' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100)

select * from PlantProfile
	  
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

select * from Plant
---------------------------------Device--------------------------------------

create table PlantInfo (
Info_ID int identity(1,1) not null primary key,
Plant_ID int not null,
Sensor_Type varchar (50) null,
Sensor_Value decimal (6,3) not null,
[TimeStamp] DateTime not null
    foreign key ("Plant_ID") references dbo.Plant ("Plant_ID")
)
delete from PlantInfo

insert into dbo.PlantInfo(Plant_ID, Sensor_Type, Sensor_Value, [Timestamp])
    values ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 120, '2019-11-01 00:00:01.000'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.30, '2019-11-01 00:00:01.000'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature' , 25, '2019-11-01 00:00:01.000'),
           ( (select Plant_ID from dbo.Plant where Plant_ID = 4), 'Light' , 80, '2019-11-01 00:00:01.000'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 5), 'Light' , 30, '2019-11-01 00:00:01.000'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 6), 'CO2' , 150, '2019-11-01 00:00:01.000'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 7), 'Humidity' , 10, '2019-11-01 00:00:01.000'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 8), 'CO2' , 12, '2019-11-01 00:00:01.000')

select * from PlantInfo

---------------------------------Caledar--------------------------------------
create table [Date](
 Date_ID int identity (1, 1) NOT NULL primary key,	
 [CalendarDate] DATETIME,
 WeekDayName nvarchar(50),
 MonthName nvarchar(50) 
)


  DECLARE @StartDate DATETIME 
  DECLARE @EndDate DATETIME 
  SET @StartDate= '2019-11-01' 
   SET @EndDate= DATEADD(d, 1095, @StartDate) -- 90 days has been assigned until we finish the SEP4 Exam
   WHILE @StartDate<= @EndDate
   BEGIN 
   INSERT INTO [Date](CalendarDate,WeekDayName,MonthName)
   SELECT 
   @StartDate,DATENAME(weekday,@startDate),
   DATENAME(month, @StartDate)SET @StartDate= DATEADD(dd, 1, @StartDate)END

   select * from [Date]




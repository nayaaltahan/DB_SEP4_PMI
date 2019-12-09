-----------------------------Creating source tables-------------------------------------
create database SEP4_PMI

use SEP4_PMI   

drop table if exists [Users]
drop table if exists PlantProfile
drop table if exists Plant
drop table if exists PlantData

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

select * from SEP4_PMI.dbo.Users
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
values ((select [User_ID] from dbo.Users where [User_ID] = 1), 'gwan flower 1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 2), 'ziad flower 1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	   ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'naya flower 1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'naya flower 2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	    ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'naya flower 3' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 1), 'gwan flower 2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 2), 'ziad flower 2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
		((select [User_ID] from dbo.Users where [User_ID] = 1), 'gwan flower 3' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100)

select * from PlantProfile
	  
-----------------------------------Plant--------------------------------------

create table Plant (
Plant_ID int identity (1,1) not null primary key,
[Device_ID] varchar(50) not null,
Profile_ID int not null,
PlantName varchar(50) null
foreign key ("Profile_ID")   references dbo.PlantProfile ("Profile_ID")
)


create table PlantData (
Data_ID int identity(1,1) not null primary key,
Plant_ID int not null,
Sensor_Type varchar (50) null,
Sensor_Value decimal (6,3) not null,
[TimeStamp] DateTime not null
    foreign key ("Plant_ID") references dbo.Plant ("Plant_ID")
)


---------------------------------Device--------------------------------------

insert into dbo.Plant (Profile_ID,[Device_ID], PlantName)
values  ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 1),'GWANEUI1','gwan tulip'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 2),'ZIADEUI1', 'ziad tulip'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 3),'NAYAEUI1', 'naya rose'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 4),'NAYAEUI2','naya sunflower'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 5),'NAYAEUI3','naya lily'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 6),'GWANEUI2','gwan orchids'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 7),'ZIADEUI2', 'ziad tulip'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 8),'GWANEUI3','gwan rose');

        select * from Plant;

delete from PlantData;

insert into dbo.PlantData(Plant_ID, Sensor_Type, Sensor_Value, [Timestamp])
    values ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 120, GETDATE()),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.30, GETDATE()),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature' , 25, getdate()),
           ( (select Plant_ID from dbo.Plant where Plant_ID = 4), 'Light' , 80, GETDATE()),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 5), 'Light' , 30, GETDATE()),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 6), 'CO2' , 150, GETDATE()),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 7), 'Humidity' , 10, GETDATE()),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 8), 'CO2' , 12,GETDATE())

select * from PlantData;
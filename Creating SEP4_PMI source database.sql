-----------------------------Creating source tables-------------------------------------
create database SEP4_PMI;

use SEP4_PMI;

drop table if exists PlantData;
drop table if exists Plant;
drop table if exists PlantProfile;
drop table if exists [Users];

------------------------------------Users Table-----------------------------------------
create table Users (
[User_ID] int identity (1, 1) not null primary key,
[Email] varchar(50) not null unique,
[Password] varchar (50) not null
);

insert into dbo.Users (
[Email],
[Password])

values 
('gwan777@yahoo.com' , '12345'),
('ziad7777@gmail.com' , '23456'),
('naya7777@gmail.com', '34567')

select * from SEP4_PMI.dbo.Users;
-----------------------------------PlantProfile-------------------------------

create table PlantProfile (
Profile_ID int identity (1, 1) not null primary key,
[User_ID] int not null,
Profile_Name varchar(50) not null,
CO2_Max decimal not null,
CO2_Min decimal not null,
Hum_Max decimal not null,
Hum_Min decimal not null,
Tem_Max decimal not null,
Tem_Min decimal not null,
Light_Max decimal not null,
Light_Min decimal not null
foreign key ("User_ID")   references dbo.Users ("User_ID") on delete cascade on update cascade
);


insert into PlantProfile ( [User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max ,Light_Min)
values ( (select [User_ID] from dbo.Users where [User_ID] = 1), 'gwan flower 1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 1), 'gwan flower 2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	   ( (select [User_ID] from dbo.Users where [User_ID] = 1), 'gwan flower 3' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 2), 'ziad flower 1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	   ( (select [User_ID] from dbo.Users where [User_ID] = 2), 'ziad flower 2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	   ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'naya flower 1' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
       ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'naya flower 2' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100),
	   ( (select [User_ID] from dbo.Users where [User_ID] = 3), 'naya flower 3' , 100, 10, 1.50, 0.25, 32, 0, 1000 ,100)

select * from PlantProfile;
	  
-----------------------------------Plant--------------------------------------

create table Plant (
Plant_ID int identity (1,1) not null primary key,
Profile_ID int not null,
[Device_ID] varchar(50) not null,
PlantName varchar(50) not null
foreign key ("Profile_ID")   references dbo.PlantProfile ("Profile_ID") on delete cascade on update cascade 
);

insert into dbo.Plant (Profile_ID,[Device_ID], PlantName)
values  ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 1),'GWANEUI1','gwan tulip'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 2),'ZIADEUI1', 'ziad tulip'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 1),'NAYAEUI1', 'naya rose'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 3),'NAYAEUI2','naya sunflower'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 2),'NAYAEUI3','naya lily'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 2),'GWANEUI2','gwan orchids'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 1),'ZIADEUI2', 'ziad tulip'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 3),'GWANEUI3','gwan rose'),
		( (select Profile_ID from dbo.PlantProfile where Profile_ID = 3),'ZIADEUI1', 'ziad tulip');


select * from Plant;

---------------------------------PLANT DATA--------------------------------------

create table PlantData (
Data_ID int identity(1,1) not null primary key,
Plant_ID int not null,
Sensor_Type varchar (50) null,
Sensor_Value decimal (6,3) null,
[TimeStamp] DateTime not null
    foreign key ("Plant_ID") references dbo.Plant ("Plant_ID") on delete cascade on update cascade
);

--drop table PlantData
select * from PlantData;

insert into dbo.PlantData(Plant_ID, Sensor_Type, Sensor_Value, [Timestamp])
--------------------------------------------Plant_ID 1 Device reading on 09th---------------------------------
    values ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 120, '2019-12-09 10:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 115, '2019-12-09 11:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 100, '2019-12-09 16:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 65, '2019-12-09 19:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 76, '2019-12-09 13:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 56,  '2019-12-09 16:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.30,  '2019-12-09 09:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.25,  '2019-12-09 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.11,  '2019-12-09 11:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature', 21,  '2019-12-09 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature',  23, '2019-12-09 11:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature', 43,  '2019-12-09 13:11:41.913'),

--------------------------------------------Plant_ID 1 Device reading on 10th ------------------------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 121, '2019-12-10 12:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 116, '2019-12-10 19:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 105, '2019-12-10 21:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 60, '2019-12-10 12:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 70, '2019-12-10 13:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 58, '2019-12-10 15:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.40, '2019-12-10 07:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.30, '2019-12-10 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.15, '2019-12-10 16:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature', 25,  '2019-12-10 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature',  26, '2019-12-10 11:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature', 38,  '2019-12-10 13:11:41.913'),

---------------------------------------------Plant_ID 1 Device reading on 11th ------------------------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 111, '2019-12-11 23:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 106, '2019-12-11 20:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'CO2', 125, '2019-12-11 21:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 63, '2019-12-11 15:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 75, '2019-12-11 14:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1) , 'Light', 60, '2019-12-11 11:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.31, '2019-12-11 05:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.32, '2019-12-11 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Humidity', 1.18, '2019-12-11 14:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature', 30,  '2019-12-11 06:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature',  27, '2019-12-11 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 1), 'Temperature', 39,  '2019-12-11 14:11:41.913'),

--------------------------------------------Plant_ID 2 Device reading on 09th---------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 109, '2019-12-09 12:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 102, '2019-12-09 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 95, '2019-12-09 08:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 80, '2019-12-09 19:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 50, '2019-12-09 13:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 30,  '2019-12-09 16:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.01,  '2019-12-09 09:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.12,  '2019-12-09 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.13,  '2019-12-09 11:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature', 28,  '2019-12-09 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature',  28, '2019-12-09 11:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature', 29,  '2019-12-09 13:11:41.913'),

--------------------------------------------Plant_ID 2 Device reading on 10th ------------------------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 121, '2019-12-10 12:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 116, '2019-12-10 19:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 105, '2019-12-10 21:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 60, '2019-12-10 12:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 70, '2019-12-10 13:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 58, '2019-12-10 15:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.40, '2019-12-10 07:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.30, '2019-12-10 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.15, '2019-12-10 16:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature', 25,  '2019-12-10 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature',  26, '2019-12-10 11:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature', 38,  '2019-12-10 13:11:41.913'),

---------------------------------------------Plant_ID 2 Device reading on 11th ------------------------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 100, '2019-12-11 23:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 107, '2019-12-11 20:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'CO2', 130, '2019-12-11 21:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 86, '2019-12-11 15:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 61, '2019-12-11 14:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2) , 'Light', 50, '2019-12-11 11:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.10, '2019-12-11 05:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.28, '2019-12-11 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Humidity', 1.21, '2019-12-11 14:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature', 29,  '2019-12-11 06:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature',  22, '2019-12-11 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 2), 'Temperature', 18,  '2019-12-11 14:11:41.913'),

		   
--------------------------------------------Plant_ID 3 Device reading on 09th---------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 99, '2019-12-09 13:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 111, '2019-12-09 15:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 85, '2019-12-09 09:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 85, '2019-12-09 20:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 58, '2019-12-09 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 60,  '2019-12-09 16:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.20,  '2019-12-09 03:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.30,  '2019-12-09 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.50,  '2019-12-09 09:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature', 32,  '2019-12-09 08:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature',  29, '2019-12-09 07:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature', 16,  '2019-12-09 15:11:41.913'),

--------------------------------------------Plant_ID 3 Device reading on 10th ------------------------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 120, '2019-12-10 12:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 106, '2019-12-10 19:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 104, '2019-12-10 21:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 58, '2019-12-10 12:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 75, '2019-12-10 13:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 61, '2019-12-10 15:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.31, '2019-12-10 07:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.25, '2019-12-10 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.17, '2019-12-10 16:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature', 30,  '2019-12-10 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature',  21, '2019-12-10 11:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature', 19,  '2019-12-10 13:11:41.913'),

---------------------------------------------Plant_ID 3 Device reading on 11th ------------------------------------------------
           ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 150, '2019-12-11 23:11:41.913'), 
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 142, '2019-12-11 20:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'CO2', 112, '2019-12-11 21:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 35, '2019-12-11 15:11:41.913'),
	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 20, '2019-12-11 14:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3) , 'Light', 35, '2019-12-11 11:11:41.913'),

	       ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.16, '2019-12-11 05:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.30, '2019-12-11 16:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Humidity', 1.25, '2019-12-11 14:11:41.913'),

		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature', 31,  '2019-12-11 06:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature',  26, '2019-12-11 10:11:41.913'),
		   ( (select Plant_ID from dbo.Plant where Plant_ID = 3), 'Temperature', 24,  '2019-12-11 14:11:41.913');




select * from PlantData;
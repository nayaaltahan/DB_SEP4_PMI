------------------------------Dimension tables------------------------------------------------
create database Dim_SEP4_PMI

use Dim_SEP4_PMI

--**************************************Dim_Users***********************************--
create table Dim_Users (
Su_User_ID int identity(1,1) not null primary key,
[Email] varchar(50) not null,
)

-- loading data from the staging area to the warehouse

insert into Dim_Users([Email])
select [Email]
from Stage_SEP4_PMI.dbo.stage_dim_Users

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


--**************************************Dim_PlantProfile********************************--

CREATE TABLE dbo.Dim_PlantProfile(
	Su_Profile_ID int identity (1,1) not null primary key, ---surrogate key
	Profile_ID int				 not null,             ---refers to the PlantProfile in the business database
	Profile_Name varchar(50)		 not null,
	CO2_Max decimal(18, 0)			 not null,
	CO2_Min decimal(18, 0)			 not null,
	Hum_Max decimal(18, 0)			 not null,
	Hum_Min decimal(18, 0)			 not null,
	Tem_Max decimal(18, 0)			 not null,
	Tem_Min decimal(18, 0)			 not null,
	Light_Max decimal(18, 0)		 not null,
	Light_Min decimal(18, 0)		 not null,
	"ValidFrom" date		 not null DEFAULT '01/11/2019',
	"ValidTo" date			 not null DEFAULT '01/01/2099'
) 

-- loading data from the staging area to the warehouse

insert into Dim_PlantProfile (Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min)
select Profile_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min
from Stage_SEP4_PMI.dbo.stage_dim_PlantProfile


--**********************************************DIm_Plant***************************************************--
create table Dim_Plant (
	Su_Plant_ID int identity (1,1) not null primary key, ---surrogate key
	[Plant_ID] int				   not null,             ---refers to the Plant in the business database
	[Plant_Name] varchar(50)         not null,
	"ValidFrom" date	   not null DEFAULT '01/11/2019',
	"ValidTo" date not null DEFAULT '01/01/2099'
)

-- loading data from the staging area to the warehouse

insert into Dim_Plant (Plant_ID, Plant_Name)
select Plant_ID, Plant_Name
from Stage_SEP4_PMI.dbo.stage_dim_Plant


--**********************************************Dim_Fact_CO2***************************************************--

create table Dim_Fact_CO2 (
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_Time_ID int          not null, --- surrogate key
Su_User_ID int			not null, ---- surrogate key
Plant_ID int			not null,
Profile_ID int		    not null,
User_ID int         	not null,
[Time] TIME	            not null,
[Date] DATE	            not null,
[Sensor_Value] decimal(3,3) null,
CO2_Status varchar(50)	not null
constraint "PK_CO2" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")

constraint "Su_Plant_ID_CO2" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_CO2" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_CO2" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_CO2" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_CO2" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

)


---Populate Stage CO2 facts table

insert into Dim_Fact_CO2 (Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,CO2_Status)
                                           
select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], SensorValue, CO2_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_CO2


--**********************************************Dim_Fact_Hum***************************************************--


create table Dim_Fact_Hum (
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_Time_ID int          not null, --- surrogate key
Su_User_ID int			not null, ---- surrogate key
Plant_ID int			not null,
Profile_ID int		    not null,
User_ID int         	not null,
[Time] TIME	            not null,
[Date] DATE	            not null,
[Sensor_Value] decimal(3,3) null,
Hum_Status varchar(50)	not null
constraint "PK_Hum" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")

constraint "Su_Plant_ID_Hum" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Hum" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Hum" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_Hum" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Hum" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID"))

select * from Dim_Fact_Hum

---Populate Stage CO2 facts table

insert into Dim_Fact_Hum (Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,Hum_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], SensorValue, Hum_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_Hum

--**********************************************Dim_Fact_Light***************************************************--


create table Dim_Fact_Light (
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_Time_ID int          not null, --- surrogate key
Su_User_ID int			not null, ---- surrogate key
Plant_ID int			not null,
Profile_ID int		    not null,
User_ID int         	not null,
[Time] TIME	            not null,
[Date] DATE	            not null,
[Sensor_Value] decimal(3,3) null,
Light_Status varchar(50)not null
constraint "PK_Light" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")

constraint "Su_Plant_ID_Light" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Light" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Light" foreign key("Su_Date_ID")references "Dim_Date"("Su_Date_ID"),

constraint "Su_Time_ID_Light" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Light" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

)

select * from Dim_Fact_Light

---Populate Stage CO2 facts table

insert into Dim_Fact_Light(Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,Light_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], SensorValue, Light_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_Light

--**********************************************Dim_Fact_Tem***************************************************--

create table Dim_Fact_Tem (
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_Time_ID int          not null, --- surrogate key
Su_User_ID int			not null, ---- surrogate key
Plant_ID int			not null,
Profile_ID int		    not null,
User_ID int         	not null,
[Time] TIME	            not null,
[Date] DATE	            not null,
[Sensor_Value] decimal(3,3) null,
Tem_Status varchar(50)not null
constraint "PK_Tem" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")

constraint "Su_Plant_ID_Tem" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Tem" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Tem" foreign key("Su_Date_ID")references "Dim_Date"("Su_Date_ID"),

constraint "Su_Time_ID_Tem" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Tem" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

)

select * from Dim_Fact_Tem

---Populate Stage CO2 facts table

insert into Dim_Fact_Tem(Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,Tem_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], SensorValue, Tem_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_tem
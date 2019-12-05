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

create table Dim_Calendar(
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
	D_Profile_ID int				 not null,             ---refers to the PlantProfile in the business database
	[D_User_ID] int					 not null ,
	Profile_Name varchar(50)		 not null,
	CO2_Max decimal(18, 0)			 not null,
	CO2_Min decimal(18, 0)			 not null,
	Hum_Max decimal(18, 0)			 not null,
	Hum_Min decimal(18, 0)			 not null,
	Tem_Max decimal(18, 0)			 not null,
	Tem_Min decimal(18, 0)			 not null,
	Light_Max decimal(18, 0)		 not null,
	Light_Min decimal(18, 0)		 not null,
	"ValidFrom" nvarchar(20)		 not null DEFAULT '01/11/2019',
	"Validto" nvarchar(20)			 not null DEFAULT '01/01/2099'
) 

-- loading data from the staging area to the warehous

insert into Dim_PlantProfile (D_Profile_ID, [D_User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min)
select St_Profile_ID,[St_User_ID], Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min
from Stage_SEP4_PMI.dbo.Stage_PlantProfile


--**************************************Dim_PlantInfo***********************************--

CREATE TABLE dbo.Dim_PlantInfo(
    Su_Info_ID int identity (1,1) not null primary key, ---surrogate key
	D_Info_ID int				  not null,				---refers to the PlantInfo in the business database
	D_Plant_ID int				  not null,
	Sensor_Type varchar(50)		  not null,
	Sensor_Value decimal(6, 3)    not null,
	[TimeStamp] datetime          not null,
	"ValidFrom" nvarchar(20)	  not null DEFAULT '01/11/2019',
	"Validto" nvarchar(20)		  not null DEFAULT '01/01/2099'

)

-- loading data from the staging area to the warehous
drop table Dim_PlantInfo
insert into Dim_PlantInfo (D_Info_ID, D_Plant_ID, Sensor_Type, Sensor_Value, TimeStamp)
select St_Info_ID , St_Plant_ID, Sensor_Type, Sensor_Value, [TimeStamp]

from Stage_SEP4_PMI.dbo.Stage_PlantInfo

select * from Dim_PlantInfo


--**********************************************DIm_Plant***************************************************--
create table Dim_Plant (
	Su_Plant_ID int identity (1,1) not null primary key, ---surrogate key
	D_Plant_ID int				   not null,             ---refers to the Plant in the business database
	D_Profile_ID int				   not null,			
	Plant_Name varchar(50)         not null,
	"ValidFrom" nvarchar(20)	   not null DEFAULT '01/11/2019',
	"Validto" nvarchar(20)		   not null DEFAULT '01/01/2099'
)

-- loading data from the staging area to the warehous

insert into Dim_Plant (D_Plant_ID, D_Profile_ID, Plant_Name)
select St_Plant_ID, St_Profile_ID, Plant_Name 
from Stage_SEP4_PMI.dbo.Stage_Plant


--**********************************************Dim_Fact_CO2***************************************************--

create table Dim_Fact_CO2 (
Su_Info_ID int			not null,  ---- surrogate key
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_User_ID int			not null, ---- surrogate key
D_Info_ID int			not null,
D_Plant_ID int			not null,
D_Profile_ID int		not null,
D_User_ID Varchar(50)	not null,
[TimeStamp] DateTime	not null,
CO2_Status varchar(50)	not null
constraint "PK_Info_ID_CO2" primary key("Su_Info_ID", "Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID")

constraint "Su_Info_ID_CO2" foreign key("Su_Info_ID" ) references "Dim_PlantInfo"("Su_Info_ID"),

constraint "Su_Plant_ID_CO2" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_CO2" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_CO2" foreign key("Su_Date_ID")references "Dim_Date"("Su_Date_ID"),

constraint "Su_User_ID_CO2" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

)


---Populate Stage CO2 facts table

insert into Dim_Fact_CO2 (Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID , Su_User_ID ,D_Info_ID, D_Plant_ID, D_Profile_ID,
                                     D_User_ID,  [TimeStamp], CO2_Status)
                                           
select Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,  Su_User_ID, St_Info_ID, 
             St_Plant_ID, St_Profile_ID, St_User_ID,  [TimeStamp], CO2_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_CO2


--**********************************************Dim_Fact_Hum***************************************************--


create table Dim_Fact_Hum (
Su_Info_ID int			not null,  ---- surrogate key
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_User_ID int			not null, ---- surrogate key
D_Info_ID int			not null,
D_Plant_ID int			not null,
D_Profile_ID int		not null,
D_User_ID Varchar(50)	not null,
[TimeStamp] DateTime	not null,
Hum_Status varchar(50)	not null
constraint "PK_Info_ID_Hum" primary key("Su_Info_ID", "Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID")

constraint "Su_Info_ID_Hum" foreign key("Su_Info_ID" ) references "Dim_PlantInfo"("Su_Info_ID"),

constraint "Su_Plant_ID_Hum" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Hum" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Hum" foreign key("Su_Date_ID")references "Dim_Date"("Su_Date_ID"),

constraint "Su_User_ID_Hum" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

)

select * from Dim_Fact_Hum

---Populate Stage CO2 facts table

insert into Dim_Fact_Hum (Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID , Su_User_ID ,D_Info_ID, D_Plant_ID, D_Profile_ID,
                                     D_User_ID,  [TimeStamp], Hum_Status)
                                           
select Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,  Su_User_ID, St_Info_ID, 
             St_Plant_ID, St_Profile_ID, St_User_ID,  [TimeStamp], Hum_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_Hum

--**********************************************Dim_Fact_Light***************************************************--


create table Dim_Fact_Light (
Su_Info_ID int			not null,  ---- surrogate key
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_User_ID int			not null, ---- surrogate key
D_Info_ID int			not null,
D_Plant_ID int			not null,
D_Profile_ID int		not null,
D_User_ID Varchar(50)	not null,
[TimeStamp] DateTime	not null,
Light_Status varchar(50)not null
constraint "PK_Info_ID_Light" primary key("Su_Info_ID", "Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID")

constraint "Su_Info_ID_Light" foreign key("Su_Info_ID" ) references "Dim_PlantInfo"("Su_Info_ID"),

constraint "Su_Plant_ID_Light" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Light" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Light" foreign key("Su_Date_ID")references "Dim_Date"("Su_Date_ID"),

constraint "Su_User_ID_Light" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

)

select * from Dim_Fact_Light

---Populate Stage CO2 facts table

insert into Dim_Fact_Light(Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID , Su_User_ID ,D_Info_ID, D_Plant_ID, D_Profile_ID,
                                     D_User_ID,  [TimeStamp], Light_Status)
                                           
select Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,  Su_User_ID, St_Info_ID, 
             St_Plant_ID, St_Profile_ID, St_User_ID,  [TimeStamp], Light_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_Light

--**********************************************Dim_Fact_Tem***************************************************--

create table Dim_Fact_Tem (
Su_Info_ID int			not null,  ---- surrogate key
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_User_ID int			not null, ---- surrogate key
D_Info_ID int			not null,
D_Plant_ID int			not null,
D_Profile_ID int		not null,
D_User_ID Varchar(50)	not null,
[TimeStamp] DateTime	not null,
Tem_Status varchar(50)not null
constraint "PK_Info_ID_Tem" primary key("Su_Info_ID", "Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID")

constraint "Su_Info_ID_Tem" foreign key("Su_Info_ID" ) references "Dim_PlantInfo"("Su_Info_ID"),

constraint "Su_Plant_ID_Tem" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Tem" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Tem" foreign key("Su_Date_ID")references "Dim_Date"("Su_Date_ID"),

constraint "Su_User_ID_Tem" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

)

select * from Dim_Fact_Tem

---Populate Stage CO2 facts table

insert into Dim_Fact_Tem(Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID , Su_User_ID ,D_Info_ID, D_Plant_ID, D_Profile_ID,
                                     D_User_ID,  [TimeStamp], Tem_Status)
                                           
select Su_Info_ID, Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,  Su_User_ID, St_Info_ID, 
             St_Plant_ID, St_Profile_ID, St_User_ID,  [TimeStamp], Tem_Status
												
from Stage_SEP4_PMI.dbo.Stage_Fact_tem
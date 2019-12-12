


--**********************************************Dim_Fact_CO2***************************************************--
use Dim_SEP4_PMI;

DROP TABLE IF EXISTS Dim_Fact_CO2;
DROP TABLE IF EXISTS Dim_Fact_Hum;
DROP TABLE IF EXISTS Dim_Fact_Light;
DROP TABLE IF EXISTS Dim_Fact_Tem;

--- Create Junk Dimension holding possible values of the facts' status


create table Dim_Fact_CO2 (
Su_Plant_ID int			not null,
Su_Profile_ID int		not null,
Su_Date_ID  int			not null,
Su_Time_ID int          not null,
Su_User_ID int			not null,
[Sensor_Value] decimal(6,3) not null,
CO2_Status INT 	not null

constraint "Su_Plant_ID_CO2" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_CO2" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_CO2" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_CO2" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_CO2" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID"),

constraint "FK_status_CO2" foreign key("CO2_Status")references "status_junk_dim"("status_id"),

constraint "PK_CO2" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")


);


---Populate Stage CO2 facts table

insert into Dim_Fact_CO2 (Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID , Sensor_Value,CO2_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID, Sensor_Value, CO2_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_CO2;

select * from Dim_Fact_CO2;


--**********************************************Dim_Fact_Hum***************************************************--


create table Dim_Fact_Hum (
Su_Plant_ID int			not null,   ---- surrogate key
Su_Profile_ID int		not null,   ---- surrogate key
Su_Date_ID  int			not null,   ---- surrogate key
Su_Time_ID int          not null, --- surrogate key
Su_User_ID int			not null, ---- surrogate key
[Sensor_Value] decimal(6,3) not null,
Hum_Status int	        not null

constraint "Su_Plant_ID_Hum" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Hum" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Hum" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_Hum" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Hum" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID"),

constraint "FK_status_Hum" foreign key("Hum_Status")references "status_junk_dim"("status_id"),

constraint "PK_Hum" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")
);

select * from Dim_Fact_Hum;

---Populate Stage CO2 facts table

insert into Dim_Fact_Hum (Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Sensor_Value,Hum_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID, Sensor_Value, Hum_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_Hum;

SELECT * FROM Dim_Fact_Hum;


--**********************************************Dim_Fact_Light***************************************************--


create table Dim_Fact_Light (
Su_Plant_ID int			not null,
Su_Profile_ID int		not null,
Su_Date_ID  int			not null,
Su_Time_ID int          not null,
Su_User_ID int			not null,
[Sensor_Value] decimal(6,3) null,
Light_Status int not null

constraint "Su_Plant_ID_Light" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Light" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Light" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_Light" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Light" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID"),

constraint "FK_status_Light" foreign key("Light_Status")references "status_junk_dim"("status_id"),

constraint "PK_Light" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")

);


---Populate Stage LIGHT facts table

insert into Dim_Fact_Light(Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID, Sensor_Value,Light_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID, Sensor_Value, Light_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_Light;

select * from Dim_Fact_Light;


--**********************************************Dim_Fact_Tem***************************************************--

create table Dim_Fact_Tem (
Su_Plant_ID int			not null,
Su_Profile_ID int		not null,
Su_Date_ID  int			not null,
Su_Time_ID int          not null,
Su_User_ID int			not null,
[Sensor_Value] decimal(6,3) null,
Tem_Status int not null

constraint "Su_Plant_ID_Tem" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_Tem" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_Tem" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_Tem" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Tem" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID"),

constraint "FK_status_Tem" foreign key("Tem_Status")references "status_junk_dim"("status_id"),

constraint "PK_Tem" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")

);


---Populate Stage TEM facts table

insert into Dim_Fact_Tem(Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID , Sensor_Value,Tem_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID, Sensor_Value, Tem_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_tem;

select * from Dim_Fact_Tem;

--**********************************************Dim_Fact_CO2***************************************************--
use Dim_SEP4_PMI;

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
[Sensor_Value] decimal(6,3) not null,
CO2_Status varchar(50)	not null
constraint "PK_CO2" primary key("Su_Plant_ID", "Su_Profile_ID", "Su_Date_ID", "Su_User_ID", "Su_Time_ID")

constraint "Su_Plant_ID_CO2" foreign key("Su_Plant_ID" )references "Dim_Plant"("Su_Plant_ID"),

constraint "Su_Profile_ID_CO2" foreign key("Su_Profile_ID" )references "Dim_PlantProfile"("Su_Profile_ID"),

constraint "Su_Date_ID_CO2" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_CO2" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_CO2" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

);


---Populate Stage CO2 facts table

insert into Dim_Fact_CO2 (Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,CO2_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], Sensor_Value, CO2_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_CO2;


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

constraint "Su_User_ID_Hum" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID"));

select * from Dim_Fact_Hum

---Populate Stage CO2 facts table

insert into Dim_Fact_Hum (Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,Hum_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], Sensor_Value, Hum_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_Hum;

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

constraint "Su_Date_ID_Light" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_Light" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Light" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

);

select * from Dim_Fact_Light

---Populate Stage CO2 facts table

insert into Dim_Fact_Light(Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,Light_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], Sensor_Value, Light_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_Light;

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

constraint "Su_Date_ID_Tem" foreign key("Su_Date_ID")references "Dim_Calendar"("Su_Date_ID"),

constraint "Su_Time_ID_Tem" foreign key("Su_Time_ID")references "Dim_Time"("Su_Time_ID"),

constraint "Su_User_ID_Tem" foreign key("Su_User_ID")references "Dim_Users"("Su_User_ID")

);

select * from Dim_Fact_Tem

---Populate Stage CO2 facts table

insert into Dim_Fact_Tem(Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID ,Plant_ID, Profile_ID,
                                     User_ID, [Date],[Time], Sensor_Value,Tem_Status)

select Su_Plant_ID, Su_Profile_ID, Su_Date_ID ,Su_Time_ID, Su_User_ID,
             Plant_ID, Profile_ID, User_ID ,[Date], [Time], Sensor_Value, Tem_Status

from Stage_SEP4_PMI.dbo.Stage_Fact_tem;
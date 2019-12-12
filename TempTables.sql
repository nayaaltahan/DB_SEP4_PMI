USE Stage_SEP4_PMI

--sttoring changed plant
Create table changed_Plant(
Plant_ID int,
Device_ID varchar(50),
Plant_Name varchar(50)
)
--storing changed plant profile
CREATE TABLE changed_PlantProfile(
Profile_ID int,
Profile_Name varchar(50)

)
--storing changed user
CREATE TABLE changed_Users(
[User_ID] int,
Email varchar(50)
)




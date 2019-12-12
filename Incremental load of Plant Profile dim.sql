USE SEP4_PMI

---------------------------------INSERT NEW PLANTS-----------------------------------------

go
Insert Into [Dim_SEP4_PMI].dbo.Dim_PlantProfile
( Profile_ID, Profile_Name)
---Find added rows
Select Profile_ID, Profile_Name
from PlantProfile ---today
Where Profile_ID in
((
---today
Select [Profile_ID] from PlantProfile
)
EXCEPT
--- yesterday
(
Select [Profile_ID]
From [Dim_SEP4_PMI].dbo.Dim_PlantProfile
));

select * from Dim_SEP4_PMI.dbo.Dim_PlantProfile;

---------------------------UPDATE DELETED PLANTS-----------------------------
go
Update [Dim_SEP4_PMI].dbo.Dim_PlantProfile
SET ValidTo = DATEADD(day,-1, cast(getdate() as date))
---last Updated
Where Profile_ID in
(
---yesterday
(
Select [Profile_ID]
From [Dim_SEP4_PMI].dbo.Dim_PlantProfile
)
EXCEPT
(
---today
Select Profile_ID
from PlantProfile
)
)

select * from Dim_SEP4_PMI.dbo.Dim_PlantProfile;


---------------------------INSERT AND UPDATE FOR CHANGED PLANTS-----------------------------------

go
---1. INSERT INTO TEMP TABLE
Insert into
[Stage_SEP4_PMI].dbo.changed_PlantProfile
(Profile_ID, Profile_Name
)
(
--- today
Select Profile_ID
, Profile_Name
from PlantProfile
)
EXCEPT
(
---yesterday
Select Profile_ID
,Profile_Name
From Dim_SEP4_PMI.dbo.Dim_PlantProfile
)
EXCEPT
( Select Profile_ID
,Profile_Name
from PlantProfile
Where Profile_ID NOT IN ( SELECT Profile_Name
FROM Dim_SEP4_PMI.dbo.Dim_PlantProfile)
)
go
--- 2. Update existing row in dimension table
---
UPDATE [Dim_SEP4_PMI].[dbo].[Dim_PlantProfile]
SET ValidTo =  DATEADD(day,-1, cast(getdate() as date)) --- last Updated
WHERE Profile_ID IN
( SELECT Profile_ID
FROM Stage_SEP4_PMI.dbo.changed_PlantProfile)
--- 3. Insert new row in dimension table
---
INSERT INTO Dim_SEP4_PMI.dbo.Dim_PlantProfile
([Profile_ID]
,[Profile_Name]
)
SELECT [Profile_ID]
,[Profile_Name]
FROM Stage_SEP4_PMI.dbo.changed_PlantProfile

select * from Dim_SEP4_PMI.dbo.Dim_PlantProfile;

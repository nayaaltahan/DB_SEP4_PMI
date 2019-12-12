USE SEP4_PMI

--Finding deleted rows
Select *
From [Dim_SEP4_PMI].dbo.Dim_Plant
Where Plant_ID
In (
---yesterday
( select [Plant_ID]
From [Dim_SEP4_PMI].dbo.Dim_Plant
)
EXCEPT (
--- today
Select [Plant_ID] from Plant
)
)


--Finding new rows
Select Plant_ID, Device_ID, PlantName
from Plant
---today
Where Plant_ID in
((
---today
Select [Plant_ID]
from Plant
)
EXCEPT
---yesterday
(select [Plant_ID]
From [Dim_SEP4_PMI].dbo.Dim_Plant
)
)


--Finding changed rows
--- today
go
(Select Plant_ID, Device_ID, PlantName
from Plant
)

EXCEPT
(
--- yesterday
select
Plant_ID, Device_ID, Plant_Name
From Dim_SEP4_PMI.dbo.Dim_Plant
)

EXCEPT
( select
Plant_ID,Device_ID,PlantName
from Plant
Where Plant_ID
NOT IN (SELECT Plant_ID
FROM Dim_SEP4_PMI.dbo.Dim_Plant
)
 )

---------------------------------INSERT NEW PLANTS-----------------------------------------

go
Insert Into [Dim_SEP4_PMI].dbo.Dim_Plant
( PLANT_ID, DEVICE_ID, PLANT_NAME)
---Find added rows
Select Plant_ID, Device_ID, PlantName
from Plant ---today
Where Plant_ID in
((
---today
Select [Plant_ID] from Plant
)
EXCEPT
--- yesterday
(
Select [Plant_ID]
From [Dim_SEP4_PMI].dbo.Dim_Plant
));

select * from Dim_SEP4_PMI.dbo.Dim_Plant;

---------------------------UPDATE DELETED PLANTS-----------------------------
go
Update [Dim_SEP4_PMI].dbo.Dim_Plant
SET ValidTo = DATEADD(day,-1, cast(getdate() as date))
---last Updated
Where Plant_ID in
(
---yesterday
(
Select [Plant_ID]
From [Dim_SEP4_PMI].dbo.Dim_Plant
)
EXCEPT
(
---today
Select Plant_ID
from Plant
)
)

select * from Dim_SEP4_PMI.dbo.Dim_Plant;


---------------------------INSERT AND UPDATE FOR CHANGED PLANTS-----------------------------------

go
---1. INSERT INTO TEMP TABLE
Insert into
[Stage_SEP4_PMI].dbo.changed_Plant
(Plant_ID, Device_ID, Plant_Name
)
(
--- today
Select Plant_ID
,Device_ID
,PlantName
from Plant
)
EXCEPT
(
---yesterday
Select Plant_ID
,Device_ID
,Plant_Name
From Dim_SEP4_PMI.dbo.Dim_Plant
)
EXCEPT
( Select Plant_ID
,Device_ID
,PlantName
from Plant
Where Plant_ID NOT IN ( SELECT Plant_ID
FROM Dim_SEP4_PMI.dbo.Dim_Plant)
)
go
--- 2. Update existing row in dimension table
---
UPDATE [Dim_SEP4_PMI].[dbo].[Dim_Plant]
SET ValidTo =  DATEADD(day,-1, cast(getdate() as date)) --- last Updated
WHERE Plant_ID IN
( SELECT Plant_ID
FROM Stage_SEP4_PMI.dbo.changed_Plant)
--- 3. Insert new row in dimension table
---
INSERT INTO Dim_SEP4_PMI.dbo.Dim_Plant
([Plant_ID]
,[Device_ID]
,[Plant_Name]
)
SELECT [Plant_ID]
,[Device_ID]
,[Plant_Name]
FROM Stage_SEP4_PMI.dbo.changed_Plant

select * from Dim_SEP4_PMI.dbo.Dim_Plant;

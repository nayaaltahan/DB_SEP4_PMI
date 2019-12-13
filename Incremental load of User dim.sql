USE SEP4_PMI
--Delete From Users where User_ID = 4
--select * from Users
--Finding deleted rows
Select *
From [Dim_SEP4_PMI].dbo.Dim_Users
Where User_ID
In (
---yesterday
( select User_ID
From [Dim_SEP4_PMI].dbo.Dim_Users
)
EXCEPT (
--- today
Select User_ID from Users
)
)


--Finding new rows
Select User_ID, Email
from Users
---today
Where User_ID in
((
---today
Select User_ID
from Users
)
EXCEPT
---yesterday
(select User_ID
From [Dim_SEP4_PMI].dbo.Dim_Users
)
)

--UPDATE Users
--SET  Email= 'jwan777@gmail.com'
--WHERE User_ID = 1;
--Finding changed rows
--- today
go
(Select User_ID, Email
from Users
)

EXCEPT
(
--- yesterday
select
User_ID, Email
From Dim_SEP4_PMI.dbo.Dim_Users
)

EXCEPT
( select
User_ID,Email
from Users
Where User_ID
NOT IN (SELECT User_ID
FROM Dim_SEP4_PMI.dbo.Dim_Users
)
 )

---------------------------------INSERT NEW User-----------------------------------------

go
Insert Into [Dim_SEP4_PMI].dbo.Dim_Users
( User_ID, Email)
---Find added rows
Select User_ID, Email
from Users ---today
Where User_ID in
((
---today
Select User_ID from Users
)
EXCEPT
--- yesterday
(
Select User_ID
From [Dim_SEP4_PMI].dbo.Dim_Users
));

select * from Dim_SEP4_PMI.dbo.Dim_Users

---------------------------UPDATE DELETED User-----------------------------
go
Update [Dim_SEP4_PMI].dbo.Dim_Users
SET ValidTo = DATEADD(day,-1, cast(getdate() as date))
---last Updated
Where User_ID in
(
---yesterday
(
Select User_ID
From [Dim_SEP4_PMI].dbo.Dim_Users
)
EXCEPT
(
---today
Select User_ID
from Users
)
)

select * from Dim_SEP4_PMI.dbo.Dim_Users


---------------------------INSERT AND UPDATE FOR CHANGED User-----------------------------------

go
---1. INSERT INTO TEMP TABLE
Insert into
[Stage_SEP4_PMI].dbo.changed_Users
(User_ID, Email
)
(
--- today
Select User_ID
,Email
from Users
)
EXCEPT
(
---yesterday
Select User_ID
,Email
From Dim_SEP4_PMI.dbo.Dim_Users
)
EXCEPT
( Select User_ID
,Email
from Users
Where User_ID NOT IN ( SELECT User_ID
FROM Dim_SEP4_PMI.dbo.Dim_Users)
)
go
--- 2. Update existing row in dimension table
---
UPDATE [Dim_SEP4_PMI].[dbo].[Dim_Users]
SET ValidTo =  DATEADD(day,-1, cast(getdate() as date)) --- last Updated
WHERE User_ID IN
( SELECT User_ID
FROM Stage_SEP4_PMI.dbo.changed_Users)
--- 3. Insert new row in dimension table
---
INSERT INTO Dim_SEP4_PMI.dbo.Dim_Users
(User_ID
,Email
)
SELECT User_ID
,Email
FROM Stage_SEP4_PMI.dbo.changed_Users

select * from Dim_SEP4_PMI.dbo.Dim_Users
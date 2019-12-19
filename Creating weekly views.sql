Use Dim_SEP4_PMI

DROP VIEW IF EXISTS CO2WeeklyAvgView;
DROP VIEW IF EXISTS TemWeeklyAvgView;
DROP VIEW IF EXISTS LightWeeklyAvgView;
DROP VIEW IF EXISTS HumWeeklyAvgView;

-----------------------------------------------CO2--------------------------------------------------------
CREATE View [CO2WeeklyAvgView] as
SELECT Dim_Calendar.WeekDayName as [Weekday], Dim_Calendar.CalendarDate as [Date] , Plant_ID, Device_ID, Plant_Name,
       avg(Dim_Fact_CO2.Sensor_Value) as CO2
    from Dim_SEP4_PMI.dbo.Dim_Fact_CO2
join dbo.Dim_Plant on Dim_Fact_CO2.Su_Plant_ID = Dim_Plant.Su_Plant_ID
join dbo.Dim_Calendar on Dim_Fact_CO2.Su_Date_ID = Dim_Calendar.Su_Date_ID
WHERE Dim_Calendar.CalendarDate > DATEADD(dd,-7, getdate()) AND Dim_Calendar.CalendarDate < getdate()
group by Dim_Calendar.WeekDayName, Dim_Calendar.CalendarDate, Plant_ID, Device_ID, Plant_Name;

SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, CO2 FROM CO2WeeklyAvgView ;

------------------------------------Humidity-------------------------------------------------

DROP VIEW IF EXISTS HumWeeklyAvgView;


CREATE View [HumWeeklyAvgView] as

SELECT Dim_Calendar.WeekDayName as [Weekday], Dim_Calendar.CalendarDate as [Date] , Plant_ID, Device_ID, Plant_Name,
       avg(Dim_Fact_Hum.Sensor_Value) as Humidity
    from Dim_SEP4_PMI.dbo.Dim_Fact_Hum
join dbo.Dim_Plant on Dim_Fact_Hum.Su_Plant_ID = Dim_Plant.Su_Plant_ID
join dbo.Dim_Calendar on Dim_Fact_Hum.Su_Date_ID = Dim_Calendar.Su_Date_ID
WHERE Dim_Calendar.CalendarDate > DATEADD(dd,-7, getdate()) AND Dim_Calendar.CalendarDate < getdate()
group by Dim_Calendar.WeekDayName, Dim_Calendar.CalendarDate, Plant_ID, Device_ID, Plant_Name;


SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, Humidity FROM HumWeeklyAvgView ;

--------------------------------------Light----------------------------------------------------------


DROP VIEW IF EXISTS LightWeeklyAvgView;


CREATE View [LightWeeklyAvgView] as

SELECT Dim_Calendar.WeekDayName as [Weekday], Dim_Calendar.CalendarDate as [Date] , Plant_ID, Device_ID, Plant_Name,
       avg(Dim_Fact_Light.Sensor_Value) as Light
       from Dim_SEP4_PMI.dbo.Dim_Fact_Light

join dbo.Dim_Plant on Dim_Fact_Light.Su_Plant_ID = Dim_Plant.Su_Plant_ID
join dbo.Dim_Calendar on Dim_Fact_Light.Su_Date_ID = Dim_Calendar.Su_Date_ID
WHERE Dim_Calendar.CalendarDate > DATEADD(dd,-7, getdate()) AND Dim_Calendar.CalendarDate < getdate()
group by Dim_Calendar.WeekDayName, Dim_Calendar.CalendarDate, Plant_ID, Device_ID, Plant_Name;

SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, Light FROM LightWeeklyAvgView ;



--------------------------------------Temperature----------------------------------------------------------


DROP VIEW IF EXISTS TemWeeklyAvgView;


CREATE View [TemWeeklyAvgView] as

SELECT Dim_Calendar.WeekDayName as [Weekday], Dim_Calendar.CalendarDate as [Date] , Plant_ID, Device_ID, Plant_Name,
       avg(Dim_Fact_Tem.Sensor_Value) as Temperature
       from Dim_SEP4_PMI.dbo.Dim_Fact_Tem

join dbo.Dim_Plant on Dim_Fact_Tem.Su_Plant_ID = Dim_Plant.Su_Plant_ID
join dbo.Dim_Calendar on Dim_Fact_Tem.Su_Date_ID = Dim_Calendar.Su_Date_ID
WHERE Dim_Calendar.CalendarDate > DATEADD(dd,-8, getdate()) AND Dim_Calendar.CalendarDate < getdate()
group by Dim_Calendar.WeekDayName, Dim_Calendar.CalendarDate, Plant_ID, Device_ID, Plant_Name;

SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, Temperature FROM [TemWeeklyAvgView] ;
SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, Light FROM LightWeeklyAvgView ;
SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, Humidity FROM HumWeeklyAvgView ;
SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, CO2 FROM CO2WeeklyAvgView ;
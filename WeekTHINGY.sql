Use Dim_SEP4_PMI

DROP VIEW IF EXISTS CO2WeeklyAvgView;


CREATE View [CO2WeeklyAvgView] as
SELECT Dim_Calendar.WeekDayName as [Weekday], Dim_Calendar.CalendarDate as [Date] , Plant_ID, Device_ID, Plant_Name,
       avg(Dim_Fact_CO2.Sensor_Value) as CO2
    from Dim_SEP4_PMI.dbo.Dim_Fact_CO2
join dbo.Dim_Plant on Dim_Fact_CO2.Su_Plant_ID = Dim_Plant.Su_Plant_ID
join dbo.Dim_Calendar on Dim_Fact_CO2.Su_Date_ID = Dim_Calendar.Su_Date_ID
WHERE Dim_Calendar.CalendarDate > DATEADD(dd,-8, getdate()) AND Dim_Calendar.CalendarDate < getdate()
group by Dim_Calendar.WeekDayName, Dim_Calendar.CalendarDate, Plant_ID, Device_ID, Plant_Name ;


SELECT [Weekday],[Date], Plant_ID, Device_ID, Plant_Name, CO2 FROM CO2WeeklyAvgView ;

Use Dim_SEP4_PMI

SELECT Plant_ID, Device_ID, Profile_ID, Plant_Name,
       avg(Dim_Fact_CO2.Sensor_Value) as CO2, avg(Dim_Fact_Hum.Sensor_Value) as Humidity,
       avg(Dim_Fact_Tem.Sensor_Value) as Temperature, avg(Dim_Fact_Light.Sensor_Value) as Light
    from Dim_SEP4_PMI.dbo.Dim_Fact_CO2
join dbo.Dim_Fact_Tem on Dim_Fact_CO2.Su_Plant_ID = Dim_Fact_Tem.Su_Plant_ID
join dbo.Dim_Fact_Light on Dim_Fact_CO2.Su_Plant_ID = Dim_Fact_Light.Su_Plant_ID
join dbo.Dim_Fact_Hum on Dim_Fact_CO2.Su_Plant_ID = Dim_Fact_Hum.Su_Plant_ID
join dbo.Dim_Plant on Dim_Fact_CO2.Su_Plant_ID = Dim_Plant.Su_Plant_ID
join dbo.Dim_PlantProfile on Dim_Fact_CO2.Su_Profile_ID = Dim_PlantProfile.Su_Profile_ID
join dbo.Dim_Calendar on Dim_Fact_CO2.Su_Date_ID = Dim_Calendar.Su_Date_ID
WHERE Dim_Calendar.CalendarDate > DATEADD(dd,-1, getdate()) AND Dim_Calendar.CalendarDate < getdate()
group by Plant_ID, Device_ID, Profile_ID, Plant_Name;
;
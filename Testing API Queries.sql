SELECT p.Plant_ID, p.Profile_ID, p.PlantName, p.Device_ID FROM SEP4_PMI.dbo.PlantProfile PP
			right join SEP4_PMI.dbo.Plant p on p.Profile_ID = PP.Profile_ID
			left join SEP4_PMI.dbo.[Users] u on PP.[User_ID] = u.[User_ID]
			WHERE Email = 'naya7777@gmail.com';

insert into dbo.Plant (Profile_ID,[Device_ID], PlantName)
values  ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 3),'NAYAEUI6', 'naya rose 2'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 4),'NAYAEUI5','naya sunflower 3'),
        ( (select Profile_ID from dbo.PlantProfile where Profile_ID = 5),'NAYAEUI4','naya lily 4');

        select * from Plant where [User_ID] = 3;

select PP.Profile_Id, PP.Profile_Name,
			PP.CO2_Max, PP.CO2_Min,
			PP.Hum_Max, PP.Hum_Min,
			PP.Tem_Max, PP.Tem_Min,
			PP.Light_Max, PP.Light_Min
			from SEP4_PMI.dbo.PlantProfile PP
            right join SEP4_PMI.dbo.[Users] u on PP.[User_ID] = u.[User_ID]
            where Email = 'naya7777@gmail.com';

SELECT [User_ID] FROM SEP4_PMI.dbo.[Users] WHERE Email='naya7777@gmail.com';

insert into SEP4_PMI.dbo.PlantProfile (User_ID, Profile_Name, CO2_Max, CO2_Min, Hum_Max, Hum_Min, Tem_Max, Tem_Min, Light_Max, Light_Min)
values ((SELECT [User_ID] FROM SEP4_PMI.dbo.[Users] WHERE Email=?), ? , ?, ?, ?, ?, ?, ?, ? ,?);

select * from SEP4_PMI.dbo.PlantProfile

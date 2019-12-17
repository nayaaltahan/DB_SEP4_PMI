-------------------------------------Delete stage data after initial load--------------------------------------------------------------------------
Delete from Stage_SEP4_PMI.dbo.Stage_Fact_CO2;
Delete from Stage_SEP4_PMI.dbo.Stage_Fact_Hum;
Delete from Stage_SEP4_PMI.dbo.Stage_Fact_Light;
Delete from Stage_SEP4_PMI.dbo.Stage_Fact_Tem;
Delete from Stage_SEP4_PMI.dbo.stage_dim_PlantProfile;
Delete from Stage_SEP4_PMI.dbo.stage_dim_Plant;
Delete from Stage_SEP4_PMI.dbo.stage_dim_Users;
Delete from Stage_SEP4_PMI.dbo.stage_dim_Time;
Delete from Stage_SEP4_PMI.dbo.stage_dim_Calendar;
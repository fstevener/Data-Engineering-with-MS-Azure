IF OBJECT_ID('dbo.dimStations') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dimStations];
END

CREATE EXTERNAL TABLE dbo.dimStations
WITH (
    LOCATION = 'dimStations.txt',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT 
TRY_CONVERT(nvarchar(4000), StationId) AS StationId, 
TRY_CONVERT(nvarchar(4000), Name) AS Name, 
TRY_CONVERT(float, Latitude) AS Latitude, 
TRY_CONVERT(float, Longitude) AS Longitude
FROM [dbo].[stations];
GO

SELECT TOP 100 * FROM dbo.dimStations

/*
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dimStations'

SELECT COUNT(*) FROM dbo.dimStations
*/

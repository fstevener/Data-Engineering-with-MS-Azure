IF OBJECT_ID('dbo.factTrips') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[factTrips];
END

CREATE EXTERNAL TABLE dbo.factTrips
WITH (
    LOCATION = 'factTrips.txt',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT 
TRY_CONVERT(nvarchar(4000), T1.TripId) AS TripId,
TRY_CONVERT(bigint, T2.DateDimId) AS DateDimId,
TRY_CONVERT(bigint, T1.RiderId) AS RiderId,
TRY_CONVERT(nvarchar(4000), T1.RideableType) AS RideableType,
TRY_CONVERT(nvarchar(4000), T1.StartStationId) AS StartStationId,
TRY_CONVERT(nvarchar(4000), T1.EndStationId) AS EndStationId,
TRY_CONVERT(datetime2(0), T1.StartedAt) AS StartedAt,
TRY_CONVERT(datetime2(0), T1.EndedAt) AS EndedAt,
DATEDIFF(MINUTE, TRY_CONVERT(datetime2(0), T1.StartedAt), TRY_CONVERT(datetime2(0), T1.EndedAt)) AS TripDurationInMinutes,
DATEDIFF(YEAR, TRY_CONVERT(date, T3.Birthday), TRY_CONVERT(date, T1.StartedAt)) AS RiderAge 
FROM dbo.trips T1
INNER JOIN dbo.d_date T2
    ON (TRY_CONVERT(date, T1.StartedAt) = TRY_CONVERT(date, T2.DateActual))
INNER JOIN dbo.riders T3
    ON (TRY_CONVERT(bigint, T1.RiderId) = TRY_CONVERT(bigint, T3.RiderId));
GO


SELECT TOP 100 * FROM dbo.factTrips
GO

/*

SELECT COUNT(*) FROM dbo.factTrips

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'factTrips'
*/
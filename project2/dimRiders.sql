IF OBJECT_ID('dbo.dimRiders') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dimRiders];
END

CREATE EXTERNAL TABLE dbo.dimRiders
WITH (
    LOCATION = 'dimRiders.txt',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT 
TRY_CONVERT(bigint, RiderId) AS RiderId, 
TRY_CONVERT(nvarchar(4000), First) AS First, 
TRY_CONVERT(nvarchar(4000), Last) AS Last, 
TRY_CONVERT(nvarchar(4000), Address) AS Address, 
TRY_CONVERT(date, Birthday) AS Birthday, 
TRY_CONVERT(date, AccountStartDate) AS AccountStartDate, 
TRY_CONVERT(date, AccountEndDate) AS AccountEndDate, 
TRY_CONVERT(bit, Member) AS Member 
FROM [dbo].[riders];
GO

SELECT TOP 100 * FROM dbo.dimRiders

/*
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dimRiders'

SELECT COUNT(*) FROM dbo.dimRiders
*/
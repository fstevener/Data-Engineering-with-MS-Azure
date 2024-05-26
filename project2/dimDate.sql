IF OBJECT_ID('dbo.dimDate') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dimDate];
END

CREATE EXTERNAL TABLE dbo.dimDate
WITH (
    LOCATION = 'dimDate.txt',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT
TRY_CONVERT(bigint, DateDimId) AS DateDimId,
TRY_CONVERT (date, DateActual) AS DateActual,
TRY_CONVERT (bigint, Epoch) AS Epoch,
TRY_CONVERT (nvarchar(4000), DaySuffix) AS DaySuffix,
TRY_CONVERT (nvarchar(4000), DayName) AS DayName,
TRY_CONVERT (bigint, DayOfWeek) AS DayOfWeek,
TRY_CONVERT (bigint, DayOfMonth) AS DayOfMonth,
TRY_CONVERT (bigint, DayOfQuarter) AS DayOfQuarter,
TRY_CONVERT (bigint, DayOfYear) AS DayOfYear,
TRY_CONVERT (bigint, WeekOfMonth) AS WeekOfMonth,
TRY_CONVERT (bigint, WeekOfYear) AS WeekOfYear,
TRY_CONVERT (nvarchar(4000), WeekOfYearIso) AS WeekOfYearIso,
TRY_CONVERT (bigint, MonthActual) AS MonthActual,
TRY_CONVERT (nvarchar(4000), MonthName) AS MonthName,
TRY_CONVERT (nvarchar(4000), MonthNameAbbreviated) AS MonthNameAbbreviated,
TRY_CONVERT (bigint, QuarterActual) AS QuarterActual,
TRY_CONVERT (nvarchar(4000), QuarterName) AS QuarterName,
TRY_CONVERT (bigint, YearActual) AS YearActual,
TRY_CONVERT (date, FirstDayOfWeek) AS FirstDayOfWeek,
TRY_CONVERT (date, LastDayOfWeek) AS LastDayOfWeek,
TRY_CONVERT (date, FirstDayOfMonth) AS FirstDayOfMonth,
TRY_CONVERT (date, LastDayOfMonth) AS LastDayOfMonth,
TRY_CONVERT (date, FirstDayOfQuarter) AS FirstDayOfQuarter,
TRY_CONVERT (date, LastDayOfQuarter) AS LastDayOfQuarter,
TRY_CONVERT (date, FirstDayOfYear) AS FirstDayOfYear,
TRY_CONVERT (date, LastDayOfYear) AS LastDayOfYear,
TRY_CONVERT (bigint, mmyyy) AS mmyyy,
TRY_CONVERT (bigint, mmddyyy) AS mmddyyy,
TRY_CONVERT (bit, WeekendIndr) AS WeekendIndr
FROM [dbo].[d_date];
GO


SELECT TOP 100 * FROM dbo.dimDate
GO


/*SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dimDate'*/


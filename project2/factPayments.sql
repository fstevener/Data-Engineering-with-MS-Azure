IF OBJECT_ID('dbo.factPayments') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[factPayments];
END

CREATE EXTERNAL TABLE dbo.factPayments
WITH (
    LOCATION = 'factPayments.txt',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT 
TRY_CONVERT(bigint, T1.PaymentId) AS PaymentId,
TRY_CONVERT(bigint, T2.DateDimId) AS DateDimId,
TRY_CONVERT(bigint, T1.RiderId) AS RiderId,
TRY_CONVERT(date, T1.PaymentDate) AS PaymentDate,
TRY_CONVERT(float, T1.Amount) AS Amount
FROM dbo.payments T1
INNER JOIN dbo.d_date T2
    ON (TRY_CONVERT(date, T1.PaymentDate) = TRY_CONVERT(date, T2.DateActual))

GO


SELECT TOP 100 * FROM dbo.factPayments

/*

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'factPayments'

SELECT COUNT(*) FROM dbo.factPayments  
GO

*/
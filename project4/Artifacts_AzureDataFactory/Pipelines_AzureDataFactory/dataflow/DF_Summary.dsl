parameters{
	dataflow_param_fiscalyear as integer (2020)
}
source(output(
		FiscalYear as integer,
		PayrollNumber as integer,
		AgencyID as string,
		AgencyName as string,
		EmployeeID as string,
		LastName as string,
		FirstName as string,
		AgencyStartDate as date,
		WorkLocationBorough as string,
		TitleCode as string,
		TitleDescription as string,
		LeaveStatusasofJune30 as string,
		BaseSalary as double,
		PayBasis as string,
		RegularHours as double,
		RegularGrossPaid as double,
		OTHours as double,
		TotalOTPaid as double,
		TotalOtherPay as double
	),
	allowSchemaDrift: true,
	validateSchema: false,
	isolationLevel: 'READ_UNCOMMITTED',
	format: 'table') ~> sourcenycpayroll2020
source(output(
		FiscalYear as integer,
		PayrollNumber as integer,
		AgencyID as string,
		AgencyName as string,
		EmployeeID as string,
		LastName as string,
		FirstName as string,
		AgencyStartDate as date,
		WorkLocationBorough as string,
		TitleCode as string,
		TitleDescription as string,
		LeaveStatusasofJune30 as string,
		BaseSalary as double,
		PayBasis as string,
		RegularHours as double,
		RegularGrossPaid as double,
		OTHours as double,
		TotalOTPaid as double,
		TotalOtherPay as double
	),
	allowSchemaDrift: true,
	validateSchema: false,
	isolationLevel: 'READ_UNCOMMITTED',
	format: 'table') ~> sourcenycpayroll2021
sourcenycpayroll2020, sourcenycpayroll2021 union(byName: true)~> unionnycpayroll
unionnycpayroll filter(toInteger(FiscalYear) >= $dataflow_param_fiscalyear) ~> filternycpayroll
filternycpayroll derive(TotalPaid = RegularGrossPaid + TotalOTPaid+TotalOtherPay) ~> totalpaid
totalpaid aggregate(groupBy(AgencyName,
		FiscalYear),
	TotalPaid = sum(TotalPaid)) ~> aggregate1
aggregate1 sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		FiscalYear as integer,
		AgencyName as string,
		TotalPaid as double
	),
	deletable:false,
	insertable:true,
	updateable:false,
	upsertable:false,
	truncate:true,
	format: 'table',
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	errorHandlingOption: 'stopOnFirstError',
	mapColumn(
		FiscalYear,
		AgencyName,
		TotalPaid
	)) ~> sinksummary
aggregate1 sink(allowSchemaDrift: true,
	validateSchema: false,
	truncate: true,
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	saveOrder: 1) ~> sinkdirstaging
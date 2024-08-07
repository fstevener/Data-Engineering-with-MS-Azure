source(output(
		EmployeeID as string,
		LastName as string,
		FirstName as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> sourceempmaster
sourceempmaster sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		EmployeeID as string,
		LastName as string,
		FirstName as string
	),
	deletable:false,
	insertable:true,
	updateable:false,
	upsertable:false,
	format: 'table',
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	errorHandlingOption: 'stopOnFirstError',
	mapColumn(
		EmployeeID,
		LastName,
		FirstName
	)) ~> sinkempmaster
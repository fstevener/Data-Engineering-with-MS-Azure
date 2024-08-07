source(output(
		AgencyID as string,
		AgencyName as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> sourceagencymaster
sourceagencymaster sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		AgencyID as string,
		AgencyName as string
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
		AgencyID,
		AgencyName
	)) ~> sinkagencymaster
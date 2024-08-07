source(output(
		TitleCode as string,
		TitleDescription as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> sourcetitlemaster
sourcetitlemaster sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		TitleCode as string,
		TitleDescription as string
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
		TitleCode,
		TitleDescription
	)) ~> sinktitlemaster
<cfif thisTag.executionMode IS "start"><!DOCTYPE html>
<html>
    <head>
		<title>
		<cfoutput>SubAwesomeContacts</cfoutput></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- Bootstrap -->
		<link href="./theme/css/bootstrap.min.css" rel="stylesheet">
		<!--local styling for this application-->
		<link href="./theme/css/SubAwesomeContacts.css" rel="stylesheet">
	</head>
	<body>
</cfif>
<cfif thisTag.executionMode IS "end">
		<script src="./theme/js/jquery-2.0.3.min.js" type="text/javascript"></script>
		<script src="./js/stapes.min.js" type="text/javascript"></script>
		<script src="./js/application.js" type="text/javascript"></script>
	</body>
</html>
</cfif>
<cfsilent>
	<!---Purely for demonstration purposes--->
	<cfset ContactService = createObject("component", "API.ContactService").init().clearCache() />
	<cflocation url="index.cfm" addtoken="no" />
</cfsilent>
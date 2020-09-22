<cfcomponent  output="false">
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,1,0,0) />
	<cfset this.setClientCookies = true />
	<cfset this.name = "SubAwesomeContacts"/>
	<cfset this.mappings["/API"] = getDirectoryFromPath( expandPath( "./API")) />
</cfcomponent>
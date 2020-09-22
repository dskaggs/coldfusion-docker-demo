<cfcomponent extends="CacheManager">
	<!---initialize outside of init() because this may be a remote service --->
	<cfset variables.DataStore = createObject("component", "API.DataStore").init() />
	<cfset super.init() />
	<cffunction name="init" output="false" access="public" returntype="ContactService" hint="I am a remote API for contact data">
		<cfreturn this />
	</cffunction>

	<cffunction name="clearCache" returntype="void" access="public" output="false" hint="This method clears the cache, but we would never ever want this to be part of a public API. It is nice for demo purposes though :)">
		<cfset super.clear() /><!--- slick the cache to show the long load times--->
	</cffunction>

	<cffunction name="fetch" returntype="array" access="remote" output="false" hint="I fetch a contact list">
		<cfargument name="filterCriteria" type="string" default="" />
		<cfreturn super.process( "ContactList", arguments, variables.DataStore, "loadContactList" ) />
	</cffunction>
	
	<cffunction name="loadByContactID" returntype="struct" access="remote" output="false" hint="I fetch a contact record by ContactID">
		<cfargument name="ContactID" type="string" default="" />
		<cfset var argumentScope = { contactID = val( arguments.ContactID ) } />
		<cfreturn super.process( "ContactList", argumentScope, variables.DataStore, "loadContact" ) />
	</cffunction>

	<cffunction name="removeContactByID" returntype="boolean" access="remote" output="false" hint="I fetch a contact record by ContactID">
		<cfargument name="ContactID" type="string" default="" />
		<cfset super.clear() /><!--- slick the cache when we change something--->
		<cfset variables.DataStore.removeContact( val( arguments.ContactID ) ) />
		<cfreturn true /><!---We should do something more sophisticated with this, if we were going to put this in to production--->
	</cffunction>

	<cffunction name="save" returntype="boolean" access="remote" output="false" hint="I fetch a contact list">
		<cfargument name="contactID" type="string" default="" />
		<cfargument name="name" type="string" default="" />
		<cfargument name="email" type="string" default="" />
		<cfargument name="phone" type="string" default="" />
		<cfset var contactStruct = {} />
		<cfset super.clear() /><!--- slick the cache when we change something--->
		<!---Never trust a public API to pass the correct values. We'd do more validation here, if we were going to put this in to production--->
		<cfset contactStruct.contactID = arguments.contactID />
		<cfset contactStruct.name = arguments.name />
		<cfset contactStruct.email = arguments.email />
		<cfset contactStruct.phone = arguments.phone />

		<cfset variables.DataStore.save( contactStruct ) />
		<cfreturn true /><!---We should do something more sophisticated with this, if we were going to put this in to production--->
	</cffunction>

	<cffunction name="overrideDatastore" returntype="void" access="public" output="false" hint="I want to use a test mode of the datastore in my tests. This would not be necessary with MXUnit, nor would this go into production">
		<cfargument name="DataStore" type="DataStore" required="true" />
		<cfset variables.DataStore = arguments.DataStore />
	</cffunction>

</cfcomponent>
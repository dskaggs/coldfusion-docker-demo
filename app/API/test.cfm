<style>
	.successMessageClass { color: #0f980a }
	.failureMessageClass { color: #b83917 }
</style>
<!---Objects we need--->
<cfset DataStore = createObject("component", "DataStore").init(true) /><!---taking this out of snooze mode--->
<cfset ContactService = createObject("component", "ContactService").init() />
<cfset ContactService.overrideDatastore(DataStore) /><!---forcing a non-snoozy datastore for my tests because "waiting, is the hardest part" --->

<cfset application.Changing_Application_ContactList = false /><!---Failed tests result in inconsistent state. Reset this.--->
<!---Tests--->
<cfoutput>
	<cfset DataStore.reset() /><!---Start the tests with a clean slate --->
	<h2>Datastore</h2>
	#test(IsArray( DataStore.fetchInitialDataset()), "DataStore.fetchInitialDataset() is an array", "DataStore.fetchInitialDataset() should have been an array, but is not")#
	#test(arrayLen( DataStore.fetchInitialDataset()) IS 30, "DataStore.fetchInitialDataset() is 30 contacts", "DataStore.fetchInitialDataset() should have been 30 contacts, not the #arrayLen( DataStore.fetchInitialDataset())# we got")#

	<h2>ContactService</h2>
	<!---Fetching the list--->
	#test( isArray( ContactService.fetch() ), "ContactService.fetch() is an array", "ContactService.fetch() is not an array" )#
	<!---Use this data for testing --->
	<cfset ContactServiceData = DataStore.fetchInitialDataset() />
	<cfset ContactArray = ContactService.fetch(ContactServiceData[1]["email"]) />
	<!---fetch with criteria--->
	#test( arrayLen(ContactService.fetch(ContactServiceData[1]["email"])) IS 1, "ContactService.fetch() with criteria worked", "Contact fetch with criteria should have returned 1 record, not #arrayLen(ContactService.fetch(ContactServiceData[1]["email"]))#")#
	<!---loadByContactID--->
	#test(
			isStruct( ContactService.loadByContactID(ContactServiceData[1].contactID)) IS true
			AND ContactService.loadByContactID(ContactServiceData[1].contactID).contactID IS ContactServiceData[1].contactID
		, "Testing ContactService.loadContact() Worked"
		, "ContactService.loadContact() should have loaded a contact with ContactID #ContactServiceData[1].contactID# but we got #ContactService.loadByContactID(ContactServiceData[1].contactID).contactID# "
	)#
	<!---try saving records--->
	<cfset recordToInsert = {"name"="Barney", "email"="barney@fife.com", "phone"="919-234-5678"} />
	<!---Save a record--->
	#test(
			ArrayLen(ContactService.fetch(recordToInsert["email"]) ) IS 0
			AND ContactService.save( argumentcollection:recordToInsert)
			AND ArrayLen(ContactService.fetch(recordToInsert["email"]) ) IS 1
		,"Testing ContactService.save() Insert Worked"
		,"ContactService.save() should have inserted a record, but instead we found #ArrayLen(ContactService.fetch(recordToInsert["email"]) ) IS 1#"
	)#
	<!---Update a record--->
	<cfset recordToUpdate = {"contactID"=ContactServiceData[1].contactID, "name"=ContactServiceData[1].name, "email"="IUpdatedA@contact.com", "phone"=ContactServiceData[1].phone} />
	<cfset contactFromInitialDataset = ContactService.loadByContactID(recordToUpdate.contactID)/>
	#test(
			ContactService.loadByContactID(recordToUpdate.contactID).email IS ContactServiceData[1].email IS true
			AND ContactService.save( argumentcollection:recordToUpdate)
			AND ContactService.loadByContactID(recordToUpdate.contactID).email IS recordToUpdate.email
		,"Testing ContactService.save() Update Worked"
		,"We should have found the updated record with #recordToUpdate.email# as an email address,  but instead we found #ContactService.loadByContactID(recordToUpdate.contactID).email#"
	)#

	<cfset recordToDelete = {"name"="DeleteMe", "email"="deleteme@deleted.com", "phone"="919-555-1111"} />
	#test(
			ArrayLen(ContactService.fetch(recordToDelete["email"]) ) IS 0
			AND ContactService.save( argumentcollection:recordToDelete) IS true
			AND ArrayLen(ContactService.fetch(recordToDelete["email"]) ) IS 1
			AND ContactService.removeContactByID( ContactService.fetch(recordToDelete["email"])[1].contactID ) IS true
			AND ArrayLen( ContactService.fetch(recordToDelete["email"])) IS 0
		,"Testing ContactService.removeContactByID() Delete Worked"
		,"We should have inserted DeleteMe, then deleted him but that didn't happen... #ArrayLen(ContactService.fetch(recordToDelete["email"])) IS 0# should be No"
	)#

	<cfset DataStore.reset() /><!---Clean up so we can run the tests each time--->
</cfoutput>




<cffunction name="test" returntype="string" access="public" output="false" hint="I am a cheap unit testing framework that does nearly nothing">
	<cfargument name="Condition" type="boolean" default="false" />
	<cfargument name="SuccessMessage" type="string" default="Successfully Passed" />
	<cfargument name="FailureMessage" type="string" default="Failed Miserably" />
	<cfset var resultClassLookup = {"success" = "successMessageClass", "failure" = "failureMessageClass"} />
	<cfset resultObject = {"message" = arguments.FailureMessage, "class" = resultClassLookup.failure } />

	<cfif arguments.Condition IS true>
		<cfset resultObject = {"message" = arguments.SuccessMessage, "class" = resultClassLookup.success } />
	</cfif>

	<cfreturn '<h3 class="#resultObject.class#">#resultObject.message#</h3>' />
</cffunction>
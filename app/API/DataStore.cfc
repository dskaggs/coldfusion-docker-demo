<cfcomponent>
	<cffunction name="init" output="false" access="public" returntype="DataStore" hint="I am a data store. You might think of me as a callable interface for a database, or you might not.">
		<cfargument name="isTestMode" type="boolean" default="false" />
		<cfset initializeLocalStorage()/>
		<cfset variables.sleepLength = 5000 /><!---to snooze or not to snooze, that is the question--->
		<cfif isTestMode IS true>
			<cfset variables.sleepLength = 0 />
		</cfif>
		<cfreturn this/>
	</cffunction>

	<cffunction name="fetchInitialDataset" returntype="array" access="public" output="false" hint="I fetch an initial dataset prepopulated in this component">
		<cfreturn [{"phone" = "(469) 937-4055", "contactID" = "10004", "name" = "Basia S. Briggs", "email" = "sed.est@euaccumsan.co.uk"}, {"phone" = "(905) 923-8525", "contactID" = "10005", "name" = "Zia Z. Juarez", "email" = "tristique.ac@dolor.edu"}, {"phone" = "(238) 212-7963", "contactID" = "10008", "name" = "Chantale M. Holt", "email" = "ultrices@est.co.uk"}, {"phone" = "(104) 737-4684", "contactID" = "10010", "name" = "Portia M. Frye", "email" = "Aliquam@Integer.ca"}, {"phone" = "(821) 893-1634", "contactID" = "10015", "name" = "Nevada X. Deleon", "email" = "Curabitur@at.edu"}, {"phone" = "(284) 544-7230", "contactID" = "10019", "name" = "Denton N. Hammond", "email" = "egestas@sed.com"}, {"phone" = "(501) 812-8191", "contactID" = "10021", "name" = "Aubrey Z. Diaz", "email" = "non@ornareegestas.org"}, {"phone" = "(713) 660-7139", "contactID" = "10024", "name" = "Ishmael Q. Floyd", "email" = "enim.nec.tempus@vel.org"}, {"phone" = "(237) 525-9514", "contactID" = "10026", "name" = "Bernard R. Landry", "email" = "dui.Cum@at.edu"}, {"phone" = "(217) 461-9771", "contactID" = "10028", "name" = "Nehru E. Church", "email" = "amet@elit.co.uk"}, {"phone" = "(814) 933-7728", "contactID" = "10034", "name" = "Ronan G. Sweet", "email" = "sed.pede@nuncest.co.uk"}, {"phone" = "(742) 378-2448", "contactID" = "10035", "name" = "Amena O. Acosta", "email" = "condimentum@enim.org"}, {"phone" = "(677) 546-8114", "contactID" = "10042", "name" = "MacKenzie J. Sims", "email" = "aliquet@Aliquamauctor.ca"}, {"phone" = "(958) 557-5540", "contactID" = "10049", "name" = "Jacob J. Cote", "email" = "Sed@augue.co.uk"}, {"phone" = "(307) 710-3381", "contactID" = "10051", "name" = "Kirsten F. Joseph", "email" = "magna.et@pedeCum.co.uk"}, {"phone" = "(936) 398-9747", "contactID" = "10054", "name" = "Oscar X. Key", "email" = "odio@blanditNam.org"}, {"phone" = "(726) 815-2621", "contactID" = "10055", "name" = "Veronica G. Fernandez", "email" = "vulputate.dui@auctor.edu"}, {"phone" = "(874) 893-0306", "contactID" = "10058", "name" = "Maris N. Alexander", "email" = "dictum.augue@semper.com"}, {"phone" = "(312) 725-5995", "contactID" = "10064", "name" = "Marny L. Walter", "email" = "non@et.edu"}, {"phone" = "(778) 822-8323", "contactID" = "10068", "name" = "Candace F. Fowler", "email" = "ut.ipsum.ac@egestas.org"}, {"phone" = "(335) 565-3607", "contactID" = "10070", "name" = "Zahir F. Jones", "email" = "elit@Vivamussitamet.org"}, {"phone" = "(710) 609-8158", "contactID" = "10071", "name" = "Marsden G. Suarez", "email" = "orci@Nullam.org"}, {"phone" = "(670) 968-8576", "contactID" = "10079", "name" = "Joelle C. Brooks", "email" = "orci@diam.ca"}, {"phone" = "(216) 765-7022", "contactID" = "10083", "name" = "Naida P. Gilliam", "email" = "auctor.velit@egestas.com"}, {"phone" = "(592) 447-7441", "contactID" = "10086", "name" = "Fleur K. Chen", "email" = "varius@orci.edu"}, {"phone" = "(407) 729-6437", "contactID" = "10088", "name" = "Madonna H. Guy", "email" = "posuere.at.velit@nibh.ca"}, {"phone" = "(376) 761-6001", "contactID" = "10092", "name" = "Hasad I. Knowles", "email" = "at@Proin.org"}, {"phone" = "(968) 976-9669", "contactID" = "10096", "name" = "Kiona C. Stokes", "email" = "in@Fusce.net"}, {"phone" = "(681) 521-3607", "contactID" = "10097", "name" = "Wylie W. Shaffer", "email" = "ut@utcursusluctus.ca"}, {"phone" = "(309) 102-4261", "contactID" = "10098", "name" = "Noel J. Bright", "email" = "blandit@Quisque.org"}]/>
	</cffunction>

	<cffunction name="loadContactList" returntype="array" access="public" output="false" hint="I load a contact list">
		<cfargument name="filterCriteria" type="string" default=""/>
		<cfset var returnValue = filter(arguments.filterCriteria, loadCopyFromStorage())/>
		<cfset snooze() />
		<cfreturn returnValue/>
	</cffunction>

	<cffunction name="loadContact" returntype="struct" access="public" output="false" hint="I load a contact list">
		<cfargument name="contactID" type="string" default=""/>
		<cfset var returnContact = {"contactID" = "", "name" = "", "email" = "", "phone" = ""}/>
		<cfset var thisContact = ""/>

		<cfloop array="#loadCopyFromStorage()#" index="thisContact">
			<cfif thisContact.contactID IS arguments.contactID>
				<cfset returnContact = thisContact/>
				<cfbreak/>
			</cfif>
		</cfloop>

		<cfreturn returnContact/>
	</cffunction>

	<cffunction name="removeContact" returntype="void" access="public" output="false" hint="I look for a contact by contactID and remove it from the data store">
		<cfargument name="contactID" type="string" default=""/>
		<cfset var contactArray = ""/>
		<cfset var i = ""/>
		<!---make sure we aren't locked by a concurrent process (which we won't be, since it's just Clark and Ben testing this, though you never know, this app could go hollywood!--->
		<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
			<cflock name="Changing_Application_ContactList" timeout="10"><!---Programmers who understand concurrency and multithreading, always bookend lock calls with a check--->
				<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
					<cfset application.Changing_Application_ContactList = true/><!---Make sure concurrent code doesn't pull the rug out from someone trying to use this--->
					<cfset contactArray = loadDirectFromStorage()/>
					<!---find and delete the contact from the storage--->
					<cfloop from="1" to="#ArrayLen(contactArray)#" index="i">
						<cfif contactArray[i].contactID IS arguments.contactID>
							<cfset ArrayDeleteAt(contactArray, i)/>
							<cfbreak/>
						</cfif>
					</cfloop>
					<cfset application.ContactList = contactArray/><!---put up with ACF's childish way of passing arrays by value, and not by reference--->
					<cfset application.Changing_Application_ContactList = false/><!---Clean up after yourself, it's good manners--->
				</cfif>
			</cflock>
		</cfif>
	</cffunction>

	<cffunction name="save" returntype="void" access="public" output="false" hint="I save a contact">
		<cfargument name="contactStruct" type="struct" required="true"/>
		<cfif structKeyExists(contactStruct, "contactID") AND val(contactStruct.contactID) GT 0><!---Do we already know the record?--->
			<cfset findAndUpdateRecord(contactStruct)/>
		<cfelse><!---We need to make the new record--->
			<cfset insertNewRecord(ContactStruct)/>
		</cfif>
	</cffunction>

<!---Private Methods--->
	<cffunction name="filter" returntype="array" access="private" output="false" hint="I filter the contact list by criteria">
		<cfargument name="filterCriteria" type="string" default=""/>
		<cfargument name="ContactDataArray" type="array" default="#ArrayNew(1)#"/>
		<cfset var filteredArray = []/>

		<cfif len(trim(filterCriteria)) IS 0><!---No filtering necessary so bail out--->
			<cfreturn arguments.ContactDataArray/><!---This meets the rule, never have two return statements, unless they are at the VERY VERY top of the method and keep people from having to scan down a crapload of code to see what is actually happening--->
		</cfif>
		<!---find appropriate matches....--->
		<cfloop array="#arguments.ContactDataArray#" index="thisContact">
			<cfif matchesCriteria(arguments.filterCriteria, thisContact) IS true>
				<cfset arrayAppend(filteredArray, thisContact)/>
			</cfif>
		</cfloop>

		<cfreturn filteredArray/>
	</cffunction>

	<cffunction name="findAndUpdateRecord" returntype="void" access="private" output="false" hint="I look for a record in the data store and update the contents">
		<cfargument name="contactStruct" type="struct" required="true"/>
		<cfset var thisContact = ""/>
		<!---make sure we aren't locked by a concurrent process (which we won't be, since it's just Clark and Ben testing this, though you never know, this app could go hollywood!--->
		<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
			<cflock name="Changing_Application_ContactList" timeout="10"><!---Programmers who understand concurrency and multithreading, always bookend lock calls with a check--->
				<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
					<cfset application.Changing_Application_ContactList = true/><!---Make sure concurrent code doesn't pull the rug out from someone trying to use this--->
					<cfloop array="#loadDirectFromStorage()#" index="thisContact"><!---Find the contact with the appropriate contactID, then update--->
						<cfif thisContact.contactID IS arguments.contactStruct.contactID>
							<cfset thisContact.name = arguments.contactStruct.name/>
							<cfset thisContact.email = arguments.contactStruct.email/>
							<cfset thisContact.phone = arguments.contactStruct.phone/>
						</cfif>
					</cfloop>
					<cfset application.Changing_Application_ContactList = false/><!---Clean up after yourself, it's good manners--->
				</cfif>
			</cflock>
		</cfif>
	</cffunction>

	<cffunction name="getNextID" returntype="numeric" access="private" output="false" hint="I get the next ID in the system. Note, only use this in a locked process so we don't get race conditions">
		<cfset var nextID = 1/>
		<cfset var thisContact = ""/>
		<!--- this would have been easier with any other data structure, but structs are unordered, and queries aren't easily updated --->
		<cfloop array="#loadDirectFromStorage()#" index="thisContact">
			<cfif thisContact.contactID GT nextID>
				<cfset nextID = thisContact.contactID/>
			</cfif>
		</cfloop>
		<!---Race condition joke:

		a: "Knock Knock"
		b: "Race Condition"
		b: "Who's there?"

		--->
		<cfreturn nextID + 1/>
	</cffunction>

	<cffunction name="insertNewRecord" returntype="void" access="private" output="false" hint="I add a new record to the end of the data store">
		<cfargument name="contactStruct" type="struct" required="true"/>
		<!---make sure we aren't locked by a concurrent process (which we won't be, since it's just Clark and Ben testing this--->
		<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
			<cflock name="Changing_Application_ContactList" timeout="10"><!---Programmers who understand concurrency and multithreading, always bookend lock calls with a check--->
				<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
					<cfset application.Changing_Application_ContactList = true/><!---Make sure concurrent code doesn't pull the rug out from someone trying to use this--->
					<cfset arguments.contactStruct.contactID = getNextID()/>
					<cfset arrayAppend(loadDirectFromStorage(), arguments.contactStruct)/>
					<cfset application.Changing_Application_ContactList = false/><!---Clean up after yourself, it's good manners--->
				</cfif>
			</cflock>
		</cfif>
	</cffunction>

	<cffunction name="initializeLocalStorage" returntype="void" access="private" output="false" hint="I slick the local storage and populate with initial data">
		<cfif structKeyExists(application, "ContactList") IS false OR ( structKeyExists(application, "ContactList") IS true AND isArray(application.ContactList) IS false )>
			<cflock name="Application_ContactList" timeout="10"><!---Programmers who understand concurrency and multithreading, always bookend lock calls with a check--->
				<cfif structKeyExists(application, "ContactList") IS false OR ( structKeyExists(application, "ContactList") IS true AND isArray(application.ContactList) IS false )>
					<cfset application.ContactList = fetchInitialDataset()/>
				</cfif>
			</cflock>
		</cfif>
	</cffunction>

	<cffunction name="loadCopyFromStorage" returntype="array" access="private" output="false" hint="I load the current contact list">
		<cfreturn duplicate(application.ContactList)/>
	</cffunction>

	<cffunction name="loadDirectFromStorage" returntype="array" access="private" output="false" hint="I load the current contact list">
		<cfreturn application.ContactList/>
	</cffunction>

	<cffunction name="matchesCriteria" returntype="boolean" access="private" output="false" hint="I check to see if a passed contact matches a bit of filter criteria">
		<cfargument name="filterCriteria" type="string" required="true"/>
		<cfargument name="contactStruct" type="struct" required="true"/>
		<cfset var returnValue = false/><!---Pessimism in this case, is a good idea--->
		<cfset var stringToCheck = "#contactStruct.name##contactStruct.email##contactStruct.phone#"/><!---match on everything, why not?--->

		<cfreturn findNoCase(arguments.filterCriteria, stringToCheck) GT 0/>
	</cffunction>

<!---todo: change this to private but we need it for our test framework. MXUnit would have let me keep this private but the requirements were no CF Frameworks :( Repeat after me "Frameworks aren't inherently evil!--->
	<cffunction name="reset" returntype="void" access="public" output="false" hint="I slick the local storage and populate with an empty array">
		<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
			<cflock name="Changing_Application_ContactList" timeout="10"><!---Programmers who understand concurrency and multithreading, always bookend lock calls with a check--->
				<cfif structKeyExists(application, "Changing_Application_ContactList") IS false OR ( structKeyExists(application, "Changing_Application_ContactList") IS true AND application.Changing_Application_ContactList IS false )>
					<cfset application.Changing_Application_ContactList = true/><!---Make sure concurrent code doesn't pull the rug out from someone trying to use this--->
					<cfset application.ContactList = fetchInitialDataset()/>
					<cfset application.Changing_Application_ContactList = false/><!---Clean up after yourself, it's good manners--->
				</cfif>
			</cflock>
		</cfif>
	</cffunction>

	<cffunction name="snooze" returntype="void" access="private" output="false" hint="I take a nap to represent a long running service">
		<cfset sleep(variables.sleepLength) /><!---I represent a long running data retrieval process, like maybe a crap external SOAP request --->
	</cffunction>

</cfcomponent>
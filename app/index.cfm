<cfimport prefix="theme" taglib="theme" />
<cfsilent>
	<cfparam name="url.filterText" default="" />
	<cfset ContactService = createObject("component", "API.ContactService").init() />
	<cfset ContactList = ContactService.fetch(url.filterText) />
	<cfset contactFormLocation = "contactForm.cfm" />
</cfsilent>

<theme:body>
    <theme:centercontent>
<cfoutput>
        <div id="filterHeader" class="row">
			<div class="col-lg-12">
				 <div class="row">
					<div class="col-lg-8">
						search: <input type="text" id="filterText" name="filterText" placeholder="filter by name, email, phone" value="">
					</div>
					<div class="col-lg-4 text-right">
						<a href="#contactFormLocation#"><span class="accentColor">create</span>contact &raquo;</a>
					</div>
				</div>
			</div>
        </div>
        <div id="mainContent" class="row">
            <div class="col-lg-12 wrapperContainer">
				<cfloop array="#ContactList#" index="thisContact">
                <div class="row contactItemWrapper">
                    <div class="col-lg-12">
                        <div class="row contactItem">
                            <div class="col-lg-6">
                                #thisContact.name#
                            </div>
                            <div class="col-lg-6 controlButtons">
                                <a class="contactDetail" href="##">more</a> | <a href="#contactFormLocation#?contactID=#thisContact.contactID#">edit</a> | <a class="deleteContact" data-contactid="#thisContact.contactID#" href="##">delete</a>
                            </div>
							<div class="col-lg-12 contactData">
								<div class="col-sm-2 text-right">
									name:
								</div>
								<div class="col-sm-10 filterableContent">
									#thisContact.name#
								</div>
								<div class="col-sm-2 text-right">
									email:
								</div>
								<div class="col-sm-10 filterableContent">
									#thisContact.email#
								</div>
								<div class="col-sm-2 text-right">
									phone:
								</div>
								<div class="col-sm-10 filterableContent">
									#thisContact.phone#
								</div>
							</div>
                        </div>
                    </div>
				</div>
				</cfloop>
            </div>
        </div>
</cfoutput>
    </theme:centercontent>
</theme:body>
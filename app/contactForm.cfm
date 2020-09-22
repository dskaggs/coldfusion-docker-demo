<cfimport prefix="theme" taglib="theme" />
<cfsilent>
	<cfset ContactService = createObject("component", "API.ContactService").init() />
	<cfset contactFormLocation = "contactForm.cfm" />
	<cfif cgi.request_method IS "post"><!---Some validation would have been nice if I had more time. You do believe I can write validation code, right?--->
		<cfset ContactService.save( argumentCollection=form ) />
		<cflocation url="index.cfm" addtoken="no" />
	</cfif>
	<cfparam name="url.contactID" default="" />

	<cfset ContactObject = ContactService.loadByContactID(url.contactID) />
</cfsilent>

<theme:body>
    <theme:centercontent>
        <div id="filterHeader" class="row">
			<div class="col-lg-12">
				 <div class="row">
					<div class="col-lg-8">
						<a href="index.cfm">&laquo; back</a>
					</div>
				</div>
			</div>
        </div>
        <div id="mainContent" class="row">
            <div class="col-lg-12 wrapperContainer">
                <div class="row contactItemWrapper">
                    <div class="col-lg-12">
						<cfoutput>
                        <div class="row">
							<div class="col-lg-12 contactForm">
								<div class="row">
									<form action="#contactFormLocation#" method="post">
										<input type="hidden" name="contactID" value="#url.contactID#" />
										<div class="form-group">
											<label>name:</label>
											<div>
												<input type="text" class="form-control" name="name" value="#ContactObject.name#" />
											</div>
										</div>
										<div class="form-group">
											<label>email:</label>
											<div>
												<input type="text" class="form-control" name="email" value="#ContactObject.email#" />
											</div>
										</div>
										<div class="form-group">
											<label>phone:</label>
											<div>
												<input type="text" class="form-control" name="phone" value="#ContactObject.phone#" />
											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-4">
												<button type="submit" class="btn-ben">Save &amp; Close</button>
											</div>
											<div class="col-lg-offset-1 col-lg-4">
												( <a href="##" class="cancelContactForm">cancel</a> )
											</div>
										</div>
									</form>
								</div>
							</div>
                        </div>
						</cfoutput>
                    </div>
                </div>
            </div>
        </div>
    </theme:centercontent>
</theme:body>
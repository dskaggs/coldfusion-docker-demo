<cfif thisTag.executionMode IS "start">
		<div class="container"><!-- container -->
			<div class="row"><!-- row -->
				<div  id="applicationWrapper" class="col-lg-8 col-lg-offset-2">
					<div class="row"><!-- row -->
						<div class="col-lg-10 col-lg-offset-1">
							<h1><a href="./">SubAwesomeContacts</a> <span class="pull-right"><a class="btn btn-mini btn-danger" href="clearCache.cfm">Clear Cache</a></span></h1>
</cfif>
<cfif thisTag.executionMode IS "end">
						</div><!-- END col-lg-10 col-lg-offset-1 -->
					</div><!-- END row -->
					<div class="row">
						<div id="footer" class="col-lg-10 col-lg-offset-1">
							<cfoutput><a href="http://nodans.com">&copy; nodans.com #Year(now())#</a></cfoutput>
						</div>
					</div>
				</div><!-- END #applicationWrapper col-lg-10 col-lg-offset-1 -->
			</div><!-- END row -->
		</div><!-- END container -->
</cfif>
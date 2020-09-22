<cfimport prefix="theme" taglib="theme" />
<theme:body>
	<div id="readme">
		<div class="row">
            <div class="jumbotron">
                <h1>Introducing SubAwesomeContacts</h1>
                <p>Thanks for having a look at this. Hopefully you started with this file before moving on.</p>
            </div>
            <div class="col-lg-8 col-lg-offset-2 instructions">
				<h3>Installation</h3>
				<p>Put the contents of this Zip file in a directory in your webroot called SubAwesomeContacts</p>
				<p><span class="glyphicon glyphicon-thumbs-up"></span> If successful, you should be able to load this file at <a href="http://localhost/SubAwesomeContacts/ReadMe.cfm">localhost/SubAwesomeContacts/ReadMe.cfm</a></p>

				<h3>Dependencies</h3>
				<ul>
					<li>CF 9.01 or greater</li>
					<li>Chrome or Firefox Browser with Javascript enabled</li>
					<li>Sense of humor</li>
				</ul>

				<h3>Features</h3>
				<ul>
					<li>Client Side Filtering</li>
					<li>Concurrency support</li>
					<li>Cacheable <abbr title="Application Programming Interface" class="initialism">API</abbr> calls</li>
					<li>Full Remote <abbr title="Application Programming Interface" class="initialism">API</abbr> implemented</li>
					<li>Unit tests for remote API using the worlds smallest testing framework</li>
				</ul>
				<h3>Highlights</h3>
				<p class="lead">Since this was a ColdFusion test, I weaved in solutions for a production application.</p>
				<blockquote>
					<p><button type="button" class="btn btn-default btn-lg"><span class="glyphicon glyphicon-lock"></span></button> The application responsibly locks shared resources during access/mutation. While overkill for a test application, a good ColdFusion programmer should know these things, because in the real world, many people may try to use a single shared resources. Look in the comments for a joke about Race Conditions.</p>
				</blockquote>

				<blockquote>
					<p><button type="button" class="btn btn-default btn-lg"><span class="glyphicon glyphicon-check"></span></button> Additionally, it's important developers document their code. There's comments inside, and also a <a href="API/test.cfm">test.cfm</a> file (since I wasn't allowed to use MXUnit) so we can ensure things work after we change them. Plus, why would one write remote services without some kind of testing...</p>
				</blockquote>

				<blockquote>
					<p><button type="button" class="btn btn-default btn-lg"><span class="glyphicon glyphicon-floppy-saved"></span></button> Just to make it interesting, I added a sleep call in some of the services. Then, I wrote a cache manager component to cache the service calls. That's because in a real world application like Invision, you'll want to reduce the overall system load by appropriate caching. If you narrowly focused on this app, you'd come to the conclusion caching isn't really necessary. Clark asked to see CF Skills so I wanted to demonstrate a bit more than a boring CRUD App.</p>
					<p>You'll notice the first time certain things are done, they are "intentionally" slow. Following interactions are blazing. Certain things that change data (add/update/delete) reset the cache. If this gets overly annoying, <strong>turn it off on line 5 of API.DataStore.cfc</strong></p>
				</blockquote>

				<blockquote>
					<p><button type="button" class="btn btn-default btn-lg"><span class="glyphicon glyphicon-resize-small"></span></button> Just to make it more interesting, I went off the reservation and used a micro-MVC framework for the Javascript parts called Stapes. I've never used Stapes before, but I enjoyed it. It's not bad for a 7k framework. <a href="http://hay.github.io/stapes/"> Here's more on stapes &raquo;</a></p>
				</blockquote>

				<blockquote>
					<p><a href="index.cfm" class="btn btn-primary btn-lg">Ready to get started? <span class="glyphicon glyphicon-forward"></span></a></p>
				</blockquote>
			</div>
		</div>
	</div>

</theme:body>
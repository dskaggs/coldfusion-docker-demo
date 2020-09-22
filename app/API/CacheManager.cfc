<cfcomponent>

	<cffunction name="init" output="false" access="public" returntype="CacheManager" hint="I bottleneck cache requests through a common pipeline for controllability and organziation">
		<cfset variables.cacheName = "API_ContactService" />
		<cfset variables.cacheTTL = createTimespan(0, 0, 15, 0) />
		<cfset variables.idleTTL = createTimespan(0, 0, 15, 0) />
		<!--- We need to do this in java because ColdFusion's cacheGetSession() returns
		 the underlying object for an EXISTING cache, not the generic cache manager --->
		<cfset variables.cacheManager = createObject('java', 'net.sf.ehcache.CacheManager').getInstance() />
		<cfset variables.APIContactServiceCache = initalizeCache( variables.cacheName ) />
		<cfreturn this />
	</cffunction>

	<cffunction name="clear" returntype="void" access="public" output="false" hint="I clear all items in the cache">
		<cfset variables.cacheManager.getCache(variables.cacheName).removeAll() />
	</cffunction>

	<cffunction name="process" returntype="any" access="public" output="false" hint="I process a value and return the cached object">
		<cfargument name="intent" type="string" required="true" />
		<cfargument name="collectionOfArguments" type="struct" default="#structNew()#" />
		<cfargument name="componentReference" type="any" default="" />
		<cfargument name="methodToExecute" type="any" default="" />
		<cfset var cacheKey = buildCacheKey( arguments.intent, collectionOfArguments ) />
		<cfset var cachedValue = CacheGet( cacheKey, variables.cacheName ) />

		<cfif isNull(cachedValue )>
			<cflock type="exclusive" name="#cacheKey#" timeout="10">
				<cfif isNull(cachedValue)>
					<cfinvoke component="#componentReference#" method="#methodToExecute#" returnVariable="cachedValue" argumentCollection="#collectionOfArguments#" />
					<cfset CachePut(cacheKey, cachedValue, variables.cacheTTL, variables.idleTTL, variables.cacheName) />
					<cfset cachedValue = CacheGet( cacheKey, variables.cacheName) />
				</cfif>
			</cflock>
		</cfif>

		<cfreturn cachedValue />
	</cffunction>

	<cffunction name="buildCacheKey" returntype="string" access="private" output="false" hint="I build a predictable cache key based off the arguments">
		<cfargument name="intent" type="string" default="" />
		<cfargument name="PassedArguments" type="any" default="" />
		<cfset var i = 1 />
		<cfset var CacheKey = intent />
		<cfset var keyMap = createObject( "java", "java.util.TreeMap" ).init() /><!---the Treemap will keep the order of the struct elements the same, preventing duplicate caching keys because ColdFusion structs do not preserve order of the keys--->

		<cfif IsStruct( arguments.PassedArguments ) IS true>
			<cfloop collection="#arguments.PassedArguments#" item="thisItem">
				<!---we don't want to deal with complex values in cache keys right now--->
				<cfif isSimpleValue( arguments.PassedArguments[thisItem] ) IS true>
					<cfset keyMap.put( javaCast( "string", thisItem), arguments.PassedArguments[thisItem] ) />
				</cfif>
			</cfloop>
			<cfset CacheKey = CacheKey & "_#serializeJSON(keyMap)#" />
		</cfif>

		<cfreturn hash(CacheKey) />
	</cffunction>

	<cffunction name="cacheCreate" output="false" returntype="void"
		hint="I create a new user defined cache region in Ehcache"
		description="I create a new user defined cache region in Ehcache. This function
				 allows you to also configure the attributes for the custom cache,
				 something you would normally have to hard code in the ehcache.xml
				 file if you rely on ColdFusion's built in caching functions. I named
				 the function cacheCreate() and not cacheNew() in the hopes that a
				 future version of ColdFusion includes a cacheNew() function with
				 similar functionality.">

		<!--- this is what's configurable as of Ehcache 2.0 (CF 9.0.1). Only required
			 argument is Name --->
		<cfargument name="name" type="string" required="true">
		<cfargument name="maxElementsInMemory" type="numeric" default="10000">
		<cfargument name="maxElementsOnDisk" type="numeric" default="10000000">
		<cfargument name="memoryStoreEvictionPolicy" type="string" default="LRU">
		<cfargument name="clearOnFlush" type="boolean" default="true">
		<cfargument name="eternal" type="boolean" default="false">
		<cfargument name="timeToIdleSeconds" type="numeric" default="86400">
		<cfargument name="timeToLiveSeconds" type="numeric" default="86400">
		<cfargument name="overflowToDisk" type="boolean" default="false">
		<cfargument name="diskPersistent" type="boolean" default="false">
		<cfargument name="diskSpoolBufferSizeMB" type="numeric" default="30">
		<cfargument name="diskAccessStripes" type="numeric" default="1">
		<cfargument name="diskExpiryThreadIntervalSeconds" type="numeric" default="120">


		<!--- constructor takes cache name and max elements in memory --->
		<cfset local.cacheConfig = createObject("java", "net.sf.ehcache.config.CacheConfiguration").init(arguments.name, arguments.maxElementsInMemory)>
		<cfset local.cacheConfig.maxElementsOnDisk(arguments.maxElementsOnDisk)>
		<cfset local.cacheConfig.memoryStoreEvictionPolicy("arguments.memoryStoreEvictionPolicy")>
		<cfset local.cacheConfig.clearOnFlush(arguments.clearOnFlush)>
		<cfset local.cacheConfig.eternal(arguments.eternal)>
		<cfset local.cacheConfig.timeToIdleSeconds(arguments.timeToIdleSeconds)>
		<cfset local.cacheConfig.timeToLiveSeconds(arguments.timeToLiveSeconds)>
		<cfset local.cacheConfig.overflowToDisk(arguments.overflowToDisk)>
		<cfset local.cacheConfig.diskPersistent(arguments.diskPersistent)>
		<cfset local.cacheConfig.diskSpoolBufferSizeMB(arguments.diskSpoolBufferSizeMB)>
		<cfset local.cacheConfig.diskAccessStripes(arguments.diskAccessStripes)>
		<cfset local.cacheConfig.diskExpiryThreadIntervalSeconds(arguments.diskExpiryThreadIntervalSeconds)>

		<cfset local.cache = createObject("java", "net.sf.ehcache.Cache").init(local.cacheConfig)>
		<cfset variables.cacheManager.addCache(local.cache)>
	</cffunction>

	<cffunction name="initalizeCache" returntype="any" access="private" output="false" hint="I ensure there is a cache ready namespaced with the cachename we want">
		<cfargument name="CacheName" type="string" required="true" />
		<cfif isNull( variables.cacheManager.getCache( arguments.CacheName ) )>
			<cfset cacheCreate( arguments.CacheName ) />
		</cfif>
		<cfreturn  variables.cacheManager.getCache( arguments.CacheName ) />
	</cffunction>

</cfcomponent>
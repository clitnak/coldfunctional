<cfcomponent extends="tests.BaseTest">

	<cffunction name="_summer" access="private">
		<cfargument name="x">
		<cfargument name="y">
		<cfreturn x+y />
	</cffunction>
	
	<cffunction name="_assertSummed" access="private">
		<cfargument name="result">
		<cfset assertEquals(expected:15, actual:arguments.result) />
	</cffunction>
</cfcomponent>
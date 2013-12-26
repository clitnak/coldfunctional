<cfcomponent extends="tests.BaseTest">

	<cffunction name="constantlyShouldReturnTheValue">
		<cfset local.fn = constantly(5) />
		<cfset assertEquals(expected:5, actual:local.fn(781)) />
		<cfset local.fn = constantly("hello world") />
		<cfset assertEquals(expected:"hello world", actual:local.fn("doesn't matter")) />
	</cffunction>

</cfcomponent>
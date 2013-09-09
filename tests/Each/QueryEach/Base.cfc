<cfcomponent extends="tests.Each.Base">
	<cffunction name="_query" access="private">
		<cfreturn query(column1:[5,10],column2:[10,20]) />
	</cffunction>
	<cffunction name="_assertEachExecuted" access="private">
		<cfargument name="result">
		<cfset assertEquals(expected:2,actual:variables.result.size()) />
		<cfset assertEquals(expected:5,actual:variables.result[1].column1) />
		<cfset assertEquals(expected:10,actual:variables.result[1].column2) />
		<cfset assertEquals(expected:10,actual:variables.result[2].column1) />
		<cfset assertEquals(expected:20,actual:variables.result[2].column2) />
	</cffunction>
</cfcomponent>
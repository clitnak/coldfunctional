<cfcomponent extends="tests.BaseTest">
	<cfset variables.result = [] />
	
	<cffunction name="_each" access="private" >
		<cfargument name="record">
		<cfset variables.result.append(record)>
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
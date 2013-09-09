<cfcomponent extends="tests.BaseTest">

	<cffunction name="_addFiver" access="private">
		<cfargument name="record">
		<cfset arguments.record.column1 +=5 />
		<cfreturn record />
	</cffunction>
	
	<cffunction name="_query" access="private">
		<cfreturn query(column1:[5,10],column2:[10,20]) />
	</cffunction>
	
	<cffunction name="_assertNumberPlus5" access="private">
		<cfargument name="result">
		<cfset assertEquals(expected:10,actual: arguments.result.column1[1]) />
		<cfset assertEquals(expected:15,actual: arguments.result.column1[2]) />
		<cfset assertEquals(expected:10,actual: arguments.result.column2[1]) />
		<cfset assertEquals(expected:20,actual: arguments.result.column2[2]) />
	</cffunction>
</cfcomponent>
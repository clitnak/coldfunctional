<cfcomponent extends="tests.BaseTest">

	<cffunction name="_number" access="private">
		<cfreturn [5,10] />
	</cffunction>
	
	<cffunction name="_2Element" access="private">
		<cfreturn ["whatever",75] />
	</cffunction>
	
	<cffunction name="_assertNumberPlus5" access="private">
		<cfargument name="result">
		<cfset assertEquals(expected:10,actual: arguments.result[1]) />
		<cfset assertEquals(expected:15,actual: arguments.result[2]) />
	</cffunction>

	<cffunction name="_assert2ElementsAreOnes" access="private">
		<cfargument name="result">	
		<cfset assertEquals(expected:1,actual: arguments.result[1]) />
		<cfset assertEquals(expected:1,actual: arguments.result[2]) />	
	</cffunction>	
</cfcomponent>
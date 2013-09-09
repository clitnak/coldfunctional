<cfcomponent extends="tests.BaseTest">

	<cffunction name="_query" access="private">
		<cfreturn query(column1:[5,10],column2:[10,20]) />
	</cffunction>
	
	<cffunction name="_queryfilter" access="private" returntype="boolean">
		<cfargument name="record">
		<cfreturn arguments.record.column1 eq 10 />
	</cffunction>
	
	<cffunction name="_assertQueryFiltered" access="private">
		<cfargument name="result">
		<cfset assertEquals(expected:1,actual:arguments.result.recordcount) />
		<cfset assertEquals(expected:10,actual: arguments.result.column1[1]) />
		<cfset assertEquals(expected:20,actual: arguments.result.column2[1]) />
	</cffunction>
</cfcomponent>
<cfcomponent extends="tests.Each.Base">

	<cfset variables.result = {} />
	<cffunction name="ShouldCallEach">
		<cfset each(_struct(), _each) />
		<cfset _assertEachExecuted() />
	</cffunction>
	
	<cffunction name="_each" access="private" >
		<cfargument name="key">
		<cfargument name="value">
		<cfset variables.result[arguments.key]=arguments.value />
	</cffunction>
	
	<cffunction name="_struct">
		<cfreturn {x:{column1:5,column2:10},y:{column1:10,column2:20}} />
	</cffunction>
	
	<cffunction name="_assertEachExecuted" access="private">
		<cfargument name="result">
		<cfset assertEquals(expected:2,actual:variables.result.size()) />
		<cfset assertEquals(expected:5,actual:variables.result.x.column1) />
		<cfset assertEquals(expected:10,actual:variables.result.x.column2) />
		<cfset assertEquals(expected:10,actual:variables.result.y.column1) />
		<cfset assertEquals(expected:20,actual:variables.result.y.column2) />
	</cffunction>
	
</cfcomponent>
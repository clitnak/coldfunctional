<cfcomponent extends="tests.BaseTest">

	<!--- privates --->
	<cffunction name="add" access="private">
		<cfargument name="x">
		<cfargument name="y">
		<cfreturn x + y />
	</cffunction>

	<cffunction name="subtract" access="private">
		<cfargument name="x">
		<cfargument name="y">
		<cfreturn x - y />
	</cffunction>
	
	
	<cffunction access="private" name="noargs">
		<cfreturn 5>
	</cffunction>
	<cffunction access="private" name="onearg">
		<cfreturn arguments[1] />
	</cffunction>

	<cffunction access="private" name="returnArgs">
		<cfargument name="argument1">
		<cfargument name="argument2">
		<cfreturn arguments />
	</cffunction>	
</cfcomponent>
<cfcomponent extends="Base">
	<cffunction name="ShouldNotError">
		<cfset local.result = any(_query(),function() {return false;}) />
	</cffunction>
</cfcomponent>
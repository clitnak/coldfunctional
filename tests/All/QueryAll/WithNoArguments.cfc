<cfcomponent extends="Base">
	<cffunction name="ShouldNotError">
		<cfset local.result = all(_query(),function() {return false;}) />
	</cffunction>
</cfcomponent>
<cfcomponent extends="Base">
	<cffunction name="ShouldNotError">
		<cfset local.result = all({},function() {}) />
	</cffunction>
</cfcomponent>
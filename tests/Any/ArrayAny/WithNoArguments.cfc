<cfcomponent extends="Base">
	<cffunction name="ShouldNotError">
		<cfset local.result = any([],function() {}) />
	</cffunction>
</cfcomponent>
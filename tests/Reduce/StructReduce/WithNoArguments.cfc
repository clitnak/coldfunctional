<cfcomponent extends="Base">
	<cffunction name="ShouldNotError">
		<cfset local.result = reduce({},function() {}) />
	</cffunction>
</cfcomponent>
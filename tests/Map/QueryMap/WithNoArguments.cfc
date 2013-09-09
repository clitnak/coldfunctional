<cfcomponent extends="Base">
	<cffunction name="ShouldNotError">
		<cfset local.result = map(query(bob:[1]),function() {return {};}) />
	</cffunction>
	
</cfcomponent>
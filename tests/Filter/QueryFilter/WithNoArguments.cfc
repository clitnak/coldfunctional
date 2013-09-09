<cfcomponent extends="Base">
	<cffunction name="ShouldNotError">
		<cfset local.result = filter(query(bob:[1]),function() {return true;}) />
	</cffunction>
	
</cfcomponent>
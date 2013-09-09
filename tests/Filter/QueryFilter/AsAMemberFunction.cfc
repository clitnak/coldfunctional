<cfcomponent extends="Base">
	<cffunction name="ShouldFilter">
		<cfset local.result = _query().filter( _queryfilter) />
		<cfset _assertQueryFiltered(local.result) />
	</cffunction>

</cfcomponent>
<cfcomponent extends="Base">

	<cffunction name="ShouldFilter">
		<cfset local.result = queryFilter(_query(), _queryfilter) />
		<cfset _assertQueryFiltered(local.result) />
	</cffunction>
	

</cfcomponent>
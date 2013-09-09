<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = queryMap(_query(), _addFiver) />
		<cfset _assertNumberPlus5(local.result) />
	</cffunction>
	

</cfcomponent>
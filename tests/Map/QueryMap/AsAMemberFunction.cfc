<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = _query().map(_addFiver) />
		<cfset _assertNumberPlus5(local.result) />
	</cffunction>
	

</cfcomponent>
<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = map(_query(), _addFiver) />
		<cfset _assertNumberPlus5(local.result) />
	</cffunction>
	

</cfcomponent>
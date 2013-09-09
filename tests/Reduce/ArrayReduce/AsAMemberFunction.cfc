<cfcomponent extends="Base">

<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = _number().reduce(_summer) />
		<cfset _assertSummed(local.result) />
	</cffunction>

</cfcomponent>
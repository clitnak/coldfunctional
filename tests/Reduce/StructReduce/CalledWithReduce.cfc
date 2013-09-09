<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = reduce(_number(),_summer) />
		<cfset _assertSummed(local.result) />
	</cffunction>
</cfcomponent>
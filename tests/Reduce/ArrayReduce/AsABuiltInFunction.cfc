<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = arrayReduce(_number(),_summer) />
		<cfset _assertSummed(local.result) />
	</cffunction>
</cfcomponent>
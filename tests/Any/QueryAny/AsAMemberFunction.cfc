<cfcomponent extends="Base">

	<cffunction name="ShouldReturnFalseIfAllButOneAreTrue">
		<cfset local.result = _query().any(_lengthIsBiggerThanThree) />
		<cfset assertFalse(local.result) />
	</cffunction>

	<cffunction name="ShouldReturnTrueIfAllPass]">
		<cfset local.result = _query().any(_lengthIsBiggerThanTwo) />
		<cfset assertTrue(local.result) />
	</cffunction>
</cfcomponent>
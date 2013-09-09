<cfcomponent extends="Base">

	<cffunction name="ShouldReturnFalseIfAllButOneAreTrue">
		<cfset local.result = _struct().all(_lengthIsBiggerThanThree) />
		<cfset assertFalse(local.result) />
	</cffunction>

	<cffunction name="ShouldReturnTrueIfAllPass]">
		<cfset local.result = _struct().all(_lengthIsBiggerThanTwo) />
		<cfset assertTrue(local.result) />
	</cffunction>
</cfcomponent>
<cfcomponent extends="Base">

	<cffunction name="ShouldReturnFalseIfAllButOneAreTrue">
		<cfset local.result = queryAll(_query(),_lengthIsBiggerThanThree) />
		<cfset assertFalse(local.result) />
	</cffunction>

	<cffunction name="ShouldReturnTrueIfAllPass]">
		<cfset local.result = queryAll(_query(),_lengthIsBiggerThanTwo) />
		<cfset assertTrue(local.result) />
	</cffunction>
</cfcomponent>
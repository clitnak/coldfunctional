<cfcomponent extends="Base">

	<cffunction name="ShouldReturnFalseIfAllButOneAreTrue">
		<cfset local.result = all(_array(),_lengthIsBiggerThanThree) />
		<cfset assertFalse(local.result) />
	</cffunction>
	
	<cffunction name="ShouldReturnTrueIfAllPass]">
		<cfset local.result = all(_array(),_lengthIsBiggerThanTwo) />
		<cfset assertTrue(local.result) />
	</cffunction>
</cfcomponent>
<cfcomponent extends="Base">

	<cffunction name="ShouldReturnFalseIfAllButOneAreTrue">
		<cfset local.result = arrayAll(_array(),_lengthIsBiggerThanThree) />
		<cfset assertFalse(local.result) />
	</cffunction>
	
	<cffunction name="ShouldReturnTrueIfAllPass]">
		<cfset local.result = arrayAll(_array(),_lengthIsBiggerThanTwo) />
		<cfset assertTrue(local.result) />
	</cffunction>
</cfcomponent>
<cfcomponent extends="Base">
	<cffunction name="ShouldCallEach">
		<cfset _query().each( _each) />
		<cfset _assertEachExecuted() />
	</cffunction>

</cfcomponent>
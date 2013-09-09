<cfcomponent extends="Base">

	<cffunction name="ShouldCallEach">
		<cfset each(_query(), _each) />
		<cfset _assertEachExecuted() />
	</cffunction>
</cfcomponent>
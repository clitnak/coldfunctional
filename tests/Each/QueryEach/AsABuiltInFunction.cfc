<cfcomponent extends="Base">

	<cffunction name="ShouldCallEach">
		<cfset queryEach(_query(), _each) />
		<cfset _assertEachExecuted() />

	</cffunction>
	

</cfcomponent>
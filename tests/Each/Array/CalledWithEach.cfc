<cfcomponent extends="tests.Each.Base">

	<cffunction name="ShouldCallEach">
		<cfset each(_array(), _each) />
		<cfset _assertEachExecuted() />
	</cffunction>
	
	<cffunction name="_array">
		<cfreturn [{column1:5,column2:10},{column1:10,column2:20}] />
	</cffunction>	
</cfcomponent>
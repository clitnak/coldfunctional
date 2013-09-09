<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = _number().map(_addFiver) />
		<cfset _assertNumberPlus5(local.result) />

	</cffunction>
	
	<cffunction name="ShouldReturnAnArray">
		<cfset local.result = _2Element().map(_returnOne) />
		<cfset _assert2ElementsAreOnes(local.result) />
	</cffunction>
	

</cfcomponent>
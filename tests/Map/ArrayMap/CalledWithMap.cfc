<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = map(_number(),_addFiver) />
		<cfset _assertNumberPlus5(local.result) />
	</cffunction>
	
	<cffunction name="ShouldReturnAnArray">
		<cfset local.result = map(_2Element(),_returnOne) />
		<cfset _assert2ElementsAreOnes(local.result) />
	</cffunction>
</cfcomponent>
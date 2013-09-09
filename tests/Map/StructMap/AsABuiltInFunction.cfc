<cfcomponent extends="Base">

	<cffunction name="ShouldAddNumericKeys">
		<cfset local.result = structMap(_number(),_addFiver) />
		<cfset _assertNumberPlus5(local.result) />
	</cffunction>
	
	<cffunction name="ShouldReturnAStruct">
		<cfset local.result = structMap(_2Element(),_returnOne) />
		<cfset _assert2ElementsAreOnes(local.result) />
	</cffunction>
</cfcomponent>
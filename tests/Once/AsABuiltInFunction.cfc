<cfcomponent extends="tests.BaseTest">

	<cffunction name="ShouldExecuteAComponentPrivateOnlyOnce">
		<cfset assertNotEquals(expected:functionToOnce(),actual:functionToOnce()) />
		<cfset local.onced = FunctionOnce(functionToOnce) />
		<cfset assertEquals(expected:local.onced(),actual:local.onced()) />
	</cffunction>

	<cffunction name="ShouldExecuteAFunctionWithAccessToVariablesScopeOnlyOnce">
		<cfset local.onced = FunctionOnce(variableFunctionToOnce) />
		<cfset variables.x = 1 />
		<cfset local.first = local.onced() />
		<cfset variables.x = 2 />
		<cfset local.second = local.onced() />
		<cfset assertEquals(expected:local.first,actual:local.second) />
	</cffunction>
	
	<cffunction name="ShouldExecuteAnonymousFunctionOnlyOnce">
		<cfset local.fn = (function() {return randRange(1,50000);}) />
		<cfset assertNotEquals(expected:local.fn(),actual:local.fn()) />
		<cfset local.onced = FunctionOnce(local.fn) />
		<cfset assertEquals(expected:local.onced(),actual:local.onced()) />
	</cffunction>	

	<cffunction name="ShouldExecuteOncedMemberFunctionOnlyOnce">
		<cfset local.cfc = createObject("OnceWrappedBuiltin") />
		<cfset assertEquals(expected:local.cfc.onced(),actual:local.cfc.onced()) />
	</cffunction>	
		
	<!--- privates --->
	<cffunction name="functionToOnce" access="private">
		<cfreturn randRange(1,5000000) />
	</cffunction>
	
	<cffunction name="variableFunctionToOnce" access="private">
		<cfreturn randRange(1,5000000) />
	</cffunction>
</cfcomponent>
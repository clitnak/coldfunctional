<cfcomponent extends="tests.BaseTest">

	<cffunction name="ShouldExecuteAComponentPrivateOnlyOnce">
		<cfset assertNotEquals(expected:functionToOnce(),actual:functionToOnce()) />
		<cfset local.onced = functionToOnce.once() />
		<cfset assertEquals(expected:local.onced(),actual:local.onced()) />
	</cffunction>

	<cffunction name="ShouldExecuteAFunctionWithAccessToVariablesScopeOnlyOnce">
		<cfset local.onced = variableFunctionToOnce.once() />
		<cfset variables.x = 1 />
		<cfset local.first = local.onced() />
		<cfset variables.x = 2 />
		<cfset local.second = local.onced() />
		<cfset assertEquals(expected:local.first,actual:local.second) />
	</cffunction>
	
	<cffunction name="ShouldExecuteAnonymousFunctionOnlyOnce">
		<cfset local.fn = (function() {return randRange(1,50000);}) />
		<cfset assertNotEquals(expected:local.fn(),actual:local.fn()) />
		<cfset local.onced = local.fn.once() />
		<cfset assertEquals(expected:local.onced(),actual:local.onced()) />
	</cffunction>	

	<cffunction name="ShouldExecuteOncedMemberFunctionOnlyOnce">
		<cfset local.cfc = createObject("OnceWrappedMember") />
		<cfset assertEquals(expected:local.cfc.onced(),actual:local.cfc.onced()) />
	</cffunction>	
		
	<!--- privates --->
	<cffunction name="functionToOnce" access="private">
		<cfreturn randRange(1,5000000) />
	</cffunction>
	
	<cffunction name="variableFunctionToOnce" access="private">
		<cfreturn variables.x />
	</cffunction>
</cfcomponent>
<cfcomponent extends="tests.BaseTest">
	<cffunction name="_lengthIsBiggerThanThree" access="private">
		<cfargument name="thing">
		<cfreturn len(thing) gt 3 />
	</cffunction>
	
	<cffunction name="_lengthIsBiggerThanTwo" access="private">
		<cfargument name="thing">
		<cfreturn len(thing) gt 2 />
	</cffunction>
</cfcomponent>
<cfcomponent extends="Base">
	<cffunction name="ShouldError">
		<cftry>
			<cfset local.result = map(query(bob:[1]),_returnArray) />
			<cfset local.failed = true />
			<cfcatch>
				<cfset local.failed = false />
			</cfcatch>
		</cftry>
		<cfif local.failed>
			<cfset fail() />
		</cfif>
	</cffunction>
	
	<cffunction name="ShouldErrorIfReturningIncorrectly">
		<cftry>
			<cfset local.result = map(query(bob:[1]),function() {return [];}) />
			<cfset local.failed=true />
			<cfcatch>
				<cfset local.failed = false />
				<!--- expected --->
			</cfcatch>
		</cftry>
		<cfif local.failed>
			<cfset fail() />
		</cfif>
	</cffunction>
	
	<cffunction name="_returnArray" access="private" returntype="array">
		<cfreturn [] />
	</cffunction>
</cfcomponent>
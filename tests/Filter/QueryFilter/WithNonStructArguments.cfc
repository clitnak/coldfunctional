<cfcomponent extends="Base">
	<cffunction name="ShouldError">
		<cftry>
			<cfset local.result = filter(query(bob:[1]),_takeArray) />
			<cfset local.failed = true />
			<cfcatch>
				<cfset local.failed = false />
			</cfcatch>
		</cftry>
		<cfif local.failed>
			<cfset fail() />
		</cfif>
	</cffunction>
	
	<cffunction name="_takeArray" access="private">
		<cfargument name="array" type="array">
		<cfreturn true />
	</cffunction>
</cfcomponent>
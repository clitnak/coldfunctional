<cfcomponent extends="Base">
	<cffunction name="ShouldError">
		<cftry>
			<cfset local.result = reduce([],function() {}) />
			<cfset local.passed = false />
			<cfcatch>
				<cfset local.passed = true />
			</cfcatch>
		</cftry>
		<cfset assertTrue(local.passed) />
	</cffunction>
</cfcomponent>
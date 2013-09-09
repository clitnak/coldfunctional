<cfcomponent output="false">
	
	<cffunction name="run" output="false" hint="runs the tests">
		<cfset local.result = [] />
		<cfset _tests().each(function (test) {result.append(_runTest(test));}) />
		<cfreturn local.result />
	</cffunction>
	
	<!--- privates --->
	<cffunction name="_tests" output="false" access="private" hint="returns the tests">
		<cfdirectory action="list" directory="./" type="file" filter="*.cfc" listinfo="name" recurse="true" name="local.qTests">
	
		<cfreturn queryColumnData(local.qTests,"name") />
	</cffunction>
	
	<cffunction name="_runTest" output="false" access="private" hint="runs a test">
		<cfargument name="relativePath" type="string" />
		<cfset local.dotPath = REReplaceNoCase(
					REreplaceNoCase(arguments.relativePath,"[\/\\]",".","all")
					, "\.cfc$"
					, ""
				) />

		<cfif !_isBaseTest(local.dotPath)>
			<cftry>
				<cfset local.test = createObject("component",local.dotPath) />
				<cfcatch>
					<cfreturn {label:local.dotPath, cfcatch:cfcatch} />
				</cfcatch>
			</cftry>
			<cfif structKeyExists(local.test,"execute")>
				<cftry>
					<cfset local.test.execute() />
					<cfset local.result="pass" />
					<cfcatch>
						<cfset local.result = {label:local.dotPath, cfcatch:cfcatch} />
					</cfcatch>
				</cftry>
			<cfelse>
				<cfset local.result = "skip">
			</cfif>
		<cfelse>
			<cfset local.result = "skip" />
		</cfif>
		<cfreturn local.result>
	</cffunction>
	
	<cffunction name="_isBaseTest" output="false" access="private" hint="returns true if the provided dotPath is THE base Test">
		<cfargument name="dotpath">
		<cfreturn arguments.dotPath eq "BaseTest" />
	</cffunction>
</cfcomponent>
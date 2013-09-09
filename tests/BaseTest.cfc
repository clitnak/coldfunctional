<cfcomponent output="false">



	<cffunction name="execute">
		<cfloop collection="#variables#" index="local.key" item="local.value">
			<cfset _attemptToCall(local.value) />
		</cfloop>
	</cffunction>
	
	<cffunction name="_attemptToCall" output="false" access="private">
		<cfargument name="potentialFunction" />
		<cfif isCustomFunction(arguments.potentialFunction)>
			<cfset local.md = getMetaData(arguments.potentialFunction) />
			<cfif local.md.access eq "public" and local.md.name neq "execute">
				<cfset variables[local.md.name]() />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="assertTrue" access="private">
		<cfargument name="condition" type="boolean" />
		<cfargument name="message" type="string" default="test failure" />
		<cfif not arguments.condition>
			<cfthrow message="#arguments.message#">
		</cfif>
	</cffunction>
	<cffunction name="assertFalse" access="private">
		<cfargument name="condition" type="boolean" />
		<cfargument name="message" type="string" default="test failure" />
		<cfset assertTrue(not arguments.condition,arguments.message) />
	</cffunction>

	<cffunction name="assertEquals" access="private">
		<cfargument name="expected" type="any" />
		<cfargument name="actual" type="any" default="test failure" />
		<cfargument name="message" type="string" default="test failure" />
		<cfset assertTrue(condition:arguments.expected eq arguments.actual,message:arguments.message) />
	</cffunction>

	<cffunction name="fail" access="private">
		<cfargument name="message" />
		<cfset assertTrue(condition:false,message:arguments.message) />
	</cffunction>
	<cffunction name="_addFiver" access="private">
		<cfargument name="argument">
		<cfreturn arguments[1] +5 />
	</cffunction>
	
	<cffunction name="_returnOne" access="private">
		<cfargument name="argument">
		<cfreturn 1 />
	</cffunction>
</cfcomponent>
<cfcomponent>

	
	<cffunction name="onced">
		<cfreturn randRange(1,5000000) />
	</cffunction>
	<cfset onced = onced.once() />
</cfcomponent>
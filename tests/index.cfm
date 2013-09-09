<cfset results = createObject("component","Runner").run() />
<cfoutput>
	Failures:
	<ul>
		<cfloop array="#results#" index="i" item="result">
			<cfif isStruct(result)>
				<li><cfdump var="#result.cfcatch#" label="#result.label#" expand="false"/></li>
			</cfif>
		</cfloop>
	</ul>
</cfoutput>
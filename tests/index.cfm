<cfset results = createObject("component","Runner").run() />
<cfoutput>
	Failures:
	<ul>
		<cfloop array="#results#" index="i" item="result">
			<cfif result.status eq "fail">
				<li><cfdump var="#result.error#" label="#result.label#" expand="true"/></li>
			</cfif>
		</cfloop>
		<cfloop array="#results#" index="i" item="result">
			<cfif result.status eq "skip">
				<li>skipped: #result.label#</li>
			</cfif>
		</cfloop>
		<cfloop array="#results#" index="i" item="result">
			<cfif result.status eq "pass">
				<li>passed: #result.label#</li>
			</cfif>
		</cfloop>
	</ul>
</cfoutput>
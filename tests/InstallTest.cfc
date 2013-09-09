<cfcomponent output="false" extends="tests.BaseTest">
	
	<cffunction name="execute" access="remote" output="false" returnformat="plain">
		<cfcontent type="text/html" />
		
		<cfset files = [
				expandPath('{railo-web}')&"/library/fld/testFLD.0.1.txt",
				expandPath('{railo-web}')&"/lib/testjar.0.1.txt"
			] />
		<cfset files.each( function(file) {try {fileDelete(file);} catch(e) {}} ) />
		<cfset files.each( function(file) {assertFalse(condition:fileExists(file));}) />
		<cfset _uut().install({},_path()) />
		<cfset files.each( function(file) {assertTrue(condition:fileExists(file));}) />
		<cfreturn "success" />
	</cffunction>
	<!--- privates --->
	<cffunction name="_path" access="private" output="false">
		<cfreturn getDirectoryFromPath(getCurrentTemplatePath()) &"testInstall" />
	</cffunction>

	<cffunction name="_uut" access="private" output="false">
		<cfreturn createObject("component","Install") />
	</cffunction>
</cfcomponent>
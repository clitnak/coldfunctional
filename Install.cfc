<cfcomponent output="false">
	<!---
	<cfscript>
		variables.name = "MongoDBCache";
		variables.id = "railo.extension.io.cache.mongodb.MongoDBCache";
		variables.jar = "mongodb-cache.jar"
		variables.driver = "MongoDBCache.cfc"
		variables.jars = "#variables.jar#,mongo.jar,mongo-java-driver.txt";
	</cfscript>
    
	--->
	
    <cffunction name="validate" returntype="void" output="false"
    	hint="called to validate values">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        <cfargument name="step" type="numeric">
        <!--- no user input to validate --->
    </cffunction>
    
    <cffunction name="install" returntype="string" output="false"
    	hint="called from Railo to install application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        
		<cfset local.filesToDelete = [] />
		<cfset _directories().each(
					function(source,destination) {
						filesToDelete.append(
							_installDirectory( path & "/" & source, destination, _extractVersion(path))
							,true
						);
					}
				) />
		<cfset local.successMessage = "Successfully installed #_name()# version #_extractVersion(path)#." />
		<cfset local.successMessage = _addDeleteFilesMessage(local.successMessage,local.filesToDelete) />
		<cfreturn  local.successMessage />
	</cffunction>
    	
     <cffunction name="update" returntype="string" output="no"
    	hint="updates an application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
		<cfreturn install(argumentCollection=arguments)>
    </cffunction>
    
    
    <cffunction name="uninstall" returntype="string" output="no"
    	hint="called from Railo to uninstall application">
    	<cfargument name="path" type="string">
        <cfargument name="config" type="struct">

		<cfset local.filesToDelete = [] />      
		<cfset _directories().each(
					function(source,destination) {
						filesToDelete.append(
							_uninstallDirectory( path & "/" & source, destination, _extractVersion(path))
							,true
						);
					}
				) />
		<cfreturn _addDeleteFilesMessage('#_Name()# version #_extractVersion(path)# was successfully uninstalled.',local.filesToDelete) />
		
    </cffunction>
    
    <cffunction name="hasExtension" returntype="boolean">
        <cfargument name="name" type="string" required="yes">
        <cfset var extensions="">
        <cfadmin 
            action="getExtensions"
            type="#_adminType()#"
            password="#_password()#"
            returnVariable="extensions">
         <cfloop query="extensions">
            <cfif extensions.name EQ _name()>
                <cfreturn true>
            </cfif>
         </cfloop>
         <cfreturn false>
    </cffunction>


	<!--- privates --->
	<cffunction name="_addDeleteFilesMessage" access="private" returntype="string">
		<cfargument name="successMessage" type='string' />
		<cfargument name="filesToDelete" type="array" />
		
		<cfif arguments.filesToDelete.size() gt 0>
			<cfset local.s = "s">
			<cfif arguments.filesToDelete.size() eq 1>
				<cfset local.s = "" />
			</cfif>
			<cfset arguments.successMessage &= "<br /> Please stop Railo and delete the following file#local.s#: <br />" />
			<cfloop array="#arguments.filesToDelete#" index="local.i" item="local.fileName">
				<cfset arguments.successMessage &= local.fileName&"<br />" />
			</cfloop>
		<cfelse>
			<cfset arguments.successMessage &= "<br /> Please restart Railo.<br />" />
		</cfif>
		<cfreturn arguments.successMessage />
	</cffunction>
	
    <cffunction name="_contextPath" access="private" returntype="string">

        <cfswitch expression="#_adminType()#">
            <cfcase value="web">
                <cfreturn expandPath('{railo-web}') />
            </cfcase>
            <cfcase value="server">
                <cfreturn expandPath('{railo-server}') />
            </cfcase>
        </cfswitch>

    </cffunction>
	
	<cffunction name="_adminType" access="private" returntype="string">
		<cfreturn request.adminType ?: "web" />
	</cffunction>

	<cffunction name="_password" access="private" returntype="string">
		<cfreturn session["password"&_adminType()] ?: "sysadmin" />
	</cffunction>

	<cffunction name="_installDirectory" access="private" returntype="array"
			hint="given the source and destination, this function will install a directory to the destination">
		
		<cfset arguments.callback=_installFile />
		<cfreturn _processDirectory(argumentCollection=arguments) />
		
	</cffunction>
	
	<cffunction name="_uninstallDirectory" access="private" returntype="array"
			hint="given the source and destination, this function will install a directory to the destination">
		
		<cfset arguments.callback=_uninstallFile />
		<cfreturn _processDirectory(argumentCollection=arguments) />
		
	</cffunction>
	
	<cffunction name="_processDirectory" access="private" returntype="array"
			hint="given the source and destination, this function will install a directory to the destination">
		<cfargument name="source" type="string" hint="source folder, absolute"/>
		<cfargument name="destination" type="string" hint="destination folder, absolute"/>
		<cfargument name="version" type="string" hint="the version number to install" />
		<cfargument name="callback" hint="the fn to execute for each file" />
		
		<cfdirectory action="list" directory="#arguments.source#" listinfo="name" type="file" name="local.qFiles" />
		<cfset local.files = queryColumnData(local.qFiles,"name") />
		<cfset local.result = [] />
		<cfset local.files.each(
					function (sourceFile) {
							result.append(
											callback( source & "/" & sourceFile, destination, version )
											,true
										);
						}
				) />
		<cfreturn local.result />
	</cffunction>
	
	<cffunction name="_installFile" access="private" returntype="array"
			hint="given the source and directory destination, this function will install a file to the directory destination,
				  the magical part is it will overwrite files with different version numbers">
		<cfargument name="source" type="string" hint="source file, absolute" />
		<cfargument name="destination" type="string" hint="destination folder, absolute" />
		<cfargument name="version" type="string" hint="the version number to install" />
		
		<!--- find destination files --->
		<cfset local.fileName= getFileFromPath(arguments.source) />
		<cfset local.versionedFileName = _addVersionToFileName(local.fileName,arguments.version) />
		<cfset local.lockedFiles = [] />
		
		<cfset local.versionedFiles = _getVersionedFiles(arguments.destination,local.fileName) />
		<cfloop array="#local.versionedFiles#" index="local.i" item="local.file">
			<cfset local.fullpath = arguments.destination & "/" &local.file />
			<cfif local.versionedFileName neq local.file>
				<cfif not _deleteFile(local.fullPath)>
					<cfset local.lockedFiles.append(local.fullPath) />
				</cfif>
			</cfif>
		</cfloop>
		<cfset local.destinedFile = arguments.destination & "/" & local.versionedFileName />
		<cfif not fileExists(local.destinedFile)>
			<cfset fileCopy( arguments.source, local.destinedFile ) />
		</cfif>
		
		<cfreturn local.lockedFiles />
	</cffunction>	


	<cffunction name="_uninstallFile" access="private" returntype="array"
			hint="given the source and directory destination, this function will install a file to the directory destination,
				  the magical part is it will overwrite files with different version numbers">
		<cfargument name="source" type="string" hint="source file, absolute" />
		<cfargument name="destination" type="string" hint="destination folder, absolute" />
		<cfargument name="version" type="string" hint="the version number to install" />
		
		<!--- find destination files --->
		<cfset local.fileName= getFileFromPath(arguments.source) />
		<cfset local.versionedFileName = _addVersionToFileName(local.fileName,arguments.version) />
		<cfset local.versionedFiles = _getVersionedFiles(arguments.destination,local.fileName) />
		<cfset local.lockedFiles = [] />
		<cfloop array="#local.versionedFiles#" index="local.i" item="local.file">
			<cfset local.fullpath = arguments.destination & "/" &local.file />
			<cfif not _deleteFile(local.fullPath)>
				<cfset local.lockedFiles.append(local.fullPath) />
			</cfif>
		</cfloop>
		<cfreturn local.lockedFiles />
	</cffunction>

	<cffunction name="_getVersionedFiles" access="private" output="false">
		<cfargument name="directory" type="string" hint="directory to search for files" />
		<cfargument name="rootFileName" type="string" hint="the root file name, without the version" />
		<cfset local.fileNameWithoutExtension = REreplaceNoCase(arguments.rootFileName,"\.[^.]*$","") />
		<cfdirectory action="list" name="local.qFiles" listInfo="name" type="file" directory="#arguments.directory#" filter="#local.fileNameWithoutExtension#.*" />
		<cfreturn queryColumnData(local.qFiles,"name") />
	</cffunction>
	
	<cffunction name="_name" access="private">
		<cfreturn "c#chr(402)#(n)" />
	</cffunction>
	
	<cffunction name="_addVersionToFileName" access="private" output="false" 
			hint="adds the version name to the file">
		<cfargument name="fileName" type="string" hint="the file name to change" />
		<cfargument name="version" type="string" hint="the version number to add" />
		<cfset local.arr = ListToArray(arguments.fileName,".") />
		<cfset arrayInsertAt(local.arr,local.arr.size(),arguments.version) />
		<cfreturn local.arr.toList(".") />
	</cffunction>

	<cffunction name="_extractVersion" access="private" output="false" 
			hint="returns the version">
		<cfargument name="path" type="string" required="true" hint="the path to the directory" />
		<cfreturn xmlParse(arguments.path & "/config.xml").config.info.version.xmlText />
	</cffunction>
	
	<cffunction name="_directories" access="private" returntype="struct"
				hint="returns a map of dirctory souces and destination">
		<cfreturn {
					'content/jar': _contextPath() &"/lib",
					'content/fld': _contextPath() &"/library/fld"
				} />
	</cffunction>
	
	<cffunction name="_deleteFile" access="private" returntype="boolean"
				hint="attempts to delete a file, if it can't it marks it for deletion">
		<cfargument name="file" type="string" required="true" hint="the file to delete" />
		
		<cftry>
			<cffile action="delete" file="#arguments.file#" />
			<cfcatch>
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>
</cfcomponent>
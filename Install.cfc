component {
	
	public void function fill (config) {
		_configurator().configure(config);
	}
	
	/**
	* called from Railo to validate entered values
	*/
	public void function validate (struct error, string path, struct config, numeric step) {
		local.minVersion = "4.1.1.000";
		if  ( server.railo.version lt local.minVersion ) {
			throw(
				type:"coldfunctional.incompatable", 
				message="ColdFunctional is not compatible with Railo version #server.railo.version#, must be version #local.minVersion# or greater"
			);
			
		}
	}

	/**
	* called from Railo to install the extension
	*/
	public string function install ( struct error, string path, struct config ){
		if ( structKeyExists( arguments, 'config' ) ) {
			_applyPreferencesToFLD( arguments.config );
		}
		local.filesToDelete = [];
		_directories().each(
				function(source,destination) {
					filesToDelete.append(
						_installDirectory( path & "/" & source, destination, _extractVersion(path) )
						,true
					);
				}
			);
		local.successMessage = "Successfully installed #_name()# version #_extractVersion(path)#.";
		local.successMessage = _addDeleteFilesMessage(local.successMessage,local.filesToDelete);
		return local.successMessage;
	}

	/**
	* called from Railo to update the already installed extension
	*/
	public string function update ( struct error, string path, struct config ) {
		return install(argumentCollection=arguments);
	}

	/**
	* called from Railo to uninstall the extension
	*/
	public string function uninstall ( string path, struct config ) {
		local.filesToDelete = [];
		_directories().each(
				function(source,destination) {
					filesToDelete.append(
						_uninstallDirectory( path & "/" & source, destination, _extractVersion(path))
						,true
					);
				}
			);
		return _addDeleteFilesMessage('#_Name()# version #_extractVersion(path)# was successfully uninstalled.',local.filesToDelete);
	}
	
	public boolean function hasExtension (string name) {
		admin 
			action="getExtensions"
			type="#_adminType()#"
			password="#_password()#"
			returnVariable="local.extensions";
		for( local.row in local.extensions ) {
			if ( local.row.name eq _name() ) return true;
		}
		return false;
	}

	/*
	* privates
	*/

	private string function _addDeleteFilesMessage ( string successMessage, array filesToDelete ) {
		local.result = arguments.successMessage;
		if ( arguments.filesToDelete.size() gt 0 ) {
			local.s = "s";
			if ( arguments.filesToDelete.size() eq 1 ) {
				local.s = "";
			}
			local.result &= '<br /> <span style="color:red;font-weight:bold;">Please stop your Servlet Container and delete the following file#local.s#: <br />';
			for( local.fileName in arguments.filesToDelete ) {
				local.result &= local.fileName & " <br /> "; /*"*/
			}
			local.result &= " </span> "; /*"*/
		} else {
			local.result &= " <br /> Please restart Railo.<br /> ";/*"*/
		}
		return local.result;
	}
	
	private string function _contextPath () {
		switch (_adminType()) {
			case "web": 
				return expandPath('{railo-web}');
				break;
			case "server":
				return expandPath('{railo-server}');
				break;
		}
	}
	
	private string function _adminType() {
		if ( structKeyExists( request,"adminType" ) ) {
			return request.adminType;
		} else {
			return "web";	
		}
	}

	private string function _password() {
		local.key = "password"&_adminType();
		if ( structKeyExists(session,local.key) ) {
			return session[local.key];
		} else {
			return "sysadmin";
		}
	}

	/**
	* given the source and destination, this function will install a directory to the destination
	*/
	private array function _installDirectory() {
		arguments.callback = _installFile;
		return _processDirectory(argumentCollection=arguments);
	}

	/**
	* given the source and destination, this function will uninstall a directory to the destination
	*/	
	private array function _uninstallDirectory(){
		arguments.callback=_uninstallFile;
		return _processDirectory(argumentCollection=arguments);
		
	}
	
	/**
	* helper function to process a directory with a callback on each file
	* @source absolute source folder
	* @destination absolute destinatoin folder
	* @version the version number to install or 
	* @callback a function to execute for each file
	*/	
	private array function _processDirectory ( string source, string destination, string version, function callback ) {
		local.files = directoryList( path:arguments.source, listinfo:"name" );
		local.result = [];
		local.files.each(
				function (sourceFile) {
						result.append(
								callback( source & "/" & sourceFile, destination, version )
								,true
							);
					}
				);
		return local.result;
	}
	
	/**
	* given the source and directory destination, this function will install a file to the directory destination,
	*			  the magical part is it will overwrite files with different version numbers
	* @source absolute source file
	* @destination absolute destination folder
	* @version the version number
	*/
	private array function _installFile ( string source, string destination, string version ) {
		// find destination files 
		local.fileName= getFileFromPath( arguments.source );
		local.versionedFileName = _addVersionToFileName( local.fileName, arguments.version );
		local.lockedFiles = [];
		
		local.versionedFiles = _getVersionedFiles( arguments.destination, local.fileName );
		for (local.file in local.versionedFiles) {
			local.fullpath = arguments.destination & "/" & local.file;
			if ( local.versionedFileName neq local.file ) {
				if ( not _deleteFile( local.fullPath ) ) {
					local.lockedFiles.append( local.fullPath );
				}
			}
		}
		local.destinedFile = arguments.destination & "/" & local.versionedFileName;
		if ( not fileExists( local.destinedFile ) ) {
			fileCopy( arguments.source, local.destinedFile );
		}
		
		return local.lockedFiles;
	}	

	/**
	* given the source and directory destination, this function will install a file to the directory destination,
	*			  the magical part is it will overwrite files with different version numbers
	* @source absolute source file
	* @destination absolute destination folder
	* @version the version
	*/
	private array function _uninstallFile (string source, string destination, string version) {
		<!--- find destination files --->
		local.fileName= getFileFromPath(arguments.source);
		local.versionedFileName = _addVersionToFileName(local.fileName,arguments.version);
		local.versionedFiles = _getVersionedFiles(arguments.destination,local.fileName);
		local.lockedFiles = [];
		for( local.file in local.versionedFiles ) {
			local.fullpath = arguments.destination & "/" & local.file;
			if (not _deleteFile( local.fullPath ) ) {
				local.lockedFiles.append( local.fullPath );
			}
		}
		return local.lockedFiles;
	}

	/**
	* @directory directory to search for files
	* @rootFilename the root file name, without the version
	*/
	private array function _getVersionedFiles ( string directory, string rootFileName ) {
		local.fileNameWithoutExtension = REreplaceNoCase( arguments.rootFileName, "\.[^.]*$", "");
		return directoryList( listInfo:"name", path:arguments.directory, filter:local.fileNamewithoutExtension & ".*" );/*"*/
	}
	
	private string function _name() {
		return "ColdFunctional";
	}
	
	/**
	* adds the version name to the file
	* @fileName the file name to change
	* @version the version number to add
	*/
	private string function _addVersionToFileName ( string fileName, string version ) {
		local.arr = ListToArray( arguments.fileName, "." );
		arrayInsertAt( local.arr, local.arr.size(), arguments.version );
		return arrayToList( local.arr, "." );
	}

	/**
	* returns the version of the config xml in the path provided.
	* @path the path to the directory of the extension xml file
	*/
	private string function _extractVersion ( string path ) {
		return xmlParse( arguments.path & "/config.xml" ).config.info.version.xmlText;
	}
	
	/**
	* returns a map of directory sources and destinations that the extension will install to.
	*/
	private struct function _directories () {
		return {
					'content/jar': _contextPath() &"/lib",
					'content/fld': _destinationFLDPath()
				};
	}
	
	
	private string function _destinationFLDPath() {
		return _contextPath() & "/library/fld";	
	}
		
	/**
	* attempts to delete a file, if it can't it marks it for deletion
	* @file the file to delete
	*/
	private boolean function _deleteFile ( string file ){
		
		try {
			fileDelete( arguments.file );
		} 
		catch (local.e) {
			return false;
		}
		return true;
	}

	private cfc.InstallStepConfigurator function _configurator() { 
		
		return new cfc.InstallStepConfigurator(_functionSettings());
	}
	
	private struct function _functionSettings() {
		return new cfc.FunctionLibraryDescriptorReader().readFunctionSettingsFromFLD(
			_getMaximumVersionedFilePath(
				_destinationFLDPath() & "/coldfunctional.fld"
			),
			_sourceFLD()
		);
	}
	
	private string function _getMaximumVersionedFilePath ( string path ) {
		local.directory = getDirectoryFromPath( arguments.path );
		local.file = getFileFromPath( arguments.path );
		local.files = _getVersionedFiles( local.directory, local.file );
		local.files.sort("textnocase");
		if ( local.files.size() eq 0 ) { 
			local.result = arguments.path
		} else {
			local.result = local.directory & "/" & local.files[ local.files.size() ];
		}
		return local.result;
		
	}
	
	private void function _applyPreferencesToFLD ( struct config ) {
		new cfc.FunctionLibraryDescriptorApplier().apply( 
			_sourceFLD(), 
			arguments.config
		);
			
	}
	
	private string function _sourceFLD() {
		return getDirectoryFromPath ( getCurrentTemplatePath() ) & "/content/fld/coldfunctional.fld";
	}
}
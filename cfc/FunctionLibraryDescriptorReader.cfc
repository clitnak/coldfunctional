component {
	
	function readFunctionSettingsFromFLD( string pathToCustomizedFLD, string pathToCanonicalFLD ) {
		local.original = _readFLD( arguments.pathToCanonicalFLD, 
			function(xml) { return arguments.xml.name.xmlText; } 
		);
		local.result = structNew('linked');
		if( !fileExists( arguments.pathToCustomizedFLD ) ) {
			local.new = local.original;	
		} else {
			local.new = _readFLD( 
			arguments.pathToCustomizedFLD, 
				function(xml) {
					if ( original.keyExists( arguments.xml.class.xmlText ) )	{
						return original[arguments.xml.class.xmlText].originalName;	
					}
					return arguments.xml.name.xmlText;
				} 
			);
		}
		for( local.key in local.original ) {
			if ( local.new.keyExists( local.key ) ) {
				local.result[local.key] = local.new[local.key];
			} else {
				local.result[local.key] = local.original[local.key];
				local.result[local.key].enabled = false;
			}
		}
		return _smash(local.result);
	}
	
	/* privates */
	
	private struct function _readFLD( string path, function keyLookup ) {
		local.functions = xmlSearch ( xmlParse( arguments.path ), "func-lib/function" );
		local.result = structNew('linked');
		for( local.xml in local.functions ) {
			if ( local.xml.keyExists('name') ) {
				local.result[ local.xml.class.xmlText ] = 
					{
						originalName: arguments.keyLookup( local.xml ),
						mappedName: local.xml.name.xmlText,
						enabled: true
					}
			}
		}
		return local.result;
		
	}
	
	/**
	* takes a struct of structs with the keys 'originalName', and creates a new struct of structs 
	* where the key is the value of the originalName key.
	*/
	private struct function _smash(struct struct) {
		local.result = structNew('linked');
		for( local.key in arguments.struct ) {
			local.value = arguments.struct[local.key];
			local.newKey = local.value.originalName;
			local.result[local.newKey] = {
				mappedName: local.value.mappedName,
				enabled: local.value.enabled
			}
		}
		return local.result;
	}
	
}
component {
	
	function apply( string pathToSourceFLD, struct formfields ) {
		local.config = _extractConfigFromFormFields( arguments.formFields );
		local.fldXML = xmlParse( arguments.pathToSourceFLD );
		local.xml = local.fldXML['func-lib'].xmlChildren;
		
		for( local.i = local.xml.size(); local.i >= 1; local.i-- ) { //go backwards in the array
			local.function = local.xml[ local.i ];
			if( local.function.keyExists( 'name' ) ) {
				local.name = local.function.name.xmlText;
				local.functionConfig = local.config[ local.name ];
				local.function.name.xmlText = local.functionConfig.newName;
				if ( !local.functionConfig.enabled ) {
					local.xml.deleteAt( local.i );	
				}
			}
		}
		
		fileWrite( pathToSourceFLD, toString( local.fldXML ) );
	}
	
	/* privates */
	
	private function _extractConfigFromFormFields( struct formFields ) {
		local.formFields = arguments.formfields.mixed;
		local.result = {};
		for( local.key in local.formFields.map ) {
			local.result[local.key] = {
				newName: local.formFields.map[ local.key ],
				enabled: local.formfields.enabled.keyExists( local.key ) 
			};
			
		}
		return local.result;
	}
}
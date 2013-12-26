component {

	variables.functions = {};
	function init(struct functions) {
		variables.functions = arguments.functions;
	}

	function configure(config) {
		local.step = arguments.config.createStep( "Customize ColdFunctional Installation", _instructions() );
		for(local.key in variables.functions) {
			local.function = variables.functions[local.key];
			_addFunctionOptions( 
				step: local.step, 
				functionName:local.key, 
				enabled:local.function.enabled, 
				mappedName:local.function.mappedName );
		}
	}
	
	/* privates */
	
	/**
	* adds the enable/disable options for a given function to the install config
	*/
	private void function _addFunctionOptions ( any step, string functionName, boolean enabled, string mappedName ) {
		local.group = arguments.step.createGroup( label:arguments.functionName &"() function", description:"Configure the #arguments.functionName#() function" );
		//add the two config items for the function
		
		if(arguments.enabled)
			local.value = "On";
		else 
			local.value = "Off";
			
		local.group.createItem(
			type: "checkbox", 
			name: "enabled.#arguments.functionName#", 
			value: local.value, 
			selected: arguments.enabled, 
			label: "Enabled?", 
			description: "Enable the #arguments.functionName#() function");
		
		local.group.createItem(
			type: "text", 
			name: "map.#arguments.functionName#", 
			value: arguments.mappedName, 
			label: "Mapped Function Name", 
			description: "If enabled, #arguments.functionName#() will be renamed / mapped to the function name provided here.");
	}
	
	private string function _instructions() {
		return "Leaving this configuration page as it is will result in a full, unmodified installation of ColdFunctional.
			The reason you may want to customize this installation is because this extension will create several built-in functions.
			In Railo, built-in functions override unscoped function calls. 
			If any code in your application has functions with the same name as a function provided in Coldfunctional. 
			Railo will pass the function call to the ColdFunctional extension. 
			To solve function name conflicts, you can either scope function calls ( e.g. use this.map() instead of map() )
			Alternatively, you can customize the installation of ColdFunctional by either not installing a conflicting function or
			by changing the function name. This is configured on this page.";
		
	}

}
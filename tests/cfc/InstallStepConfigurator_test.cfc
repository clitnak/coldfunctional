component extends="root.tests.BaseTest" {

	function beforeTests () {
		variables.config = createObject("component","railo-context.admin.extension.ExtensionConfig");
		_uut().configure(variables.config); 
	}

	function shouldHaveStepExplanationText () {
		assertEquals( actual: variables.config.getSteps().size(), expected: 1);
		assertTrue(condition: len( variables.config.getSteps()[1].getDescription() ) gt 20 );
		
	}
	

	function shouldHaveDisabledStructMap () {
		assertEquals( 
			actual: variables.config.getSteps()[1].getGroups()[1].getLabel(), 
			expected: "map() function",
			message:variables.config.getSteps()[1].getGroups()[1].getLabel()
		);

		assertEquals( 
			actual: variables.config.getSteps()[1].getGroups()[2].getLabel(), 
			expected: "structMap() function",
			message:variables.config.getSteps()[1].getGroups()[2].getLabel()
		);
		
	}
	
	/* privates */
	
	private function _uut() {
		local.functions = structNew('linked'); //order matters
		local.functions.map = {
				enabled: true,
				mappedName: "$map"	
			};
		local.functions.structMap = {
				enabled: false,
				mappedName: "structMap"
			};
		return new root.cfc.InstallStepConfigurator(local.functions);
		
	}
}
component extends="root.tests.BaseTest" {
	
	variables.canonicalPath = getDirectoryFromPath( getCurrentTemplatePath() ) & "/canonical.fld";
	variables.testPath = getDirectoryFromPath( getCurrentTemplatePath() ) & "/test.fld";
	
	function testApplyingFormFields() {
		
		fileCopy( variables.canonicalPath, variables.testPath );
		
		_uut().apply( variables.testPath, _formFields() );
		local.functionSettings =_reader().readFunctionSettingsFromFLD( variables.testPath, variables.canonicalPath );
		
		assertEquals( actual: local.functionSettings.size(), expected: 4 );
		assertEquals( actual: local.functionSettings.structMap.mappedName,
					  expected: "all");
		assertEquals( actual: local.functionSettings.queryMap.mappedName,
					  expected: "$any");
		assertEquals( actual: local.functionSettings.arrayMap.mappedName,
					  expected: "_each");

		assertTrue( condition: local.functionSettings.structMap.enabled );
		assertTrue( condition: local.functionSettings.queryMap.enabled );
		assertTrue( condition: local.functionSettings.arrayMap.enabled );
		assertFalse( condition: local.functionSettings.map.enabled );
	}
	
	/* privates */
	
	private function _uut() {
		return new root.cfc.FunctionLibraryDescriptorApplier();
	}
	
	private function _reader() {
		return new root.cfc.FunctionLibraryDescriptorReader();
	}
	
	private function _formFields() {
		return {
			mixed: {
				enabled: {
					structMap: 'On',
					queryMap: 'On',
					arrayMap: 'On'
				},
				map: {
					structMap: 'all',
					queryMap: '$any',
					arrayMap: '_each',
					map: '$map'
				}
			}
		}
		
	}
}
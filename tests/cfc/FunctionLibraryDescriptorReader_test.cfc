component extends="root.tests.BaseTest" {
	
	variables.customPath = getDirectoryFromPath( getCurrentTemplatePath() ) & "/custom.fld";
	variables.canonicalPath = getDirectoryFromPath( getCurrentTemplatePath() ) & "/canonical.fld";
	
	function readFunctionSettingsShouldWorkOnFLD() {
		local.functionSettings =_uut().readFunctionSettingsFromFLD( variables.customPath, variables.canonicalPath );
		assertEquals( actual: local.functionSettings.size(), expected: 4 );
		assertEquals( actual: local.functionSettings.structMap.mappedName,
					  expected: "_StructMap");
		assertTrue( condition: local.functionSettings.structMap.enabled );
		assertFalse( condition: local.functionSettings.map.enabled ); //map should be disabled
	}
	
	/* privates */
	
	private function _uut() {
		return new root.cfc.FunctionLibraryDescriptorReader();
		
	}
}
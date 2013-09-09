<cfcomponent extends="tests.All.Base">

	<cffunction name="_query" access="private">
		<cfreturn query(column1:["bobby","mike","cally","moi"],column2:[1,7,48,9]) />
	</cffunction>

	<cffunction name="_lengthIsBiggerThanThree" access="private">
		<cfargument name="record">
		<cfreturn len(record.column1) gt 3 />
	</cffunction>

	<cffunction name="_lengthIsBiggerThanTwo" access="private">
		<cfargument name="record">
		<cfreturn len(record.column1) gt 2 />
	</cffunction>
</cfcomponent>
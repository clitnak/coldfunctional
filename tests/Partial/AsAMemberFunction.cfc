<cfcomponent extends="Base">

	<cffunction name="ShouldExecuteAddOne">
		<cfset local.plusOne = add.partial([1]) />
		<cfset local.six = local.plusOne(5) />
		<cfset local.random = randrange(1,20) />
		<cfset local.addedByOne =local.plusOne(local.random) />
		<cfset assertEquals(expected:6,actual:local.six) />
		<cfset assertEquals(expected:local.random+1,actual:local.addedByOne) />
	</cffunction>
	
	<cffunction name="ShouldExecuteSubtractOneWithNamedArguments">
		<cfset local.minusOne = subtract.partial({y:1}) />
		<cfset local.six = local.minusOne(7) />
		<cfset assertEquals(expected:6,actual:local.six) />
	</cffunction>	

	<cffunction name="ShouldPartialApplyNoArgs">
		<cfset local.fn = noargs.partial() />
		<cfset local.five = local.fn() />
		<cfset assertEquals(expected:5,actual:local.five) />
	</cffunction>	

	<cffunction name="ShouldFullyApplyOneArg">
		<cfset local.fn = onearg.partial({x:5}) />
		<cfset local.five = local.fn() />
		<cfset assertEquals(expected:5,actual:local.five) />
		
		<cfset local.fn = onearg.partial([5]) />
		<cfset local.five = local.fn() />
		<cfset assertEquals(expected:5,actual:local.five) />
	</cffunction>	

	<cffunction name="ApplyNamedArgumentsThenCallWithNamedArgumentsShouldPreferAppliedValues">
		<cfset local.fn = subtract.partial({y:1}) />
		<cfset local.six = local.fn(y:7,x:5) />
		<cfset assertEquals(expected:4,actual:local.six) />
	</cffunction>	

	<cffunction name="ShouldApplyUnNamedArgumentsThenCallWithNamedArguments">
		<cfset local.fn = subtract.partial([1]) />
		<cfset local.nsix = local.fn(y:7) />
		<cfset assertEquals(expected:-6,actual:local.nsix) />
	</cffunction>
	
	<cffunction name="ShouldApplyNamedArgumentsThenCallWithUnNamedArguments">
		<cfset local.fn = subtract.partial({y:1}) />
		<cfset local.six = local.fn(7) />
		<cfset assertEquals(expected:6,actual:local.six) />
	</cffunction>
	
	<cffunction name="ShouldApplyWithExcessNamedArgumentsThenCallWithExcessNamedArguments">
		<cfset local.fn = returnArgs.partial({bob:"1",argument1:"2"}) />
		<cfset local.result = local.fn(argument2:"3",bob4:"5")>
		<cfset assertEquals(expected:1, actual: local.result.bob) />
		<cfset assertEquals(expected:2, actual: local.result.argument1) />
		<cfset assertEquals(expected:3, actual: local.result.argument2) />
		<cfset assertEquals(expected:5, actual: local.result.bob4) />
	
	</cffunction>

	<cffunction name="ShouldApplyWithExcessUnNamedArgumentsThenCallWithExcessNamedArguments">
		<cfset local.fn = returnArgs.partial(["1","2","3"]) />
		<cfset local.result = local.fn(argument2:"4",bob4:"5")>
		<cfset assertEquals(expected:1, actual: local.result.argument1) />
		<cfset assertEquals(expected:2, actual: local.result.argument2) />
		<cfset assertEquals(expected:3, actual: local.result[3]) />
		<cfset assertEquals(expected:5, actual: local.result[4]) />
		<cfset assertEquals(expected:5, actual: local.result.bob4) />
	</cffunction>

	<cffunction name="ShouldApplyWithExcessUnNamedArgumentsThenCallWithExcessUnNamedArguments">
		<cfset local.fn = returnArgs.partial(["1","2","3"]) />
		<cfset local.result = local.fn("4","5")>
		<cfset assertEquals(expected:1, actual: local.result.argument1) />
		<cfset assertEquals(expected:2, actual: local.result.argument2) />
		<cfset assertEquals(expected:3, actual: local.result[3]) />
		<cfset assertEquals(expected:4, actual: local.result[4]) />		
		<cfset assertEquals(expected:5, actual: local.result[5]) />		
	</cffunction>
	
	<cffunction name="ShouldApplyWithExcessNamedArgumentsThenCallWithExcessUnNamedArguments">
		<cfset local.fn = returnArgs.partial({bob:"1",argument1:"2"}) />
		<cfset local.result = local.fn("3","5")>
		<cfset assertEquals(expected:1, actual: local.result.bob) />
		<cfset assertEquals(expected:2, actual: local.result.argument1) />
		<cfset assertEquals(expected:3, actual: local.result.argument2) />
		<cfset assertEquals(expected:5, actual: local.result[4]) />
	</cffunction>
	
</cfcomponent>
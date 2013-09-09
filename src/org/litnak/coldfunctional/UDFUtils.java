package org.litnak.coldfunctional;

import railo.commons.lang.CFTypes;
import railo.runtime.exp.ExpressionException;
import railo.runtime.type.FunctionArgument;
import railo.runtime.type.UDF;

public class UDFUtils {
	public static void assertUDFHasCorrectArguments(UDF fn,int[] argumentTypes) throws ExpressionException {
		FunctionArgument[] args = fn.getFunctionArguments();
		for (int i = 0; i < Math.min(args.length,argumentTypes.length); i++) {
			int expected = argumentTypes[i];
			int actual = args[i].getType();
			if(actual != CFTypes.TYPE_ANY && actual != expected) {
				
				throw new ExpressionException("function has an incorrect argument type. argument ["+(i+1)+"] is of type [" + CFTypes.toString(actual, "unknown") + "], but should be of type ["+CFTypes.toString(expected, "unknown")+"]");	
			}
		
			
		}
	}
	
	public static void assertReturnType(UDF fn, int type) throws ExpressionException {
		if (fn.getReturnType() != CFTypes.TYPE_ANY && fn.getReturnType() != type) {
			throw new ExpressionException("function should have a return type of [" + CFTypes.toString(type, "unkown") + "]");
		}
		
	}
}

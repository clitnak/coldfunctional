/**
 * Extends structs by adding a reduce() member function
 * 
 */
package org.litnak.coldfunctional.reduce;

import java.util.Iterator;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;

public class StructReduce extends BIF{

	private static final long serialVersionUID = -3247772368267641723L;

	public static Object call(PageContext pc , Struct sct, UDF reducer) throws PageException {
		if (sct.size() == 0) return new ExpressionException("struct provided to StructReduce must not be empty");
		Iterator<Object> i = sct.valueIterator();
		Object lastValue = null;
		boolean first = true;
		while(i.hasNext()) {
			Object nextValue = i.next();
			if(first) {
				lastValue = nextValue;
				first = false;
			} else {
				lastValue = reducer.call(pc,new Object[]{lastValue,nextValue},true);
			}
		}
		return lastValue;
	}
	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toStruct(args[0]),Caster.toFunction(args[1]));
	}
}

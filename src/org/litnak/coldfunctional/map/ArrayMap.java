/**
 * Extends arrays by adding a map() member function
 * 
 */
package org.litnak.coldfunctional.map;

import java.util.Iterator;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.Array;
import railo.runtime.type.ArrayImpl;
import railo.runtime.type.UDF;



public class ArrayMap extends BIF{

	private static final long serialVersionUID = 488028677292155155L;


	public static Array call(PageContext pc , Array arr, UDF mapper) throws PageException {
		Array result=new ArrayImpl();
		Iterator<Object> iterator = arr.valueIterator();
		while(iterator.hasNext()){
			Object value = iterator.next();
			result.append(mapper.call(pc, new Object[]{value}, true));
		}
		return result;
	}

	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toArray(args[0]),Caster.toFunction(args[1]));
	}
}

/**
 * Extends arrays by adding a map() member function
 * 
 */
package org.litnak.coldfunctional.all;

import java.util.Iterator;

import org.litnak.coldfunctional.UDFUtils;

import railo.commons.lang.CFTypes;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;



public class StructAll extends BIF{

	private static final long serialVersionUID = 5540797094043832911L;

	public static boolean call(PageContext pc , Struct struct, UDF udf) throws PageException {
		UDFUtils.assertReturnType(udf, CFTypes.TYPE_BOOLEAN);
		Iterator<Object> iterator = struct.valueIterator();
		boolean result = true;
		while(iterator.hasNext()){
			Object value = iterator.next();
			result = result && Caster.toBooleanValue(udf.call(pc, new Object[]{value}, true));
		}
		return result;
	}

	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toStruct(args[0]),Caster.toFunction(args[1]));
	}
}

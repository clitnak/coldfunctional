/**
 * Extends structs by adding a map() member function
 * 
 */
package org.litnak.coldfunctional.map;

import java.util.Iterator;
import java.util.Map.Entry;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.Struct;
import railo.runtime.type.StructImpl;
import railo.runtime.type.UDF;
import railo.runtime.type.Collection.Key;


public class StructMap extends BIF{

	private static final long serialVersionUID = 955605687252660489L;

	public static Struct call(PageContext pc , Struct sct, UDF mapper) throws PageException {
		Struct result=new StructImpl();
		Iterator<Entry<Key, Object>> iterator = sct.entryIterator();
		while(iterator.hasNext()){
			Entry<Key, Object> entry = iterator.next();
			result.set(entry.getKey(), mapper.call(pc, new Object[]{entry.getValue()}, true));
		}
		return result;
	}

	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toStruct(args[0]),Caster.toFunction(args[1]));
	}
}

/**
 * Extends queries by adding a each() member function
 * 
 */
package org.litnak.coldfunctional.each;

import railo.commons.lang.CFTypes;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.Query;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;

import org.litnak.coldfunctional.QueryUtils;
import org.litnak.coldfunctional.UDFUtils;


public class QueryEach extends BIF{

	private static final long serialVersionUID = -2608139449306721393L;


	public static Object call(PageContext pc , Query query, UDF eacher) throws PageException {
		UDFUtils.assertUDFHasCorrectArguments(eacher,new int[]{CFTypes.TYPE_STRUCT});
		
		for(int row=0; row < query.getRecordcount(); row++) {
			Struct record = QueryUtils.rowToStruct(query,row);
			eacher.call(pc, new Object[]{record}, true);
		}
		return null;
	}

	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toQuery(args[0]),Caster.toFunction(args[1]));
	}
}

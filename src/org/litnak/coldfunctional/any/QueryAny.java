/**
 * Extends arrays by adding a map() member function
 * 
 */
package org.litnak.coldfunctional.any;

import org.litnak.coldfunctional.QueryUtils;
import org.litnak.coldfunctional.UDFUtils;

import railo.commons.lang.CFTypes;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.Query;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;

public class QueryAny extends BIF{

	private static final long serialVersionUID = 7125254333356433820L;


	public static boolean call(PageContext pc , Query query, UDF udf) throws PageException {
		UDFUtils.assertUDFHasCorrectArguments(udf,new int[]{CFTypes.TYPE_STRUCT});
		UDFUtils.assertReturnType(udf, CFTypes.TYPE_BOOLEAN);
		boolean result = false;
		for(int row=0; row < query.getRecordcount(); row++) {
			Struct record = QueryUtils.rowToStruct(query,row);
			result = Caster.toBooleanValue(udf.call(pc, new Object[]{record},true));
			if(result) break;
		}
		return result;
	}

	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toQuery(args[0]),Caster.toFunction(args[1]));
	}
}

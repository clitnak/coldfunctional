/**
 * Extends queries by adding a map() member function
 * 
 */
package org.litnak.coldfunctional.map;

import railo.commons.lang.CFTypes;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.Collection.Key;
import railo.runtime.type.Query;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;

import org.litnak.coldfunctional.QueryUtils;
import org.litnak.coldfunctional.UDFUtils;


public class QueryMap extends BIF{

	private static final long serialVersionUID = -1452208018702705428L;


	public static Query call(PageContext pc , Query query, UDF mapper) throws PageException {
		UDFUtils.assertUDFHasCorrectArguments(mapper,new int[]{CFTypes.TYPE_STRUCT});
		UDFUtils.assertReturnType(mapper, CFTypes.TYPE_STRUCT);
		Query result = QueryUtils.cloneQueryWithoutData(query);
		Key[] columns = result.getColumnNames();
		for(int row=0; row < query.getRecordcount(); row++) {
			Struct record = QueryUtils.rowToStruct(query,row);
			result.addRow();
			Object response = mapper.call(pc, new Object[]{record},true);
			if (!Decision.isStruct(response)) {
				throw Caster.toPageException(new ExpressionException("mapper function for QueryMap() did not return a struct"));
				
			}
			Struct mappedResponse = Caster.toStruct(response);
			for(Key column : columns) {
				if(mappedResponse.containsKey(column)) {
					result.setAt(column, result.getRecordcount(),mappedResponse.get(column));
				}
			}
			
		}
		return result;
	}

	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toQuery(args[0]),Caster.toFunction(args[1]));
	}
}

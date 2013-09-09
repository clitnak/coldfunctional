/**
 * Extends queries by adding a filter() member function
 * 
 */
package org.litnak.coldfunctional.filter;

import railo.commons.lang.CFTypes;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.Collection.Key;
import railo.runtime.type.Query;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;

import org.litnak.coldfunctional.QueryUtils;
import org.litnak.coldfunctional.UDFUtils;


public class QueryFilter extends BIF{

	private static final long serialVersionUID = -6796466659737981100L;

	public static Query call(PageContext pc , Query query, UDF filter) throws PageException {
		UDFUtils.assertUDFHasCorrectArguments(filter,new int[]{CFTypes.TYPE_STRUCT});
		UDFUtils.assertReturnType(filter, CFTypes.TYPE_BOOLEAN);
		Query result = QueryUtils.cloneQueryWithoutData(query);
		Key[] columns = result.getColumnNames();
		for(int row=0; row < query.getRecordcount(); row++) {
			Struct record = QueryUtils.rowToStruct(query,row);
			boolean response = Caster.toBooleanValue(filter.call(pc, new Object[]{record},true));
			if (response) {
				result.addRow();
				for(Key column : columns) {
					result.setAt(column, result.getRecordcount(),record.get(column));
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

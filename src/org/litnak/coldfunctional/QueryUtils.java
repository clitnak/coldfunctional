package org.litnak.coldfunctional;

import railo.runtime.exp.PageException;
import railo.runtime.type.Query;
import railo.runtime.type.QueryImpl;
import railo.runtime.type.Collection.Key;
import railo.runtime.type.Struct;
import railo.runtime.type.StructImpl;
public class QueryUtils {

	public static Query cloneQueryWithoutData(Query query) throws PageException {
		return new QueryImpl(query.getColumnNames(),0,query.getName());
	}

	public static Struct rowToStruct(Query query, int row) throws PageException {
		Struct result = new StructImpl();
		for(Key column : query.getColumnNames()) {
			result.set(column, query.getAt(column,row+1));
		}
		return result;
	}
}

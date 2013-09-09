package org.litnak.coldfunctional.filter;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.ext.function.Function;
import railo.runtime.functions.arrays.ArrayFilter;
import railo.runtime.functions.struct.StructFilter;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.UDF;
public class Filter implements Function {

	private static final long serialVersionUID = 5775799703406626794L;

	public static Object call(PageContext pc , Object obj, UDF mapper) throws PageException {
		if(Decision.isArray(obj)) return ArrayFilter.call(pc, Caster.toArray(obj), mapper);
		if(Decision.isStruct(obj)) return StructFilter.call(pc, Caster.toStruct(obj), mapper);
		if(Decision.isQuery(obj)) return QueryFilter.call(pc, Caster.toQuery(obj), mapper);	
		throw new ExpressionException("first argument provided to filter() must be an array, struct, or query");
	}
}

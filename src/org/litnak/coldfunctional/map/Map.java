package org.litnak.coldfunctional.map;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.ext.function.Function;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.UDF;
public class Map implements Function {

	private static final long serialVersionUID = -7188149755108299559L;
	public static Object call(PageContext pc , Object obj, UDF mapper) throws PageException {
		if(Decision.isArray(obj)) return ArrayMap.call(pc, Caster.toArray(obj), mapper);
		if(Decision.isStruct(obj)) return StructMap.call(pc, Caster.toStruct(obj), mapper);
		if(Decision.isQuery(obj)) return QueryMap.call(pc, Caster.toQuery(obj), mapper);	
		throw new ExpressionException("first argument provided to map() must be an array, struct, or query");
	}
}

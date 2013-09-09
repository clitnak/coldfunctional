package org.litnak.coldfunctional.any;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.ext.function.Function;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.UDF;
public class Any implements Function {

	private static final long serialVersionUID = -3428487654072146848L;

	public static boolean call(PageContext pc , Object obj, UDF udf) throws PageException {
		if(Decision.isArray(obj)) return ArrayAny.call(pc, Caster.toArray(obj), udf);
		if(Decision.isStruct(obj)) return StructAny.call(pc, Caster.toStruct(obj), udf);
		if(Decision.isQuery(obj)) return QueryAny.call(pc, Caster.toQuery(obj), udf);	
		throw new ExpressionException("first argument provided to any() must be an array, struct, or query");
	}
}

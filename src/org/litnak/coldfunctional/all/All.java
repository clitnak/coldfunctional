package org.litnak.coldfunctional.all;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.ext.function.Function;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.UDF;
public class All implements Function {

	private static final long serialVersionUID = 493187912832406872L;

	public static boolean call(PageContext pc , Object obj, UDF udf) throws PageException {
		if(Decision.isArray(obj)) return ArrayAll.call(pc, Caster.toArray(obj), udf);
		if(Decision.isStruct(obj)) return StructAll.call(pc, Caster.toStruct(obj), udf);
		if(Decision.isQuery(obj)) return QueryAll.call(pc, Caster.toQuery(obj), udf);	
		throw new ExpressionException("first argument provided to all() must be an array, struct, or query");
	}
}

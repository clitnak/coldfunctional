package org.litnak.coldfunctional.reduce;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.ext.function.Function;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.UDF;
public class Reduce implements Function {

	private static final long serialVersionUID = 8313215013653283399L;

	public static Object call(PageContext pc , Object obj, UDF mapper) throws PageException {
		if(Decision.isArray(obj)) return ArrayReduce.call(pc, Caster.toArray(obj), mapper);
		if(Decision.isStruct(obj)) return StructReduce.call(pc, Caster.toStruct(obj), mapper);
		throw new ExpressionException("first argument provided to reduce() must be an array or struct");
	}
}

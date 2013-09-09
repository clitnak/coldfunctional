package org.litnak.coldfunctional.each;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.ext.function.Function;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.UDF;
public class Each implements Function {

	private static final long serialVersionUID = -8363124300451973548L;

	public static Object call(PageContext pc , Object obj, UDF eacher) throws PageException {
		if(Decision.isQuery(obj)) return QueryEach.call(pc, Caster.toQuery(obj), eacher);
		return railo.runtime.functions.closure.Each.call(pc, obj, eacher);
	}
}

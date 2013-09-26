package org.litnak.coldfunctional.once;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.type.UDF;
public class Once extends BIF {
	private static final long serialVersionUID = -2329816153430600470L;

	public static UDF call(PageContext pc , UDF udf) throws PageException {
		return new Wrapper(udf);
	}

	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,Caster.toFunction(args[0]));
	}


}

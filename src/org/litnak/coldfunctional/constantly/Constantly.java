package org.litnak.coldfunctional.constantly;
import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.type.UDF;
public class Constantly extends BIF {

	public static UDF call(PageContext pc , Object obj) throws PageException {
		return new Wrapper(obj);
	}

	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		return call(pc,args[0]);
	}


}

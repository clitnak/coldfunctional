package org.litnak.coldfunctional.constantly;

import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.type.Closure;
import railo.runtime.type.Collection.Key;
import railo.runtime.type.Struct;

public class Wrapper extends Closure{

	private Object result;
	public Wrapper(Object _result) {
		result = _result;
	}
	
	@Override
	public Object callWithNamedValues(PageContext pageContext, Struct values,
			boolean doIncludePath) throws PageException {
		return result;
	}
	
	@Override
	public Object callWithNamedValues(PageContext pageContext, Key calledName,
			Struct values, boolean doIncludePath) throws PageException {
		return result;
	}

	@Override
	public Object call(PageContext pageContext, Object[] args,
			boolean doIncludePath) throws PageException {
		return result;
	}

	@Override
	public Object call(PageContext pageContext, Key calledName, Object[] args,
			boolean doIncludePath) throws PageException {
		return result;
	}

}

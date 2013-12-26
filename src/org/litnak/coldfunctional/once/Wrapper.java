package org.litnak.coldfunctional.once;

import org.litnak.coldfunctional.AbstractFunctionWrapper;

import railo.runtime.PageContext;
import railo.runtime.exp.PageException;
import railo.runtime.type.Collection.Key;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;
import railo.runtime.type.UDFPlus;

public class Wrapper extends AbstractFunctionWrapper{

	private boolean executed;
	private Object result;
	public Wrapper(UDF _udf) {
		/*
		 * Railo casts UDF to UDFPlus in several places. UDFImpl implements UDFPlus.
		 if(member instanceof UDF) {
            return _call(pc,key,(UDFPlus)member,namedArgs,args);
        }
		  
		 */
		
		this.udf = (UDFPlus)_udf;
		executed = false;
	}
	
	@Override
	public Object callWithNamedValues(PageContext pageContext, Struct values,
			boolean doIncludePath) throws PageException {
		if(!executed) {
			result = udf.callWithNamedValues(pageContext, values, doIncludePath);
			executed = true;
		}
		return result;
	}
	
	@Override
	public Object callWithNamedValues(PageContext pageContext, Key calledName,
			Struct values, boolean doIncludePath) throws PageException {
		if(!executed) {
			result = udf.callWithNamedValues(pageContext, calledName, values, doIncludePath);
			executed = true;
		}
		return result;
	}

	@Override
	public Object call(PageContext pageContext, Object[] args,
			boolean doIncludePath) throws PageException {
		if(!executed) {
			result = udf.call(pageContext, args, doIncludePath);
			executed = true;
		}
		return result;
	}

	@Override
	public Object call(PageContext pageContext, Key calledName, Object[] args,
			boolean doIncludePath) throws PageException {
		if(!executed) {
			result = udf.call(pageContext, calledName, args, doIncludePath);
			executed = true;
		}
		return result;
	}

}

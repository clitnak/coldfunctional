package org.litnak.coldfunctional.partial;
import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.functions.BIF;
import railo.runtime.op.Caster;
import railo.runtime.op.Decision;
import railo.runtime.type.Array;
import railo.runtime.type.ArrayImpl;
import railo.runtime.type.FunctionValue;
import railo.runtime.type.KeyImpl;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;
public class PartialFunction extends BIF {
	private static final long serialVersionUID = -2329816153430600470L;

	public static UDF call(PageContext pc, UDF udf, Object args ) throws PageException {
		if( Decision.isArray( args ) ) return call(pc,udf, Caster.toArray( args ));
		if( Decision.isStruct( args ) ) return call(pc,udf, Caster.toStruct( args ));
		throw new ExpressionException("first argument provided to all() must be an array, struct, or query");
	}	
	
	public static UDF call(PageContext pc, UDF udf, Struct args ) throws PageException {
		return new Wrapper(udf,args);
	}
	
	public static UDF call(PageContext pc, UDF udf ) throws PageException {
		return new Wrapper(udf);
	}
	
	public static UDF call(PageContext pc, UDF udf, Array args ) throws PageException {
		return new Wrapper(udf,args);
	}

	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		UDF udf = Caster.toFunction(args[0]);
		if(args.length == 1) return call(pc,udf);
		return call( pc, udf, args[1] );
	}

	
	

}

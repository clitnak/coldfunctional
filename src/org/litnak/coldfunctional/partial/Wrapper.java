package org.litnak.coldfunctional.partial;

import java.util.Iterator;

import org.litnak.coldfunctional.AbstractFunctionWrapper;

import railo.runtime.PageContext;
import railo.runtime.exp.ExpressionException;
import railo.runtime.exp.PageException;
import railo.runtime.op.Decision;
import railo.runtime.type.Array;
import railo.runtime.type.Collection.Key;
import railo.runtime.type.FunctionArgument;
import railo.runtime.type.KeyImpl;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;
import railo.runtime.type.UDFPlus;
import railo.runtime.type.scope.ArgumentImpl;

public class Wrapper extends AbstractFunctionWrapper {

	private ArgumentImpl appliedArgs;
	//private Array appliedExcessArgs = new ArrayImpl();
		// unnamed args applied that are in excess of the number of 
		// named args in the function being applied
	
	public Wrapper(UDF _udf) {
		_init(_udf,new ArgumentImpl());
	}

	public Wrapper(UDF _udf, Array args) throws PageException {
		FunctionArgument[] arguments = _udf.getFunctionArguments();
		ArgumentImpl newArgs = new ArgumentImpl();
		
		for(int i = 0; i < args.size() ; i ++) {
			Object arg = args.getE(i+1);
			if(i < arguments.length) {
				newArgs.setEL(arguments[i].getName(), arg);
			} else {
				newArgs.appendEL( arg );
			}
		}
		_init(_udf,newArgs);
	}

	public Wrapper(UDF _udf, Struct args) throws PageException {
		ArgumentImpl newArgs = new ArgumentImpl();
	    Iterator<Key> it = args.keyIterator();
	    Key key;
	   
	    while(it.hasNext()) {
			key=it.next();
			newArgs.setEL(key, args.get(key));
	    }
		_init(_udf,newArgs);
	}


	
	private void _init(UDF _udf, ArgumentImpl args) {
		this.udf = (UDFPlus)_udf;
		appliedArgs = args;
		
	}

	@Override
	public Object callWithNamedValues(PageContext pageContext, Struct values,
			boolean doIncludePath) throws PageException {
		return udf.callWithNamedValues(pageContext, _applyVars(values), doIncludePath);
	}

	@Override
	public Object callWithNamedValues(PageContext pageContext, Key calledName,
			Struct values, boolean doIncludePath) throws PageException {
		return udf.callWithNamedValues(pageContext, calledName, _applyVars(values), doIncludePath);
	}

	@Override
	public Object call(PageContext pageContext, Object[] args,
			boolean doIncludePath) throws PageException {
		return udf.callWithNamedValues(pageContext, _applyVars(args), doIncludePath);
		
	}

	@Override
	public Object call(PageContext pageContext, Key calledName, Object[] args,
			boolean doIncludePath) throws PageException {
		return udf.callWithNamedValues(pageContext, calledName, _applyVars(args), doIncludePath);

	}

	
	private Struct _applyVars(Object[] args) throws PageException {
		//duplicate appliedArgs
		//for each original argument, i
			// if original argument is already in applied args... skip.
		    // else original argument is filled in applied args by the next arg supplied by args
		// for each remaining argument in args
		    // fill appliedargs with new value
		ArgumentImpl newArgs = new ArgumentImpl();
		
		// fill args in order of the original functions arguments
		FunctionArgument[] originalArgs = udf.getFunctionArguments();
		int i=0;
		for( FunctionArgument originalArg : originalArgs) {
			Key key = originalArg.getName();
			if ( appliedArgs.containsKey( key ) ) {
				newArgs.setEL( key, appliedArgs.get( key ) );
			} else if ( i < args.length ) {
				newArgs.setEL( key, args[i] );
				i++;
			}
		}

		// any leftovers in the original arguments need to be applied
		Iterator<Key> keys = appliedArgs.keyIterator();
		while( keys.hasNext() ) {
			Key key = keys.next();
			Object val = appliedArgs.get( key );
			if ( Decision.isNumeric( key.getLowerString() ) ) {
				newArgs.append( val );
			} else if ( !newArgs.containsKey( key ) ) {
				newArgs.setEL( key, val );
			}
		}
		
		// any leftovers in the provided args need to be applied as well
		for( int ii = i ; ii < args.length ; ii++ ) {
			newArgs.appendEL( args[ii] );
		}
		
		return newArgs;
	}

	private Struct _applyVars(Struct values) throws PageException  {
		Iterator<Key> keys = values.keyIterator();
		ArgumentImpl newArgs = _duplicate( appliedArgs );
		while( keys.hasNext() ) {
			Key key = keys.next();
			if( !newArgs.containsKey(key) ) {
				newArgs.setEL(key, values.get(key));
			}
		}
		return newArgs;
	}
	
	private static Object[] _toArray (ArgumentImpl args) throws PageException {
		Object[] result = new Object[args.size()];
		for (int i = 0; i < args.size(); i++ ) {
			result[i] = args.getE( i + 1 );
		}
		return result;
	}
	private static ArgumentImpl _duplicate(ArgumentImpl args) throws ExpressionException {
	    Iterator<Key> it = args.keyIterator();
	    ArgumentImpl result = new ArgumentImpl();
	    while(it.hasNext()) {
	        Key key = it.next();
        	result.setEL(key,args.get(key));
	    }
	    return result;
	}
}

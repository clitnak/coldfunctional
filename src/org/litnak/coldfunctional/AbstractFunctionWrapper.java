package org.litnak.coldfunctional;

import railo.runtime.Component;
import railo.runtime.ComponentImpl;
import railo.runtime.PageContext;
import railo.runtime.PageSource;
import railo.runtime.dump.DumpData;
import railo.runtime.dump.DumpProperties;
import railo.runtime.exp.PageException;
import railo.runtime.type.FunctionArgument;
import railo.runtime.type.Struct;
import railo.runtime.type.UDF;
import railo.runtime.type.UDFPlus;
import railo.runtime.type.Collection.Key;

public abstract class AbstractFunctionWrapper  implements UDFPlus { 

	private static final long serialVersionUID = -5305872728144533697L;
	protected UDFPlus udf;
	@Override
	public DumpData toDumpData(PageContext pc, int maxlevel,
			DumpProperties properties) {
		return udf.toDumpData(pc,maxlevel,properties);
	}

	@Override
	public int getAccess() {
		return this.udf.getAccess();
	}

	@Override
	public Object getValue() {
		return this.udf.getValue();
	}

	@Override
	public Object implementation(PageContext pageContext) throws Throwable {
		return this.udf.implementation(pageContext);
	}

	@Override
	public FunctionArgument[] getFunctionArguments() {
		return this.udf.getFunctionArguments();
	}

	@Override
	public Object getDefaultValue(PageContext pc, int index)
			throws PageException {
		return this.udf.getDefaultValue(pc,index);
	}

	@Override
	public String getFunctionName() {
		return this.udf.getFunctionName();
	}

	@Override
	public boolean getOutput() {
		return this.udf.getOutput();
	}

	@Override
	public int getReturnType() {
		return this.udf.getReturnType();
	}

	@Override
	public int getReturnFormat() {
		return this.udf.getReturnFormat();
	}

	@Override
	public Boolean getSecureJson() {
		return this.udf.getSecureJson();
	}

	@Override
	public Boolean getVerifyClient() {
		return this.udf.getVerifyClient();
	}

	@Override
	public String getReturnTypeAsString() {
		return this.udf.getReturnTypeAsString();
	}

	@Override
	public String getDescription() {
		return this.udf.getDescription();
	}



	@Override
	public String getDisplayName() {
		return this.udf.getDisplayName();
	}

	@Override
	public String getHint() {
		return this.udf.getHint();
	}

	@Override
	public PageSource getPageSource() {
		return this.udf.getPageSource();
	}

	@Override
	public Struct getMetaData(PageContext pc) throws PageException {
		return this.udf.getMetaData(pc);
	}

	@Override
	public UDF duplicate() {
		return this.udf.duplicate();
	}

	@SuppressWarnings("deprecation")
	@Override
	public Component getOwnerComponent() {
		return this.udf.getOwnerComponent();
	}



	@Override
	public Object getDefaultValue(PageContext pc, int index, Object defaultValue)
			throws PageException {
		return this.udf.getDefaultValue(pc, index, defaultValue);
	}

	@Override
	public int getIndex() {
		return this.udf.getIndex();
	}

	@Override
	public void setOwnerComponent(ComponentImpl component) {
		this.udf.setOwnerComponent(component);
		
	}

	@Override
	public void setAccess(int access) {
		this.udf.setAccess(access);
	}

	@Override
	public Object callMemberFunction(PageContext pc, Key key, Struct args)
			throws PageException {
		return this.udf.callMemberFunction(pc, key, args);
	}

	@Override
	public Object callMemberFunction(PageContext pc, Key key, Object[] args)
			throws PageException {
		return this.udf.callMemberFunction(pc, key, args);
	}

	@Override
	public int getReturnFormat(int defaultFormat) {
		return this.udf.getReturnFormat(defaultFormat);
	}

}

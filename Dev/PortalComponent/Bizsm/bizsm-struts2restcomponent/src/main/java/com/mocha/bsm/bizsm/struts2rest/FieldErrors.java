package com.mocha.bsm.bizsm.struts2rest;

import java.util.ArrayList;
import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamImplicit;
@XStreamAlias("FieldErrors")
public class FieldErrors {
	@XStreamImplicit
	public List<FieldError> fieldErrors;
	public FieldErrors(){
		this.fieldErrors = new ArrayList<FieldError>();
	}
	
	public void addFieldError(FieldError fieldError){
		this.fieldErrors.add(fieldError);
	}

	public List<FieldError> getFieldError() {
		return fieldErrors;
	}
	
	
}

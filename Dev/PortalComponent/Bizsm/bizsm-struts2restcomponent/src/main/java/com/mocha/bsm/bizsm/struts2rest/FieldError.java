package com.mocha.bsm.bizsm.struts2rest;

import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamImplicit;

@XStreamAlias("FieldError")
public class FieldError {
	@XStreamAlias("FieldId")
	public String fieldId;
	
	@XStreamImplicit(itemFieldName="ErrorInfo")
	public List<String> fieldErrors;
	
	public FieldError(String fieldId,List<String> fieldErrors){
		this.fieldId = fieldId;
		this.fieldErrors = fieldErrors;
	}
	
	public String getFieldId() {
		return fieldId;
	}
	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}
	public List<String> getFieldErrors() {
		return fieldErrors;
	}
	public void setFieldErrors(List<String> fieldErrors) {
		this.fieldErrors = fieldErrors;
	}
	
	
}

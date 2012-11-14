package com.mocha.bsm.bizsm.struts2rest;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamImplicit;


/**
 * 代表交验的错误信息
 * 目标是能让该错误信息序列化为
 * 比较好一些的格式
 * @author liuyong
 *
 */
@XStreamAlias("ValidateErrors")
public class ValidateErrors {
	
	@XStreamAlias("FieldErrors")
	public FieldErrors fieldErrors;
	
	@XStreamAlias("ActionErrors")
	@XStreamImplicit(itemFieldName="ActionErrorInfo")
	public List<String> actionErrors;
	
	public ValidateErrors(Collection<String> actionErrors,Map<String, List<String>> fieldErrorsMap){
		this.actionErrors = new ArrayList<String>();
		if(actionErrors!=null){
			for (String actionError:actionErrors) {
				this.actionErrors.add(actionError);
			}			
		}
		this.fieldErrors = new FieldErrors();
		if(fieldErrors!=null){
			for (Map.Entry<String, List<String>> entry : fieldErrorsMap.entrySet()) {
				fieldErrors.addFieldError(new FieldError(entry.getKey(),entry.getValue()));
			}			
		}
	}
	
	public FieldErrors getFieldErrors() {
		return fieldErrors;
	}
	
	public List<String> getActionErrors() {
		return actionErrors;
	}
	

	
}

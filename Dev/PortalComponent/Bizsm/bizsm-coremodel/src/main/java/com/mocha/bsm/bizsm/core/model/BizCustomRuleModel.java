/**
 * 
 */
package com.mocha.bsm.bizsm.core.model;

/**
 * @author liuhw
 *
 */
public class BizCustomRuleModel {
	//服务id，资源id，
	private String id = "";
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getDescID() {
		return descID;
	}
	public void setDescID(String descID) {
		this.descID = descID;
	}
	
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	//展示id
	private String descID = "";
	//显示值
	private String value = "";
}

package com.mocha.bsm.bizsm.db4otemplate.database;

/**
 * 环境根路径,用来初始化环境
 * @author liuyong
 */
public class ContextRoot implements IContextRoot{
	
	private String contextRoot;
	
	public void setContextRoot(String contextRoot){
		this.contextRoot = contextRoot;
	}
	
	public String getContextRoot(){
		return this.contextRoot;
	}
}

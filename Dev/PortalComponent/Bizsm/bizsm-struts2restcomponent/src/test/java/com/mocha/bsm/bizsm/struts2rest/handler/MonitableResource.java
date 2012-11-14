package com.mocha.bsm.bizsm.struts2rest.handler;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 可监控资源
 * @author liuyong
 * @version 1.0
 */
@XStreamAlias("MonitableResource")
public class MonitableResource {
	
	private String resourceInstanceId;
	
	public MonitableResource(String resourceInstanceId){
		this.resourceInstanceId = resourceInstanceId;
	}
	
	public String getResourceInstanceId(){
		return this.resourceInstanceId;
	}
}
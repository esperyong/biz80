package com.mocha.bsm.bizsm.core.model;

import com.thoughtworks.xstream.annotations.XStreamAlias;

public class GraphInfo {
	
	@XStreamAlias("Info")
	private String info;

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
	
	
}

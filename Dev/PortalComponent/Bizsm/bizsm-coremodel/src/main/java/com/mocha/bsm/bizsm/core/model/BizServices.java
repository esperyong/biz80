package com.mocha.bsm.bizsm.core.model;

import java.util.ArrayList;
import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.annotations.XStreamImplicit;
@XStreamAlias("BizServices")
public class BizServices {
	@XStreamImplicit
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	@XStreamAlias("services")
	private List<BizService> services;
	
	public BizServices(List<BizService> services){
		this.services = services;
	}
	
	public BizServices(){
		this.services = new ArrayList<BizService>();
	}
	
	public List<BizService> getServices(){
		return this.services;
	}
	
	public void addService(BizService service){
		this.services.add(service);
	}
	
	/**
	 * 获得总数
	 * @return
	 */
	public int getServiceNum(){
		return this.services.size();
	}
	
	public boolean contains(BizService father){
		return this.services.contains(father);
	}
	
}

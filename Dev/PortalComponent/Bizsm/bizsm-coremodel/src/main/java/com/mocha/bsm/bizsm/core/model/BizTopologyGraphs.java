package com.mocha.bsm.bizsm.core.model;

import java.util.ArrayList;
import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.annotations.XStreamImplicit;

@XStreamAlias("BizTopologyGraphs")
public class BizTopologyGraphs {
	
	@XStreamImplicit
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	private List<BizTopologyGraph> topos;
	
	public BizTopologyGraphs(List<BizTopologyGraph> topos){
		this.topos = topos;
	}
	
	public BizTopologyGraphs(){
		this.topos = new ArrayList<BizTopologyGraph>();
	}
	
	public List<BizTopologyGraph> getTopos(){
		return this.topos;
	}
	
	public void addTopo(BizTopologyGraph topo){
		this.topos.add(topo);
	}
	
	/**
	 * 获得总数
	 * @return
	 */
	public int getTopoNum(){
		return this.topos.size();
	}
	
	public boolean contains(BizTopologyGraph topo){
		return this.topos.contains(topo);
	}	
}

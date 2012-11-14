package com.mocha.bsm.bizsm.core.model;
import java.util.Set;
import java.util.TreeSet;

import com.mocha.bsm.bizsm.db4otemplate.core.IRefreshable;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
//import com.thoughtworks.xstream.annotations.XStreamImplicit;

/**
 * 业务单位
 * @author liuyong
 * @version 1.0
 */
@XStreamAlias("BizUser")
public class BizUser  implements IRefreshable{
	
	@XStreamAlias("name")
	private String name;
	
	@XStreamAlias("id")
	private String id;
	
	@XStreamAlias("uri")
	private String uri;
	
	@XStreamAlias("ips")
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.TreeSetConverter.class)
	private Set<IPv4> ips;
	
	@XStreamAlias("vlsms")
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.TreeSetConverter.class)
	private Set<VLSM> vlsms;
	
	public BizUser(){
		this.ips = new TreeSet<IPv4>();
		this.vlsms = new TreeSet<VLSM>();
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
		this.uri = "/bizuser/" + this.id;
	}

	public Set<IPv4> getIps() {
		return ips;
	}
	
	public void addIp(IPv4 ip){
		this.ips.add(ip);
	}
	
	public void setIps(Set<IPv4> ips) {
		this.ips = ips;
	}

	public Set<VLSM> getVlsms() {
		return vlsms;
	}

	public void setVlsms(Set<VLSM> vlsms) {
		this.vlsms = vlsms;
	}
	
	public void addVlsm(VLSM vlsm){
		this.vlsms.add(vlsm);
	}
	
	public String getUri() {
		return uri;
	}

	public void refresh(IRefreshable newObj){
		if(newObj instanceof BizUser){
			BizUser newUser = (BizUser)newObj;
			String name = newUser.getName();
			if(name!=null){
				this.setName(name);
			}
			
			Set<IPv4> ips = newUser.getIps();
			this.setIps(ips);
			
			Set<VLSM> vlsms = newUser.getVlsms();
			this.setVlsms(vlsms);
		}
	}
	
    public int hashCode() {
    	return this.id.hashCode()*13;
    }
    
    public boolean equals(Object anObject) {
    	if (this == anObject) {
    	    return true;
    	}
    	if (anObject instanceof BizUser) {
    		BizUser anotherBizUser = (BizUser)anObject;
    	    if(anotherBizUser.id !=null && anotherBizUser.id.equals(this.id)){
    	    	return true;	
    	    }
    	}
    	return false;
    }	
	
}
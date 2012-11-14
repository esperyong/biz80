package com.mocha.bsm.bizsm.core.model;

import java.util.ArrayList;
import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.annotations.XStreamImplicit;
@XStreamAlias("BizUsers")
public class BizUsers {
	@XStreamImplicit
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	private List<BizUser> users;
	
	public BizUsers(List<BizUser> users){
		this.users = users;
	}
	
	public BizUsers(){
		this.users = new ArrayList<BizUser>();
	}
	
	public List<BizUser> getUsers(){
		return this.users;
	}
	
	public void addUser(BizUser service){
		this.users.add(service);
	}

}

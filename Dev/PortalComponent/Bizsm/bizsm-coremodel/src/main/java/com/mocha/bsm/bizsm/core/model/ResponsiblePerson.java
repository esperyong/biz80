package com.mocha.bsm.bizsm.core.model;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 负责人 normally BizService
 * @author liuyong
 *
 */
@XStreamAlias("ResponsiblePerson")
public class ResponsiblePerson {
	
	@XStreamAlias("id")
	private String id;
	
	@XStreamAlias("name")
	private String name;
	
	@XStreamAlias("telephoneNumber")
	private String telephoneNumber;
	
	@XStreamAlias("emailAddress")
	private String emailAddress;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelephoneNumber() {
		return telephoneNumber;
	}
	public void setTelephoneNumber(String telephoneNumber) {
		this.telephoneNumber = telephoneNumber;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	
}

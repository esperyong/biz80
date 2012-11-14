package com.mocha.bsm.bizsm.web.action.rest;

import com.mocha.bsm.bizsm.core.model.state.BizServiceState;
import com.mocha.bsm.bizsm.core.model.state.ConfStateCal;
import com.mocha.bsm.bizsm.struts2rest.DefaultHttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.support.RestResourceSupport;
import com.mocha.bsm.bizsm.core.service.ConfStateCalManager;
import com.opensymphony.xwork2.Action;
/**
 * 资源:(业务服务自定义状态规则)
 * @author liuyong
 *
 */
public class BizServiceConfStateCalResource extends RestResourceSupport{
	
	private ConfStateCal model = new ConfStateCal(BizServiceState.UNKNOWN);
	
	private ConfStateCalManager confStateCalManager;
	
	public void setConfStateCalManager(ConfStateCalManager confStateCalManager){
		this.confStateCalManager = confStateCalManager;
	}
	
	private String bizservice;
	
	public String getBizservice() {
		return bizservice;
	}
	
	public void setBizservice(String bizservice) {
		this.bizservice = bizservice;
	}
	
	/**
	 * GET 
	 * 	/bizservice/{serviceid}/bizservice-confstatecal/SERIOUS
	 * 	or
	 *  /bizservice/{serviceid}/bizservice-confstatecal/WARNING
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#view()
	 */
	public HttpHeaders view() {
		String stateExpect = this.getId();
		String bizServiceId = this.getBizservice();
		BizServiceState expectedState = BizServiceState.valueOf(stateExpect);
		this.model = this.confStateCalManager.getStateCal(this.getBizservice(), expectedState);
		return new DefaultHttpHeaders(Action.NONE).disableCaching();
	}
	
	/**
	 * PUT /bizservice/{serviceid}/bizservice-confstatecal/SERIOUS
	 * @return
	 */
	public HttpHeaders createOrUpdate(){
		String stateExpect = this.getId();
		String bizServiceId = this.getBizservice();
		BizServiceState expectedState = BizServiceState.valueOf(stateExpect);
		this.model.setExpectedState(expectedState);
		this.confStateCalManager.saveStateCal(bizServiceId, this.model);
		return new DefaultHttpHeaders(Action.NONE).disableCaching();
	}
	
	public Object getModel(){
		return this.model;
	}	
}

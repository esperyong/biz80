/**
 * 
 */
package com.mocha.bsm.bizsm.web.action.rpc;

import com.mocha.bsm.bizsm.core.model.BizCustomRuleModel;
import com.mocha.bsm.bizsm.core.service.BizServiceManager;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author liuhw
 *
 */
public class BizStatusDefineService extends ActionSupport {
	private BizServiceManager bizServiceManager;
	public BizServiceManager getBizServiceManager() {
		return bizServiceManager;
	}
	public void setBizServiceManager(BizServiceManager bizServiceManager) {
		this.bizServiceManager = bizServiceManager;
	}

	//服务id
	private String serviceId;

	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	
	private BizCustomRuleModel ruleModel; 
	
	public BizCustomRuleModel getRuleModel() {
		return ruleModel;
	}
	public void setRuleModel(BizCustomRuleModel ruleModel) {
		this.ruleModel = ruleModel;
	}
	
	/**
	 * 根据服务id获得服务拓扑上的服务和资源信息
	 * @return
	 */
	public String getServiceTopologyByID(){
		this.ruleModel = new BizCustomRuleModel();
		this.ruleModel.setDescID("descID");
		this.ruleModel.setId("123");
		this.ruleModel.setValue("value");
		return "custom";
	}

}

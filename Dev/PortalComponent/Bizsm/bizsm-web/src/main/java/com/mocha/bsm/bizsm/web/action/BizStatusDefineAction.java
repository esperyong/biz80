/**
 * 
 */
package com.mocha.bsm.bizsm.web.action;

import com.mocha.bsm.bizsm.core.service.BizServiceManager;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 状态定义
 * @author liuhw
 *
 */
public class BizStatusDefineAction extends ActionSupport {

	private BizServiceManager bizServiceManager;
	//服务id
	private String serviceId;

	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	
	/**
	 * 跳转到自定义规则页面
	 * @return
	 * url: {domainContextPath}/bizsm/bizservice/ui/bizstatusmanager!getCustomRule
	 */
	public String getCustomRule(){
		//TODO 根据serverId获得自定义规则数据
		return "custom";
	}
	
	/**
	 * 跳转到默认规则页面
	 * @return
	 * url: {domainContextPath}/bizsm/bizservice/ui/bizstatusmanager!getDefaultRule
	 */
	public String getDefaultRule(){
		return "default";
	}
	
	/**
	 * 跳转到状态定义页面
	 * @return
	 * url:{domainContextPath}/bizsm/bizservice/ui/bizstatusmanager!getStatusDefinePage
	 */
	public String getStatusDefinePage(){
		//TODO 根据serverId获得是按默认规则设置还是按自定义规则设置
		return Action.SUCCESS;
	}

	/**
	 * @inject{bizsm.bizServiceManager}
	 */
	public void setBizServiceManager(BizServiceManager bizServiceManager){
		this.bizServiceManager = bizServiceManager;
	}
}

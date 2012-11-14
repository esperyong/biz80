package com.mocha.bsm.bizsm.web.action;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.service.BizServiceManager;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author liuhw
 *
 */

public class BizDefineAction extends ActionSupport {
	
	//private NewOperationSrvModel newOptSrvModel = new NewOperationSrvModel();
	private BizServiceManager bizServiceManager;
	private BizService model = new BizService();
	
	private String serviceName;
	
	private String serviceId;

	/**
	 * @inject{bizsm.bizServiceManager}
	 */
	public void setBizServiceManager(BizServiceManager bizServiceManager){
		this.bizServiceManager = bizServiceManager;
	}
	
	/**
	 * 获得业务服务基本信息
	 * @return
	 * uri:{domainContextPath}/bizsm/bizservice/ui/addnewbizservice!getGeneralInfo?serviceId={xxx}
	 */
	public String getGeneralInfo(){
		model = this.bizServiceManager.getBizServiceById(this.serviceId);//this.serviceName);
		return Action.SUCCESS;
	}
	
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public BizService getModel() {
		return model;
	}
	public void setModel(BizService model) {
		this.model = model;
	}
	
}

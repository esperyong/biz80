package com.mocha.bsm.bizsm.core.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;

public class SimpleCacheBizServiceManager implements IBizServiceManager {
	
	private Map<String,BizService> services = null;
	
	public SimpleCacheBizServiceManager(List<BizService> bizServices){
		this.services = new HashMap<String,BizService>();
		if(bizServices != null){
			for(BizService service:bizServices){
				this.services.put(service.getBizId(), service);
			}
		}
	}
	
	public void deleteBizServiceById(String serviceId) {
		// TODO Auto-generated method stub
	}

	public List<BizService> getAllBizService() {
		// TODO Auto-generated method stub
		return null;
	}

	public BizService getBizServiceById(String serviceId) {
		return this.services.get(serviceId);
	}

	public BizService getBizServiceByName(String serviceName) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<BizService> getCanAdoptBizServiceByServiceId(String bizServiceId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void saveBizService(BizService bizService) {
		// TODO Auto-generated method stub

	}

	public void setDbtemplate(IDb4oTemplate dbtemplate) {
		// TODO Auto-generated method stub

	}

	public void updateBizServiceBasicInfo(BizService bizService) {
		// TODO Auto-generated method stub

	}

}

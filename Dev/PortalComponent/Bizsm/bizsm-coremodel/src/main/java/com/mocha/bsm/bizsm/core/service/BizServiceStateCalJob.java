/**
 * 
 */
package com.mocha.bsm.bizsm.core.service;

import java.util.List;
import java.util.TimerTask;

import com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizServices;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.core.ISessionCallback;

/**
 * @author liuyong
 */
public class BizServiceStateCalJob extends TimerTask implements IBizServiceStateCalJob {
	private IDb4oTemplate dbtemplate;
	private IBSMResourceModelAdapter bsmAdapter;
	
	public void setBsmAdapter(IBSMResourceModelAdapter bsmAdapter){
		this.bsmAdapter = bsmAdapter;
	}
	
	//Inject@{db4oTemplateMultiConn}
	public void setDbtemplate(IDb4oTemplate dbtemplate){
		this.dbtemplate = dbtemplate;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceStateCalJob#fetchAndCalState()
	 */
	public BizServices fetchAndCalState() {
		ISessionCallback sessionCallback = new BizServiceStateCalSession(this.bsmAdapter);
		List<BizService> serviceList = (List<BizService>)dbtemplate.executeSession(sessionCallback);
		BizServices services = new BizServices(serviceList);
		return services;
	}
	
	public void run() {
		this.fetchAndCalState();
	}
	
}

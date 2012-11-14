package com.mocha.bsm.bizsm.core.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter;
import com.mocha.bsm.bizsm.adapter.bsmres.IBatchBSMResourceModelAdapter;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.db4otemplate.core.ISessionCallback;
/**
 * 进行所有处于监控状态的
 * 业务服务的状态计算事务
 * @author liuyong
 *
 */
public class BizServiceStateCalSession implements ISessionCallback {
	private IBSMResourceModelAdapter bsmAdapter;
	
	public BizServiceStateCalSession(IBSMResourceModelAdapter bsmAdapter){
		this.bsmAdapter = bsmAdapter;
	}
	
	public Object execute(ObjectContainer oc) throws Exception {
		Calendar stateTime = Calendar.getInstance();
		
		ObjectSet<BizService> bizServices = oc.query(new Predicate<BizService>(){
			   public boolean match(BizService service) {
				      return service.isMonitered();
			   }
		});
		
		if(this.bsmAdapter instanceof IBatchBSMResourceModelAdapter){
			((IBatchBSMResourceModelAdapter)this.bsmAdapter).emptyCache();
		}		
		//prepare batch request
		this.prepareData(bizServices, stateTime);
		
		//execute Batch
		if(this.bsmAdapter instanceof IBatchBSMResourceModelAdapter){
			((IBatchBSMResourceModelAdapter)this.bsmAdapter).executeBatch();
		}
		
		List<BizService> bizServiceList = new ArrayList<BizService>();
		//fetch data and calulate State
		while(bizServices.hasNext()){
			BizService bizService = bizServices.next();
			bizService.calculateState(stateTime);
			bizServiceList.add(bizService);
		}
		
		return bizServiceList;
	}
	
	
	
	protected void prepareData(ObjectSet<BizService> bizServices,Calendar stateTime) throws Exception{
		IBizServiceManager bizServiceManager = new SimpleCacheBizServiceManager(bizServices);
		while(bizServices.hasNext()){
			BizService bizService = bizServices.next();
			bizService.prepareCalculateState(this.bsmAdapter,bizServiceManager, stateTime);
		}		
	}

}

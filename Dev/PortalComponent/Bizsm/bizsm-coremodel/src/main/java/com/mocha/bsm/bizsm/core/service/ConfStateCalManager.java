package com.mocha.bsm.bizsm.core.service;
import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.state.Assertion;
import com.mocha.bsm.bizsm.core.model.state.BizServiceState;
import com.mocha.bsm.bizsm.core.model.state.ConfStateCal;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.core.ISessionCallback;

/**
 * 状态计算规则管理器
 * @author liuyong
 */
public class ConfStateCalManager {
	
	IBizServiceManager bizServiceManager;
	
	private IDb4oTemplate dbtemplate;
	
	//Inject@{db4oTemplateMultiConn}
	public void setDbtemplate(IDb4oTemplate dbtemplate){
		this.dbtemplate = dbtemplate;
	}	
	/**
	 * injected
	 * @param bizServiceManager
	 */
	public void setBizServiceManager(IBizServiceManager bizServiceManager){
		this.bizServiceManager = bizServiceManager;
	}
	
	/**
	 * 根据业务服务获取状态
	 * @param serviceId
	 * @param state
	 * @return
	 */
	public ConfStateCal getStateCal(String serviceId,BizServiceState state){
		BizService bizService = this.bizServiceManager.getBizServiceById(serviceId);
		return (ConfStateCal)bizService.getConfStateCalByExpectState(state);
	}
	
	/**
	 * 
	 * @param serviceId
	 * @param confStateCal
	 */
	public void saveStateCal(final String serviceId,final ConfStateCal confStateCal){
		
		this.dbtemplate.executeSession(new ISessionCallback() {
			
			public Object execute(ObjectContainer oc) throws Exception {
				
				BizService service = null;
				
				ObjectSet<BizService> services = oc.query(new Predicate<BizService>(){
					   public boolean match(BizService service) {
						      return service.getBizId().equals(serviceId);
					   }
				});
				
				if(services.hasNext()){
					service = services.next();
					ConfStateCal calInDb = service.getConfStateCalByExpectState(confStateCal.getExpectedState());
					
					calInDb.setAnd(confStateCal.isAnd());
					
					for (Assertion assertion:calInDb.getAssertions()) {
						oc.delete(assertion);
					}
					calInDb.getAssertions().clear();
					
					for(Assertion assertion:confStateCal.getAssertions()){
						calInDb.addAssertion(assertion);
					}
					
					oc.store(calInDb);
					
				}
				
				
				return Boolean.TRUE;
			}
			
		});
		
	}
	
}

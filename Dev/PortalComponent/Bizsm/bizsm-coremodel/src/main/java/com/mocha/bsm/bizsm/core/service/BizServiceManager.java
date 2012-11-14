package com.mocha.bsm.bizsm.core.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.util.UidGenerator;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.core.ISessionCallback;

/**
 * @author liuyong
 * @version 1.0
 */
public class BizServiceManager implements IBizServiceManager {
	
	private IDb4oTemplate dbtemplate;
	
	//Inject@{db4oTemplateMultiConn}
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#setDbtemplate(com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate)
	 */
	public void setDbtemplate(IDb4oTemplate dbtemplate){
		this.dbtemplate = dbtemplate;
	}
	
	public BizServiceManager(){
	}

	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#getBizServiceByName(java.lang.String)
	 */
	public BizService getBizServiceByName(final String serviceName){
		BizService service = null;
		List<BizService> services = this.dbtemplate.query(new Predicate<BizService>(){
			   public boolean match(BizService service) {
				      return service.getName().equals(serviceName);
			   }
		});
		
		if(services.size() > 0){
			service = services.get(0);
		}
		return service;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#getCanAdoptBizServiceByServiceId(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<BizService> getCanAdoptBizServiceByServiceId(final String bizServiceId){
		ObjectSet<BizService> services = (ObjectSet<BizService>)this.dbtemplate.executeSession(new ISessionCallback(){
			public Object execute(ObjectContainer oc) throws Exception{
				
				ObjectSet<BizService> services = oc.query(new Predicate<BizService>(){
					   public boolean match(BizService service) {
						      return service.getBizId().equals(bizServiceId);
					   }
				});
				
				if(services.hasNext()){
					final BizService parent = services.next();
					
					ObjectSet<BizService> parentParents = oc.query(new Predicate<BizService>(){
						   public boolean match(BizService service) {
							      return service.getChildBizServices().contains(parent);
						   }
					});
					
					//如果给定业务服务有父亲了,什么都没有
					if(parentParents != null && parentParents.size() > 0){
						return null;
					}
					
					ObjectSet<BizService> results = oc.query(new Predicate<BizService>(){
						   public boolean match(BizService service) {
							      return (service.getChildServiceNum()==0)
							      			&& 
							      		 !(parent.getChildBizServices().contains(service))
							      		    &&
							      		  parent != service
							      		 ;
						   }
					});
					
				return results;					
				}else{
				return null;
				}
			}
		});
		
		List<BizService> results = new ArrayList<BizService>();
		if(services!=null){
			while(services.hasNext()){
				results.add(services.next());
			}			
		}
		
		return results;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#getBizServiceById(java.lang.String)
	 */
	public BizService getBizServiceById(final String serviceId){
		BizService service = null;
		List<BizService> services = this.dbtemplate.query(new Predicate<BizService>(){
			   public boolean match(BizService service) {
				      return service.getBizId().equals(serviceId);
			   }
		});
		
		if(services.size() > 0){
			service = services.get(0);
		}
		return service;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#deleteBizServiceById(java.lang.String)
	 */
	public void deleteBizServiceById(final String serviceId){
		this.dbtemplate.delete(new Predicate<BizService>(){
			   public boolean match(BizService service) {
				      return service.getBizId().equals(serviceId);
			   }
		});
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#getAllBizService()
	 */
	public List<BizService> getAllBizService(){
		List<BizService> services = this.dbtemplate.query(new Predicate<BizService>(){
			   public boolean match(BizService service) {
				      return true;
			   }
		});
		List<BizService> resultservices = new ArrayList<BizService>();
		int serviceSize = services.size();
		for (int i = 0; i < serviceSize; i++) {
			resultservices.add(services.get(i));
		}
		
//		Collections.sort(resultservices, new Comparator<BizService>(){
//			public int compare(BizService s1, BizService s2) {
//				Calendar cal1 = s1.getLastUpdateDate();
//				Calendar cal2 = s2.getLastUpdateDate();
//				if(cal1 != null && cal2 != null){
//					return cal1.compareTo(cal2);
//				}else{
//					return 0;
//				}
//			}
//		});
		
		return resultservices;
	
	}

	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#saveBizService(com.mocha.bsm.bizsm.core.model.BizService)
	 */
	public void saveBizService(BizService bizService){
		if(bizService.getBizId() == null){//create
			String id = UidGenerator.generateUid();
			bizService.setBizId(id);
			bizService.getResponsiblePerson().setId(UidGenerator.generateUid());
			bizService.setLastUpdateDate(new Date());
			bizService.setCreateDate(new Date());
			this.dbtemplate.save(bizService);
		}else{//update
			this.updateBizServiceBasicInfo(bizService);
		}
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceManager#updateBizServiceBasicInfo(com.mocha.bsm.bizsm.core.model.BizService)
	 */
	public void updateBizServiceBasicInfo(BizService bizService){
		final String bizId = bizService.getBizId();
		bizService.setLastUpdateDate(new Date());
		this.dbtemplate.update(new Predicate<BizService>(){
			   public boolean match(BizService service) {
				      return service.getBizId().equals(bizId);
			   }
		}, bizService);
	}
	
}
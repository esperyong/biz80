/**
 * 
 */
package com.mocha.bsm.bizsm.core.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizTopologyGraph;
import com.mocha.bsm.bizsm.core.model.BizUser;
import com.mocha.bsm.bizsm.core.model.GraphInfo;
import com.mocha.bsm.bizsm.core.model.MonitableResource;
import com.mocha.bsm.bizsm.db4otemplate.core.ISessionCallback;

/**
 * 更新topo事务
 * @author liuyong
 *
 */
public class UpdateBizTopologyGraphSession implements ISessionCallback {
	private BizTopologyGraph topo = null;
	public UpdateBizTopologyGraphSession(BizTopologyGraph topo){
		this.topo = topo;
	}
	
	/**
	 * 
	 * @param topo
	 * @return key 是国际化的key,value是params 如果返回的map中没有数据证明校验通过
	 */
	private Map<String,String[]> validateUpdateTopo(BizTopologyGraph topo,ObjectContainer oc){
		Map<String,String[]> errors = new HashMap<String,String[]>();
		//1.子业务服务不能出现环路和多层（子业务服务在topo编辑期间被其他人加入了子业务服务或者被其他人加入了当前业务服务）
		//2.当前的子业务服务,当前的子业务单位，当前的资源，如果被删除的话，不能通过校验。
		//TODO
		
		return errors;
	}
	
	public Object execute(ObjectContainer oc) throws Exception {
		
		Map<String,String[]> errors = this.validateUpdateTopo(topo, oc);
		
		if(errors == null || errors.isEmpty()){
			
			final String topoId = topo.getTopoId();
			
			BizTopologyGraph topoInDb = null;
			
			ObjectSet<BizTopologyGraph> topoGraphs = oc.query(new Predicate<BizTopologyGraph>(){
				@Override
				public boolean match(BizTopologyGraph topo) {
					return topo.getTopoId().equals(topoId);
				}
			});
			
			if(topoGraphs.hasNext()){
				topoInDb = topoGraphs.next();
			}else{
				return errors.put("拓扑[id:${0}]已经被删除.", new String[]{topoId});
			}
			
			//1.更新图形数据
			if(topoInDb.getGraphInfo() == null){
				topoInDb.setGraphInfo(new GraphInfo());
			}
			topoInDb.getGraphInfo().setInfo(topo.getGraphInfo().getInfo());
			//2.同步业务服务
			this.updateBizService(topo.getBizService(), topoInDb.getBizService(), oc, errors);
			
			if(errors == null || errors.isEmpty()){
				//finally update topo
				oc.store(topoInDb);							
			}
			
		}
		
		return errors;
	}
	
	/**
	 * 1.数据库里面没有,topo里面有，添加引用
	 * 2.topo里面没有，数据库里面有，删除引用
	 * @param requestService
	 * @param serviceInDB
	 * @param oc
	 * @return
	 */
	public void updateBizService(BizService requestService,BizService serviceInDB,ObjectContainer oc,Map<String,String[]> errors){
		try {
			Set<BizUser> requestUserSet = this.userListToHashSet(requestService.getBizUsers());
			Set<BizUser> inDBUserSet = this.userListToHashSet(serviceInDB.getBizUsers());
			Set<BizService> requestChildServiceSet = this.serviceListToHashSet(requestService.getChildBizServices());
			Set<BizService> inDBChildServiceSet = this.serviceListToHashSet(serviceInDB.getChildBizServices());
			Set<MonitableResource> requestMonitableResourceSet = this.resourceListToHashSet(requestService.getMonitableResources());
			Set<MonitableResource> inDBMonitableResourceSet = this.resourceListToHashSet(serviceInDB.getMonitableResources());
			
			for (BizUser requestUser:requestUserSet) {
				if(!inDBUserSet.contains(requestUser)){//数据库里面没有,topo里面有，添加引用
					serviceInDB.addBizUser(this.getBizUserById(requestUser.getId(), oc));
				}
			}
			
			for (BizUser inDBUser:inDBUserSet) {
				if(!requestUserSet.contains(inDBUser)){//topo里面没有，数据库里面有，删除引用
					serviceInDB.removeBizUser(inDBUser);
				}
			}
			
			for (BizService requestChildService:requestChildServiceSet) {
				if(!inDBChildServiceSet.contains(requestChildService)){//数据库里面没有,topo里面有，添加引用
					serviceInDB.addChildBizService(this.getServiceById(requestChildService.getBizId(), oc));
				}
			}
			
			for (BizService inDBChildService:inDBChildServiceSet) {
				if(!requestChildServiceSet.contains(inDBChildService)){//topo里面没有，数据库里面有，删除引用
					serviceInDB.removeChildBizService(inDBChildService);
				}
			}		
			
			for (MonitableResource requestMonitableResource:requestMonitableResourceSet) {
				if(!inDBMonitableResourceSet.contains(requestMonitableResource)){//数据库里面没有,topo里面有，添加引用
					serviceInDB.addMonitableResource(this.getMonitableResourceById(requestMonitableResource.getResourceInstanceId(), oc));
				}
			}
			
			for (MonitableResource inDBMonitableResource:inDBMonitableResourceSet) {
				if(!requestMonitableResourceSet.contains(inDBMonitableResource)){//topo里面没有，数据库里面有，删除引用
					serviceInDB.removeMonitableResource(inDBMonitableResource);
				}
			}	
			
		} catch (Exception e) {
			errors.put("updateresourceException", new String[]{e.getMessage()});
		}
		
	}
	
	protected BizService getServiceById(final String bizServiceId,ObjectContainer oc){
		ObjectSet<BizService> services = oc.query(new Predicate<BizService>(){
			@Override
			public boolean match(BizService service) {
				return service.getBizId().equals(bizServiceId);
			}
		});
		if(services.hasNext()){
			return services.next();
		}else{
			return null;
		}
	}
	
	protected BizUser getBizUserById(final String bizUserId,ObjectContainer oc){
		ObjectSet<BizUser> users = oc.query(new Predicate<BizUser>(){
			@Override
			public boolean match(BizUser user) {
				return user.getId().equals(bizUserId);
			}
		});
		if(users.hasNext()){
			return users.next();
		}else{
			return null;
		}
	}

	protected MonitableResource getMonitableResourceById(final String resourceInstanceId,ObjectContainer oc){
		ObjectSet<MonitableResource> resources = oc.query(new Predicate<MonitableResource>(){
			@Override
			public boolean match(MonitableResource resource) {
				return resource.getResourceInstanceId().equals(resourceInstanceId);
			}
		});
		if(resources.hasNext()){
			return resources.next();
		}else{
			return null;
		}
	}

	protected Set<MonitableResource> resourceListToHashSet(List<MonitableResource> resourceData){
		Set<MonitableResource> data = new HashSet<MonitableResource>();
		for (MonitableResource aListData:resourceData) {
			data.add(aListData);
		}
		return data;
	}				
	
	protected Set<BizService> serviceListToHashSet(List<BizService> listData){
		Set<BizService> data = new HashSet<BizService>();
		for (BizService aListData:listData) {
			data.add(aListData);
		}
		return data;
	}
	
	protected Set<BizUser> userListToHashSet(List<BizUser> listData){
		Set<BizUser> data = new HashSet<BizUser>();
		for (BizUser aListData:listData) {
			data.add(aListData);
		}
		return data;
	}				

}

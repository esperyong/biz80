package com.mocha.bsm.bizsm.core.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizTopologyGraph;
import com.mocha.bsm.bizsm.core.util.UidGenerator;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.core.ISessionCallback;
/**
 * 拓扑管理服务
 * @author liuyong
 * @version 1.0
 */
public class BizTopologyGraphManager {
	
	private IDb4oTemplate dbtemplate;
	
	//Inject@{db4oTemplateMultiConn}
	public void setDbtemplate(IDb4oTemplate dbtemplate){
		this.dbtemplate = dbtemplate;
	}
	
	public BizTopologyGraphManager(){
	}
	
	/**
	 * 为一个业务服务创建一个拓扑并存入数据库
	 * @param topo 返回值如果是null说明并未创建成功,由于指定的服务并不存在;
	 */
	public BizTopologyGraph createTopoForBizService(final String bizServiceId){
		
		BizTopologyGraph biztopo = (BizTopologyGraph)this.dbtemplate.executeSession(new ISessionCallback(){
			public Object execute(ObjectContainer oc) throws Exception {
				BizTopologyGraph topo = null;
				ObjectSet<BizService> services = oc.query(new Predicate<BizService>(){
					@Override
					public boolean match(BizService service) {
						return service.getBizId().equals(bizServiceId);
					}
				});
				if(services.hasNext()){
					BizService service = services.next();
					topo = new BizTopologyGraph();
					topo.setTopoId(UidGenerator.generateUid());
					topo.setBizService(service);
					oc.store(topo);
				}
				return topo;
			}
		});
		
		return biztopo;
	}
	
	/**
	 * 更新一个拓扑
	 * @param topo
	 */
	@SuppressWarnings(value={"unchecked"})
	public Map<String, String[]> updateTopo(BizTopologyGraph topo) {
		Map<String, String[]> errors = (Map<String, String[]>) this.dbtemplate
				.executeSession(new UpdateBizTopologyGraphSession(topo));
		return errors;
	}
	
	
	
	/**
	 * 根据topoID删除一个topo
	 * @param topoId
	 */
	public void deleteTopoById(final String topoId){
		this.dbtemplate.delete(new Predicate<BizTopologyGraph>(){
			   public boolean match(BizTopologyGraph topo) {
				      return topo.getTopoId().equals(topoId);
			   }
		});
	}
	
	/**
	 * 根据业务服务ID删除一个topo
	 * @param bizServiceId
	 */
	public void deleteTopoByServiceId(final String bizServiceId){
		this.dbtemplate.delete(new Predicate<BizTopologyGraph>(){
			public boolean match(BizTopologyGraph topo) {
				return topo.getBizService().getBizId().equals(bizServiceId);
			}
		});
	}
	
	/**
	 * 根据业务服务ID获取该业务服务的topo
	 * @param serviceId
	 * @return
	 */
	public BizTopologyGraph getTopoByBizServiceId(final String serviceId){
		
		BizTopologyGraph biztopo = (BizTopologyGraph)this.dbtemplate.executeSession(new ISessionCallback(){
			public Object execute(ObjectContainer oc) throws Exception {
				BizTopologyGraph topo = null;
				ObjectSet<BizService> bizServices = oc.query(new Predicate<BizService>(){
					@Override
					public boolean match(BizService bizService) {
						return bizService.getBizId().equals(serviceId);
					}
				});
				
				if(bizServices.hasNext()){
					final BizService service = bizServices.next();
					
					ObjectSet<BizTopologyGraph> bizTopos = oc.query(new Predicate<BizTopologyGraph>(){
						@Override
						public boolean match(BizTopologyGraph bizTopo) {
							return bizTopo.getBizService() == service;
						}
					});						
					if(bizTopos.hasNext()){
						topo = bizTopos.next();
					}
				}
				
				return topo;
			}
		});
		
		return biztopo;
	}
	
	/**
	 * 根据拓扑ID获得某一个topo
	 * @param topoId
	 * @return
	 */
	public BizTopologyGraph getTopoById(final String topoId){
		BizTopologyGraph topo = null;
		List<BizTopologyGraph> topos = this.dbtemplate.query(new Predicate<BizTopologyGraph>(){
			   public boolean match(BizTopologyGraph topo) {
				      return topo.getTopoId().equals(topoId);
			   }
		});
		
		if(topos.size() > 0){
			topo = topos.get(0);
		}	
		return topo;
	}
	
	/**
	 * 获得所有topo
	 * @return
	 */
	public List<BizTopologyGraph> getAllTopo(){
		List<BizTopologyGraph> topos = this.dbtemplate.query(new Predicate<BizTopologyGraph>(){
			   public boolean match(BizTopologyGraph topo) {
				      return true;
			   }
		});
		
		List<BizTopologyGraph> resulttopos = new ArrayList<BizTopologyGraph>();
		int topoSize = topos.size();
		for (int i = 0; i < topoSize; i++) {
			resulttopos.add(topos.get(i));
		}
		
		return resulttopos;
	}

}
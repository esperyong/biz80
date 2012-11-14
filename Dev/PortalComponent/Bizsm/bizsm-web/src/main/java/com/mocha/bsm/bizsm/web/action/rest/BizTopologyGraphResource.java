/**
 * 
 */
package com.mocha.bsm.bizsm.web.action.rest;
import java.util.List;
import java.util.Map;
import com.mocha.bsm.bizsm.core.model.BizTopologyGraph;
import com.mocha.bsm.bizsm.core.model.BizTopologyGraphs;
import com.mocha.bsm.bizsm.core.service.BizTopologyGraphManager;
import com.mocha.bsm.bizsm.struts2rest.DefaultHttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 
 * @author liuyong
 */
public class BizTopologyGraphResource  extends ActionSupport implements ModelDriven<Object>{
	
	private Object model = new BizTopologyGraph();
	
	private BizTopologyGraphManager bizTopologyGraphManager;
	
	private String bizServiceId;
	
	private String id;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getBizServiceId() {
		return bizServiceId;
	}

	public void setBizServiceId(String bizServiceId) {
		this.bizServiceId = bizServiceId;
	}

	/**
	 * @inject{bizsm.bizTopoManager}
	 */
	public void setBizTopologyGraphManager(BizTopologyGraphManager bizTopologyGraphManager){
		this.bizTopologyGraphManager = bizTopologyGraphManager;
	}
	
	public Object getModel(){
		return this.model;
	}
	
	/**
	 * 获得业务服务Topo
	 * Get /biztopo/.xml?bizServiceId={serviceId}
	 * get all BizServices
	 * @return
	 */
	public HttpHeaders list(){
		String serviceId = this.getBizServiceId();
		if(serviceId != null && !serviceId.equals("")){
			this.model = this.getTopoByServiceId(serviceId);
		}else{
			this.model = new BizTopologyGraphs(this.getAllTopo());
		}
		
		return new DefaultHttpHeaders(Action.NONE).disableCaching();
	}
	
	/**
	 * 通过服务ID获得TOPO
	 * @param serviceId
	 * @return
	 */
	public BizTopologyGraph getTopoByServiceId(String serviceId){
		return this.bizTopologyGraphManager.getTopoByBizServiceId(serviceId);
	}
	
	/**
	 * 获得所有topo
	 * @return
	 */
	public List<BizTopologyGraph> getAllTopo(){
		return this.bizTopologyGraphManager.getAllTopo();
	}
	
	/**
	 * 获得业务服务Topo
	 * Get /biztopo/{topoId}
	 * get all BizServices
	 * @return
	 */
	public HttpHeaders view(){
		String topoId = this.getId();
		this.model = this.bizTopologyGraphManager.getTopoById(topoId);
		return new DefaultHttpHeaders(Action.NONE).disableCaching();
	}
	
	/**
	 * 更新某一个业务拓扑
	 * PUT /biztopo/{topoId}
	 * or
	 * POST /biztopo/{topoId}?__http_method=PUT (模拟POST,应用于PUT表单提交(Tomcat不解析),或者前台无法发出PUT请求)
	 * @return
	 */
	public HttpHeaders createOrUpdate(){
		String topoId = this.getId();
		BizTopologyGraph topo = (BizTopologyGraph)this.model;
		topo.setTopoId(topoId);
		Map<String, String[]> errors =this.bizTopologyGraphManager.updateTopo(topo);
		if(errors != null && !errors.isEmpty()){
			
			for (Map.Entry<String, String[]> entry:errors.entrySet()) {
				this.addActionError(this.getText(entry.getKey(), entry.getValue()));
			}
			
		}
		return new DefaultHttpHeaders(Action.NONE);
	}
	
}

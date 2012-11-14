//
package com.mocha.bsm.bizsm.web.action.rest;

import java.util.List;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizServices;
import com.mocha.bsm.bizsm.core.service.BizServiceManager;
import com.mocha.bsm.bizsm.core.service.BizTopologyGraphManager;
import com.mocha.bsm.bizsm.struts2rest.DefaultHttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;


/**
 * 代表资源BizService
 * @author liuyong
 *
 */
public class BizServiceResource extends ActionSupport implements ModelDriven<Object>{

	private Object model = new BizService();
	private BizServiceManager bizServiceManager;
	private BizTopologyGraphManager bizTopologyGraphManager;
	private String id;
	/**
	 * 查询一组业务服务资源,可以作为给定业务服务资源的子资源
	 */
	private String canAdoptByServiceId;
	
	public String getCanAdoptByServiceId() {
		return canAdoptByServiceId;
	}
	public void setCanAdoptByServiceId(String canAdoptByServiceId) {
		this.canAdoptByServiceId = canAdoptByServiceId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * @inject{bizsm.bizServiceManager}
	 */
	public void setBizServiceManager(BizServiceManager bizServiceManager){
		this.bizServiceManager = bizServiceManager;
	}
	
	/**
	 * @inject{bizsm.bizTopoManager}
	 */	
	public void setBizTopologyGraphManager(BizTopologyGraphManager bizTopologyGraphManager) {
		this.bizTopologyGraphManager = bizTopologyGraphManager;
	}
	
	/**
	 * 获得所有的业务服务
	 * Get /bizservice/
	 * get all BizServices
	 * @return
	 */
	public HttpHeaders list(){
		if(this.canAdoptByServiceId != null && !"".equals(this.canAdoptByServiceId)){//算法执行结果的Resource
			return this.listCanAdoptBizService(canAdoptByServiceId);
		}else{
			List<BizService> service = bizServiceManager.getAllBizService();
			BizServices services = new BizServices(service);
			this.model = services;
			return new DefaultHttpHeaders(Action.NONE).disableCaching();			
		}
	}
	
	/**
	 * 列出可以被选为子业务服务的业务服务
	 * Get /bizservice/?canAdoptByServiceId=59405420947923590011009151012201284559940531
	 * @param canAdoptByServiceId
	 * @return
	 */
	protected HttpHeaders listCanAdoptBizService(String canAdoptByServiceId){
		List<BizService> service = this.bizServiceManager.getCanAdoptBizServiceByServiceId(canAdoptByServiceId);
		BizServices services = new BizServices(service);
		this.model = services;		
		return new DefaultHttpHeaders("listBizService").disableCaching();
	}
	
	/**
	 * 删除业务服务
	 * DELETE /bizservice/59405420947923590011009151012201284559940531
	 * @see {@link http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html}
	 * @return
	 */
	public HttpHeaders remove(){
		this.bizServiceManager.deleteBizServiceById(this.id);
		this.bizTopologyGraphManager.deleteTopoByServiceId(this.id);//删除该服务的topo
		return new DefaultHttpHeaders(Action.NONE).withStatus(204);//204 NO Content
	}
	
	/**
	 * 增加一个新的业务服务
	 * POST /bizservice/
	 * @return
	 */	
	public HttpHeaders createSubResource(){
		BizService newBizService = (BizService)this.model;
		this.bizServiceManager.saveBizService(newBizService);
		this.bizTopologyGraphManager.createTopoForBizService(newBizService.getBizId());
		return new DefaultHttpHeaders(Action.NONE).setLocation(newBizService.getUri());
	}
	
	/**
	 * 校验createSubResource方法
	 */
	public void validateCreateSubResource(){
		BizService newBizService = (BizService)this.model;
		if(newBizService != null){
			BizService oldService = this.bizServiceManager.getBizServiceByName(newBizService.getName());
			if(oldService != null){
				this.addFieldError("model.name", "输入的业务服务名称重复,请重新输入!");
			}
		}	
	}
	
	/**
	 * 获得某一个业务服务
	 * Get /bizservice/{bizId}
	 * get a BizService
	 * @return
	 */	
	public HttpHeaders view(){
		BizService service = this.bizServiceManager.getBizServiceById(this.id);
		this.model = service;
		return new DefaultHttpHeaders(Action.NONE).disableCaching();
	}
	
	/**
	 * 更新某一个业务服务
	 * PUT /bizservice/{bizId}
	 * or
	 * POST /bizservice/{bizId}?__http_method=PUT (模拟POST,应用于PUT表单提交(Tomcat不解析),或者前台无法发出PUT请求)
	 * @return
	 */
	public HttpHeaders createOrUpdate(){
		String bizServiceId = this.getId();
		BizService bizService = (BizService)this.model;
		bizService.setBizId(bizServiceId);
		this.bizServiceManager.saveBizService(bizService);
		return new DefaultHttpHeaders(Action.NONE);
	}
	
	/**
	 * 校验createOrUpdate方法
	 */
	public void validateCreateOrUpdate(){
		String bizServiceId = this.getId();
		BizService newBizService = (BizService)this.model;
		if(newBizService != null){
			BizService oldService = this.bizServiceManager.getBizServiceByName(newBizService.getName());
			if(oldService != null 
					&& !oldService.getBizId().equals(bizServiceId)){
				this.addFieldError("model.name", "输入的业务服务名称重复,请重新输入!");
			}
		}	
	}
	
	public Object getModel(){
		return this.model;
	}
}

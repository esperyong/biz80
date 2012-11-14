package com.mocha.bsm.bizsm.web.action.rest;

import java.util.List;
import com.mocha.bsm.bizsm.core.model.BizUser;
import com.mocha.bsm.bizsm.core.model.BizUsers;
import com.mocha.bsm.bizsm.core.service.BizUserManager;
import com.mocha.bsm.bizsm.struts2rest.DefaultHttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 业务单位资源
 * @author liuyong
 *
 */
public class BizUserResource  extends ActionSupport implements ModelDriven<Object>{
	private Object model = new BizUser();
	private BizUserManager bizUserManager;
	private String id;
	
	
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	/**
	 * @inject{bizsm.bizUserManager}
	 */
	public void setBizUserManager(BizUserManager bizUserManager){
		this.bizUserManager = bizUserManager;
	}
	
	
	/**
	 * 获得某一个业务单位
	 * Get /bizuser/{userId}
	 * get all BizServices
	 * @return
	 */
	public HttpHeaders view(){
			String userId = this.getId();
			this.model = bizUserManager.getUserById(userId);
			return new DefaultHttpHeaders(Action.NONE).disableCaching();
	}	
	
	/**
	 * 获得所有的业务单位
	 * Get /bizuser/
	 * get all BizServices
	 * @return
	 */
	public HttpHeaders list(){
			
			List<BizUser> users = bizUserManager.getAllBizUser();
			BizUsers bizusers = new BizUsers(users);
			this.model = bizusers;
			return new DefaultHttpHeaders("listBizUser").disableCaching();
		
	}	
	
	/**
	 * 增加一个新的业务单位
	 * POST /bizuser/
	 * @return
	 */	
	public HttpHeaders createSubResource(){
		BizUser newBizUser = (BizUser)this.model;
		this.bizUserManager.saveBizUser(newBizUser);
		return new DefaultHttpHeaders(Action.NONE).setLocation(newBizUser.getUri());
	}
	
	/**
	 * 更新某一个业务单位
	 * PUT /bizuser/{bizuserId}
	 * or
	 * POST /bizuser/{bizuserId}?__http_method=PUT (模拟POST,应用于PUT表单提交(Tomcat不解析),或者前台无法发出PUT请求)
	 * @return
	 */
	public HttpHeaders createOrUpdate(){
		String bizUserId = this.getId();
		BizUser bizUser = (BizUser)this.model;
		bizUser.setId(bizUserId);
		this.bizUserManager.saveBizUser(bizUser);
		return new DefaultHttpHeaders(Action.NONE);
	}	
	
	
	/**
	 * 删除业务服务
	 * DELETE /bizservice/59405420947923590011009151012201284559940531
	 * @see {@link http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html}
	 * @return
	 */
	public HttpHeaders remove(){
		this.bizUserManager.deleteBizUserById(this.id);
		return new DefaultHttpHeaders(Action.NONE).withStatus(204);//204 NO Content
	}	
	
	public Object getModel(){
		return this.model;
	}	
}

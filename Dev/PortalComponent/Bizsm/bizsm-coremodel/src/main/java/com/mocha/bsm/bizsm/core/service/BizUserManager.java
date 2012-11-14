package com.mocha.bsm.bizsm.core.service;

import java.util.ArrayList;
import java.util.List;

import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizUser;
import com.mocha.bsm.bizsm.core.util.UidGenerator;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.core.ISessionCallback;

public class BizUserManager {
	private IDb4oTemplate dbtemplate;
	
	//Inject@{db4oTemplateMultiConn}
	public void setDbtemplate(IDb4oTemplate dbtemplate){
		this.dbtemplate = dbtemplate;
	}
	
	/**
	 * 获得当前所有的业务单位
	 * @return
	 */
	public List<BizUser> getAllBizUser(){
		List<BizUser> bizUsers = this.dbtemplate.query(new Predicate<BizUser>(){
			   public boolean match(BizUser user) {
				      return true;
			   }
		});
		
		List<BizUser> resultUsers = new ArrayList<BizUser>();
		int userSize = bizUsers.size();
		for (int i = 0; i < userSize; i++) {
			resultUsers.add(bizUsers.get(i));
		}
		return resultUsers;
	}
	
	/**
	 * saveOrUpdate
	 * @param bizService
	 */
	public void saveBizUser(BizUser bizUser){
		if(bizUser.getId() == null || bizUser.getId().equals("")){//create
			String id = UidGenerator.generateUid();
			bizUser.setId(id);
			this.dbtemplate.save(bizUser);
		}else{//update
			this.updateBizUserInfo(bizUser);
		}
	}
	
	/**
	 * 更新业务单位基本信息
	 * @param bizService
	 */
	protected void updateBizUserInfo(final BizUser bizUser){
		this.dbtemplate.executeSession(new ISessionCallback(){
			public Object execute(ObjectContainer oc) throws Exception {
				Boolean result = Boolean.FALSE;
				ObjectSet<BizUser> users = oc.query(new Predicate<BizUser>(){
				   public boolean match(BizUser sample) {
					      return sample.getId().equals(bizUser.getId());
				   }
			    });
				if(users.hasNext()){
					BizUser userInDB = users.next();
					
					oc.delete(userInDB.getVlsms());
					
					oc.delete(userInDB.getIps());
					
					userInDB.refresh(bizUser);
					
					oc.store(userInDB);
					
					result = Boolean.TRUE;
				}
				return result;
			}
		});
	}
	
	public void deleteBizUserById(final String bizUserId){
		this.dbtemplate.delete(new Predicate<BizUser>(){
			   public boolean match(BizUser user) {
				      return user.getId().equals(bizUserId);
			   }
		});
	}
	
	public BizUser getUserById(final String bizUserId){
		List<BizUser> users = this.dbtemplate.query(new Predicate<BizUser>(){
			   public boolean match(BizUser user) {
				      return user.getId().equals(bizUserId);
			   }
		});
		if(users==null || users.size()==0){
			return null;
		}else{
			return users.get(0);
		}
	}
	
}

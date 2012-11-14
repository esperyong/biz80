package com.mocha.bsm.bizsm.core.model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter;
import com.mocha.bsm.bizsm.core.model.state.Assertion;
import com.mocha.bsm.bizsm.core.model.state.BizServiceState;
import com.mocha.bsm.bizsm.core.model.state.ConfStateCal;
import com.mocha.bsm.bizsm.core.model.state.StateCalResult;
import com.mocha.bsm.bizsm.core.model.state.SystemDefaultStateCal;
import com.mocha.bsm.bizsm.core.service.IBizServiceManager;
import com.mocha.bsm.bizsm.db4otemplate.core.IRefreshable;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.converters.basic.DateConverter;
import com.thoughtworks.xstream.converters.enums.EnumConverter;
import com.thoughtworks.xstream.converters.basic.IntConverter;
import com.thoughtworks.xstream.converters.basic.BooleanConverter;

/**
 * 业务服务管理
 * @author liuyong
 * @version 1.0
 */
@XStreamAlias("BizService")
public class BizService implements IRefreshable{
	
	@XStreamAlias("confStateCals")
	private Map<BizServiceState,ConfStateCal> confStateCals;
	
	@XStreamAlias("stateCalulated")
	@XStreamConverter(BooleanConverter.class)
	private boolean stateCalulated = false;
	
	@XStreamAlias("confStateCal")
	@XStreamConverter(BooleanConverter.class)	
	private boolean confStateCal = false;//配置状态计算或者是默认状态计算
	
	/**
	 * 业务服务监控状态
	 */
	@XStreamAlias("monitoredState")
	@XStreamConverter(EnumConverter.class)
	private BizServiceState monitoredState = BizServiceState.UNKNOWN;
	
	/**
	 * 判断该业务服务是否被监控(启用/禁用)
	 */
	@XStreamAlias("monitered")
	@XStreamConverter(BooleanConverter.class)
	private boolean monitered = false;
	
	/**
	 * for rest request
	 */
	@XStreamAlias("uri")
	private String uri;
	
	/**
	 * 业务服务ID
	 */
	@XStreamAlias("bizId")
	private String bizId;
	
	/**
	 * 业务服务名称
	 */
	@XStreamAlias("name")
	private String name;
	
	/**
	 * 业务服务影响因子
	 */
	@XStreamAlias("reflectFactor")
	@XStreamConverter(IntConverter.class)	
	private int reflectFactor;
	
	@XStreamAlias("ResponsiblePerson")
	private ResponsiblePerson responsiblePerson;
	
	@XStreamConverter(DateConverter.class)
	@XStreamAlias("createDate")
	private Date createDate;
	
	@XStreamConverter(DateConverter.class)
	@XStreamAlias("lastUpdateDate")	
	private Date lastUpdateDate;
	
	/**
	 * 所属域ID
	 */
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.ArrayConverter.class)
	private String[] belongDomainIds;
	
	/**
	 * 业务服务备注
	 */
	@XStreamAlias("remark")
	private String remark;
	
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	private List<BizService> childBizServices;
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)	
	private List<MonitableResource> monitableResources;	
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	private List<BizUser> bizUsers;
	
	private String[] customPropertiesKey;
	
	private String[] customPropertiesValue;
	
	public BizService(){
		this.childBizServices = new ArrayList<BizService>();
		this.bizUsers = new ArrayList<BizUser>();
		this.monitableResources = new ArrayList<MonitableResource>();
		this.responsiblePerson = new ResponsiblePerson();
		this.initConfStateCalMap();
		
	}
	
	private void initConfStateCalMap(){
		this.confStateCals = new HashMap<BizServiceState,ConfStateCal>();
		for (BizServiceState state:BizServiceState.values()) {
			this.confStateCals.put(state, new ConfStateCal(state));
		}
	}
	
	/**
	 * 准备计算自身及其子业务服务的状态
	 * @param bsmAdapter
	 * @param stateTime
	 * @throws Exception
	 */
	public void prepareCalculateState(IBSMResourceModelAdapter bsmAdapter,IBizServiceManager bizServiceManager,Calendar stateTime) throws Exception{
		List<MonitableResource> mresources = this.getMonitableResources();
		for (MonitableResource mresource:mresources) {
			mresource.setBSMResourceModelAdapter(bsmAdapter);
			mresource.preRefreshState(stateTime);
		}
		
		if(this.isConfStateCal()){
			ConfStateCal seriousStateCal = this.getConfStateCalByExpectState(BizServiceState.SERIOUS);
			ConfStateCal warningStateCal = this.getConfStateCalByExpectState(BizServiceState.WARNING);
			
			for(Assertion sAssertion:seriousStateCal.getAssertions()){
				sAssertion.prepareDoAssert(stateTime,bsmAdapter,bizServiceManager);
			}
			
			for(Assertion wAssertion:warningStateCal.getAssertions()){
				wAssertion.prepareDoAssert(stateTime,bsmAdapter,bizServiceManager);
			}
		}
	}
	
	/**
	 * 计算自身及其子业务服务的状态
	 */
	public void calculateState(Calendar stateTime) throws Exception{
		if(!this.stateCalulated){
			
			List<MonitableResource> mresources = this.getMonitableResources();
			
			for (MonitableResource mresource:mresources) {
				mresource.refreshState(stateTime);
			}			
			
			for (BizService child:this.childBizServices) {
				if(child != null){
					child.calculateState(stateTime);
				}
			}
			
			if(this.isConfStateCal()){//自定义状态计算规则
				this.monitoredState = this.calulateConfState();
			}else{//系统默认状态计算规则
				this.monitoredState = SystemDefaultStateCal.calculateState(this);
			}
			
			this.stateCalulated = true;
		}
	}
	
	protected BizServiceState calulateConfState() throws Exception{
		BizServiceState result = null;
		StateCalResult seriousStateCalResult = this.getConfStateCalByExpectState(BizServiceState.SERIOUS).calculateState();
		StateCalResult warningStateCalResult = this.getConfStateCalByExpectState(BizServiceState.WARNING).calculateState();
		if(seriousStateCalResult.equals(StateCalResult.SATISFY)){
			result = BizServiceState.SERIOUS;
		}else if(seriousStateCalResult.equals(StateCalResult.UNSATISFIED)&&
				warningStateCalResult.equals(StateCalResult.SATISFY)
				 ){
			result = BizServiceState.WARNING;
		}else if(seriousStateCalResult.equals(StateCalResult.UNSATISFIED)&&
				warningStateCalResult.equals(StateCalResult.UNSATISFIED)
		 ){
			result = BizServiceState.NORMAL;
		}else{//两者都不满足或其中一个不满足,那也无法判断状态
			result = BizServiceState.UNKNOWN;
		}
		return result;
	}
	
	public String getBizId() {
		return bizId;
	}
	
	public void setBizId(String bizId) {
		this.bizId = bizId;
		this.uri = "/bizservice/" + this.bizId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String[] getBelongDomainIds() {
		return belongDomainIds;
	}

	public void setBelongDomainIds(String[] belongDomainIds) {
		this.belongDomainIds = belongDomainIds;
	}
	
	public int getReflectFactor() {
		return reflectFactor;
	}
	
	public void setReflectFactor(int reflectFactor) {
		this.reflectFactor = reflectFactor;
	}
	
	public Date getCreateDate() {
		return createDate;
	}
	
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}
	
	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}
	
	/**
	 * 添加一个子业务服务
	 * @param bizService
	 */
	public void addChildBizService(BizService bizService){
		this.childBizServices.add(bizService);
	}
	
	/**
	 * 移出一个子业务服务的引用
	 * @param monitableResource
	 */
	public void removeChildBizService(BizService bizService){
		this.childBizServices.remove(bizService);
	}

	/**
	 * 添加一个受控资源
	 * @param monitableResource
	 */
	public void addMonitableResource(MonitableResource monitableResource){
		this.monitableResources.add(monitableResource);
	}
	
	/**
	 * 移除一个受控资源
	 * @param monitableResource
	 */
	public void removeMonitableResource(MonitableResource monitableResource){
		this.monitableResources.remove(monitableResource);
	}	
	
	/**
	 * 根据资源ID获取一个资源
	 * @param resourceInstanceId
	 * @return
	 */
	public MonitableResource getMonitableResourceById(String resourceInstanceId){
		MonitableResource result = null;
		for(MonitableResource resource:this.monitableResources){
			if(resource.getResourceInstanceId().equals(resourceInstanceId)){
				result = resource;
				break;
			}
		}
		return result;
	}
	
	/**
	 * 获得所有的受控资源
	 * @return
	 */
	public List<MonitableResource> getMonitableResources() {
		return monitableResources;
	}
	
	/**
	 * 添加一个业务用户(业务单位)
	 * @param bizUser
	 */
	public void addBizUser(BizUser bizUser){
		this.bizUsers.add(bizUser);
	}	
	
	/**
	 * 移出一个业务用户(业务单位)的引用
	 * @param monitableResource
	 */
	public void removeBizUser(BizUser bizUser){
		this.bizUsers.remove(bizUser);
	}
	
	/**
	 * 获得该业务服务所引用的用户
	 * @return
	 */
	public java.util.List<BizUser> getBizUsers(){
		return this.bizUsers;
	}
	
	/**
	 * 获得该业务服务所引用的所有子业务服务
	 * @return
	 */
	public java.util.List<BizService> getChildBizServices(){
		return this.childBizServices;
	}
	/**
	 * 获得子资源的个数
	 * @return
	 */
	public int getChildServiceNum(){
		return this.childBizServices.size();
	}

	/**
	 * 获得责任人
	 * @return
	 */
	public ResponsiblePerson getResponsiblePerson() {
		return responsiblePerson;
	}
	
	/**
	 * 设置责任人
	 * @param responsiblePerson
	 */
	public void setResponsiblePerson(ResponsiblePerson responsiblePerson) {
		this.responsiblePerson = responsiblePerson;
	}
	
	/**
	 * uri for Rest
	 * @return
	 */
	public String getUri() {
		return this.uri;
	}	
	
	public String[] getCustomPropertiesKey() {
		return customPropertiesKey;
	}

	public void setCustomPropertiesKey(String[] customPropertiesKey) {
		this.customPropertiesKey = customPropertiesKey;
	}

	public String[] getCustomPropertiesValue() {
		return customPropertiesValue;
	}

	public void setCustomPropertiesValue(String[] customPropertiesValue) {
		this.customPropertiesValue = customPropertiesValue;
	}

	public void refresh(IRefreshable newObj){
		if(newObj instanceof BizService){
			BizService newService = (BizService)newObj;
			
			boolean monitered = newService.isMonitered();
			this.setMonitered(monitered);
			
			String name = newService.getName();
			if(name!=null){
				this.setName(name);
			}
			
			int reflectFactor = newService.getReflectFactor();
			if(reflectFactor != 0){
				this.setReflectFactor(reflectFactor);
			}
			
			String[] belongDomainIds = newService.getBelongDomainIds();
			if(belongDomainIds != null && belongDomainIds.length >0){
				this.setBelongDomainIds(belongDomainIds);
			}
			
			String[] customPropertiesKey = newService.getCustomPropertiesKey();
			if(customPropertiesKey != null && customPropertiesKey.length >0){
				this.setCustomPropertiesKey(customPropertiesKey);
			}
			
			String[] customPropertiesValue = newService.getCustomPropertiesValue();
			if(customPropertiesValue != null && customPropertiesValue.length >0){
				this.setCustomPropertiesValue(customPropertiesValue);
			}
			
			String remark = newService.getRemark();
			if(remark != null){
				this.setRemark(remark);
			}
			
			ResponsiblePerson responsiblePerson = newService.getResponsiblePerson();
			if(responsiblePerson != null){
				this.setResponsiblePerson(responsiblePerson);
			}
			
			Date createDate = newService.getCreateDate();
			if(createDate != null){
				this.setCreateDate(createDate);
			}
			
			Date lastUpdateDate = newService.getLastUpdateDate();
			if(lastUpdateDate != null){
				this.setLastUpdateDate(lastUpdateDate);
			}
			
		}
	}
	
    public int hashCode() {
    	return this.bizId.hashCode()*31;
    }
    
    public boolean equals(Object anObject) {
    	if (this == anObject) {
    	    return true;
    	}
    	if (anObject instanceof BizService) {
    		BizService anotherBizService = (BizService)anObject;
    	    if(anotherBizService.bizId!=null && anotherBizService.bizId.equals(this.bizId)){
    	    	return true;	
    	    }
    		
    	}
    	return false;
    }

    /**
     * 判断是否被监控(启用)
     * @return
     */
	public boolean isMonitered() {
		return monitered;
	}
	
	/**
	 * 
	 * @param monitered
	 */
	public void setMonitered(boolean monitered) {
		this.monitered = monitered;
	}

	public boolean isStateCalulated() {
		return stateCalulated;
	}



	public void setStateCalulated(boolean stateCalulated) {
		this.stateCalulated = stateCalulated;
	}
	
	public BizServiceState getMonitoredState() {
		return monitoredState;
	}
	
	public void setMonitoredState(BizServiceState monitoredState) {
		this.monitoredState = monitoredState;
	}
	
	/**
	 * 根据业务服务状态,找到相关的状态计算规则
	 * @param state
	 * @return
	 */
	public ConfStateCal getConfStateCalByExpectState(BizServiceState state){
		return this.confStateCals.get(state);
	}
	
	public boolean isConfStateCal() {
		return confStateCal;
	}
	
	public void setConfStateCal(boolean confStateCal) {
		this.confStateCal = confStateCal;
	}
		
}
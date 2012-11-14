package com.mocha.bsm.bizsm.core.model;

import java.util.Calendar;

import com.mocha.bsm.bizsm.adapter.bsmres.BSMCompositeState;
import com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter;
import com.mocha.bsm.bizsm.adapter.bsmres.IBatchBSMResourceModelAdapter;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.annotations.XStreamOmitField;
import com.thoughtworks.xstream.converters.enums.EnumConverter;

/**
 * 可监控资源
 * @author liuyong
 * @version 1.0
 */
@XStreamAlias("MonitableResource")
public class MonitableResource {
	
	/**
	 * 用来做取值的
	 */
	@XStreamOmitField
	private IBSMResourceModelAdapter bsmAdapter;
	
	public void setBSMResourceModelAdapter(IBSMResourceModelAdapter bsmAdapter){
		this.bsmAdapter = bsmAdapter;
	}
	
	@XStreamAlias("monitoredState")
	private BSMCompositeState monitoredState;
	
	@XStreamAlias("resourceInstanceId")
	private String resourceInstanceId;
	
	@XStreamAlias("uri")
	private String uri;
	
	@XStreamAlias("resourceName")
	private String resourceName;
	
	@XStreamAlias("resourceType")
	@XStreamConverter(EnumConverter.class)
	private MonitableResourceType resourceType;
	
	public MonitableResource(String resourceInstanceId){
		this.resourceInstanceId = resourceInstanceId;
		this.monitoredState = new BSMCompositeState();
		this.resourceType = MonitableResourceType.UNKNOWN;
	}
	
	public String getResourceInstanceId(){
		return this.resourceInstanceId;
	}

	public String getResourceName() {
		return resourceName;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	
	public void setResourceInstanceId(String resourceInstanceId) {
		this.resourceInstanceId = resourceInstanceId;
		this.uri = "/bizservice/" + this.resourceInstanceId;
	}
	
    public BSMCompositeState getMoniterState() {
		return monitoredState;
	}
    
	public void setMoniterState(BSMCompositeState monitoredState) {
		this.monitoredState = monitoredState;
	}
	
	public BSMCompositeState getMonitoredState() {
		return monitoredState;
	}

	public void setMonitoredState(BSMCompositeState monitoredState) {
		this.monitoredState = monitoredState;
	}
	
	public void preRefreshState(Calendar stateTime){
		if(this.bsmAdapter instanceof IBatchBSMResourceModelAdapter){
			IBatchBSMResourceModelAdapter adapter = (IBatchBSMResourceModelAdapter)this.bsmAdapter;
			adapter.requestGetResourceState(this.resourceInstanceId, stateTime);
		}
	}
	
	public void refreshState(Calendar stateTime){
		this.monitoredState = this.bsmAdapter.getResourceState(this.resourceInstanceId, stateTime);
	}
	
	public MonitableResourceType getResourceType() {
		return resourceType;
	}

	public void setResourceType(MonitableResourceType resourceType) {
		this.resourceType = resourceType;
	}
	
	public boolean equals(Object anObject) {
    	if (this == anObject) {
    	    return true;
    	}
    	if (anObject instanceof MonitableResource) {
    		MonitableResource anotherResource = (MonitableResource)anObject;
    	    if(anotherResource.resourceInstanceId != null 
    	    		&& anotherResource.resourceInstanceId.equals(this.resourceInstanceId)){
    	    	return true;	
    	    }
    		
    	}
    	return false;
    }
    
    public int hashCode(){
    	return this.resourceInstanceId.hashCode();
    }
	
}
package com.mocha.bsm.bizsm.core.model.state;

import java.util.List;

import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.MonitableResource;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.converters.enums.EnumConverter;

@XStreamAlias("BizService")
public class BizServiceStateBean {
	
	public BizServiceStateBean(BizService service){
		if(service != null){
			this.monitoredState = service.getMonitoredState();
			this.uri = service.getUri();
			this.bizId = service.getBizId();
			this.monitableResources = service.getMonitableResources();			
		}
	}
	
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)	
	@XStreamAlias("monitableResources")
	private List<MonitableResource> monitableResources;
	
	/**
	 * 业务服务监控状态
	 */
	@XStreamAlias("monitoredState")
	@XStreamConverter(EnumConverter.class)
	private BizServiceState monitoredState = BizServiceState.UNKNOWN;
	
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
	
	
	
}

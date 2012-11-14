/**
 * 
 */
package com.mocha.bsm.bizsm.adapter.bsmres;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.mocha.bsm.basedata.obj.MetricState;
import com.mocha.bsm.basedata.obj.ResourceState;
import com.mocha.bsm.basedata.obj.query.MetricQuery;
import com.mocha.bsm.basedata.service.BaseDataQueryService;
import com.mocha.bsm.resourcemodel.obj.state.State;
import com.mocha.bsm.resourcemodel.obj.state.composite.AvaliableResourceState;
import com.mocha.bsm.resourcemodel.obj.state.composite.PerformanceResourceState;
import com.mocha.bsm.resourcemodel.obj.state.metric.avail.MetricAvailableState;
import com.mocha.bsm.resourcemodel.obj.state.metric.avail.MetricCannotFetchAvailDataState;
import com.mocha.bsm.resourcemodel.obj.state.metric.avail.MetricUnavailableState;
import com.mocha.bsm.resourcemodel.obj.state.metric.perf.MetricCannotFetchPerfDataState;
import com.mocha.bsm.resourcemodel.obj.state.metric.perf.MetricPerfMinorState;
import com.mocha.bsm.resourcemodel.obj.state.metric.perf.MetricPerfNormalState;
import com.mocha.bsm.resourcemodel.obj.state.metric.perf.MetricPerfSeriousState;
import com.mocha.bsm.resourcemodel.service.resource.IResourceSvcMgr;

/**
 * BSM资源模型8.0版本取值实现
 * @author liuyong
 */
public class BSMResourceModelV8Adapter implements IBSMResourceModelAdapter {
	
	static Log log = LogFactory.getLog(BSMResourceModelV8Adapter.class);
	
	/**
	 * 模型API.
	 */
	protected IResourceSvcMgr resSvc;
	
	public void setResSvc(IResourceSvcMgr resSvc){
		this.resSvc = resSvc;
	}
	
	/**
	 * 数据查询API.
	 */
	protected BaseDataQueryService baseQuerySvc;
	
	public void setBaseQuerySvc(BaseDataQueryService baseQuerySvc){
		this.baseQuerySvc = baseQuerySvc;
	}
	
	/**
	 * 获取资源最新状态
	 * @param instanceId
	 * @return
	 */
	private ResourceState getLastResourceState(String instanceId) {
		ResourceState state = null;
		long l1 = System.currentTimeMillis();
		List<String> instanceIds = new ArrayList<String>(1);
		instanceIds.add(instanceId);
		try {
			List<ResourceState> states = baseQuerySvc.selectResStateByInstance(instanceIds);
			if (states != null && states.size() > 0) {
				state = states.get(0);
			}
		} catch (Exception e) {
			log.error("", e);
		}
		long l2 = System.currentTimeMillis();
		log.info("isMonitor instanceId=" + instanceId + ", state=" + state
				+ ", time=" + (l2 - l1));
		return state;
	}

	/**
	 * 获取指标最后一次的状态.
	 * 
	 * @param list
	 * @return
	 */
	protected List<MetricState> getLastMetricStates(List<MetricQuery> list) {
		long l1 = System.currentTimeMillis();
		List<MetricState> result = null;
		try {
			result = baseQuerySvc.selectMetricState(list);
		} catch (Exception e) {
			log.error("getLastMetricStates", e);
		}
		long l2 = System.currentTimeMillis();
		log.info("getValue time=" + (l2 - l1));
		return result;
	}

	/*
	 * @see
	 * com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter#getMetricState
	 * (java.lang.String, java.lang.String, java.util.Calendar)
	 */
	public BSMCompositeState getMetricState(String resInstanceId,
			String metricId, Calendar occurTime) {
		List<MetricQuery> metrics = new ArrayList<MetricQuery>();
		MetricQuery metric = new MetricQuery();
		metric.setInstanceId(resInstanceId);
		metric.setMetricId(metricId);
		metrics.add(metric);
		List<MetricState> metricStates = this.getLastMetricStates(metrics);
		if (metricStates == null || metricStates.size() <= 0) {
			return null;
		}
		MetricState metricState = metricStates.get(0);
		return this.transformState(metricState);
	}

	public BSMCompositeState transformState(MetricState metricState){
		State state = metricState.getState();
		BSMAvailState availState = BSMAvailState.AVAILUNKNOWN;
		if (state instanceof MetricAvailableState) {
			availState = BSMAvailState.AVAILABLE;
		} else if (state instanceof MetricUnavailableState) {
			availState = BSMAvailState.UNAVAILABLE;
		} else if (state instanceof MetricCannotFetchAvailDataState) {
			availState = BSMAvailState.AVAILUNKNOWN;
		}
		
		BSMPerfState perfState = BSMPerfState.PERFUNKNOWN;
		if (state instanceof MetricPerfNormalState) {
			perfState = BSMPerfState.PERFNORMAL;//性能正常
		} else if (state instanceof MetricPerfMinorState) {
			perfState = BSMPerfState.PERFMINOR;//性能轻微超标
		} else if (state instanceof MetricPerfSeriousState) {
			perfState = BSMPerfState.PERFSERIOUS;//性能严重超标
		} else if (state instanceof MetricCannotFetchPerfDataState) {
			perfState = BSMPerfState.PERFUNKNOWN;//性能状态无法获知
		}

		BSMCompositeState comState = new BSMCompositeState();
		

		comState.setAvailState(availState);
		comState.setPerfState(perfState);

		return comState;		
	}
	
	/*
	 * @see
	 * com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter#getResourceState
	 * (java.lang.String, java.util.Calendar)
	 */
	public BSMCompositeState getResourceState(String resInstanceId,
			Calendar occurTime) {
		ResourceState resourceState = this.getLastResourceState(resInstanceId);
		return this.transformState(resourceState);
	}
	
	protected BSMCompositeState transformState(ResourceState resourceState){
		AvaliableResourceState resAvailState = resourceState.getCompositeState().getAvaliableResourceState();
		
		BSMAvailState availState = BSMAvailState.AVAILUNKNOWN;
		if (resAvailState.isAvaliable()) {
			availState = BSMAvailState.AVAILABLE;
		} else if (resAvailState.isUnavaliable()) {
			availState = BSMAvailState.UNAVAILABLE;
		} else if (resAvailState.isUnknown()) {
			availState = BSMAvailState.AVAILUNKNOWN;
		}
		
		PerformanceResourceState resPerfState = resourceState.getCompositeState().getPerformanceResourceState();
		BSMPerfState perfState = BSMPerfState.PERFUNKNOWN;
		if (resPerfState.isNormal()) {
			perfState = BSMPerfState.PERFNORMAL;//性能正常
		} else if (resPerfState.isMinor()) {
			perfState = BSMPerfState.PERFMINOR;//性能轻微超标
		} else if (resPerfState.isSerious()) {
			perfState = BSMPerfState.PERFSERIOUS;//性能严重超标
		} else if (resPerfState.isUnknown()) {
			perfState = BSMPerfState.PERFUNKNOWN;//性能状态无法获知
		}

		BSMCompositeState comState = new BSMCompositeState();
		

		comState.setAvailState(availState);
		comState.setPerfState(perfState);

		return comState;		
	}

	public static void main(String[] args) {
		BSMResourceModelV8Adapter a = new BSMResourceModelV8Adapter();
		BSMCompositeState b = a.getMetricState("", "", null);
		System.out.println(b.getAvailState().toString());

	}

}

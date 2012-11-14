/**
 * 
 */
package com.mocha.bsm.bizsm.adapter.bsmres;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.text.SimpleDateFormat;
import com.mocha.bsm.basedata.obj.MetricState;
import com.mocha.bsm.basedata.obj.ResourceState;
import com.mocha.bsm.basedata.obj.query.MetricQuery;

/**
 * 确保只取一次值,并可以在取值完毕之后执行emptyCache
 * @author liuyong
 */
public class CacheAbleBSMResourceModelV8Adapter extends BSMResourceModelV8Adapter implements IBatchBSMResourceModelAdapter {
	
	private Map<String,BSMCompositeState> metricStateCache;
	
	private Map<String,BSMCompositeState> resourceStateCache;
	
	private Map<String,String> resourceStateQueryCache;
	
	private Map<String,MetricQuery> metricStateQueryCache;
	
	
	public CacheAbleBSMResourceModelV8Adapter(){
		this.metricStateCache = new HashMap<String,BSMCompositeState>();
		this.resourceStateCache = new HashMap<String,BSMCompositeState>();
		this.resourceStateQueryCache = new HashMap<String,String>();
		this.metricStateQueryCache = new HashMap<String,MetricQuery>();
	}
	

	/**
	 * @see com.mocha.bsm.bizsm.adapter.bsmres.IBatchBSMResourceModelAdapter#requestGetResourceState(String resInstanceId,Calendar occurTime)
	 */	
	public void requestGetResourceState(String resInstanceId,Calendar occurTime){
		String dateStr = this.formatCalendar(occurTime);
		String cacheKeyStr = resInstanceId + "-" + dateStr;
		String requestQuery = resInstanceId;
		this.resourceStateQueryCache.put(cacheKeyStr, requestQuery);
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.adapter.bsmres.IBatchBSMResourceModelAdapter#requestGetMetricState(String resInstanceId,String metricId,Calendar occurTime)
	 */	
	public void requestGetMetricState(String resInstanceId,String metricId,Calendar occurTime){
		String dateStr = this.formatCalendar(occurTime);
		String cacheKeyStr = resInstanceId + "-" + metricId + "-" + dateStr;
		MetricQuery metricQuery = new MetricQuery();
		metricQuery.setInstanceId(resInstanceId);
		metricQuery.setMetricId(metricId);
		this.metricStateQueryCache.put(cacheKeyStr, metricQuery);
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.adapter.bsmres.IBatchBSMResourceModelAdapter#executeBatch()
	 */	
	public void executeBatch() throws Exception{
		this.executeMetricStateQueryBatch();
		this.executeResourceStateQueryBatch();
	}	
	
	
	protected void executeResourceStateQueryBatch() throws Exception{
		
		Set<Entry<String,String>> entrys = this.resourceStateQueryCache.entrySet();
		List<String> instanceIds = new ArrayList<String>();
		for(Entry<String,String> entry:entrys){
			instanceIds.add(entry.getValue());
		}
		
		List<ResourceState> states = baseQuerySvc.selectResStateByInstance(instanceIds);
		int i = 0;
		for(Entry<String,String> entry:entrys){
			String key = entry.getKey();
			BSMCompositeState value = this.transformState(states.get(i));
			this.resourceStateCache.put(key, value);
			i++;
		}		
	}
	
	
	protected void executeMetricStateQueryBatch() throws Exception{
		
		Set<Entry<String,MetricQuery>> entrys = this.metricStateQueryCache.entrySet();
		
		List<MetricQuery> metricQuerys = new ArrayList<MetricQuery>();
		
		for(Entry<String,MetricQuery> entry:entrys){
			metricQuerys.add(entry.getValue());
		}
		
		List<MetricState> states = this.getLastMetricStates(metricQuerys);
		
		int i = 0;
		for(Entry<String,MetricQuery> entry:entrys){
			String key = entry.getKey();
			BSMCompositeState value = this.transformState(states.get(i));
			this.metricStateCache.put(key, value);
			i++;
		}
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.adapter.ICacheAble#emptyCache()
	 */
	public void emptyCache() {
		this.metricStateCache.clear();
		this.resourceStateCache.clear();
		this.metricStateQueryCache.clear();
		this.resourceStateQueryCache.clear();
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter#getMetricState(java.lang.String, java.lang.String, java.util.Calendar)
	 */
	public BSMCompositeState getMetricState(String resInstanceId,
			String metricId, Calendar occurTime) {
		String dateStr = this.formatCalendar(occurTime);
		String cacheKeyStr = resInstanceId + "-" + metricId + "-" + dateStr;
		BSMCompositeState state = this.metricStateCache.get(cacheKeyStr);
		if(state == null){
			state = super.getMetricState(resInstanceId, metricId, occurTime);
			this.metricStateCache.put(cacheKeyStr, state);
		}
		return state;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter#getResourceState(java.lang.String, java.util.Calendar)
	 */
	public BSMCompositeState getResourceState(String resInstanceId,
			Calendar occurTime) {
		String dateStr = this.formatCalendar(occurTime);
		String cacheKeyStr = resInstanceId + "-" + dateStr;
		BSMCompositeState state = this.resourceStateCache.get(cacheKeyStr);
		if(state == null){
			state = super.getResourceState(resInstanceId, occurTime);
			this.resourceStateCache.put(cacheKeyStr, state);
		}
		return state;
	}
	
	private String formatCalendar(Calendar occurTime){
		String dateStr = "";
		if(occurTime != null){
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			dateStr = dateFormat.format(occurTime.getTime());			
		}
		return dateStr;
	}
	
}

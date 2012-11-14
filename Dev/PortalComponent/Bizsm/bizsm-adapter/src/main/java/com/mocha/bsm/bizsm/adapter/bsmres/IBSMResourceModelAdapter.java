package com.mocha.bsm.bizsm.adapter.bsmres;

import java.util.Calendar;

/**
 * 资源模型相关适配器接口
 * @author liuyong
 */
public interface IBSMResourceModelAdapter {
	
	/**
	 * 获得资源在某一个时间的状态
	 * @param resInstanceId
	 * @param occurTime
	 * @return
	 */
	public BSMCompositeState getResourceState(String resInstanceId,Calendar occurTime);
	
	/**
	 * 获得某资源的某一个指标在某一个时间的状态
	 * @param resInstanceId
	 * @param metricId
	 * @param occurTime
	 * @return
	 */
	public BSMCompositeState getMetricState(String resInstanceId,String metricId,Calendar occurTime);
	
}

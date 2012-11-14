package com.mocha.bsm.bizsm.adapter.bsmres;

import java.util.Calendar;

import com.mocha.bsm.bizsm.adapter.ICacheAble;
/**
 * 支持批量获取
 * @author liuyong
 */
public interface IBatchBSMResourceModelAdapter extends IBSMResourceModelAdapter,ICacheAble{
	
	/**
	 * 发出一个获取资源状态的请求
	 * 可以在多次调用之后,执行批处理
	 * 之后再获取值
	 * @param resInstanceId
	 * @param occurTime
	 */
	public void requestGetResourceState(String resInstanceId,Calendar occurTime);
	
	/**
	 * 发出一个获取指标状态的请求
	 * 可以在多次调用之后,执行批处理
	 * 之后再获取值
	 * @param resInstanceId
	 * @param metricId
	 * @param occurTime
	 */
	public void requestGetMetricState(String resInstanceId,String metricId,Calendar occurTime);
	
	/**
	 * 执行批处理请求
	 * 执行之后结果都会缓存起来
	 * @return
	 */
	public void executeBatch() throws Exception;
	
}

package com.mocha.bsm.bizsm.core.model.state;


/**
 * 业务服务状态计算规则
 * @author liuyong
 */
public interface IBizServiceStateCal {
	
	/**
	 * 计算业务服务的状态是否满足期望
	 * @param service
	 * @return
	 */
	public StateCalResult calculateState() throws Exception; 
	
	public BizServiceState getExpectedState();
}

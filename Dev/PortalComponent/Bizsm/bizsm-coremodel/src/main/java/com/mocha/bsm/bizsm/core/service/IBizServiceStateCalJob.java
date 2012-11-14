package com.mocha.bsm.bizsm.core.service;

import com.mocha.bsm.bizsm.core.model.BizServices;

/**
 * 业务服务状态计算
 * @author liuyong
 */
public interface IBizServiceStateCalJob {
	
	/**
	 * 执行一次所有业务服务何其关联的资源的状态计算
	 * @return
	 */
	public BizServices fetchAndCalState();
	
}


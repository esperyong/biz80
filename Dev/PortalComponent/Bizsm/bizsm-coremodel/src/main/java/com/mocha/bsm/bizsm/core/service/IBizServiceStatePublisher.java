package com.mocha.bsm.bizsm.core.service;

import com.mocha.bsm.bizsm.core.model.BizServices;

public interface IBizServiceStatePublisher {
	
	/**
	 * 使用JMSAPI向mq发送消息
	 * 发送业务服务的状态信息,和其关联的受控资源的状态信息
	 * @param bizServices
	 */
	public void publish(BizServices bizServices);
	
}

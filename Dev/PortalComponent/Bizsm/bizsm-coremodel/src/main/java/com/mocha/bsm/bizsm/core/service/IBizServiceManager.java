package com.mocha.bsm.bizsm.core.service;

import java.util.List;

import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;

public interface IBizServiceManager {

	//Inject@{db4oTemplateMultiConn}
	public abstract void setDbtemplate(IDb4oTemplate dbtemplate);

	/**
	 * 根据名字获取业务服务对象,如果业务服务不存在则返回null
	 * @param serviceName
	 * @return if not exist return null
	 */
	public abstract BizService getBizServiceByName(final String serviceName);

	/**
	 * 得到所有可以被给定业务服务加为子业务服务的业务服务
	 * 1.如果给定业务服务有父亲了,什么都没有
	 * 2.else 
	 * 		父亲们不能有当前资源?(太复杂,由前台来保证)
	 * 		不能有儿子;
	 * @param bizServiceId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public abstract List<BizService> getCanAdoptBizServiceByServiceId(
			final String bizServiceId);

	/**
	 * 根据名字获取业务服务对象,如果业务服务不存在则返回null
	 * @param serviceName
	 * @return if not exist return null
	 */
	public abstract BizService getBizServiceById(final String serviceId);

	public abstract void deleteBizServiceById(final String serviceId);

	/**
	 * 获得所有的业务服务
	 * @return
	 */
	public abstract List<BizService> getAllBizService();

	/**
	 * saveOrUpdate
	 * @param bizService
	 */
	public abstract void saveBizService(BizService bizService);

	/**
	 * 更新业务服务基本信息
	 * @param bizService
	 */
	public abstract void updateBizServiceBasicInfo(BizService bizService);

}
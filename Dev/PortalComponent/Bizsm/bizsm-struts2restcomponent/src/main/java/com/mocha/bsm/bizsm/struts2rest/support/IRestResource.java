package com.mocha.bsm.bizsm.struts2rest.support;

import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;

public interface IRestResource {
	
	/**
	 * GET /xresource/{resourceid}
	 * 
	 * @return
	 */
	public HttpHeaders view();
	
	/**
	 * 得到所有资源
	 * GET /xresource/
	 * @return
	 */
	public HttpHeaders list();
	
	/**
	 * 创建一个新资源(资源的uri由Server决定)
	 * POST /xresource/
	 * @return
	 */
	public HttpHeaders createSubResource();
	
	/**
	 * 更新某一个资源或者创建一个资源(资源的uri由Client决定)
	 * PUT /xresource/{resourceid}
	 * @return
	 */
	public HttpHeaders createOrUpdate();
	
	/**
	 * 创建一个资源(资源的uri由Client决定)
	 * POST /xresource/{resourceid}
	 * @return
	 */	
	public HttpHeaders appendData();
	
	/**
	 * 删除一个资源
	 * DELETE /xresource/{resourceid}
	 * @return
	 */	
	public HttpHeaders remove();
	
	/**
	 * 查看一个资源的元数据
	 * HEAD /xresource/{resourceid}
	 * @return
	 */	
	public HttpHeaders viewMeta();	
	
	/**
	 * 查看一组资源的元数据
	 * HEAD /xresource/
	 * @return
	 */	
	public HttpHeaders viewStructureMeta();	
	
	/**
	 * 查看一组资源,服务端所提供的操作类型
	 * OPTIONS /xresource/
	 * @return
	 */	
	public HttpHeaders viewResourcesOperations();		
	
	/**
	 * 查看一个资源,服务端所提供的操作类型
	 * OPTIONS /xresource/{resourceid}
	 * @return
	 */	
	public HttpHeaders viewResourceOperations();

	
	/**
	 * 查看一个资源,服务端所提供的操作类型
	 * GET /xresource/new
	 * @return
	 */	
	public HttpHeaders editNew();
	
}

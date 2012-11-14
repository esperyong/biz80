/**
 * 
 */
package com.mocha.bsm.bizsm.struts2rest.support;

import com.mocha.bsm.bizsm.struts2rest.DefaultHttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author liuyong
 *
 */
public abstract class RestResourceSupport extends ActionSupport implements
		IRestResource, ModelDriven<Object> {
	
	
	private String id;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public Object getModel(){
		return null;
	}
	
	protected HttpHeaders unSupport(){
    	HttpHeaders info = new DefaultHttpHeaders()
	    .disableCaching()
	    .renderResult(Action.NONE)
	    .withStatus(400);		
    	return info;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#appendData()
	 */
	public HttpHeaders appendData() {
		return this.unSupport();
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#createOrUpdate()
	 */
	public HttpHeaders createOrUpdate() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#createSubResource()
	 */
	public HttpHeaders createSubResource() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#editNew()
	 */
	public HttpHeaders editNew() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#list()
	 */
	public HttpHeaders list() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#remove()
	 */
	public HttpHeaders remove() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#view()
	 */
	public HttpHeaders view() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#viewMeta()
	 */
	public HttpHeaders viewMeta() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#viewResourceOperations()
	 */
	public HttpHeaders viewResourceOperations() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#viewResourcesOperations()
	 */
	public HttpHeaders viewResourcesOperations() {
		return this.unSupport();
	}

	/**
	 * @see com.mocha.bsm.bizsm.struts2rest.support.IRestResource#viewStructureMeta()
	 */
	public HttpHeaders viewStructureMeta() {
		return this.unSupport();
	}

}

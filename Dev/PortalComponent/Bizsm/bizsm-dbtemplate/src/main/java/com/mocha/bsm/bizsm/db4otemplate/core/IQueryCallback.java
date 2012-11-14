package com.mocha.bsm.bizsm.db4otemplate.core;

import com.db4o.ObjectContainer;
import com.db4o.query.Query;
/**
 * 使用DB4O中的SODA方式进行查询的
 * 模板接口,客户程序在该方法中返回
 * @author liuyong
 *
 */
public interface IQueryCallback {
	/**
	 * 生成一个Query并返回
	 * @see ObjectContainer#query()
	 * @param oc - {@link ObjectContainer}
	 * @return
	 */
	public Query generateQuery(ObjectContainer oc);
}

package com.mocha.bsm.bizsm.db4otemplate.core;

import com.db4o.ObjectContainer;

public interface ISessionCallback {
	/**
	 * 执行一个事务
	 * @param oc - {@link ObjectContainer}
	 * @return Object result object if need
	 * @see IDb4oDAO#executeSession(ISessionTemplate)
	 */
	public Object execute(ObjectContainer oc) throws Exception;
}

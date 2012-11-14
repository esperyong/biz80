package com.mocha.bsm.bizsm.db4otemplate.core;
/**
 * 提供一个更新策略
 * @author liuyong
 *
 */
public interface IRefreshable {
	/**
	 * 根据对象样例
	 * 以一个策略来更新对象
	 * @param examplemodel
	 */
	public void refresh(IRefreshable examplemodel);
}

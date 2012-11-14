package com.mocha.bsm.bizsm.adapter;
/**
 * 缓存接口,减少对实际系统的压力
 * @author liuyong
 */
public interface ICacheAble {
	/**
	 * 清空Cache
	 */
	public void emptyCache();
}

package com.mocha.bsm.bizsm.db4otemplate.database;

import com.db4o.config.EmbeddedConfiguration;

public interface IDb4oConfigurationLoader {

	/**
	 * 设置数据库配置
	 * @param path
	 * @return
	 */
	public abstract void loadDbConfig(EmbeddedConfiguration dbConfig);

}
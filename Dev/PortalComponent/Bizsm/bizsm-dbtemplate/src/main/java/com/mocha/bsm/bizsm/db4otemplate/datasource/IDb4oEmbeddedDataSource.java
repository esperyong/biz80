package com.mocha.bsm.bizsm.db4otemplate.datasource;

import com.mocha.bsm.bizsm.db4otemplate.database.IEmbeddedDb4oServer;

public interface IDb4oEmbeddedDataSource extends IDb4oDataSource {
	public void setDataBase(IEmbeddedDb4oServer db);
}

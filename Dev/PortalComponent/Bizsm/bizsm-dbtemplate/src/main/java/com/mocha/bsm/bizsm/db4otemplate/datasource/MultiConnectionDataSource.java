package com.mocha.bsm.bizsm.db4otemplate.datasource;

import com.db4o.ObjectContainer;
import com.mocha.bsm.bizsm.db4otemplate.database.IEmbeddedDb4oServer;

public class MultiConnectionDataSource implements IDb4oEmbeddedDataSource {

	private IEmbeddedDb4oServer db;
	
	public MultiConnectionDataSource(){
	}
	
	public MultiConnectionDataSource(IEmbeddedDb4oServer db){
		this.db = db;
	}		
	
	public void setDataBase(IEmbeddedDb4oServer db) {
		this.db = db;
	}
	
	public ObjectContainer getConnection() {
		return this.db.getDataBase().openSession();
	}
	
	public boolean shouldClose(ObjectContainer con) {
		return true;
	}

}

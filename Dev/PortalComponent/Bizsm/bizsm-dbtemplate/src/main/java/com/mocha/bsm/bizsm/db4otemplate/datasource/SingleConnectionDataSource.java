package com.mocha.bsm.bizsm.db4otemplate.datasource;


import com.db4o.ObjectContainer;
import com.mocha.bsm.bizsm.db4otemplate.database.IEmbeddedDb4oServer;

public class SingleConnectionDataSource implements IDb4oEmbeddedDataSource {
	
	private IEmbeddedDb4oServer db;
	
	private ObjectContainer conn = null;
	
	private byte[] lock = new byte[0];
	
	public SingleConnectionDataSource(){
	}
	
	public SingleConnectionDataSource(IEmbeddedDb4oServer db){
		this.db = db;
	}
	
	public void setDataBase(IEmbeddedDb4oServer db) {
		this.db = db;
	}
	
	public ObjectContainer getConnection() {
		synchronized (lock) {
			if(this.conn == null){
					this.conn = this.db.getDataBase();
			}
		}	
		return this.conn;			
		
	}
	
	public boolean shouldClose(ObjectContainer conn){
		return false;
	}
	
}

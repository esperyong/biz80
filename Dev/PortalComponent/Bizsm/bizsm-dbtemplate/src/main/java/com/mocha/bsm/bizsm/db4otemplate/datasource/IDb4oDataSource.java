package com.mocha.bsm.bizsm.db4otemplate.datasource;

import com.db4o.ObjectContainer;

public interface IDb4oDataSource {
	  
	  public ObjectContainer getConnection();
	  
	  public boolean shouldClose(ObjectContainer con);
	  
}
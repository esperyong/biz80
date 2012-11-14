package com.mocha.bsm.bizsm.db4otemplate.exception;

/**
 * @author liuyong
 */
public class DBConfigFileException  extends BaseCheckedException {
	
	public DBConfigFileException(String msg) {
		super(msg);
	}
	
	public DBConfigFileException(String msg, Throwable ex) {
		super(msg, ex);
	}
	
}

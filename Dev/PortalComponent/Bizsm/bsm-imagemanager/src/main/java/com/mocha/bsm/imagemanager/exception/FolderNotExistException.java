package com.mocha.bsm.imagemanager.exception;

public class FolderNotExistException extends BaseCheckedException {
	
	public FolderNotExistException(String msg) {
		super(msg);
	}
	
	public FolderNotExistException(String msg, Throwable ex) {
		super(msg, ex);
	}

}
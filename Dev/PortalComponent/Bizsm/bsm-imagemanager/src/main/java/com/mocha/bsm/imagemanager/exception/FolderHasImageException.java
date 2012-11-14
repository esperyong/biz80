package com.mocha.bsm.imagemanager.exception;
/**
 * 描述一个Folder下存在图片导致的异常
 * 通常是用户试图删除Folder时有可能发生
 * @author liuyong
 *
 */
public class FolderHasImageException extends BaseCheckedException {
	
	public FolderHasImageException(String msg) {
		super(msg);
	}
	
	public FolderHasImageException(String msg, Throwable ex) {
		super(msg, ex);
	}

}

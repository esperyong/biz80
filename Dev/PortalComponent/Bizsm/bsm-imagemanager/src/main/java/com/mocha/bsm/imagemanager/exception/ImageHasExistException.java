package com.mocha.bsm.imagemanager.exception;
/**
 * 描述一个Image图片已经存在导致的异常
 * 通常是用户试图创建图片时有可能发生
 * @author liuyong
 * 
 */
public class ImageHasExistException extends BaseCheckedException {
	
	public ImageHasExistException(String msg) {
		super(msg);
	}
	
	public ImageHasExistException(String msg, Throwable ex) {
		super(msg, ex);
	}
}
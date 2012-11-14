package com.mocha.bsm.imagemanager.exception;
/**
 * 提示图片没有找到引发的异常
 * 在删除图片的时候抛出
 * @author liuyong
 *
 */
public class ImageNotFoundException extends BaseCheckedException {
	
	public ImageNotFoundException(String msg) {
		super(msg);
	}
	
	public ImageNotFoundException(String msg, Throwable ex) {
		super(msg, ex);
	}
	
}

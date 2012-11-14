/**
 * 
 */
package com.mocha.bsm.bizsm.annotation;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * @author liuyong
 * 表示一个类型在使用XStream
 * 序列化时不需要对xml进行转义
 */
@Retention(RetentionPolicy.RUNTIME)
public @interface XStreamDisableEscapeXml {
	
}

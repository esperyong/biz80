/**
 * 
 */
package com.mocha.bsm.bizsm.core.model.state;

/**
 * @author liuyong
 *
 */
public enum BizServiceState {
	SERIOUS,	//严重
	WARNING,	//警告
	NORMAL,		//正常
	UNKNOWN     //无法获知,计算状态所需要的每个值都没取到
}

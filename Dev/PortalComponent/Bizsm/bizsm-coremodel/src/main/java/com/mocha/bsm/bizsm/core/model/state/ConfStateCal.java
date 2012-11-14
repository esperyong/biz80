/**
 * 
 */
package com.mocha.bsm.bizsm.core.model.state;

import java.util.ArrayList;
import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.converters.basic.BooleanConverter;
import com.thoughtworks.xstream.converters.enums.EnumConverter;

/**
 * 自定义配置状态计算规则
 * @author liuyong
 */
@XStreamAlias("ConfStateCal")
public class ConfStateCal implements IBizServiceStateCal {
	
	@XStreamAlias("assertions")
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	private List<Assertion> assertions;
	
	@XStreamAlias("and")
	@XStreamConverter(BooleanConverter.class)
	private boolean and = true;
	
	@XStreamAlias("expectedState")
	@XStreamConverter(EnumConverter.class)
	private BizServiceState expectedState = BizServiceState.UNKNOWN;
	
	/**
	 * 用来记录计算原因
	 */
	@XStreamAlias("calulateLog")
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	private List<String> calulateLog;
	
	public ConfStateCal(BizServiceState expectedState){
		this.assertions = new ArrayList<Assertion>();
		this.calulateLog = new ArrayList<String>();
		this.expectedState = expectedState;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.model.state.IBizServiceStateCal#calculateState(com.mocha.bsm.bizsm.core.model.BizService)
	 */
	public StateCalResult calculateState() throws Exception{
		AssertResult result = null;
		if(this.isAnd()){
			result = this.andCompute(this.assertions);
		}else{
			result = this.orCompute(this.assertions);
		}
		if(result.equals(AssertResult.TRUE)){
			return StateCalResult.SATISFY;
		}else if(result.equals(AssertResult.FALSE)){
			return StateCalResult.UNSATISFIED;//不符合这个计算规则所期望的状态值
		}else{//UNKNOWN
			return StateCalResult.INSUFFICIENT;
		}
	}
	
	protected AssertResult andCompute(List<Assertion> assertions) throws Exception{
		AssertResult assertResult = AssertResult.IGNORE;
		for (Assertion assertion:this.assertions) {
			AssertResult result = assertion.doAssert();
			if(result.equals(AssertResult.IGNORE)){
				continue;
			}else if(result.equals(AssertResult.TRUE)){
				assertResult = AssertResult.TRUE;
			}else{
				assertResult = AssertResult.FALSE;
				break;
			}
		}		
		return assertResult;
	}
	
	protected AssertResult orCompute(List<Assertion> assertions) throws Exception{
		AssertResult assertResult = AssertResult.IGNORE;
		for (Assertion assertion:this.assertions) {
			AssertResult result = assertion.doAssert();
			if(result.equals(AssertResult.IGNORE)){
				continue;
			}else if(result.equals(AssertResult.TRUE)){
				assertResult = AssertResult.TRUE;
				break;
			}else{
				assertResult = AssertResult.FALSE;
			}
		}		
		return assertResult;
	}
	
	
	public boolean isAnd() {
		return and;
	}

	public void setAnd(boolean and) {
		this.and = and;
	}

	public BizServiceState getExpectedState() {
		return expectedState;
	}

	public void setExpectedState(BizServiceState expectedState) {
		this.expectedState = expectedState;
	}

	public List<Assertion> getAssertions() {
		return assertions;
	}

	public void setAssertions(List<Assertion> assertions) {
		this.assertions = assertions;
	}
	
	public void addAssertion(Assertion assertion) {
		this.assertions.add(assertion);
	}
	
	public List<String> getCalulateLog() {
		return calulateLog;
	}

	public void setCalulateLog(List<String> calulateLog) {
		this.calulateLog = calulateLog;
	}
	
	
	
}

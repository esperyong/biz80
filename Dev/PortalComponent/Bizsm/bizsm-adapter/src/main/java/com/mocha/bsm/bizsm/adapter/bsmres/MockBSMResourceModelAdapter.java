/**
 * 
 */
package com.mocha.bsm.bizsm.adapter.bsmres;

import java.util.Calendar;

/**
 * 随机生成一些状态,用于和BSM集成之前的本体调试
 * 和独立环境的测试
 * @author liuyong
 *
 */
public class MockBSMResourceModelAdapter implements IBSMResourceModelAdapter {
	
	/* 
	 * @see com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter#getMetricState(java.lang.String, java.lang.String, java.util.Calendar)
	 */
	public BSMCompositeState getMetricState(String resInstanceId,
			String metricId, Calendar occurTime) {		
		return this.getRandomMetricCompositeState();
	}
	
	/* 
	 * @see com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter#getResourceState(java.lang.String, java.util.Calendar)
	 */
	public BSMCompositeState getResourceState(String resInstanceId,
			Calendar occurTime) {
		return this.getRandomResourceCompositeState();
	}
	
	protected BSMCompositeState getRandomMetricCompositeState(){
		BSMCompositeState compositeState = new BSMCompositeState();
		int i = ((int)(Math.random() * 2)) + 1;
		if(i == 1){
			compositeState.setAvailState(this.getRandomAvailState());
		}else{
			compositeState.setPerfState(this.getRandomPerfState());
		}
		return compositeState;
	}

	
	
	protected BSMCompositeState getRandomResourceCompositeState(){
		BSMCompositeState compositeState = new BSMCompositeState();
		compositeState.setAvailState(this.getRandomAvailState());
		compositeState.setPerfState(this.getRandomPerfState());
		return compositeState;
	}
	
	protected BSMAvailState getRandomAvailState(){
		BSMAvailState[] availStates = BSMAvailState.values();
		int availStateNum = availStates.length;
		int i = ((int)(Math.random() * availStateNum));
		return availStates[i];
	}
	
	protected BSMPerfState getRandomPerfState(){
		BSMPerfState[] perfStates = BSMPerfState.values();
		int perfStateNum = perfStates.length;
		int i = ((int)(Math.random() * perfStateNum));
		return perfStates[i];
	}

}

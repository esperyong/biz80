package com.mocha.bsm.bizsm.adapter.bsmres;
import java.util.Arrays;
import java.util.Calendar;

public class BSMResourceModelAdapterTest extends BSMAdapterBaseTestCase {

	public void testGetMetricState() {
		
		BSMCompositeState state = this.resourceModelAdapter.getMetricState("123" , "123456" , Calendar.getInstance());
		
		if(state.getAvailState().equals(BSMAvailState.AVAILUNKNOWN)){
			assertFalse(state.getPerfState().equals(BSMPerfState.PERFUNKNOWN));
			assertTrue(Arrays.asList(BSMPerfState.values()).contains(state.getPerfState()));
		}else{
			assertTrue(Arrays.asList(BSMAvailState.values()).contains(state.getAvailState()));
		}
		
	}

	public void testGetResourceState() {
		BSMCompositeState state = this.resourceModelAdapter.getResourceState("123", Calendar.getInstance());
		
		assertTrue(Arrays.asList(BSMAvailState.values()).contains(state.getAvailState()));
		
		assertTrue(Arrays.asList(BSMPerfState.values()).contains(state.getPerfState()));
	}

}

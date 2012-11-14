/**
 * 
 */
package com.mocha.bsm.bizsm.core.model.state;

import java.util.Map;
import java.util.Map.Entry;

import junit.framework.TestCase;
import net.sf.json.JSONObject;
/**
 * @author liuyong
 *
 */
public class AssertionTest extends TestCase {

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
	}
	
	public void testJson(){
		String resState = "{'resinsid':'123','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}";
		String resMetricState = "{'resinsid':'123','metricid':'CPU_RATE','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}";
		String childResMetricState = "{'resinsid':'123','childresinsid':'123','metricid':'CPU_RATE','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}";
		String childResState = "{'resinsid':'123','childresinsid':'123','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}";
		String bizServiceState = "{'bizserviceid':'123','bizservicestate':'SERIOUS'}";//SERIOUS,严重 WARNING,警告 NORMAL,正常 UNKNOWN无法获知,计算状态所需要的每个值都没取到
		JSONObject jsonObject = JSONObject.fromObject( bizServiceState );  
		
		Map<String,Object> map = (Map) JSONObject.toBean( jsonObject, Map.class );
		
		for (Object entryObj : map.entrySet()) {
			Entry entry = (Entry)entryObj;
			System.out.println(entry.getKey()+":"+entry.getValue());
		}
		
	}
	
	/**
	 * Test method for {@link com.mocha.bsm.bizsm.core.model.state.Assertion#compile()}.
	 */
	public void testCompile() {
		fail("Not yet implemented"); // TODO
	}

	/**
	 * Test method for {@link com.mocha.bsm.bizsm.core.model.state.Assertion#doAssert()}.
	 */
	public void testDoAssert() {
		fail("Not yet implemented"); // TODO
	}

}

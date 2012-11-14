/**
 * 
 */
package com.mocha.bsm.bizsm.core.service;

import com.mocha.bsm.bizsm.core.model.BizServices;
import com.mocha.bsm.bizsm.core.test.BizsmCoremodelBaseTest;

import junit.framework.TestCase;

/**
 * @author liuyong
 *
 */
public class BizServiceStateCalJobTest extends BizsmCoremodelBaseTest {
	

	/**
	 * Test method for {@link com.mocha.bsm.bizsm.core.service.BizServiceStateCalJob#fetchAndCalState()}.
	 */
	public void testFetchAndCalState() throws Exception{
		BizServiceStateCalJob job = (BizServiceStateCalJob)this.getBean("bizsm.bizServiceStateCalJob");
		
		BizServices services = job.fetchAndCalState();
	}

}

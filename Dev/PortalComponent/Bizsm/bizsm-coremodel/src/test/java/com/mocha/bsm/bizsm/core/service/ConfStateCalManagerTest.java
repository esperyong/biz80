/**
 * 
 */
package com.mocha.bsm.bizsm.core.service;

import java.util.List;

import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.state.Assertion;
import com.mocha.bsm.bizsm.core.model.state.BizServiceState;
import com.mocha.bsm.bizsm.core.model.state.ConfStateCal;
import com.mocha.bsm.bizsm.core.test.BizsmCoremodelBaseTest;

import junit.framework.TestCase;

/**
 * @author liuyong
 *
 */
public class ConfStateCalManagerTest extends BizsmCoremodelBaseTest {

	/**
	 * Test method for {@link com.mocha.bsm.bizsm.core.service.ConfStateCalManager#getStateCal(java.lang.String, com.mocha.bsm.bizsm.core.model.state.BizServiceState)}.
	 */
	public void testGetStateCal() {
		BizService bizService = this.getSampleServiceWithoutId();
		this.bizServiceManager.saveBizService(bizService);
		ConfStateCal stateCal = this.confStateCalManager.getStateCal(bizService.getBizId(), BizServiceState.SERIOUS);
		assertEquals(BizServiceState.SERIOUS,stateCal.getExpectedState());
	}

	/**
	 * Test method for {@link com.mocha.bsm.bizsm.core.service.ConfStateCalManager#saveStateCal(java.lang.String, com.mocha.bsm.bizsm.core.model.state.ConfStateCal)}.
	 */
	public void testSaveStateCal() {
		BizService bizService = this.getSampleServiceWithoutId();
		this.bizServiceManager.saveBizService(bizService);
		ConfStateCal stateCal = this.confStateCalManager.getStateCal(bizService.getBizId(), BizServiceState.SERIOUS);
		
		assertEquals(0,stateCal.getAssertions().size());
		assertEquals(true,stateCal.isAnd());		
		
		stateCal = new ConfStateCal(BizServiceState.SERIOUS);
		stateCal.setAnd(false);
		Assertion assertion = new Assertion();
		assertion.setSrcCode("1234567");
		stateCal.addAssertion(assertion);
		
		this.confStateCalManager.saveStateCal(bizService.getBizId(), stateCal);
		
		stateCal = this.confStateCalManager.getStateCal(bizService.getBizId(), BizServiceState.SERIOUS);
		assertEquals(1,stateCal.getAssertions().size());
		assertEquals(false,stateCal.isAnd());
		assertEquals("1234567",stateCal.getAssertions().get(0).getSrcCode());
		
		Assertion assertion2 = new Assertion();
		assertion2.setSrcCode("12345678");
		stateCal.addAssertion(assertion2);
		stateCal.getAssertions().remove(assertion);
		stateCal.setAnd(true);
		this.confStateCalManager.saveStateCal(bizService.getBizId(), stateCal);
		
		stateCal = this.confStateCalManager.getStateCal(bizService.getBizId(), BizServiceState.SERIOUS);
		assertEquals(1,stateCal.getAssertions().size());
		assertEquals(true,stateCal.isAnd());
		assertEquals("12345678",stateCal.getAssertions().get(0).getSrcCode());
		
		List<Assertion> result = this.db4oTemplate.query(new Predicate<Assertion>(){
			   public boolean match(Assertion service) {
				      return true;
			   }
		});
		
		assertEquals(1,result.size());
		
	}

}

package com.mocha.bsm.bizsm.adapter.bsmres;

import junit.framework.TestCase;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class BSMAdapterBaseTestCase extends TestCase{
	/**
	 * Log Instance.
	 */
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected ApplicationContext context = null;
	protected IBSMResourceModelAdapter resourceModelAdapter = null;
	
	public BSMAdapterBaseTestCase(){
	}
	
	protected void setUp() throws Exception {
		//加载所有服务
		this.context = new ClassPathXmlApplicationContext("classpath*:/META-INF/mochasoft/services.xml");
		((AbstractApplicationContext)this.context).registerShutdownHook();
		this.resourceModelAdapter = (IBSMResourceModelAdapter)this.getBean("bizsm.resmodeladapter");
		
	}
	
	protected void tearDown() throws Exception {
		super.tearDown();
	}
	
	protected Object getBean(String beanId){
		return this.context.getBean(beanId);
	}
}

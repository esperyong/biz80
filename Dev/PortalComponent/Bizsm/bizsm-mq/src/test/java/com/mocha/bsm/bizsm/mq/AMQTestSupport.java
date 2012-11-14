package com.mocha.bsm.bizsm.mq;

import javax.jms.Destination;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jms.core.JmsTemplate;

import junit.framework.TestCase;

/**
 * 
 * @author liuyong
 */
public class AMQTestSupport extends TestCase {
	Destination destination;
	ApplicationContext ctx;
	JmsTemplate template;
	
	protected void setUp() throws Exception {
		this.ctx = new ClassPathXmlApplicationContext("classpath*:/META-INF/mochasoft/services.xml");
        this.template = (JmsTemplate)this.ctx.getBean("jmsTemplate");
        this.destination = (Destination)this.ctx.getBean("bizserviceStates");
	}
	
	protected void tearDown() throws Exception {
		
	}

}

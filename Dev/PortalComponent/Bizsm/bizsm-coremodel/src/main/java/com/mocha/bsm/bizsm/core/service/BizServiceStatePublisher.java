/**
 * 
 */
package com.mocha.bsm.bizsm.core.service;

import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizServices;
import com.mocha.bsm.bizsm.serializer.ISerializer;
import com.mocha.bsm.bizsm.serializer.XStreamSerializer;

/**
 * @author liuyong
 *
 */
public class BizServiceStatePublisher implements IBizServiceStatePublisher {
	
	private ISerializer handler;
	
	private JmsTemplate jmsTemplate;
	
	private Log log = LogFactory.getLog(this.getClass());	
	
	
	public BizServiceStatePublisher(){
		this.handler = new XStreamSerializer();
	}
	
	public void setJmsTemplate(JmsTemplate jmsTemplate) {
		this.jmsTemplate = jmsTemplate;
	}
	
	/**
	 * @see com.mocha.bsm.bizsm.core.service.IBizServiceStatePublisher#publish(java.util.List)
	 */
	public void publish(final BizServices bizServices) {
		try {
			List<BizService> services = bizServices.getServices();
			if(services != null){
				for (BizService service : services) {
					final String serviceId = service.getBizId();
					StringWriter writer = new StringWriter();
					this.handler.fromObject(service, writer);
					final String messageContent = writer.toString();
					jmsTemplate.send(new MessageCreator() {
			            public Message createMessage(Session session) throws JMSException {
			                TextMessage message = session.createTextMessage(messageContent);
			                message.setStringProperty("BIZSERVICE_ID",serviceId);
			                return message;
			            }
			        });
				}				
			}
		} catch (IOException ioe) {
			log.error(ioe);
		}
	}
	
}

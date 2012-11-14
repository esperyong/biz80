
package com.mocha.bsm.bizsm.mq;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;
import org.springframework.jms.core.MessageCreator;

/**
 * @author liuyong
 *
 */
public class AMQTest extends AMQTestSupport {
	
	public void testJmsTemplate() throws Exception{
		
		template.setPubSubDomain(true);
		
//        template.send(this.destination, new MessageCreator() {
//            public Message createMessage(Session session) throws JMSException {
//                TextMessage message = session.createTextMessage("Hello World!");
//                message.setStringProperty("id", "1");
//                return message;
//            }
//        });
        template.send(new MessageCreator() {
            public Message createMessage(Session session) throws JMSException {
                TextMessage message = session.createTextMessage("Hello World!");
                message.setStringProperty("id", "1");
                return message;
            }
        });        
        Thread.sleep(1000);
//        TextMessage message = (TextMessage)template.receive(this.topicName);
//        
//        assertEquals("Hello World!",message.getText());
	}
	
	
}

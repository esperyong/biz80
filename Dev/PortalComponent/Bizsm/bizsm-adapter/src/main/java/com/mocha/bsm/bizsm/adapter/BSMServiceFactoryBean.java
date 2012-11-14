/**
 * 
 */
package com.mocha.bsm.bizsm.adapter;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.InitializingBean;
import com.mocha.bsm.service.proxy.ServiceProxy;

/**
 * 
 * @author liuyong
 *
 */
public class BSMServiceFactoryBean implements FactoryBean, InitializingBean {
	
	private Class<?> serviceClass;
	
	/**
	 * The name of the Interface.
	 * <p>This property is required.
	 * @param logName the name of the log
	 */
	public void setServiceName(String serviceName) throws ClassNotFoundException{
		
		this.serviceClass = Class.forName(serviceName);
	}
	
	public void afterPropertiesSet() {
		if (this.serviceClass == null) {
			throw new IllegalArgumentException("'className' is required");
		}
	}

	public Object getObject() throws Exception{
		Object result = ServiceProxy.getService(this.serviceClass);
		return result;
	}
	
	public Class<?> getObjectType() {
		return this.serviceClass;
	}
	
	public boolean isSingleton() {
		return true;
	}

}

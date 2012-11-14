package com.mocha.bsm.bizsm.core.model;

import java.io.StringReader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.mocha.bsm.bizsm.adapter.bsmres.BSMCompositeState;
import com.mocha.bsm.bizsm.core.model.state.Assertion;
import com.mocha.bsm.bizsm.core.model.state.BizServiceState;
import com.mocha.bsm.bizsm.core.model.state.BizServiceStateBeans;
import com.mocha.bsm.bizsm.core.model.state.ConfStateCal;
import com.mocha.bsm.bizsm.serializer.ISerializer;
import com.mocha.bsm.bizsm.serializer.XStreamSerializer;
import junit.framework.TestCase;

public class BizServiceTest extends TestCase {
	ISerializer handler;
	protected void setUp() throws Exception {
		super.setUp();
		handler = new XStreamSerializer();
	}

	protected void tearDown() throws Exception {
		super.tearDown();
	}
	/**
	 * 序列化
	 */
	public void testFromObject() throws Exception{
		BizService obj = this.getSampleService();
		StringWriter writer = new StringWriter();
		handler.fromObject(obj, writer);
		
		System.out.println(writer.toString());
	}
	
	public void testFromBizServiceBeans() throws Exception{
		BizService obj = this.getSampleService();
		BizService obj2 = this.getSampleService();
		
		List<BizService> list = new ArrayList<BizService>();
		
		list.add(obj);
		
		list.add(obj2);
		BizServices bizServices = new BizServices(list);
		BizServiceStateBeans stateBeans = new BizServiceStateBeans(bizServices);
		
		StringWriter writer = new StringWriter();
		
		handler.fromObject(stateBeans, writer);
		
		System.out.println(writer.toString());		
	}
	
	/**
	 * 序列化
	 */
	public void testFromObjectList() throws Exception{
		BizService obj = this.getSampleService();
		BizService obj2 = this.getSampleService();
		
		List<BizService> list = new ArrayList<BizService>();
		
		list.add(obj);
		
		list.add(obj2);
		BizServices bizServices = new BizServices(list);
		
		StringWriter writer = new StringWriter();
		
		handler.fromObject(bizServices, writer);
		
		System.out.println(writer.toString());
	}	
	
	public void testFromConfStateCal() throws Exception{
		ConfStateCal stateCal = new ConfStateCal(BizServiceState.NORMAL);
		stateCal.setAnd(true);
		stateCal.setExpectedState(BizServiceState.SERIOUS);
		Assertion assertion1 = new Assertion();
		assertion1.setSrcCode("[aaa:bbb]");
		Assertion assertion2 = new Assertion();
		assertion2.setSrcCode("[aaa:bbb]");
		stateCal.addAssertion(assertion1);
		stateCal.addAssertion(assertion2);
		StringWriter writer = new StringWriter();
		
		handler.fromObject(stateCal, writer);
		System.out.println(writer.toString());
	}
	
	public BizService getSampleService(){
		BizService obj = new BizService();
		obj.setBizId("123");
		obj.setReflectFactor(33);
		obj.setRemark("描述信息xxx");
		
		obj.setCreateDate(new Date());
		obj.setLastUpdateDate(new Date());
		
		obj.setBelongDomainIds(new String[]{"123","233"});
		obj.setName("业务服务1");
		BizService chiledobj = new BizService();
		chiledobj.setName("业务服务2");
		chiledobj.setBelongDomainIds(null);
		obj.addChildBizService(chiledobj);
		
		BizUser bizUser = new BizUser();
		bizUser.setId("1");
		bizUser.setName("北京电视台");
		bizUser.addIp(IPv4.getByName("192.168.6.241"));
		bizUser.addVlsm(VLSM.getVLSM(IPv4.getByName("192.168.1.0"), 24));
		BizUser bizUser2 = new BizUser();
		bizUser2.setId("2");
		bizUser2.setName("中央电视台");
		BizUser bizUser3 = new BizUser();
		bizUser3.setId("3");
		bizUser3.setName("河北电视台");
		obj.addBizUser(bizUser);
		obj.addBizUser(bizUser2);
		obj.addBizUser(bizUser3);
		
		MonitableResource mres = new MonitableResource("123");
		MonitableResource mres1 = new MonitableResource("1223");
		obj.addMonitableResource(mres);
		obj.addMonitableResource(mres1);
		
		ResponsiblePerson rp = new ResponsiblePerson();
		rp.setEmailAddress("liuyong@rd.mochasoft.com.cn");
		rp.setId("123");
		rp.setName("刘勇");
		rp.setTelephoneNumber("13911893209");
		obj.setResponsiblePerson(rp);
		
		
		return obj;
	}
	
	/**
	 * 反序列化
	 */
	public void testToObject() throws Exception{
		BizService obj = this.getSampleService();
		obj.setMonitoredState(BizServiceState.SERIOUS);
		StringWriter writer = new StringWriter();
		
		handler.fromObject(obj, writer);		
		StringReader reader = new StringReader(writer.toString());
		BizService toObj = new BizService();
		
		handler.toObject(reader, toObj);
		
		for(IPv4 ip:toObj.getBizUsers().get(0).getIps()){
			System.out.println(ip.getIpStr());	
		}
		
		for(VLSM vlsm:toObj.getBizUsers().get(0).getVlsms()){
			System.out.println(vlsm.getIp().getIpStr());	
			System.out.println(vlsm.getMaskStr());
			System.out.println(vlsm.contains(IPv4.getByName("192.168.1.205")));
		}
		
	}
	
	/**
	 * 反序列化2
	 */
	public void testToObject2() throws Exception{
		String s = "<BizService><name>业务服务1</name></BizService>";
		StringReader reader = new StringReader(s);
		BizService toObj = new BizService();
		handler.toObject(reader, toObj);
		System.out.println(toObj);	
	}	
	
	/**
	 * 反序列化3
	 */
	public void testToObject3() throws Exception{
		String s = "<BizService><monitered>true</monitered></BizService>";
		StringReader reader = new StringReader(s);
		BizService toObj = new BizService();
		handler.toObject(reader, toObj);
		System.out.println(toObj);	
	}
	
	/**
	 * 反序列化
	 * @throws Exception
	 */
	public void testToBizUser() throws Exception{
		String s = "<BizUser>";
	     s += "<name>中央电视台</name>";
	     s += "<id>2</id>";
	     s += "<uri>/bizuser/2</uri>";
	     s += "<ips class=\"tree-set\"><no-comparator/></ips>"; 
	     s += "<vlsms class=\"tree-set\"><no-comparator/></vlsms>";
	     s += "</BizUser>";
	     StringReader reader = new StringReader(s);
	     BizUser user = new BizUser();
	     handler.toObject(reader, user);
	     System.out.println(user);
	    		
	}

}

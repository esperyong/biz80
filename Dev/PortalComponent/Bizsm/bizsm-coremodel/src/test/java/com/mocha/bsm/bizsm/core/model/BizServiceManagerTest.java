package com.mocha.bsm.bizsm.core.model;

import java.io.StringWriter;
import java.util.Date;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.service.IBizServiceManager;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.database.Db4oEmbeddedServer;
import com.mocha.bsm.bizsm.serializer.ISerializer;
import com.mocha.bsm.bizsm.serializer.XStreamSerializer;

import junit.framework.TestCase;

public class BizServiceManagerTest extends TestCase {

	ApplicationContext context = null;
	IDb4oTemplate db4oTemplate = null;
	Db4oEmbeddedServer server = null;
	IBizServiceManager bManager = null;
	ISerializer handler = null;
	protected void setUp() throws Exception {
		super.setUp();
		this.context = new ClassPathXmlApplicationContext("classpath*:/META-INF/mochasoft/services.xml");
		((AbstractApplicationContext)this.context).registerShutdownHook();
		this.db4oTemplate = (IDb4oTemplate)context.getBean("db4oTemplateMultiConn");
		this.server = (Db4oEmbeddedServer)context.getBean("db4oEmbeddedServer");
		this.server.startup();
		this.db4oTemplate.delete(new Predicate<BizService>(){
			   public boolean match(BizService service) {
				      return true;
				   }
		});
		this.bManager = (IBizServiceManager)this.context.getBean("bizsm.bizServiceManager");
		handler = new XStreamSerializer();
		System.out.println(server.getContextPath());
		
	}

	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public void testGetBizService() {
		this.testSaveBizService();
		assertNotNull(this.bManager.getBizServiceByName("业务服务1"));
	}

	public void testLoadGraph() {
		fail("Not yet implemented"); // TODO
	}

	public void testSaveBizService() {
		BizService bizService = new BizService();
		bizService.setName("业务服务1");
		bizService.setReflectFactor(10);
		this.bManager.saveBizService(bizService);
	}
	public BizService getSampleService(){
		BizService obj = new BizService();
		//obj.setBizId("123");
		obj.setReflectFactor(33);
		obj.setRemark("描述信息xxx");
		
		obj.setCreateDate(new Date());
		obj.setLastUpdateDate(new Date());
		
		obj.setBelongDomainIds(new String[]{"123","233"});
		obj.setName("业务服务1");
		
		BizUser bizUser = new BizUser();
		//bizUser.setId("1");
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
	public void testDeleteBizService() throws Exception{
		BizService bizService = this.getSampleService();
		
		BizService bizService2 = this.getSampleService();	
		
		this.bManager.saveBizService(bizService);
		
		this.bManager.saveBizService(bizService2);
		
		bizService = this.bManager.getBizServiceById(bizService.getBizId());
		
		TestCase.assertNotNull(bizService.getCreateDate());
		TestCase.assertNotNull(bizService.getLastUpdateDate());
		
		this.bManager.deleteBizServiceById(bizService.getBizId());
		
		bizService2 = this.bManager.getBizServiceById(bizService2.getBizId());
		TestCase.assertNotNull(bizService2.getCreateDate());
		TestCase.assertNotNull(bizService2.getLastUpdateDate());		

		
		
		for (BizService service:this.bManager.getAllBizService()) {
			TestCase.assertNotNull(service.getCreateDate());
			TestCase.assertNotNull(service.getLastUpdateDate());
			StringWriter writer = new StringWriter();
			handler.fromObject(service, writer);
			System.out.println(writer.toString());
		}
		
	}
	
	public void testGetCanAdoptBizServiceByServiceId(){
		this.testSaveBizService();
		this.testSaveBizService();
		this.testSaveBizService();
		
		List<BizService> services = this.bManager.getAllBizService();
		BizService service = services.get(0);
		List<BizService> results = this.bManager.getCanAdoptBizServiceByServiceId(service.getBizId());
		
		assertEquals(2, results.size());
	}

	public void testSaveGraph() {
		fail("Not yet implemented"); // TODO
	}

}

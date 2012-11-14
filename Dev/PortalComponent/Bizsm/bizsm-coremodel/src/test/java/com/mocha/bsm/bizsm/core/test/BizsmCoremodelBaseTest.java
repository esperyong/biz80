package com.mocha.bsm.bizsm.core.test;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizTopologyGraph;
import com.mocha.bsm.bizsm.core.model.BizUser;
import com.mocha.bsm.bizsm.core.model.GraphInfo;
import com.mocha.bsm.bizsm.core.model.IPv4;
import com.mocha.bsm.bizsm.core.model.MonitableResource;
import com.mocha.bsm.bizsm.core.model.ResponsiblePerson;
import com.mocha.bsm.bizsm.core.model.VLSM;
import com.mocha.bsm.bizsm.core.service.BizTopologyGraphManager;
import com.mocha.bsm.bizsm.core.service.BizUserManager;
import com.mocha.bsm.bizsm.core.service.ConfStateCalManager;
import com.mocha.bsm.bizsm.core.service.IBizServiceManager;
import com.mocha.bsm.bizsm.core.util.UidGenerator;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.database.Db4oEmbeddedServer;
import junit.framework.TestCase;

public abstract class BizsmCoremodelBaseTest extends TestCase {
	/**
	 * Log Instance.
	 */
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected ApplicationContext context = null;
	protected IDb4oTemplate db4oTemplate = null;
	protected Db4oEmbeddedServer server = null;
	
	protected IBizServiceManager bizServiceManager = null;
	protected BizTopologyGraphManager topoManager = null;
	protected BizUserManager bizUserManager = null;
	protected ConfStateCalManager confStateCalManager = null;
	public BizsmCoremodelBaseTest(){
		//加载所有服务
		this.context = new ClassPathXmlApplicationContext("classpath*:/META-INF/mochasoft/services.xml");
		
		//((AbstractApplicationContext)this.context).registerShutdownHook();
		
		this.db4oTemplate = (IDb4oTemplate)this.getBean("db4oTemplateMultiConn");
		this.server = (Db4oEmbeddedServer)this.getBean("db4oEmbeddedServer");
		//取出所有需要测试的服务
		this.bizServiceManager = (IBizServiceManager)this.getBean("bizsm.bizServiceManager");
		this.topoManager = (BizTopologyGraphManager)this.getBean("bizsm.bizTopoManager");
		this.bizUserManager = (BizUserManager)this.getBean("bizsm.bizUserManager");		
		this.confStateCalManager = (ConfStateCalManager)this.getBean("bizsm.confStateCalManager");
		//启动数据库
		this.server.startup();		
	}
	protected void setUp() throws Exception {
		super.setUp();
		
		//清空数据库
		this.db4oTemplate.delete(new Predicate<Object>(){
			   public boolean match(Object obj) {
				      return true;
			   }
		});
		
		log.info("dbcontext:["+server.getContextPath()+"]");
	}
	
	protected void tearDown() throws Exception {
		super.tearDown();
	}
	
	protected Object getBean(String beanId){
		return this.context.getBean(beanId);
	}
	
	protected BizTopologyGraph getSampleTopoWithoutId(){
		BizService service = this.getSampleServiceWithoutId();
		service.setBizId(UidGenerator.generateUid());
		BizTopologyGraph topo = new BizTopologyGraph();
		topo.setBizService(service);
		GraphInfo info = new GraphInfo();
		info.setInfo("<graphInfo></graphInfo>");
		topo.setGraphInfo(info);
		return topo;
	}
	
	protected BizUser getSampleUserWithoutId(String name,String ip,String vlsm){
		BizUser bizUser = new BizUser();
		bizUser.setName(name);
		bizUser.addIp(IPv4.getByName(ip));
		bizUser.addVlsm(VLSM.getVLSM(IPv4.getByName(vlsm), 24));
		return bizUser;
	}
	
	protected BizService getSampleServiceWithoutId(){
		BizService obj = new BizService();
		obj.setReflectFactor(33);
		obj.setRemark("描述信息xxx");
		
		obj.setCreateDate(new Date());
		obj.setLastUpdateDate(new Date());
		
		obj.setBelongDomainIds(new String[]{"123","233","domain2"});
		obj.setName("业务服务1");
		
		BizUser bizUser = new BizUser();
		bizUser.setId(UidGenerator.generateUid());
		bizUser.setName("北京电视台");
		bizUser.addIp(IPv4.getByName("192.168.6.241"));
		bizUser.addVlsm(VLSM.getVLSM(IPv4.getByName("192.168.1.0"), 24));
		BizUser bizUser2 = new BizUser();
		bizUser2.setId(UidGenerator.generateUid());
		bizUser2.setName("中央电视台");
		BizUser bizUser3 = new BizUser();
		bizUser3.setId(UidGenerator.generateUid());
		bizUser3.setName("河北电视台");
		obj.addBizUser(bizUser);
		obj.addBizUser(bizUser2);
		obj.addBizUser(bizUser3);
		
		MonitableResource mres = new MonitableResource(UidGenerator.generateUid());
		MonitableResource mres1 = new MonitableResource(UidGenerator.generateUid());
		obj.addMonitableResource(mres);
		obj.addMonitableResource(mres1);
		
		ResponsiblePerson rp = new ResponsiblePerson();
		rp.setEmailAddress("liuyong@rd.mochasoft.com.cn");
		rp.setId(UidGenerator.generateUid());
		rp.setName("刘勇");
		rp.setTelephoneNumber("13911893209");
		obj.setResponsiblePerson(rp);
		
		return obj;
	}
	
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:/META-INF/mochasoft/services.xml");
		System.out.println("HelloWorld");
	}
}

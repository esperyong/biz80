package com.mocha.bsm.bizsm.db4otemplate.core;

import java.util.List;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.db4otemplate.database.Db4oEmbeddedServer;
import junit.framework.TestCase;

public class Db4oTemplateTest extends TestCase {
	ApplicationContext context = null;
	IDb4oTemplate db4oTemplate = null;
	Db4oEmbeddedServer server = null;
	protected void setUp() throws Exception {
		super.setUp();
		this.context = new ClassPathXmlApplicationContext("classpath*:/META-INF/mochasoft/services.xml");
		((AbstractApplicationContext)this.context).registerShutdownHook();
		this.db4oTemplate = (IDb4oTemplate)context.getBean("db4oTemplateSingleConn");
		this.server = (Db4oEmbeddedServer)context.getBean("db4oEmbeddedServer");
		this.server.startup();
		this.db4oTemplate.delete(new Predicate<Person>(){
			   public boolean match(Person person) {
				      return true;
				   }			
		});
		System.out.println(server.getContextPath());
		
	}
	
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public void testDeletePredicateOfExtentType() {
		fail("Not yet implemented"); // TODO
	}

	public void testDeleteIQueryCallback() {
		fail("Not yet implemented"); // TODO
	}

	public void testDeleteLongArray() {
		fail("Not yet implemented"); // TODO
	}

	public void testDeleteObject() {
		fail("Not yet implemented"); // TODO
	}

	public void testGetByIDLong() {
		fail("Not yet implemented"); // TODO
	}

	public void testGetByIDLongInt() {
		fail("Not yet implemented"); // TODO
	}

	public void testQueryPredicateOfT() {
		fail("Not yet implemented"); // TODO
	}

	public void testQueryIQueryCallback() {
		fail("Not yet implemented"); // TODO
	}

	public void testQueryWithId() {
		fail("Not yet implemented"); // TODO
	}

	public void testQueryAll() {
		fail("Not yet implemented"); // TODO
	}

	public void testQueryAllWithId() {
		fail("Not yet implemented"); // TODO
	}

	public void testQueryLongArray() {
		fail("Not yet implemented"); // TODO
	}

	public void testPagingQuery() {
		fail("Not yet implemented"); // TODO
	}

	public void testSaveObject() {
		Person person = new Person();
		person.setName("liuyong");
		person.setSex("male");
		this.db4oTemplate.save(person);		
		
		List<Person> persons = this.db4oTemplate.query(new Predicate<Person>(){
			   public boolean match(Person person) {
				      return person.getName().equals("liuyong");
			   }			
		});
		
		assertEquals(1, persons.size());
	}

	public void testSaveCollectionOfT() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdateLongIRefreshable() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdateLongIRefreshableInt() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdateLongArrayIRefreshableArray() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdateLongArrayIRefreshableArrayInt() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdateLongArrayIRefreshableInt() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdateLongArrayIRefreshable() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdatePredicateOfTIRefreshable() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdatePredicateOfTIRefreshableInt() {
		fail("Not yet implemented"); // TODO
	}

	public void testExecuteSession() {
		fail("Not yet implemented"); // TODO
	}

	public void testGetID() {
		fail("Not yet implemented"); // TODO
	}

	public void testActivateObject() {
		fail("Not yet implemented"); // TODO
	}

	public void testActivateObjectInt() {
		fail("Not yet implemented"); // TODO
	}

}

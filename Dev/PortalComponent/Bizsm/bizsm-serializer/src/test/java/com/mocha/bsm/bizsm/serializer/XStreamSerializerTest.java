package com.mocha.bsm.bizsm.serializer;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

public class XStreamSerializerTest extends TestCase {
	XStreamSerializer handler = null;
	protected void setUp() throws Exception {
		super.setUp();
		handler = new XStreamSerializer();
	}

	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public void testFromObject() {
		
		
		StringWriter writer = new StringWriter();
		List s = new ArrayList();
		Apple a = new Apple();
		a.setColor("blue");
		a.setName("big");
		s.add(a);
		s.add(a);
		handler.fromObject(s, writer);
		
		System.out.println(writer.toString());		
		
	}

	public void testToObject() {
		fail("Not yet implemented"); // TODO
	}

}

package com.mocha.bsm.bizsm.core.model;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.mocha.bsm.bizsm.core.test.BizsmCoremodelBaseTest;
public class BizTopologyGraphTest extends BizsmCoremodelBaseTest {

	public void testCreateTopoForBizService(){
		BizService service = this.getSampleServiceWithoutId();
		this.bizServiceManager.saveBizService(service);
		this.topoManager.createTopoForBizService(service.getBizId());
		
		assertEquals(1,this.topoManager.getAllTopo().size());
		BizTopologyGraph graph = this.topoManager.getTopoByBizServiceId(service.getBizId());
		assertNotNull(graph);
		
		assertTrue(graph.getUri().equals("/biztopo/"+graph.getTopoId()));
	}
	
	public void testRemoveElementFromList(){
		Set<BizUser> bizUser = new HashSet<BizUser>();
		BizUser user = new BizUser();
		user.setId("1");
		bizUser.add(user);
		BizUser user2 = new BizUser();
		user2.setId("1");
		assertTrue(bizUser.contains(user2));
	}
	
	public void testUpdateTopo(){
		
		BizService serviceInDB = this.getSampleServiceWithoutId();
		
		this.bizServiceManager.saveBizService(serviceInDB);
		
		String bizId = serviceInDB.getBizId();
		
		assertNotNull(bizId);
		
		BizTopologyGraph topoInDB = this.topoManager.createTopoForBizService(bizId);
		
		assertNotNull(topoInDB.getTopoId());
		
		BizTopologyGraph requestTopo = this.getSampleTopoWithoutId();
		
		requestTopo.setTopoId(topoInDB.getTopoId());
		
		assertEquals(3,requestTopo.getBizService().getBizUsers().size());
		
		assertEquals(3,topoInDB.getBizService().getBizUsers().size());
		
		this.topoManager.updateTopo(requestTopo);
		
		assertEquals(3,topoInDB.getBizService().getBizUsers().size());
		
		List<BizUser> newUsers = topoInDB.getBizService().getBizUsers();
		
		for (BizUser user:newUsers) {
			assertTrue(requestTopo.getBizService().getBizUsers().contains(user));
		}
		
	}
	
}

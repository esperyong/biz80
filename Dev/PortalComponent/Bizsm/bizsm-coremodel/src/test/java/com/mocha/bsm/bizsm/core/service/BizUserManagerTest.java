package com.mocha.bsm.bizsm.core.service;

import java.util.List;

import com.mocha.bsm.bizsm.core.model.BizUser;
import com.mocha.bsm.bizsm.core.model.IPv4;
import com.mocha.bsm.bizsm.core.test.BizsmCoremodelBaseTest;

public class BizUserManagerTest extends BizsmCoremodelBaseTest {
	public BizUserManagerTest(){
		super();
	}
	protected void createSomeUserInDB(){
		BizUser user1 = this.getSampleUserWithoutId("北京电视台","192.168.6.240","192.168.6.240");
		BizUser user2 = this.getSampleUserWithoutId("河北电视台","192.168.11.240","192.168.11.240");
		BizUser user3 = this.getSampleUserWithoutId("辽宁电视台","192.168.15.240","192.168.15.240");
		this.bizUserManager.saveBizUser(user1);
		this.bizUserManager.saveBizUser(user2);
		this.bizUserManager.saveBizUser(user3);
	}
	
	public void testGetAllBizUser() {
		List<BizUser> users = this.bizUserManager.getAllBizUser();
		assertEquals(0, users.size());
		this.createSomeUserInDB();
		users = this.bizUserManager.getAllBizUser();
		assertEquals(3, users.size());
	}
	
	public void testGetBizUserById(){
		this.createSomeUserInDB();
		String userID = null;
		for (BizUser user:this.bizUserManager.getAllBizUser()) {
			userID = user.getId();
			assertNotNull(this.bizUserManager.getUserById(userID));
		}
	}

	public void testSaveBizUser() {
		fail("Not yet implemented"); // TODO
	}

	public void testUpdateBizUserInfo() {
		BizUser user1 = this.getSampleUserWithoutId("北京电视台","192.168.6.240","192.168.6.240");
		BizUser user2 = this.getSampleUserWithoutId("河北电视台","192.168.11.240","192.168.11.240");
		this.bizUserManager.saveBizUser(user1);
		this.bizUserManager.saveBizUser(user2);
		BizUser user1InDB = this.bizUserManager.getUserById(user1.getId());
		assertEquals(1,user1InDB.getIps().size());
		BizUser user2InDB = this.bizUserManager.getUserById(user2.getId());
		assertEquals(1,user2InDB.getIps().size());		
		assertNotNull(user1.getId());
		assertNotNull(user2.getId());
		assertEquals("/bizuser/" + user1.getId(),user1.getUri());
		assertEquals("/bizuser/" + user2.getId(),user2.getUri());
		
		user1.addIp(IPv4.getByName("192.168.6.241"));
		this.bizUserManager.updateBizUserInfo(user1);//Test
		
		user1InDB = this.bizUserManager.getUserById(user1.getId());
		assertEquals(2,user1InDB.getIps().size());
		user2InDB = this.bizUserManager.getUserById(user2.getId());
		assertEquals(1,user2InDB.getIps().size());		
		
		
		user1.getIps().remove(IPv4.getByName("192.168.6.241"));
		this.bizUserManager.updateBizUserInfo(user1);//Test
		user1InDB = this.bizUserManager.getUserById(user1.getId());
		assertEquals(1,user1InDB.getIps().size());		
		
		
	}

	public void testDeleteBizUserById() {
		fail("Not yet implemented"); // TODO
	}

}

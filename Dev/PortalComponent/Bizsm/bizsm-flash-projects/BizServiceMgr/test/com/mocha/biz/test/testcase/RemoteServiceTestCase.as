package com.mocha.biz.test.testcase
{
	import com.mocha.common.business.remote.BatchRemoteService;
	import com.mocha.common.business.remote.RemoteBean;
	import com.mocha.common.business.remote.RemoteService;
	import com.mocha.common.business.responder.BaseResponder;
	import com.mocha.common.business.responder.RemoteObjectResponder;
	import com.mocha.common.business.responder.XMLToObjectResponder;

	public class RemoteServiceTestCase
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testRemoteSerive():void
		{
			var bean:RemoteBean;
			var remote:BaseResponder = new RemoteObjectResponder();
			var service:RemoteService;
			RemoteService.remoteObjectService(bean);
			var responder:RemoteObjectResponder;
		}
		
		[Test]
		public function testHttpService():void
		{
			var responder:XMLToObjectResponder;
			
		}
		
		[Test]
		public function testBatchService():void
		{
			var service:BatchRemoteService;
			
		}
		
	}
}
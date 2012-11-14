package com.mocha.biz.test.testcase
{
	import com.mocha.common.util.ObjectInfoUtil;
	import com.mocha.biz.vo.logic.BizSerivceVO;
	
	import mx.utils.ObjectUtil;
	
	import org.flexunit.Assert;

	public class BizServiceVOTestCase
	{		
		private var xml:XML;
		[Before]
		public function setUp():void
		{
			xml = <BizService>
				<uri>/bizservice/123</uri>
				<bizId>123</bizId>
				<name>业务服务1</name>
				<refGraphId>1234</refGraphId>
				<reflectFactor>33</reflectFactor>
				<ResponsiblePerson>
				  <id>123</id>
				  <name>刘勇</name>
				  <telephoneNumber>13911893209</telephoneNumber>
				  <emailAddress>liuyong@rd.mochasoft.com.cn</emailAddress>
				</ResponsiblePerson>
				<belongDomainIds>
				  <string>123</string>
				  <string>233</string>
				</belongDomainIds>
				<remark>描述信息xxx</remark>
				<childBizServices>
				  <BizService>
					<name>业务服务2</name>
					<refGraphId>0</refGraphId>
					<reflectFactor>0</reflectFactor>
					<ResponsiblePerson/>
					<childBizServices/>
					<monitableResources/>
					<bizUsers/>
				  </BizService>
				</childBizServices>
				<monitableResources>
				  <MonitableResource>
					<resourceInstanceId>123</resourceInstanceId>
				  </MonitableResource>
				  <MonitableResource>
					<resourceInstanceId>1223</resourceInstanceId>
				  </MonitableResource>
				</monitableResources>
				<bizUsers>
				  <BizUser>
					<name>北京电视台</name>
					<id>1</id>
				  </BizUser>
				  <BizUser>
					<name>中央电视台</name>
					<id>2</id>
				  </BizUser>
				  <BizUser>
					<name>河北电视台</name>
					<id>3</id>
				  </BizUser>
				</bizUsers>
			  </BizService>
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
		public function testXMLVOConvert():void
		{
			var aa:ObjectInfoUtil;
			var bus:BizSerivceVO = new BizSerivceVO();
			ObjectInfoUtil.xmlToObject(xml,bus);
			
			var obj:Assert;
			Assert.assertEquals(bus.bizId,xml.bizId);
			trace("xml to Obj>>>\n" + ObjectUtil.toString(bus));
			
			var temp:XML = ObjectInfoUtil.objectToXML(bus);
			
			Assert.assertEquals(bus.name,temp.name);
			trace("obj to xml>>>\n" + ObjectUtil.toString(temp));

		}
		
	}
}
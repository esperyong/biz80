package com.mocha.common.vo
{
	import com.mocha.common.util.BizInspectable;
	import com.mocha.common.util.ObjectInfoUtil;
	
	import mx.logging.ILogger;
	import mx.logging.Log;

	/**
	 * TODO：com.mocha.biz.vo.BaseVO
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-15  下午02:01:01
	 */
	public class BaseVO implements BizInspectable
	{
		private static var log:ILogger = Log.getLogger("com.mocha.common.vo.BaseVO");
		[TstInspectable]
		public function get prosAsXMLAttribute():Object
		{
			var attributes:Object = {};
			var allProperties:Object = ObjectInfoUtil.getClassAllProperties(this);
			for each(var pro:Object in allProperties){
				if(pro["xml"]){
					attributes[pro["xml"]] = null;
				}
			}
			return attributes;
		}
		
		[TstInspectable]
		public function get transientPros():Object
		{
			var attributes:Object = {};
			var allProperties:Object = ObjectInfoUtil.getClassAllProperties(this);
			for each(var pro:Object in allProperties){
				if(pro["tst"]){
					attributes[pro["tst"]] = null;
				}
			}
			return attributes;
		}
		
		[TstInspectable]
		public function get aliasName():String
		{
//			log.warn("child class not implements method[get aliasName]!");
			return null;
		}
	}
}
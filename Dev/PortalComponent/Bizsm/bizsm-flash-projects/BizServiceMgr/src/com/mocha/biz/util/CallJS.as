package com.mocha.biz.util
{
	import com.mocha.biz.model.GraphLocator;
	
	import flash.external.ExternalInterface;
	
	import mx.logging.ILogger;
	import mx.logging.Log;

	/**
	 * @author chendg
	 * @version 1.0
	 * @created 14-����-2010 9:44:23
	 */
	public class CallJS
	{
	
		private static var log:ILogger = Log.getLogger("com.mocha.biz.util.CallJS");
		
		static public function initTopoFlashComplete():void
		{
			callJSProxy("initTopoFlashComplete");
		}
		
		static public function loadTopoDataComplete():void
		{
			callJSProxy("loadTopoDataComplete",GraphLocator.getInstance().fullGraphVO.uri,GraphLocator.getInstance().serviceId);
		}
		
		static public function saveTopoComplete():void
		{
			callJSProxy("saveTopoComplete",GraphLocator.getInstance().fullGraphVO.uri,GraphLocator.getInstance().serviceId);
		}
		
		static public function callJSProxy(funStr:String,...rest):void
		{
			log.info("callJSProxy [method={0},parameters={1}].",funStr,rest);
			try{
				switch(rest.length){
					case 0:
					{
						ExternalInterface.call(funStr);
						break;
					}
					case 1:
					{
						ExternalInterface.call(funStr,rest[0]);
						break;
					}
					case 2:
					{
						ExternalInterface.call(funStr,rest[0],rest[1]);
						break;
					}
					case 3:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2]);
						break;
					}
					case 4:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2],rest[3]);
						break;
					}
					case 5:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2],rest[3],rest[4]);
						break;
					}
					case 6:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2],rest[3],rest[4],rest[5]);
						break;
					}
					case 7:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2],rest[3],rest[4],rest[5],rest[6]);
						break;
					}
					case 8:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2],rest[3],rest[4],rest[5],rest[6],rest[7]);
						break;
					}
					case 9:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2],rest[3],rest[4],rest[5],rest[6],rest[7],rest[8]);
						break;
					}
					case 10:
					{
						ExternalInterface.call(funStr,rest[0],rest[1],rest[2],rest[3],rest[4],rest[5],rest[6],rest[7],rest[8],rest[9]);
						break;
					}
					default:
					{
						log.error("callJSProxy [method={0},parameters={1}] expected parameters'length is 10.",
							funStr,rest);
					}
				}
			} catch(e:Error){
				log.error("callJSProxy [method={0},parameters={1}] error:::\n{2}",
					funStr,rest,e);
			}
		}
		
//	    /**
//	     * 
//	     * @param selectedChilds
//	     */
//	    static public function updateChildService(selectedChilds:Array): void
//	    {
//	    }
//	
//	    /**
//	     * 
//	     * @param selectedInstanceIds
//	     */
//	    static public function updateMonitorInstance(selectedInstanceIds:Array): void
//	    {
//	    }
//	
//	    /**
//	     * 
//	     * @param name
//	     */
//	    static public function updateName(name:String): void
//	    {
//	    }
	
	}//end CallJS
}
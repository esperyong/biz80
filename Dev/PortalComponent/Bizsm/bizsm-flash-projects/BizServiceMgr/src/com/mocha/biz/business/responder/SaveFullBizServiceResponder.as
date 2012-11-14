package com.mocha.biz.business.responder
{
	import com.mocha.biz.util.CallJS;
	import com.mocha.common.business.responder.BaseResponder;
	import com.mocha.common.event.RemoteEvent;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	
	/**
	 * TODO：com.mocha.biz.business.responder.SaveFullBizServiceResponder
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-27  下午05:08:45
	 */
	public class SaveFullBizServiceResponder extends BaseResponder
	{
		private var log:ILogger = Log.getLogger("com.mocha.biz.business.responder.SaveFullBizServiceResponder");
		public function SaveFullBizServiceResponder()
		{
			super();
			this.addEventListener(RemoteEvent.REMOTE_ITEM_FINISH,remoteFinish,false,0,true);
		}
		
		private function remoteFinish(e:RemoteEvent):void
		{
			if(e.resultFault as FaultEvent){
//				Alert.show("save fail>>>"+e.resultFault);
				log.error("save error" + e.resultFault);
			}
			CallJS.saveTopoComplete();
		}
	}
}
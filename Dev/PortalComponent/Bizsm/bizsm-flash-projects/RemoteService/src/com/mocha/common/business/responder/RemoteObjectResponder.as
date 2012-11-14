package com.mocha.common.business.responder
{
	import com.mocha.common.event.RemoteEvent;
	import com.mocha.common.util.ObjectInfoUtil;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	
	/**
	 * 主要用于RemoteObject方式请求远程资源,且结果集是集合.<br>
	 * <b>需要指定:</b><br>
	 * <li><b>targetClass:</b>默认Object
	 * <li><b>isNotifyFinish:</b>默认true，处理完毕发送事件<br><br>
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  下午12:06:39
	 */
	public class RemoteObjectResponder extends BaseResponder
	{
		private var log:ILogger = Log.getLogger("com.mocha.common.business.responder.RemoteObjectResponder");
		
		public function RemoteObjectResponder(targetV:*=null,_isNotifyFinish:Boolean=true):void
		{
			super(targetV,_isNotifyFinish);
		}
		
		
		override public function result(data:Object):void
		{
			if(!this.invokeCheckSameRequest(data)){
				log.error("result response header not equal request header!");
				return;
			}
			if(ObjectInfoUtil.classHaveAliasDef(this._targetClass)){
				this._targetObj = this._targetClass(data.result);
			} else {
				this._targetObj = new this._targetClass();
				ObjectInfoUtil.objectPropertiesMerge(this._targetObj,data.result);
			}
			
			notifyFinish(data);
		}
		
		override public function fault(info:Object):void
		{
			if(!this.invokeCheckSameRequest(info)){
				log.error("fault response header not equal request header!");
				return;
			}
			notifyFinish(info);
		}
		
	}
}
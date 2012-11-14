package com.mocha.common.business.responder
{
	import com.mocha.common.util.ObjectInfoUtil;
	import com.mocha.common.util.XMLUtil;
	
	import flash.xml.XMLNode;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	
	/**
	 * 主要用于HTTPService方式请求远程资源,且结果不是集合.<br>
	 * <b>需要指定:</b><br>
	 * <li><b>targetClass:</b>默认Object
	 * <li><b>isNotifyFinish:</b>默认true，处理完毕发送事件<br><br>
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  下午12:05:54
	 */
	public class XMLToObjectResponder extends BaseResponder
	{
		private var log:ILogger = Log.getLogger("com.mocha.common.business.responder.XMLToObjectResponder");
		
		
		public function XMLToObjectResponder(targetV:*=null,_isNotifyFinish:Boolean=true):void
		{
			super(targetV,_isNotifyFinish);
		}
		
		override public function result(data:Object):void
		{
			if(!this.invokeCheckSameRequest(data)){
				log.error("result response header not equal request header!");
				return;
			}
			
			try{
				var targetClassHaveAlias:Boolean = ObjectInfoUtil.classHaveAliasDef(this._targetClass);
				if(data.result && data.result as XMLNode){
					var xml:XML = XML(data.result);
					XMLUtil.removeNullNodes(xml);
					this._targetObj = ObjectInfoUtil.xmlToObject(xml,this._targetClass);
				} else if(data.result){
					this._targetObj = new this._targetClass();
					for each(var topObj:Object in data.result){
						if(targetClassHaveAlias){
							this._targetObj = this._targetClass(topObj);
						} else {							
							this._targetObj = new this._targetClass();
							ObjectInfoUtil.objectPropertiesMerge(this._targetObj,topObj);
						}
					}
				} else {
					log.warn("request[token={0},data={1}] respone xml is null"
						,data.token,data.result);
					this._targetObj = null;
				}
			}catch(e:Error){
				log.warn("request[token={0},data={1}] respone conervt error={2}"
					,data.token,data.result,e.getStackTrace());
				this._targetObj = null;
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
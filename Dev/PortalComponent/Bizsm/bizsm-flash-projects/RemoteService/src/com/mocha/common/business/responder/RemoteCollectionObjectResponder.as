package com.mocha.common.business.responder
{
	import com.mocha.common.event.RemoteEvent;
	import com.mocha.common.util.ObjectInfoUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	
	/**
	 * 主要用于RemoteObject方式请求远程资源,且结果集是集合.
	 * <b>需要指定:</b><br>
	 * <li><b>targetClass:</b>默认ArrayCollection
	 * <li><b>itemTargetClass:</b>默认Object；如果itemTargetClass对应类有别名定义，可以不需要指定itemTargetClass
	 * <li><b>isNotifyFinish:</b>默认true，处理完毕发送事件<br><br>
	 * <b>派发event：</b><br>
	 * <li><b>RemoteEvent.REMOTE_ITEM_FINISH:</b> 处理完成事件</li>
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  下午12:06:39
	 */
	public class RemoteCollectionObjectResponder extends BaseResponder
	{
		private var log:ILogger = Log.getLogger("com.mocha.common.business.responder.RemoteCollectionObjectResponder");
		
		private var _itemTargetClass:Class;
		
		public function RemoteCollectionObjectResponder(_itemTargetClass:*,targetV:*=null,_isNotifyFinish:Boolean=true):void
		{
			if(!targetV){
				targetV = "mx.collections.ArrayCollection";
			}
			super(targetV,_isNotifyFinish);
			this.itemTargetClass = _itemTargetClass;
		}
		
		
		public function set itemTargetClass(targetV:Object):void
		{
			if(targetV){
				if(targetV is Class){
					this.itemTargetClass = Class(targetV);
				} else if(targetV is String){
					this._itemTargetClass = ObjectInfoUtil.getClass(targetV as String);
					if(!this._targetClass){
						log.error("class[{0}] not found! class default is Object.",targetV);
						this._itemTargetClass = Object;
					}
				} else {
					log.error("class[{0}] not found! class default is Object.",targetV);
					this._itemTargetClass = Object;
				}
			} else {
				log.error("class[{0}] not found! class default is ArrayCollection.",targetV);
				this._itemTargetClass = Object;
			}
		}
		
		override public function result(data:Object):void
		{
			if(!this.invokeCheckSameRequest(data)){
				log.error("result response header not equal request header!");
				return;
			}
			var targetClassHaveAlias:Boolean = ObjectInfoUtil.classHaveAliasDef(this._itemTargetClass);
			if(targetClassHaveAlias){
				this._targetObj = this._targetClass(data.result);
			} else {
				this._targetObj = new this._targetClass();
				var childIntance:Object;
				for each(var item:Object in data.result){
					childIntance = new this._itemTargetClass();
					childIntance = ObjectInfoUtil.objectPropertiesMerge(childIntance,item);
					pushItemObj(childIntance);
				}
			}
			
			notifyFinish(data);
		}
		
		override public function fault(info:Object):void
		{
			if(!this.invokeCheckSameRequest(info)){
				log.error("fault response header not equal request header!");
				return;
			}
			log.warn("remote[targetClass={0},itemClass={1}] fault,detail>>>>"
				,this._targetClass,this._itemTargetClass,info);
			notifyFinish(info);
		}
		
		private function pushItemObj(childItem:Object):void
		{
			if(this.targetObj){
				if(this.targetObj is Array){
					this.targetObj.push(childItem);
				} else if(this.targetObj is ArrayCollection ||
					this.targetObj is ArrayList){
					this.targetObj.addItem(childItem);
				}
			}	
		}
		
	}
}
package com.mocha.common.business.responder
{
	import com.mocha.common.util.ObjectInfoUtil;
	
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectUtil;

	/**
	 * 主要用于HTTPSerice方式请求远程资源,且结果集是集合.<br>
	 * <b>需要指定:</b><br>
	 * <li><b>targetClass:</b>默认ArrayCollection
	 * <li><b>itemTargetClass:</b>默认Object；如果itemTargetClass对应类有别名定义，可以不需要指定itemTargetClass
	 * <li><b>isNotifyFinish:</b>默认true，处理完毕发送事件<br><br>
	 * <b>派发event：</b><br>
	 * <li><b>RemoteEvent.REMOTE_ITEM_FINISH:</b> 处理完成事件</li>
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  下午04:39:29
	 */
	public class XMLToCollectionObjectResponder extends BaseResponder
	{
		private var log:ILogger = Log.getLogger("com.mocha.common.business.responder.XMLToCollectionObjectResponder");
		
		private var _itemTargetClass:Class;
		public function XMLToCollectionObjectResponder(_itemTargetClass:*,targetV:*=null,_isNotifyFinish:Boolean=true):void
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
				log.error("class[{0}] not found! class default is Object.",targetV);
				this._itemTargetClass = Object;
			}
		}
		
		override public function result(data:Object):void
		{
			if(!this.invokeCheckSameRequest(data)){
				log.error("result response header not equal request header!");
				return;
			}
			try{
				var targetClassHaveAlias:Boolean = ObjectInfoUtil.classHaveAliasDef(this._itemTargetClass);
				var childIntance:Object;
				if(data.result && data.result as XMLNode){
					var xml:XML = XML(data.result);
					this._targetObj = new this._targetClass();
					var childs:XMLList = xml.children();
					for each(var childXML:XML in childs){
						childIntance = this._itemTargetClass(ObjectInfoUtil.xmlToObject(childXML,this._itemTargetClass));
						pushItemObj(childIntance);
					}
				} else if(data.result){
					this._targetObj = new this._targetClass();
					for each(var topObj:Object in data.result){
						for each(var list:Object in topObj){
							if(list.hasOwnProperty("length") && list["length"] >0){
								for each(var childObj:Object in list){
									pushItemObj(childIntance);
									if(targetClassHaveAlias){
										childIntance = this._itemTargetClass(childObj);
									} else {							
										childIntance = new this._itemTargetClass();
										childIntance = ObjectInfoUtil.objectPropertiesMerge(childIntance,childObj);
									}
									pushItemObj(childIntance);
								}
							}
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
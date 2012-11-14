package com.mocha.common.business.responder
{
	import com.mocha.common.event.RemoteEvent;
	import com.mocha.common.util.ObjectInfoUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	[event(name="remoteItem",type="com.mocha.common.event.RemoteEvent")]
	
	/**
	 * TODO：com.mocha.common.business.responder.BaseResponder<br>
	 * 远程调用响应处理基类.
	 * 子类应该重写result和fault方法，并且子类通过在result和fault方法中调用
	 * <code>invokeCheckSameRequest</code>这个方法确定请求和响应是否是同一次。<br><br>
	 * <b>属性说明：</b><br>
	 * <b>_header:</b>请求和响应的头信息，由于比较请求和响应是否是一一对应<br>
	 * <b>_checkSameRequestFunction：</b>比较请求和响应是否相同的方法,默认：defualtCheckSameRequestFun，参数token对象<br>
	 * <b>dispatcher：</b>事件分发器<br>
	 * <b>isNotifyFinish：</b>处理完毕是否发通知<br>
	 * <b>_targetObj：</b>处理后的目标对象<br>
	 * <b>_targetClass：</b>处理后的目标对象的类
	 * <br><br><b>派发event：</b><br>
	 * <li><b>RemoteEvent.REMOTE_ITEM_FINISH:</b> 处理完成事件</li>
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  下午12:07:18
	 */
	public class BaseResponder extends EventDispatcher implements IEventDipatcherResponder
	{
		public static const HEADER:String = "header";
		
		private static var log:ILogger = 
			Log.getLogger("com.mocha.common.business.responder.BaseResponder");
		
		protected var _header:Object;
		protected var _checkSameRequestFunction:Function;
		private var dispatcher:IEventDispatcher;
		protected var isNotifyFinish:Boolean = true;
		protected var _targetObj:*;
		protected var _targetClass:Class = Object;
		
		/**
		 * 
		 * @param target 处理后的对象类字符串或者是类对象
		 * @param _isNotifyFinish 处理完毕后是否发通知
		 * 
		 */ 
		public function BaseResponder(target:*=null,_isNotifyFinish:Boolean=true):void
		{
			if(target){
				this.targetClass = target;
			}
			this.isNotifyFinish = _isNotifyFinish;
			
			
			this._checkSameRequestFunction = defualtCheckSameRequestFun;
		}
		
		/**
		 * 成处理函数，数据：data.result.
		 * 
		 */ 
		public function result(data:Object):void
		{
			if(!invokeCheckSameRequest(data)){
				log.error("result response header not equal request header!");
			} else {
				this._targetObj = data.result;
				this.notifyFinish(data);
			}
		}
		
		public function fault(info:Object):void
		{
			if(!invokeCheckSameRequest(info)){
				log.error("fault response header not equal request header!");
			} else {
				this._targetObj = null;
				this.notifyFinish(info);
			}
		}
		
		/**
		 * 保留请求的request header，用于检测请求和响应是否是同一次操作.
		 * @param headers 请求响应header，类型Object 
		 * 
		 */ 
		public function set header(headers:Object):void
		{
			this._header = headers;	
		}
		public function get header():Object
		{
			return this._header;
		}
		
		/**
		 * 检测请求和响应是否对应.
		 * <p>checkSameRequestFunction: 默认值为defualtCheckSameRequestFun，
		 * 		参数为token["header"]：Object,return：Boolean
		 * 		默认比较（token["header"] == this.header?）
		 * </p>
		 * 
		 */ 
		public function set checkSameRequestFunction(v:Function):void
		{
			this._checkSameRequestFunction = v;
		}
		
		public function get checkSameRequestFunction():Function
		{
			return this._checkSameRequestFunction;
		}
		
		/**
		 * 获取处理完成后转换的新对象.
		 */ 
		public function get targetObj():*{
			return this._targetObj;
		}
		
		/**
		 * 设置响应结果转换为的目标对象类型.
		 * @param targetV  类全路径名称或者类对象
		 * 如果设置的类路径没有找到或者设置null，默认targetClass是Object
		 * 
		 */ 
		public function set targetClass(targetV:Object):void
		{
			if(targetV){
				if(targetV is Class){
					this._targetClass = Class(targetV);
				} else if(targetV is String){
					this._targetClass = ObjectInfoUtil.getClass(targetV as String);
					if(!this._targetClass){
						log.error("class[{0}] not found! class default is Object.",targetV);
						this._targetClass = Object;
					}
				} else {
					log.error("class[{0}] not found! class default is Object.",targetV);
					this._targetClass = Object;
				}
			} else {
				log.error("class[{0}] not found! class default is Object.",targetV);
				this._targetClass = Object;
			}
		}

		
		/**
		 * 调用校验请求和响应是否是一一对应的.
		 * @param data result方法或者fault方法的参数
		 * 
		 */ 
		protected function invokeCheckSameRequest(data:Object):Boolean
		{
			if(this._checkSameRequestFunction != null && 
				!this._checkSameRequestFunction.call(this,data.token[HEADER])){
				return false;
			}
			return true;
		}
		
		/**
		 * 通知上层应用处理完毕.
		 * 
		 */ 
		protected function notifyFinish(resultFault:Object):void
		{
			if(this.isNotifyFinish){
				var e:RemoteEvent = new RemoteEvent(RemoteEvent.REMOTE_ITEM_FINISH);
				e.data = this.targetObj;
				e.resultFault = resultFault;
				this.dispatchEvent(e);
			}
		}
		
		protected function getResponeHeader(resultFault:Object):Object
		{
			if(resultFault && resultFault["token"]){
				return resultFault["token"][HEADER];
			}
			return null;
		}
		
		private function defualtCheckSameRequestFun(responeHeader:Object):Boolean
		{
			if(this._header == responeHeader){
				return true;
			}
			return false;
		}
	}
}
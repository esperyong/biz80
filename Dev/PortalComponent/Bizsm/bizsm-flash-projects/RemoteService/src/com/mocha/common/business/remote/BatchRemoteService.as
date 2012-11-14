package com.mocha.common.business.remote
{
	import com.mocha.common.event.RemoteEvent;
	import com.mocha.common.util.Queue;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.IResponder;
	import mx.utils.UIDUtil;

	/**
	 * 批量请求后台服务，包括HTTPService或者RemoteObject混合方式,请求完成后组件会发送一个RemoteEvent.REMOTE_ALL_FINISH事件.
	 * <br><b>方法介绍：</b><br>
	 * <li>remoteOrderServices: 队列中服务顺序请求 
	 * <li>remoteBatchServices: 队列中的服务并发请求
	 * 
	 * <b>派发event：</b><br>
	 * <li><b>RemoteEvent.REMOTE_ALL_FINISH:</b> 处理完成事件
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  上午10:29:49
	 */
	public class BatchRemoteService extends EventDispatcher
	{
		public static const RANDOM_HEADER_PREF:String = "RandomHeader@@@";
		private var queue:Queue;
		private var responder:ResponderProxy;
		
		
		private var isAddEvent:Boolean = false;
		
		private var isOrder:Boolean = false;
		
		public function BatchRemoteService(beans:Queue=null):void
		{
			this.queue = beans;
			responder = new ResponderProxy(false);
		}
		
		private function addEvent():void
		{
			if(!responder){
				responder = new ResponderProxy(false);
			}
			responder.addEventListener(RemoteEvent.REMOTE_ALL_FINISH_INNER,remoteAllFinish_handler);
			responder.addEventListener(RemoteEvent.REMOTE_ITEM_FINISH,itemRemoteElementFinish_handler);
			isAddEvent = true;
		}
		
		/**
		 * 顺序请求队列中的服务.
		 * @param beans Queue  	请求队列
		 * 
		 */ 
		public function remoteOrderServices(beans:Queue=null):void
		{
			if(!this.isAddEvent){
				addEvent();
			}
			responder.isOrder = true;
			isOrder = true;
			remoteServices(beans);
		}
		
		/**
		 * 并发请求.
		 * @param beans Queue  	请求队列
		 */ 
		public function remoteBatchServices(beans:Queue=null):void
		{
			if(!this.isAddEvent){
				addEvent();
			}
			responder.isOrder = false;
			isOrder = false;
			remoteServices(beans);
		}
		
		private  function remoteServices(beans:Queue=null):void
		{
			if(beans){
				this.queue = beans;
			}
			
			if(this.queue && this.queue.isEmpty){
				remoteAllFinish_handler(null);
				return;
			}
			var remoteBean:RemoteBean;
			if(this.isOrder){
				remoteBean = queue.peek();
				remote(remoteBean);
			} else {
				
				this.responder.remoteCount = queue.length;
				
				while(!queue.isEmpty){
					remoteBean = queue.peek();
					remote(remoteBean);
				}
			}
		}
		
		private function remote(remoteBean:RemoteBean):void
		{
			if(remoteBean){
				var header:Object = {};
				if(!remoteBean.header){
					header["oldheader"] = RANDOM_HEADER_PREF + UIDUtil.createUID();
				} else {
					header["oldheader"] = remoteBean.header;
				}
				header["responder"] = remoteBean.responder;
				remoteBean.header = header;
				remoteBean.responder = this.responder;
				
				if(remoteBean.remoteMethod && remoteBean.destination){
					RemoteService.remoteObjectService(remoteBean);
				} else {
					RemoteService.remoteHttpService(remoteBean);
				}
			}
		}

		private function remoteAllFinish_handler(e:Event):void
		{
			responder.removeEventListener(RemoteEvent.REMOTE_ALL_FINISH_INNER,remoteAllFinish_handler);
			responder.removeEventListener(RemoteEvent.REMOTE_ITEM_FINISH,itemRemoteElementFinish_handler);
			
			this.isOrder = false;
			this.queue = null;
			this.responder = null;
			this.isAddEvent = false;
			
			var fEvent:RemoteEvent = new RemoteEvent(RemoteEvent.REMOTE_ALL_FINISH);
			this.dispatchEvent(fEvent);
		}
		private function itemRemoteElementFinish_handler(e:Event):void
		{
			if(this.isOrder){
				remoteServices();
			}
		}
	}
}

import com.mocha.common.business.remote.BatchRemoteService;
import com.mocha.common.event.RemoteEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import mx.rpc.AsyncToken;
import mx.rpc.IResponder;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

/**
 * 代理响应类.
 * 
 * 
 * 
 * 
 */ 
class ResponderProxy extends EventDispatcher implements IResponder,IEventDispatcher
{
	public var isOrder:Boolean = false;
	
	
	public var remoteCount:Number = 0;
	
	public function ResponderProxy(b:Boolean):void
	{
		this.isOrder = b;
	}
	
	public function result(data:Object):void
	{
		
		if(data is ResultEvent){
			var token:AsyncToken = data.token;
			var currentResponder:IResponder = parseToken(token);
			if(currentResponder){				
				currentResponder.result(data);
			}
		}
		if(isOrder){
			remoteCount--;
		}
		checkFinish();
	}
	
	public function fault(info:Object):void
	{
		if(info is FaultEvent){
			var token:AsyncToken = info.token;
			var currentResponder:IResponder = parseToken(token);
			if(currentResponder){
				currentResponder.fault(info);
			}
		}
		
		if(isOrder){
			remoteCount--;
		}
		checkFinish();
	}
	
	
	private function checkFinish():void
	{
		var e:RemoteEvent;
		if(!this.isOrder){
			if(this.remoteCount <= 0){
				e = new RemoteEvent(RemoteEvent.REMOTE_ALL_FINISH_INNER);
				this.dispatchEvent(e);
			}
		} else {
			e = new RemoteEvent(RemoteEvent.REMOTE_ITEM_FINISH);
			this.dispatchEvent(e);
		}
	}
	
	private function parseToken(token:AsyncToken):IResponder
	{
		var currentResponder:IResponder = token["header"]["responder"];
		if(token["header"]["oldheader"] is String
			&& token["header"]["oldheader"].indexOf(BatchRemoteService.RANDOM_HEADER_PREF) == 0){
			token["header"] = null;
		} else {
			token["header"] = token["header"]["oldheader"];
		}
		return currentResponder;
	}

}
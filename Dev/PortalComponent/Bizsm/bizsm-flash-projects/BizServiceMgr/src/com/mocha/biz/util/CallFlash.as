package com.mocha.biz.util
{
	import flash.external.ExternalInterface;
	
	import mx.logging.ILogger;
	import mx.logging.Log;

	/**
	 * @author chendg
	 * @version 1.0
	 * @created 14-����-2010 9:44:23
	 */
	public class CallFlash
	{
		private static var log:ILogger = Log.getLogger("com.mocha.biz.util.CallFlash");
		
		private static var proxy:CallFlashProxy;
		public static function initCallBack():void
		{
			proxy = new CallFlashProxy();
			ExternalInterface.addCallback("callFlash",callFlash);
		}
		
		public static function callFlash(funStr:String,...rest):void
		{
			log.info("callFlash [method={0},parameters={1}]",funStr,rest);
			
			if(proxy.hasOwnProperty(funStr)){
				var fun:Function = proxy[funStr];
				if(fun == null){
					log.warn("CallFlashProxy not exist [method={0}]",funStr);
					return;
				}
				if(isInvalidParameters(fun.length,rest,funStr)){
					return;
				}
				fun.apply(proxy,rest);
			} else {
				log.warn("CallFlashProxy not contain method={0}",funStr);
			}
		}
		
		private static function isInvalidParameters(len:Number,rest:Array,method:String):Boolean
		{
			if(rest.length == len){
				return false;
			}
			log.warn("[Method={0}] expected parameter [length={1}],but actual parameter [length={2}]",
				method,len,rest.length);
			return true;
		}
	
	  
	
	}//end CallFlash
}
import com.mocha.biz.business.service.BizManager;
import com.mocha.biz.business.service.SelectedService;
import com.mocha.biz.core.common.NodeType;
import com.mocha.biz.event.GraphActionEvent;
import com.mocha.biz.model.BizControl;
import com.mocha.biz.model.GraphLocator;
import com.mocha.biz.util.BizEditorUtil;

import flash.external.ExternalInterface;

import mx.logging.ILogger;
import mx.logging.Log;

class CallFlashProxy{
	
	private static var log:ILogger = Log.getLogger("CallFlashProxy");
	
	public function choose(type:String,uri:String):void
	{
		SelectedService.choose(type,uri);
	}
	
	public function editComplete(type:String,uri:String):void{
		var url:String = BizEditorUtil.uriConvertToURL(uri);
		switch(type){
			case NodeType.BIZSERVICE:
			{
				BizManager.remoteSubBizService(url,false);
				break;
			}
			case NodeType.BIZUSER:
			{
				BizManager.remoteBizUser(url,false);
				break;
			}
			case NodeType.RESOURCE:
			{
				BizManager.remoteMonitorResource(url,false);
				break;
			}
			default:
			{
				log.warn("NodeType[type={0},uri={1}] is Invalid when updating node."
							,type,uri);
			}
		}
	}
	
	public function deleteComplete(type:String,uri:String):void{
	}
	
	public function saveTopo(contentPath:String):void{
		BizManager.save(contentPath);
	}
	
	public function chooseTopo(uri:String):void{
		var url:String = BizEditorUtil.uriConvertToURL(uri,null);
		BizManager.openFullGraph(url);
	}
	
	public function unChoose():void{
		BizEditorUtil.selectDefaultStencil();
	}
	
	public function deleteSelectedCmps():void
	{
		var bizControl:BizControl = GraphLocator.getInstance().bizControl;
		bizControl.dispatchGraphActionEvent(GraphActionEvent.DELETE_SELECTED_NODES);
	}
	
	public function refreshTopo():void
	{
		var uri:String = GraphLocator.getInstance().fullGraphVO.uri;
		var url:String = BizEditorUtil.uriConvertToURL(uri);
		chooseTopo(url);
	}
	
	
//	public function chooseSubBizService(uri:String,functionName:String):void
//	{
//		BizManager.chooseSubBizService(uri,functionName);
//	}
//	
//	public function choooseBizUser(uri:String,functionName:String): void
//	{
//		BizManager.choooseBizUser(uri,functionName);
//	}
//	public function choooseMonitorResource(uri:String,functionName:String): void
//	{
//		BizManager.choooseMonitorResource(uri,functionName);
//	}
//	public function choooseCustomShape(id:String, name:String): void
//	{
//	}
//	public function chooosePicture(id:String, name:String): void
//	{
//	}
//	public function repaceBackGround(id:String, name:String): void
//	{
//	}
//	public function choooseLine(id:String, name:String): void
//	{
//	}
//	public function choooseRegion(id:String, name:String): void
//	{
//	}
//	public function choooseElementInRegion(id:String, name:String): void
//	{
//	}
//	public function zoomOut(id:String, name:String): void
//	{
//	}
//	public function zoomIn(id:String, name:String): void
//	{
//	}
//	public function fullScreen(id:String, name:String): void
//	{
//	}
//	public function deleteElements(id:String, name:String): void
//	{
//	}
//	public function rubbish(id:String, name:String): void
//	{
//	}
}
package com.mocha.biz.business.service
{
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.biz.core.vo.logic.BizSerivceVO;
	import com.mocha.biz.event.StencilEvent;
	import com.mocha.biz.model.BizControl;
	import com.mocha.biz.model.GraphLocator;
	import com.mocha.biz.ui.stencil.CommonNodeStencil;
	
	import mx.logging.ILogger;
	import mx.logging.Log;

	/**
	 * TODO：com.mocha.biz.business.service.SelectedService
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-29  上午10:40:17
	 */
	public class SelectedService
	{
		private static var log:ILogger = Log.getLogger("com.mocha.biz.business.service.SelectedService");
		
		private static var proxy:RemoteStencilDataProxy;
		
		static public function choose(type:String,uri:String):void
		{
			if(!proxy){
				proxy = new RemoteStencilDataProxy();
			}
			
			if(!isValidStencil(type,uri)){
				log.warn("choose stencil[type={0},uri={1}] is Invalid.",type,uri);
				return;
			}
			
			GraphLocator.getInstance().selectedData.selectedType = type;
			GraphLocator.getInstance().selectedData.selectedUri = uri;
			proxy.addMouseDownEventListenerInApplication();
			
			dipatchChangeStencilEvent();
		}
		
		static private function dipatchChangeStencilEvent():void
		{
			var bizControl:BizControl = GraphLocator.getInstance().bizControl;
			bizControl.dispatchStencilEvent(StencilEvent.SELECTED_STENCIL,CommonNodeStencil.COMPONENT_TYPE,null);
		}
		
		static private function isValidStencil(type:String,uri:String):Boolean
		{
			var isValid:Boolean = true;
			var bizServiceVO:BizSerivceVO = GraphLocator.getInstance().logicVO;
			if(!bizServiceVO){
				return isValid;
			}
			switch(type){
				case NodeType.BIZSERVICE:
				{
					isValid = !bizServiceVO.isChildBizServiceExist(uri);
					break;
				}
				case NodeType.BIZUSER:
				{
					isValid = !bizServiceVO.isBizUserExist(uri);
					break;
				}
					
				case NodeType.RESOURCE:
				{
					isValid = !bizServiceVO.isResouceExist(uri);
					break;
				}
			}
			return isValid;
		}
		
	}
}


import com.mocha.biz.business.service.BizManager;
import com.mocha.biz.core.common.NodeType;
import com.mocha.biz.event.StencilEvent;
import com.mocha.biz.model.GraphLocator;
import com.mocha.biz.util.BizEditorUtil;

import flash.events.MouseEvent;

import mx.core.FlexGlobals;

class RemoteStencilDataProxy{
	
	
	private var isAddEventListener:Boolean = false;
	public function get hasMouseDownListenerInStage():Boolean
	{
		return isAddEventListener;
	}
	
	public function removeMouseDownEventListenerInApplication():void
	{
		isAddEventListener = false;
		FlexGlobals.topLevelApplication.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandlerInApplication,false);
	}
	
	public function addMouseDownEventListenerInApplication():void
	{
		if(this.hasMouseDownListenerInStage){
			return;
		}
		isAddEventListener = true;
		FlexGlobals.topLevelApplication.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandlerInApplication,false,
			0,true);
	}	
	
	
	private function mouseDownHandlerInApplication(e:MouseEvent):void
	{
		this.removeMouseDownEventListenerInApplication();
		
		GraphLocator.getInstance().selectedData.creatorMoserEvent = e;
		
		var type:String = GraphLocator.getInstance().selectedData.selectedType;
		
		var uri:String = GraphLocator.getInstance().selectedData.selectedUri;
		var url:String = BizEditorUtil.uriConvertToURL(uri); 
		
		if(type == NodeType.BIZSERVICE){
			BizManager.remoteSubBizService(url,true);
		} else if(type == NodeType.BIZUSER){
			BizManager.remoteBizUser(url,true);
		} else if(type == NodeType.RESOURCE){
			BizManager.remoteMonitorResource(url,true);
		} else {
			throw new Error("type="+ type + " not implemetes remoteData.");
		}
	}
	
	
}
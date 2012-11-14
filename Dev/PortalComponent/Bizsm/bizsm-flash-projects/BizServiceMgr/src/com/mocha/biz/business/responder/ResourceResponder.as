package com.mocha.biz.business.responder
{
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.biz.core.vo.logic.MonitableResource;
	import com.mocha.biz.event.NodeEvent;
	import com.mocha.biz.event.StencilEvent;
	import com.mocha.biz.model.BizControl;
	import com.mocha.biz.model.GraphLocator;
	import com.mocha.biz.ui.cvo.NodeVO;
	import com.mocha.biz.ui.stencil.CommonNodeStencil;
	import com.mocha.biz.util.BizEditorUtil;
	import com.mocha.common.business.responder.XMLToObjectResponder;
	import com.mocha.common.event.RemoteEvent;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	
	/**
	 * TODO：com.mocha.biz.business.responder.ChooseResouceResponder
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-27  上午11:41:15
	 */
	public class ResourceResponder extends XMLToObjectResponder
	{
		
		private static var log:ILogger = Log.getLogger("com.mocha.biz.business.responder.ResourceResponder");
		
		private var isAdd:Boolean = false;
		
		public function ResourceResponder(isAdd:Boolean=true)
		{
			super(MonitableResource);
			
			this.isAdd = isAdd;
			
			this.addEventListener(RemoteEvent.REMOTE_ITEM_FINISH,remoteFinish,false,0,true);
		}
		
		private function remoteFinish(e:RemoteEvent):void
		{
			this.removeEventListener(RemoteEvent.REMOTE_ITEM_FINISH,remoteFinish,false);
			
			var header:Object = this.getResponeHeader(e.resultFault);
			if(e.resultFault is FaultEvent){
				log.warn("remote resouce fail>>>[uri={0}]",header["uri"]);
				BizEditorUtil.selectDefaultStencil();
				return;
			}
			
			try{
				
				var monitorResouce:MonitableResource =  this.targetObj as MonitableResource;	
				var nodeVO:NodeVO = resouceVOConvertNodeVO(monitorResouce);
				var bizControl:BizControl = GraphLocator.getInstance().bizControl;
				
				if(this.isAdd){
					GraphLocator.getInstance().selectedData.monitorResouce = monitorResouce;
					bizControl.dispatchStencilEvent(StencilEvent.SELECTED_STENCIL_REMOTE_END,
						CommonNodeStencil.COMPONENT_TYPE,nodeVO);
				} else {
					bizControl.dispatchNodeEvent(NodeEvent.NODE_UPDATE,nodeVO,monitorResouce);
				}
			} catch(error:Error){
				BizEditorUtil.selectDefaultStencil();
				log.error("convert bizurer error>>>>{0}", error.getStackTrace());
			}
		}
		
		
		private function resouceVOConvertNodeVO(resouce:MonitableResource):NodeVO
		{
			var nodevo:NodeVO = new NodeVO();
			nodevo.nodeImg = "./assets/images/rs.jpg";
			nodevo.nodeType = NodeType.RESOURCE;
			nodevo.statusImg = "./assets/images/lv.gif";
			nodevo.nodeText = resouce.name;
			nodevo.relationId = resouce.uri;
			nodevo.isRunning = true;
			return nodevo;
		}
	}
}
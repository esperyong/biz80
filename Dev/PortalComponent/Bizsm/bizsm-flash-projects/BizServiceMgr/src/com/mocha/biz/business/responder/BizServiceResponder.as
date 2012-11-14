package com.mocha.biz.business.responder
{
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.biz.core.vo.logic.BizSerivceVO;
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
	 * TODO：com.mocha.biz.business.responder.ChooseBizServiceResponder
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-26  下午03:30:06
	 */
	public class BizServiceResponder extends XMLToObjectResponder
	{
		private static var log:ILogger = Log.getLogger("com.mocha.biz.business.responder.BizServiceResponder");
		
		private var isAdd:Boolean = false;
		public function BizServiceResponder(isAdd:Boolean=true)
		{
			//TODO: implement function
			super(BizSerivceVO);
			
			this.isAdd = isAdd;
			this.addEventListener(RemoteEvent.REMOTE_ITEM_FINISH,remoteFinish,false,0,true);
		}
		
		private function remoteFinish(e:RemoteEvent):void
		{
			this.removeEventListener(RemoteEvent.REMOTE_ITEM_FINISH,remoteFinish,false);
			
			var header:Object = this.getResponeHeader(e.resultFault);
			
			if(e.resultFault is FaultEvent){
				log.warn("remote fail...[url={0}]   \n{1}",header["uri"],e.resultFault);
				BizEditorUtil.selectDefaultStencil();
				return;
			}
			
			try{
				
				var bizService:BizSerivceVO = this.targetObj as BizSerivceVO;
				var nodeVO:NodeVO = bizvoConvertNodeVO(bizService);
				var bizControl:BizControl = GraphLocator.getInstance().bizControl;
				
				if(this.isAdd){
					GraphLocator.getInstance().selectedData.bizService = bizService;
					bizControl.dispatchStencilEvent(StencilEvent.SELECTED_STENCIL_REMOTE_END,CommonNodeStencil.COMPONENT_TYPE,nodeVO);
				} else {
					bizControl.dispatchNodeEvent(NodeEvent.NODE_UPDATE,nodeVO,bizService);
				}
			} catch(error:Error){
				BizEditorUtil.selectDefaultStencil();
				log.error("convert biz service error>>>>{0}", error.getStackTrace());
			}
		}
		
		
		private function bizvoConvertNodeVO(bizVO:BizSerivceVO):NodeVO
		{
			var nodevo:NodeVO = new NodeVO();
			nodevo.nodeImg = "./assets/images/flow.png";
			nodevo.nodeType = NodeType.BIZSERVICE;
			nodevo.statusImg = "./assets/images/lv.gif";
			nodevo.nodeText = bizVO.name;
			nodevo.relationId = bizVO.uri;
			return nodevo;
		}
	}
}
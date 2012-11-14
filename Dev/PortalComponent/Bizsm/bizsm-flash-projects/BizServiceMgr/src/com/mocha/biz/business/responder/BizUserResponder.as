package com.mocha.biz.business.responder
{
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.biz.core.vo.logic.BizUser;
	import com.mocha.biz.event.NodeEvent;
	import com.mocha.biz.event.StencilEvent;
	import com.mocha.biz.model.BizControl;
	import com.mocha.biz.model.GraphLocator;
	import com.mocha.biz.ui.cvo.NodeVO;
	import com.mocha.biz.ui.stencil.CommonNodeStencil;
	import com.mocha.biz.util.BizEditorUtil;
	import com.mocha.common.business.responder.XMLToObjectResponder;
	import com.mocha.common.event.RemoteEvent;
	import com.mocha.common.util.ObjectInfoUtil;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.utils.ObjectUtil;
	
	/**
	 * TODO：com.mocha.biz.business.responder.ChooseBizUserResponder
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-27  上午11:39:23
	 */	
	public class BizUserResponder extends XMLToObjectResponder
	{
		private static var log:ILogger = Log.getLogger("com.mocha.biz.business.responder.BizServiceResponder");
		
		private var isAdd:Boolean = false;
		public function BizUserResponder(isAdd:Boolean=true)
		{
			super(BizUser);
			
			this.isAdd = isAdd;
			this.addEventListener(RemoteEvent.REMOTE_ITEM_FINISH,remoteFinish,false,0,true);
		}
		
		private function remoteFinish(e:RemoteEvent):void
		{
			this.removeEventListener(RemoteEvent.REMOTE_ITEM_FINISH,remoteFinish,false);
			
			var header:Object = this.getResponeHeader(e.resultFault);
			
			if(e.resultFault is FaultEvent){
				log.warn("remote bizuser fail>>>[uri={0}]",header["uri"]);
				BizEditorUtil.selectDefaultStencil();
				return;
			}
			
			try{
				
				var bizUser:BizUser = e.data as BizUser;
				var nodeVO:NodeVO = bizUserVOConvertNodeVO(bizUser);
				var bizControl:BizControl = GraphLocator.getInstance().bizControl;
				
				if(this.isAdd){
					GraphLocator.getInstance().selectedData.bizUser = bizUser;
					bizControl.dispatchStencilEvent(StencilEvent.SELECTED_STENCIL_REMOTE_END,
									CommonNodeStencil.COMPONENT_TYPE,nodeVO);
				} else {
					bizControl.dispatchNodeEvent(NodeEvent.NODE_UPDATE,nodeVO,bizUser);
				}
				
			} catch(error:Error){
				BizEditorUtil.selectDefaultStencil();
				log.error("convert bizurer error>>>>{0}", error.getStackTrace());
			}
		}
		
		private function bizUserVOConvertNodeVO(bizuser:BizUser):NodeVO
		{
			var nodevo:NodeVO = new NodeVO();
			nodevo.nodeImg = "./assets/images/bizuser.png";
			nodevo.nodeType = NodeType.BIZUSER;
			nodevo.statusImg = "./assets/images/lv.gif";
			nodevo.nodeText = bizuser.name;
			nodevo.relationId = bizuser.uri;
			log.debug("bizuser Node>>>{0}",ObjectUtil.toString(ObjectInfoUtil.objectToXML(nodevo)));
			return nodevo;
		}
	}
}
package com.mocha.biz.business.responder
{
	import com.adobe.json.JSONDecoder;
	import com.adobe.json.JSONEncoder;
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.biz.core.vo.logic.BizSerivceVO;
	import com.mocha.biz.core.vo.logic.BizUser;
	import com.mocha.biz.core.vo.logic.MonitableResource;
	import com.mocha.biz.model.GraphLocator;
	import com.mocha.biz.ui.cvo.GraphVO;
	import com.mocha.biz.util.CallJS;
	import com.mocha.biz.vo.FullGraphVO;
	import com.mocha.common.business.responder.BaseResponder;
	import com.mocha.common.util.ObjectInfoUtil;
	import com.mocha.common.util.XMLUtil;
	
	import flash.xml.XMLNode;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	/**
	 * TODO：com.mocha.biz.business.responder.FullBizServiceResponder
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-27  下午03:59:16
	 */
	public class FullBizServiceResponder extends BaseResponder
	{
		private static var log:ILogger = 
			Log.getLogger("com.mocha.biz.business.responder.FullBizServiceResponder");
		public function FullBizServiceResponder()
		{
			super(FullGraphVO);
		}
		
		override public function result(data:Object):void
		{
			if(!this.invokeCheckSameRequest(data)){
				log.error("result response header not equal request header!");
				return;
			}
			
			try{
				
				if(data.result && data.result as XMLNode){
					
					var fullVO:FullGraphVO = GraphLocator.getInstance().fullGraphVO;
					var xml:XML = XML(data.result);
					
					fullVO.topoId = xml.topoId;
					fullVO.uri = xml.uri;
					
					var bizServiceXML:XML = XML(xml.BizService);
					
					var graphXML:XML = new XML(String(xml.GraphInfo.Info));
					var nodesXML:XMLList = graphXML.nodes.node;
					var linesXML:XMLList = graphXML.edges.edge;
					
					XMLUtil.removeNullNodes(bizServiceXML);
					var logicVO:BizSerivceVO = ObjectInfoUtil.xmlToObject(bizServiceXML,BizSerivceVO) as BizSerivceVO;
					var graphVO:GraphVO = new GraphVO();
					
					if(graphXML.toXMLString() == ""){
						graphXML = <peony version="1.0">
										  <graph/>
										  <dataBindings/>
										</peony>;
					}
					
					if(logicVO){
						removeNoExistNodes(graphXML,logicVO);
						GraphLocator.getInstance().serviceId = logicVO.bizId;
						mergeGraphData(logicVO,graphXML);
					}
					fullVO.logicVO = logicVO;
					fullVO.graphVO = graphVO;
					
					this._targetObj =  fullVO;
					
					GraphLocator.getInstance().graphProxy.removeAllComponents();
					GraphLocator.getInstance().graphProxy.importData(graphXML);
				}
			}catch(e:Error){
				log.warn("request[token={0},data={1}] respone conervt error={2}"
					,data.token,data.result,e.getStackTrace());
				this._targetObj = null;
				GraphLocator.getInstance().graphProxy.removeAllComponents();
				GraphLocator.getInstance().initGraphData();
			}
			remoteComplete();
			notifyFinish(data);
		}
		
		override public function fault(info:Object):void
		{
			if(!this.invokeCheckSameRequest(info)){
				log.error("fault response header not equal request header!");
				return;
			}
			log.warn("Remote Data error:::{0}",info);
			GraphLocator.getInstance().graphProxy.removeAllComponents();
			GraphLocator.getInstance().initGraphData();
			remoteComplete();
			notifyFinish(info);
		}
		
		private function remoteComplete():void
		{
			CallJS.loadTopoDataComplete();
		}
		
		private function mergeGraphData(logicVO:BizSerivceVO,graphXML:XML):void
		{
			if(!graphXML || !logicVO){
				return;
			}
			for each(var nodeDataXML:XML in graphXML..property.(@key=="nodeVO")){
				mergeNodeData(logicVO,nodeDataXML);
			}
		}
		
		private function mergeNodeData(logicVO:BizSerivceVO,nodeDataXML:XML):void
		{
			var json:JSONDecoder = new JSONDecoder(nodeDataXML.children()[0],true);
			var nodeVO:Object = json.getValue();
			var type:String = nodeVO.nodeType;
			switch(type){
				case NodeType.BIZSERVICE:
				{
					var childBizService:BizSerivceVO = logicVO.getChildByUri(nodeVO.relationId,type) as BizSerivceVO;
					if(childBizService){
						nodeVO.nodeText = childBizService.name;
					}
					break;
				}
				case NodeType.BIZUSER:
				{
					var childBizUser:BizUser = logicVO.getChildByUri(nodeVO.relationId,type) as BizUser;
					if(childBizUser){
						nodeVO.nodeText = childBizUser.name;
					}
					break;
				}
				case NodeType.RESOURCE:
				{
					var childResouce:MonitableResource = logicVO.getChildByUri(nodeVO.relationId,type) as MonitableResource;
					if(childResouce){
						nodeVO.nodeText = childResouce.name;
					}
					break;
				}
			}
			
			var  enJson:JSONEncoder = new JSONEncoder(nodeVO);
			nodeDataXML.children()[0] = enJson.getString();
		}
		
		private function removeNoExistNodes(graphXML:XML,logicVO:BizSerivceVO):void
		{
			var nodesXML:XMLList = graphXML..node;			
			var nodeType:String;
			var relationId:String; 
			for each(var xml:XML in nodesXML){
				nodeType = xml.property.(@key=="nodeType");
				if(nodeType){
					relationId = xml.property.(@key=="relationId");
					switch(nodeType){
						case NodeType.BIZSERVICE:
						{
							if(!logicVO.isChildBizServiceExist(relationId)){
								log.debug("delete nodeXML={0}",String(xml));
								XMLUtil.deleteXMLNode(xml);
								removeEdge(graphXML,xml.@id);
							}
							break;
						}
						case NodeType.BIZUSER:
						{
							if(!logicVO.isBizUserExist(relationId)){
								log.debug("delete nodeXML={0}",String(xml));
								XMLUtil.deleteXMLNode(xml);
								removeEdge(graphXML,xml.@id);
							}
							break;
						}
						
						case NodeType.RESOURCE:
						{
							if(!logicVO.isResouceExist(relationId)){
								log.debug("delete nodeXML={0}",String(xml));
								XMLUtil.deleteXMLNode(xml);
								removeEdge(graphXML,xml.@id);
							}
							break;
						}
						
					}
				}
			}
		}
		
		private function removeEdge(graphXML:XML,id:String):void
		{
			var edgesXML:XMLList = graphXML..edge;
			for each(var xml:XML in edgesXML){
				if(xml.@source==id || xml.@target==id){
					XMLUtil.deleteXMLNode(xml);
				}
			}
		}
	}
}
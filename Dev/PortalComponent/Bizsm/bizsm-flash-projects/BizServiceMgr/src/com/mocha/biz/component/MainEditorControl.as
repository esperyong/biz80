package com.mocha.biz.component
{
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.biz.core.vo.logic.BizSerivceVO;
	import com.mocha.biz.event.GraphActionEvent;
	import com.mocha.biz.event.NodeEvent;
	import com.mocha.biz.event.StencilEvent;
	import com.mocha.biz.model.BizControl;
	import com.mocha.biz.model.GraphLocator;
	import com.mocha.biz.model.SelectedStencilData;
	import com.mocha.biz.ui.component.node.CommonNode;
	import com.mocha.biz.ui.cvo.NodeVO;
	import com.mocha.biz.ui.data.GraphCanvasProxy;
	import com.mocha.biz.ui.event.StencilOperatorEvent;
	import com.mocha.biz.ui.stencil.CommonNodeStencil;
	import com.mocha.biz.util.BizContant;
	import com.mocha.peony.core.component.IComponent;
	import com.mocha.peony.core.events.ComponentsSelectedEvent;
	import com.mocha.peony.core.events.StencilActionEvent;
	import com.mocha.peony.core.stencil.SelectorStencil;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.core.FlexGlobals;

	/**
	 * TODO：com.mocha.biz.comparent.MainEditorControl
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-25  下午04:02:20
	 */
	public class MainEditorControl
	{
		private var mainEditor:MainEditor;
		
		private var selectedNodeVO:NodeVO;
		
		private var currentComponentName:String = BizContant.DEFAULT_STENCIL_NAME;
		
		private var selectedCompanents:Vector.<IComponent>;
		
		private var proxy:GraphCanvasProxy;
		
		public function MainEditorControl(editor:MainEditor)
		{
			this.mainEditor = editor;
			addEventLisenter();
			proxy = GraphLocator.getInstance().graphProxy;
		}
		
		private function addEventLisenter():void
		{
			var bizControl:BizControl = GraphLocator.getInstance().bizControl;
			
			bizControl.addEventListener(StencilEvent.SELECTED_STENCIL,stencilChange,false,0,true);
			bizControl.addEventListener(StencilEvent.SELECTED_STENCIL_REMOTE_END,stencilDataEndHandler,
				false,0,true);
			bizControl.addEventListener(GraphActionEvent.DELETE_SELECTED_NODES,removeSelectedCmps,false,0,true);
			bizControl.addEventListener(NodeEvent.NODE_UPDATE,nodeUpdateHandler,false,0,true);
			
			
			this.mainEditor.main.addEventListener(StencilActionEvent.STENCIL_ACTION_END,elementCreatorEndHandler);
			
			this.mainEditor.main.addEventListener(ComponentsSelectedEvent.COMPONENTS_SELECTED,componentSelectedHandler);
			
			this.mainEditor.setFocus();
			
			//监听键盘事件
			FlexGlobals.topLevelApplication.addEventListener(KeyboardEvent.KEY_DOWN,deleteElementsHandler);
			
		}
		
		private function stencilChange(e:StencilEvent):void
		{
			if(currentComponentName == BizContant.DEFAULT_STENCIL_NAME 
				&& e.comparentName == this.currentComponentName){
				return;
			}
			this.currentComponentName = e.comparentName;
			
			this.selectedNodeVO = e.nodeVO;
			this.mainEditor.main.useStencil(e.comparentName);
		}
		private function stencilDataEndHandler(e:StencilEvent):void
		{
			this.selectedNodeVO = e.nodeVO;
			notifyStencilCreatorElement(e.nodeVO);
		}
		
		private function elementCreatorEndHandler(e:StencilActionEvent):void
		{
			//notify js create end
			if(e.stencil && e.stencil is SelectorStencil){
				this.selectedCompanents = this.mainEditor.main.selectionManager.selectedComponents;
				this.mainEditor.setFocus();
			} else {
//				this.selectedCompanents = null;
			}
			
			if(e.stencil && e.stencil is CommonNodeStencil){
				this.currentComponentName = BizContant.DEFAULT_STENCIL_NAME;
				this.mainEditor.main.useStencil(BizContant.DEFAULT_STENCIL_NAME);
				elementCreatorEndBehind();
			}
		}
		
		private function elementCreatorEndBehind():void
		{
			var selectedData:SelectedStencilData = GraphLocator.getInstance().selectedData;
			if(!GraphLocator.getInstance().logicVO){
				return;
			}
			var comp:IComponent = proxy.getComponentByRelatonId(this.selectedNodeVO.relationId);
			if(comp){
				proxy.addLines(comp);
			}
			if(this.selectedNodeVO){
				switch(this.selectedNodeVO.nodeType){
					case NodeType.BIZSERVICE:
					{
						GraphLocator.getInstance().logicVO.addBizSerivces(selectedData.bizService);
						selectedData.bizService = null;
						this.selectedNodeVO = null;
						break;
						
					}
				
					case NodeType.BIZUSER:
					{
						GraphLocator.getInstance().logicVO.addBizUsers(selectedData.bizUser);
						selectedData.bizUser = null;
						this.selectedNodeVO = null;
						break;
						
					}
					case NodeType.RESOURCE:
					{
						GraphLocator.getInstance().logicVO.addMonitorResources(selectedData.monitorResouce);
						selectedData.monitorResouce = null;
						this.selectedNodeVO = null;
						break;
						
					}
					default:
					{
						
					}
				}
			}
		}
		
		private function notifyStencilCreatorElement(nodeVO:NodeVO):void
		{
			var creatorEvent:StencilOperatorEvent = new StencilOperatorEvent(StencilOperatorEvent.CREATOR_COMPARENT);
			creatorEvent.mouseEvent = GraphLocator.getInstance().selectedData.creatorMoserEvent;
			creatorEvent.nodeVO = nodeVO;
			GraphLocator.getInstance().selectedData.creatorMoserEvent = null;
			
			this.mainEditor.main.dispatchEvent(creatorEvent);
		}
		
		private function removeAllElements():void
		{
			GraphLocator.getInstance().graphProxy.removeAllComponents();
		}
		
		
		private function deleteElementsHandler(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.DELETE){
				removeSelectedCmps();
			}
		}
		
		private function nodeUpdateHandler(e:NodeEvent):void
		{
			var origin:Object = e.nodeOrigin;
			GraphLocator.getInstance().logicVO.updateChild(origin);
			var nodeVO:NodeVO = e.nodeVO;
			if(!nodeVO){
				return;
			}
			
			var proxy:GraphCanvasProxy =  GraphLocator.getInstance().graphProxy;
			var allNodes:Vector.<IComponent> = proxy.getAllComponents();
			for each(var nodeCmp1:Object in allNodes){
				if(nodeCmp1 is CommonNode){
					var nodeCmp:CommonNode = nodeCmp1 as CommonNode;
					if(nodeCmp &&nodeCmp.relationId == nodeVO.relationId){
						nodeCmp.nodeVO = nodeVO;
						break;
					}
				}
			}
		}
		
		private function removeSelectedCmps(e:Event=null):void
		{
			var serviceVO:BizSerivceVO = GraphLocator.getInstance().logicVO;
			for each(var node1:Object in this.selectedCompanents){
				if(node1 is CommonNode){
					var node:CommonNode = node1 as CommonNode;
					if(node){
						if(node.nodeType == NodeType.BIZSERVICE){
							serviceVO.removeBizServices(node.relationId);
						} else if(node.nodeType == NodeType.BIZUSER){
							serviceVO.removeBizUsers(node.relationId);
						} else if(node.nodeType == NodeType.RESOURCE){
							serviceVO.removeMonitorResources(node.relationId);
						}
					}
				}
			}
			GraphLocator.getInstance().graphProxy.deleteCompanent(this.selectedCompanents);
		}
		
		private function componentSelectedHandler(e:ComponentsSelectedEvent):void
		{
			selectedCompanents = e.components;
		}
	}
}
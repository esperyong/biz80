package com.mocha.biz.ui.stencil
{
	import com.mocha.biz.ui.cvo.NodeVO;
	import com.mocha.biz.ui.event.StencilOperatorEvent;
	import com.mocha.peony.core.component.PropertyValue;
	import com.mocha.peony.core.events.StencilActionEvent;
	import com.mocha.peony.core.stencil.GenericCreatorStencil;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * TODO：com.mocha.biz.ui.stencil.CommonNodeStencil
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-21  下午01:41:20
	 */
	public class CommonNodeStencil extends GenericCreatorStencil
	{
		
		public static var COMPONENT_TYPE:String = "com.mocha.biz.ui.component.node.CommonNode";
		
		[PeonyInspectable]
		public var nodeImg:String;
		[PeonyInspectable]
		public var stateImg:String;
		[PeonyInspectable]
		public var nodeType:String;
		[PeonyInspectable]
		public var text:String;
		
		private var _nodeVO:NodeVO;
		
		private var _p1:Point = null;
		private var _componentUID:String = null;
		
		private var comparentDefaultProperty:PropertyValue;
		
		public function CommonNodeStencil()
		{
			super();
			this.defaultHeight = 73;
			this.defaultWidth = 61;
			this.componentTypeName = COMPONENT_TYPE;
			comparentDefaultProperty = new PropertyValue("nodeVO",_nodeVO);
			this.componentDefaultValues.push(comparentDefaultProperty);
		}
		
		public function set nodeVO(v:NodeVO):void
		{
			this._nodeVO = v;
			comparentDefaultProperty.value = this._nodeVO;
			filledStencilProperties();
		}
		
		public function get nodeVO():NodeVO
		{
			return this._nodeVO;
		}
		
		override protected function $attach():void
		{
			filledStencilProperties();
			this._target.addEventListener(StencilOperatorEvent.CREATOR_COMPARENT, onCreatorHandler);
		}
		
		override protected function $detach():void
		{
			this._target.removeEventListener(StencilOperatorEvent.CREATOR_COMPARENT, onCreatorHandler);
		}
		
		private function onCreatorHandler(e:StencilOperatorEvent):void
		{
			var mouseEvent:MouseEvent = e.mouseEvent;
			this.nodeVO = e.nodeVO;
			
			this._p1 = new Point(mouseEvent.stageX, mouseEvent.stageY);
			
			var localPoint:Point = this._target.contentPane.globalToLocal(this._p1);
			
			var t:Vector.<PropertyValue> = new Vector.<PropertyValue>(this.componentDefaultValues);
			t = Vector.<PropertyValue>(this.componentDefaultValues);
			
			_componentUID =  this._target.addComponent(this.componentTypeName, "", 
				Vector.<PropertyValue>(this.componentDefaultValues));
			
			this._target.moveAndResizeComponent(_componentUID, localPoint.x - this.defaultWidth/2, localPoint.y - this.defaultHeight/2
				,this.defaultWidth,this.defaultHeight);
			
			
			this._active = true;
			var stencilEndEvent:StencilActionEvent = new StencilActionEvent(StencilActionEvent.STENCIL_ACTION_END);
			stencilEndEvent.stencil = this;
			this._target.dispatchEvent(stencilEndEvent);
		}
		
		
		private function filledStencilProperties():void
		{
			if(this._nodeVO){
				this.nodeImg = this.nodeVO.nodeImg;
				this.nodeType = this.nodeVO.nodeType;
				this.text = this.nodeVO.nodeText;
				this.stateImg = this.nodeVO.statusImg;
			}
		}
		
	}
}
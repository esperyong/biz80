package com.mocha.biz.common.ui.radar
{
	import com.mocha.biz.common.ui.radar.vo.RadarNodeVO;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.events.ToolTipEvent;
	
	import spark.components.supportClasses.SkinnableComponent;
	import spark.components.supportClasses.TextBase;

	[SkinState("red")]
	[SkinState("yellow")]
	[SkinState("green")]	
	public class RadarNode extends SkinnableComponent
	{
		public function RadarNode()
		{
			super();
			this.addEventListener(ToolTipEvent.TOOL_TIP_CREATE,toolTipCreatorHandler);
		}
		
		[SkinPart(required=false)]
		public var nodeText:TextBase;
		[SkinPart(required=false)]
		public var graphContent:UIComponent;
		
		public var nodeIndex:Number = 0;
		
		private var over:String = "";
		
		
		public var status:String = RadarNodeVO.GREEN;
		
		public var helper:RadarNodeTweenHelper;
		
		[Bindable]
		public var nodeTextStr:String = "";
		
		public var isMoveEffect:Boolean =false;
		
		public var degree:Number;
		
		private var _nodeData:RadarNodeVO;
		
		private var _centerPosition:Point = new Point(0,0);

		public function get nodeData():RadarNodeVO
		{
			return _nodeData;
		}

		public function set nodeData(value:RadarNodeVO):void
		{
			if(value == this._nodeData){
				return;
			}
			_nodeData = value;
			if(value){
				this.status = this._nodeData.nodeStatus;
				this.nodeTextStr = this._nodeData.nodeText;
			} else {
				this.status = RadarNodeVO.GREEN;
			}
			this.invalidateSkinState();
		}

		public function set centerPosition(p:Point):void
		{
			if(p == null){
				return;
			}
			if(p.equals(this._centerPosition)){
				return;
			}
			this._centerPosition = p;
			var compPoint:Point = getPosition(p);
			this.x = compPoint.x;
			this.y = compPoint.y;
			this.invalidateDisplayList();
		}
		
		public function get centerPosition():Point
		{
			return this._centerPosition;
		}
		
		public function getPosition(center:Point=null):Point
		{
			if(center == null){
				center = this._centerPosition;
			}
			var w:Number = this.getExplicitOrMeasuredWidth();
			var h:Number = this.getExplicitOrMeasuredHeight();
			var compPoint:Point = center.add(new Point(-w/2,-h/2));
			return compPoint;
		}
		
		override protected function  getCurrentSkinState():String
		{
			return status + over;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == graphContent){
				graphContent.addEventListener(MouseEvent.MOUSE_OUT,nodeOutHandler);
				graphContent.addEventListener(MouseEvent.MOUSE_OVER,nodeOverHandler);				
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == graphContent){
				graphContent.removeEventListener(MouseEvent.MOUSE_OUT,nodeOutHandler);
				graphContent.removeEventListener(MouseEvent.MOUSE_OVER,nodeOverHandler);				
			}
		}
	    private function nodeOverHandler(e:MouseEvent):void{
			over = "Over";
			this.invalidateSkinState();
	    }
	    private function nodeOutHandler(e:MouseEvent):void{
			over = "";	 
			this.invalidateSkinState();
	    }
		
		private function toolTipCreatorHandler(e:ToolTipEvent):void
		{
		}
	}
}
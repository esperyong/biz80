package com.mocha.biz.ui.component.node
{
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.peony.core.component.node.Node;
	
	import mx.controls.Image;
	
	import spark.components.supportClasses.TextBase;
	
	/**
	 * TODO：com.mocha.biz.comparent.CommonNode
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-21  上午11:48:37
	 */
	public class CommonNode extends Node
	{
		[SkinPart(required="false")]
		public var nodeImg:Image;
		
		[SkinPart(required="false")]
		public var labelDisplay:TextBase;
		
		[SkinPart(required="false")]
		public var stateImg:Image;
		
		[Bindable]
		private var _nodeVO:Object;
		
		[Bindable]
		public var nodeText:String;
		[Bindable]
		public var nodeImgUrl:String;
		[Bindable]
		public var statusImgUrl:String;
		
		[PeonyInspectable]
		public  var relationId:String;
		
		[PeonyInspectable]
		public var nodeType:String;
		
		
		public function CommonNode()
		{
			super();
		}
		
		[PeonyInspectable]
		public function get nodeVO():Object
		{
			return _nodeVO;
		}

		public function set nodeVO(value:Object):void
		{
			_nodeVO = value;
			if(_nodeVO){
				this.nodeImgUrl = this._nodeVO.nodeImg;
				this.statusImgUrl = this._nodeVO.statusImg;
				this.nodeText = this._nodeVO.nodeText;
				this.relationId = this._nodeVO.relationId;
				this.nodeType = this._nodeVO.nodeType;
			} else {
				this.nodeImgUrl = "";
				this.statusImgUrl = "";
				this.nodeText = "";
			}
		}

		override protected function getCurrentSkinState():String
		{
			if(nodeVO && nodeVO.isRunning){
				if(nodeVO.nodeType == NodeType.BIZSERVICE
							|| nodeVO.nodeType == NodeType.RESOURCE){
					return super.getCurrentSkinState() + "AndRun";
				}
				return super.getCurrentSkinState();
			} else {
				return super.getCurrentSkinState();
			}
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
		}		
	}
}
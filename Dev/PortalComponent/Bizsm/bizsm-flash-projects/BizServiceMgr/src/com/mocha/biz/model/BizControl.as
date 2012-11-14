package com.mocha.biz.model
{
	import com.mocha.biz.event.GraphActionEvent;
	import com.mocha.biz.event.NodeEvent;
	import com.mocha.biz.event.StencilEvent;
	import com.mocha.biz.ui.cvo.NodeVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="selectedStencil", type="com.mocha.biz.event.StencilEvent")]
	[Event(name="stenciRemoteDataEnd", type="com.mocha.biz.event.StencilEvent")]
	[Event(name="deleteSelectedNodes", type="com.mocha.biz.event.GraphActionEvent")]
	[Event(name="nodeUpdate", type="com.mocha.biz.event.NodeEvent")]
	
	/**
	 * TODO：com.mocha.biz.model.BizControl
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-10-14  上午10:00:22
	 */
	public class BizControl extends EventDispatcher
	{
		public function BizControl(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function dispatchGraphActionEvent(type:String):void
		{
			var event:GraphActionEvent = new GraphActionEvent(GraphActionEvent.DELETE_SELECTED_NODES);
			this.dispatchEvent(event);
		}
		
		public function dispatchStencilEvent(type:String,componentName:String,nodeVO:NodeVO):void
		{
			var event:StencilEvent = new StencilEvent(type);
			event.comparentName = componentName;
			event.nodeVO = nodeVO;
			this.dispatchEvent(event);
		}	
		
		public function dispatchNodeEvent(type:String,nodeVO:NodeVO,origin:Object):void
		{
			var event:NodeEvent = new NodeEvent(type);
			event.nodeVO = nodeVO;
			event.nodeOrigin = origin;
			this.dispatchEvent(event);
		}
	}
}
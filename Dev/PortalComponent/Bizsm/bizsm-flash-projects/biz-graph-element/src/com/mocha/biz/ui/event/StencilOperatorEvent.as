package com.mocha.biz.ui.event
{
	import com.mocha.biz.ui.cvo.NodeVO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * TODO：com.mocha.biz.ui.stencil.StencilOperatorEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-29  上午11:11:58
	 */
	public class StencilOperatorEvent extends Event
	{
		static public const CREATOR_COMPARENT:String = "creator";
		
		public var nodeVO:NodeVO;
		public var mouseEvent:MouseEvent;
		public function StencilOperatorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
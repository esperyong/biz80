package com.mocha.biz.event
{
	import com.mocha.biz.ui.cvo.NodeVO;
	
	import flash.events.Event;
	
	/**
	 * TODO：com.mocha.biz.event.StencilEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-26  上午10:27:15
	 */
	public class StencilEvent extends Event
	{
		public static const SELECTED_STENCIL:String = "selectedStencil";
		public static const SELECTED_STENCIL_REMOTE_END:String = "stenciRemoteDataEnd";
		
		public var nodeVO:NodeVO;
		public var comparentName:String;
		public function StencilEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
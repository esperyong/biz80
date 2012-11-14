package com.mocha.biz.event
{
	import com.mocha.biz.ui.cvo.NodeVO;
	
	import flash.events.Event;
	
	/**
	 * TODO：com.mocha.biz.event.NodeEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-10-14  下午02:06:00
	 */
	public class NodeEvent extends Event
	{
		public static const NODE_UPDATE:String = "nodeUpdate";
		
		public var nodeVO:NodeVO;
		public var nodeOrigin:Object;
		
		public function NodeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
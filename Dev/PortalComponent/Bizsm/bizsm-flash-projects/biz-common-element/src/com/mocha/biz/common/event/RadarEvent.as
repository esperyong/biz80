package com.mocha.biz.common.event
{
	import com.mocha.biz.common.ui.radar.RadarNode;
	
	import flash.events.Event;
	
	/**
	 * TODO：com.mocha.biz.common.event.RadarEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-4  上午10:52:49
	 */
	public class RadarEvent extends Event
	{
		public static const CLICK_NODE:String = "clickNode";
		public static const DOUBLE_CLICK_NODE:String = "doubleNode";
		
		public var radarNode:RadarNode;
		public function RadarEvent(node:RadarNode,type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.radarNode = node;
		}
	}
}
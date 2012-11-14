package com.mocha.biz.event
{
	import flash.events.Event;
	
	/**
	 * TODO：com.mocha.biz.event.GraphEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-30  下午02:21:56
	 */
	public class GraphActionEvent extends Event
	{
		public static const DELETE_SELECTED_NODES:String = "deleteSelectedNodes";
		public function GraphActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
package com.mocha.biz.common.event
{
	import flash.events.Event;
	
	/**
	 * TODO：com.mocha.biz.common.event.PanelEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-10-27  下午04:27:20
	 */
	public class PanelEvent extends Event
	{
		static public const CLOSE:String = "close";
		static public const COMMIT:String = "commit";
		static public const CANCEL:String = "cancel";
		
		public function PanelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
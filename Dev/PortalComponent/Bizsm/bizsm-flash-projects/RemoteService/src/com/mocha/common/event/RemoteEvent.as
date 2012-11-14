package com.mocha.common.event
{
	import flash.events.Event;
	
	/**
	 * TODO：com.mocha.common.event.end.BatchRemoteEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  上午11:41:06
	 */
	public class RemoteEvent extends Event
	{
		public static const REMOTE_ALL_FINISH:String = "remoteAll";
		public static const REMOTE_ALL_FINISH_INNER:String = "remoteAll_inner";
		public static const REMOTE_ITEM_FINISH:String = "remoteItem";
		
		public function RemoteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var data:Object;
		public var resultFault:Object;
	}
}
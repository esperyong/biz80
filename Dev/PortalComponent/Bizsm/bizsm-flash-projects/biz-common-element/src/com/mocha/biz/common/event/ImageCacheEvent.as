package com.mocha.biz.common.event
{
	import flash.events.Event;
	
	/**
	 * TODO：com.mocha.biz.ui.event.ImageCacheEvent
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-10-26  下午04:05:50
	 */
	public class ImageCacheEvent extends Event
	{
		public static const COMPLETE:String = "complete";
		
		public var result:Object;
		public var url:String;
		
		public function ImageCacheEvent(type:String, url:String, result:Object, 
										bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.result = result;
			this.url = url;
		}

	}
}
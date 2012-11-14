package com.mocha.common.util
{

	/**
	 * 队列.
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  上午10:54:15
	 */
	public class Queue
	{
		private var content:Array;
		
		public function Queue(arr:Array=null):void
		{
			if(arr){
				this.content = arr.slice(0);
			} else {
				this.content = new Array();
			}
		}
		
		public function get length():Number
		{
			return this.content.length;
		}
		
		public function get isEmpty():Boolean
		{
			return this.content.length==0 ? true : false;
		}
		
		public function offer(e:*):void
		{
			this.content.push(e);	
		}
		
		public function peek():*{
			return this.content.shift();
		}
	}
}
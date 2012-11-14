package com.mocha.biz.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.controls.Image;
	import mx.controls.SWFLoader;

	/**
	 * TODO：.Cache
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-19  下午02:58:48
	 */
	public class Cache
	{
		public static var cache:Dictionary = new Dictionary();
		private static var image:Image = new Image ();
		private static var target:Image;
		public function Cache()
		{
		}
		
		public static function init():void
		{
			image.addEventListener(Event.INIT,initHanderler);
			image.addEventListener(Event.OPEN,openHandler);
			image.addEventListener(Event.COMPLETE,completeHandler);
			image.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			image.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			image.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusHandler);
			image.addEventListener(SecurityErrorEvent.SECURITY_ERROR,secuityHandler);
		}
		
		private static function initHanderler(e:Event):void
		{
			trace("initHanderler>>>>>" + e);
		}
		private static function openHandler(e:Event):void
		{
			trace("openHandler>>>>>" + e);
		}
		private static function completeHandler(e:Event):void
		{
			trace("completeHandler>>>>>" + e);
//			var image1 : Image = event.target as Image;
			
				var bitmapData : BitmapData = new BitmapData
					(image.content.width, image.content.height, true);
				
				bitmapData.draw (image);
				target.source = new Bitmap(bitmapData);

//				target.source = bitmapData;
				

		}
		private static function ioErrorHandler(e:Event):void
		{
			trace("ioErrorHandler>>>>>" + e);
		}
		private static function progressHandler(e:Event):void
		{
			trace("progressHandler>>>>>" + e);
		}
		private static function httpStatusHandler(e:Event):void
		{
			trace("httpStatusHandler>>>>>" + e);
		}
		private static function secuityHandler(e:Event):void
		{
			trace("secuityHandler>>>>>" + e);
		}
		public static function load(src:String,ta:Image):ByteArray
		{
			if(cache[src]){
				return cache[src];
			}
			target = ta;
			image.load(src);
		
			return null;
		}
		[Bindable]
		public static var bitmapData:BitmapData;
	}
}
package com.mocha.biz.common.cache
{
	
	import com.mocha.biz.common.event.ImageCacheEvent;
	
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.LoaderContext;
	import flash.utils.setTimeout;
	
	import mx.controls.Image;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	


	/**
	 * TODO：com.mocha.biz.cache.ImgCache
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-19  下午04:08:38
	 */
	public class ImageCache extends Image
	{
		private var imageCache:ImageCacheUtil;
		private var _sourceURL:String = "";
		private var _loadingTriesCounter:int;
		private const MAX_LOADING_TRIES:int = 10;
		
		
		public function ImageCache()
		{
			super();
			super.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			imageCache = ImageCacheUtil.getInstance();
		}
		
		
		public override function set source(value:Object):void
		{
			if(value is Class){
				super.source = value;
			} 
			else if (value is String && String(value) != "")
			{
				_sourceURL = String(value);
				imageCache.addEventListener(ImageCacheEvent.COMPLETE, onImageRequestComplete);
				imageCache.requestImage(String(value));
				
				var lc:LoaderContext = new LoaderContext();
				lc.checkPolicyFile = true;
				super.loaderContext = lc;
			}
			else {
				super.source = null;
			}
		}
		
		private function onImageRequestComplete(event:ImageCacheEvent):void
		{
			if (_sourceURL == event.url)
			{
				imageCache.removeEventListener(ImageCacheEvent.COMPLETE, onImageRequestComplete);
				if(event.result is Bitmap)
				{
					super.source = new Bitmap(Bitmap(event.result).bitmapData);
				}
				else
				{
					super.source = event.result;
				}
				
				if (event.result is Bitmap)
					callLater(dispatchEvent, [new Event(Event.COMPLETE)]);
			}
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			_loadingTriesCounter++;
			if (_loadingTriesCounter <= MAX_LOADING_TRIES)
			{
				event.stopImmediatePropagation();
				setTimeout(setSource, 1000, _sourceURL);
			}
		}
		
		private function setSource(url:String):void
		{
			source = null;
			source = _sourceURL;
		}
		
		// If we have a URL then cache a bitmap of this control with the
		// url string as the identifier
		override mx_internal function contentLoaderInfo_completeEventHandler(event:Event):void
		{
			if (LoaderInfo(event.target).loader != contentHolder)
				return;
			
			if (_sourceURL != "")
			{
				imageCache.cacheImage(_sourceURL, this);
			}
			
			//var smoothLoader:Loader = event.target.loader as Loader;
			// var smoothImage:Bitmap = smoothLoader.content as Bitmap;
			//  smoothImage.smoothing = true;
			
			super.contentLoaderInfo_completeEventHandler(event);
		}
	}
} 

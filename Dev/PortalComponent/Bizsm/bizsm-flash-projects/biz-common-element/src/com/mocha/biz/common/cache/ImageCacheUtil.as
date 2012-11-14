package com.mocha.biz.common.cache
{
	
	import com.mocha.biz.common.event.ImageCacheEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	
	import mx.collections.ArrayCollection;
	import mx.controls.SWFLoader;
	
	/**
	 * 图片缓存管理类.
	 * 属性列表：
	 * <ol>
	 * 	<li>isCached：是否缓存图片，默认缓存</li>
	 * 	<li>cacheLimit：缓存数量，默认100</li>
	 * </ol>
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-10-26  下午03:59:59
	 */
	public class ImageCacheUtil extends EventDispatcher
	{
		private static var imageCache:ImageCacheUtil;
		
		private var imageDictionary:ArrayCollection = new ArrayCollection();
		private var _cacheLimit:Number = 100;
		
		/**
		 * 是否开启图片或者swf的缓存功能，默认值是true.
		 * 
		 */
		public var isCached:Boolean = true;
		
		/**
		 * 最大缓存数量.默认值：100
		 * 
		 */ 
		public function set cacheLimit(num:Number):void
		{
			_cacheLimit = num;
		}
		
		public function get cacheLimit():Number
		{
			return _cacheLimit;
		}
		
		public function ImageCacheUtil()
		{
			if (imageCache != null)
				throw new Error("Only one instance should be instantiated");
		}
		
		public static function getInstance():ImageCacheUtil
		{
			if (imageCache == null)
				imageCache = new ImageCacheUtil();
			
			return imageCache;
		}
		
		/**
		 * 缓存资源.
		 * @param id  资源url
		 * @param source  资源对象
		 * 
		 */ 
		public function cacheImage(id:String, source:SWFLoader):void
		{
//			trace("id=" + id + ",source=" + source);
			if(!this.isCached){
				return;
			}
			for each (var newObj:Object in imageDictionary)
			{
				if (newObj.id == id)
					return;
			}
			var bd:BitmapData = getBitmapData(source);
			var obj:Object = new Object();
			obj.id = id;
			obj.data = bd;
			imageDictionary.addItem(obj);
			checkLimit();
			
			if(_currentlyRequestedURLs.contains(id))
			{
				_currentlyRequestedURLs.removeItemAt(_currentlyRequestedURLs.getItemIndex(id));
				var bm:Bitmap = new Bitmap(bd);
				dispatchRequestComplete(id, bm);
			}
		}
		
		private var _currentlyRequestedURLs:ArrayCollection = new ArrayCollection();
		
		/**
		 * 请求资源.
		 * @param url 资源url
		 */ 
		public function requestImage(url:String):void
		{
			var bm:Bitmap;
			if(isCached){				
				for each (var obj:Object in imageDictionary)
				{
					if (obj.id == url)
					{
						bm = new Bitmap(obj.data);
					}
				}				
			}
			if (bm)
			{
				dispatchRequestComplete(url, bm);
			}
			else
			{
				if (!this.isCached || !_currentlyRequestedURLs.contains(url))
				{
					if(this.isCached){
						_currentlyRequestedURLs.addItem(url);
					}
					dispatchRequestComplete(url, url);
				}
			}
		}
		
		private function dispatchRequestComplete(url:String, result:Object):void
		{
			dispatchEvent(new ImageCacheEvent(ImageCacheEvent.COMPLETE, url, result));
		}
		
		private function getBitmapData(target:SWFLoader):BitmapData
		{
			var bd:BitmapData = new BitmapData(target.width,target.height,true,0x00000000);
			if(target.source is String 
				&& String(target.source).lastIndexOf(".swf") != String(target.source).length - 4){
				bd = Bitmap(target.content).bitmapData;
			} else {
				bd = new BitmapData(target.width,target.height,true,0x00000000);
				var m:Matrix = new Matrix();
				m.scale(1, 1);  				
				bd.draw(target,m,null,null,null,true);
			}
			return bd;
		}
		
		/**
		 * 清空缓存.
		 */ 
		public function clear():void
		{
			imageDictionary.removeAll();
		}
		
		/**
		 * 移除指定资源缓存.
		 * 
		 */ 
		public function removeImage(id:String):void
		{
			var i:Number = 0;
			for each (var obj:Object in imageDictionary)
			{
				if (obj.id == id)
				{
					imageDictionary.removeItemAt(i);
					return;
				}
				i++
			}
		}
		
		private function checkLimit():void
		{
			var i:Number = 0;
			while (imageDictionary.length > _cacheLimit)
			{
				imageDictionary.removeItemAt(i);
				i++;
			}
		}
	}

}
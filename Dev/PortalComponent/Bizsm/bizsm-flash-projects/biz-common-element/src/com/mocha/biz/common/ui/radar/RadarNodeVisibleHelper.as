package com.mocha.biz.common.ui.radar
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 * TODO：com.mocha.biz.common.ui.radar.RadarNodeVisibleHelper
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-3  上午11:48:49
	 */
	public class RadarNodeVisibleHelper
	{
		private static var nodeCount:Number = 0;
		private static var timer:Timer = new Timer(1000);
		
		private static var nodeRepeatCountDic:Dictionary = new Dictionary(true);
		
		private static var visibleCount:Number = 6;
		
		private static var lastVisible:Boolean = true;
		
		public static function join(node:RadarNode):void
		{
			if(nodeRepeatCountDic.hasOwnProperty(node)){
				return;
			}
			nodeCount++;
			nodeRepeatCountDic[node] = visibleCount;
			if(!timer.running){
				lastVisible = true;
				timer.reset();
				timer.start();
				timer.addEventListener(TimerEvent.TIMER,timerHandler);
			}
		}
		
		public static function removeVisibleEffect(node:RadarNode):void
		{
			if(nodeRepeatCountDic.hasOwnProperty(node)){
				delete nodeRepeatCountDic[node];
			}
		}
		
		
		private static function timerHandler(e:TimerEvent):void
		{
			if(nodeCount == 0){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				return;
			}
			lastVisible = !lastVisible;
			var count:Number = 0;
			for(var node1:* in nodeRepeatCountDic){
				var node:RadarNode = node1 as RadarNode;
				if(node && nodeRepeatCountDic[node] <= visibleCount){
					count = nodeRepeatCountDic[node];
					if(count == 0){
						delete nodeRepeatCountDic[node];
						node.isMoveEffect = false;
						node.visible = true;
						nodeCount--;
					} else {
						node.visible = lastVisible;
						count--;
						nodeRepeatCountDic[node] = count;
					}
				} else if(node && visibleCount <= 0){
					node.visible = lastVisible;
				}
			}
			
		}
		
	}
}
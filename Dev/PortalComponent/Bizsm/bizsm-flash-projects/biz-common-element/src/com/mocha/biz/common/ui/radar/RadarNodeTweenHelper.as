package com.mocha.biz.common.ui.radar
{
	import com.mocha.biz.common.ui.radar.vo.RadarNodeVO;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.effects.Tween;
	import mx.logging.ILogger;
	import mx.logging.Log;
	

	/**
	 * TODO：com.mocha.biz.common.ui.radar.RadarNodeEffectHelper
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-2  下午04:36:54
	 */
	public class RadarNodeTweenHelper
	{
		private static var log:ILogger = Log.getLogger("com.mocha.biz.common.ui.radar.RadarNodeTweenHelper");
		private var node:RadarNode;
		private var origin:Point;
		private var outR:Array;
		private var midR:Array;
		private var lowR:Array;
		
		private var listener:Object = new Object();
		public function RadarNodeTweenHelper(node:RadarNode,origin:Point,whRadius:Array)
		{
			this.node = node;
			this.origin = origin;
			this.outR = RadarPositionUtil.getCircleRadius(whRadius,RadarNodeVO.GREEN);
			this.midR = RadarPositionUtil.getCircleRadius(whRadius,RadarNodeVO.YELLOW);
			this.lowR = RadarPositionUtil.getCircleRadius(whRadius,RadarNodeVO.RED);
		}
		
		public function moveEffect(fromState:String,toState:String):void
		{
//			trace("node:"+node.name +  ",from-->to:" + fromState + "-->" + toState);
//			trace("node:"+node.name +  ",x:" + this.node.x + ",y=" + this.node.y);
			var fromRadius:Array = getRadius(fromState);
			var toRadius:Array = getRadius(toState);
//			trace("node:"+node.name +  ",from w=" + fromRadius);
//			trace("node:"+node.name +  ",to w=" + toRadius);
			var fromPosition:Point = RadarPositionUtil.getCirclePosition(this.origin,
											this.node.degree,fromRadius);
			var toPosition:Point = RadarPositionUtil.getCirclePosition(this.origin,
											this.node.degree,toRadius);
			
			fromPosition = this.node.getPosition(fromPosition);
			toPosition = this.node.getPosition(toPosition);
//			trace("node:"+node.name +  ",from>>>x:" + fromPosition.x + ",y=" + fromPosition.y);
			
			var listen:TweenListener = new TweenListener(toState,this.node,this);
			
			var tween:Tween = new Tween(listen,[fromPosition.x,fromPosition.y],
									[toPosition.x,toPosition.y],2000);
										
		}
		
		public function alarmEffect():void
		{
			RadarNodeVisibleHelper.join(this.node);
		}
		
		
		private function getRadius(state:String):Array
		{
			var result:Array = this.outR;
			if(state == RadarNodeVO.RED){
				result = this.lowR;
			} else if(state == RadarNodeVO.YELLOW){
				result = this.midR;
			} else if(state == RadarNodeVO.GREEN){
				result = this.outR;
			} else {
				log.warn("input state:{0} invalid.",state);
			}
			return result;
		}
	}
}
import com.mocha.biz.common.ui.radar.RadarNode;
import com.mocha.biz.common.ui.radar.RadarNodeTweenHelper;
import com.mocha.biz.common.ui.radar.vo.RadarNodeVO;


class TweenListener{
	private var toState:String;
	private var node:RadarNode;
	private var helper:RadarNodeTweenHelper;
	public function TweenListener(toState:String,node:RadarNode,helper:RadarNodeTweenHelper){
		this.toState = toState;
		this.node = node;
		this.helper = helper;
	}
	
	public function onTweenUpdate(val:Object):void
	{
		this.node.x = val[0];
		this.node.y = val[1];
//		trace("node:" +  this.node.name + ",up val:" +val);

	}
	public function onTweenEnd(val:Object):void
	{
		
		this.node.x = val[0];
		this.node.y = val[1];
//		trace("node:" +this.node.name + ",end val:" +val);
		if(toState == RadarNodeVO.RED){
			helper.alarmEffect();
		} else {
			this.node.isMoveEffect = false;
		}
	}
}
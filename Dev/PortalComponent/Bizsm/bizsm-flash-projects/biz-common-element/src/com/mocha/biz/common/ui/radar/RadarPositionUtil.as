package com.mocha.biz.common.ui.radar
{
	import com.mocha.biz.common.ui.radar.vo.RadarNodeVO;
	
	import flash.geom.Point;

	/**
	 * TODO：com.mocha.biz.common.ui.radar.RadarPositionUtil
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-2  下午04:54:17
	 */
	public class RadarPositionUtil
	{
		public static function getCirclePosition(orgin:Point,degree:Number,xyRadius:Array):Point
		{
			var fdegree:Number = degree * Math.PI/180;
			var tempPoint:Point = new Point(xyRadius[0]*Math.cos(fdegree),xyRadius[1]*Math.sin(fdegree));
			return orgin.add(tempPoint);
		}
		
		public static function getCircleRadius(whRadius:Array,state:String):Array
		{
			var xUint:Number = whRadius[0]/6;
			var yUint:Number = whRadius[1]/6;
			var xyRadius:Array = [];
			if(state == RadarNodeVO.GREEN){
				xyRadius.push(xUint*4.5);
				xyRadius.push(yUint*4.5);
			} else if(state == RadarNodeVO.YELLOW){
				xyRadius.push(xUint*3);
				xyRadius.push(yUint*3);
			} else if(state == RadarNodeVO.RED){
				xyRadius.push(xUint*1.3);
				xyRadius.push(yUint*1.3);
			} else {
				xyRadius.push(xUint*4.5);
				xyRadius.push(yUint*4.5);
			}
			return xyRadius;
		}
	}
}
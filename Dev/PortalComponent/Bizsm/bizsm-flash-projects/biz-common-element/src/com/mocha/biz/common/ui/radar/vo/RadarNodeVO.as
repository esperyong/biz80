package com.mocha.biz.common.ui.radar.vo
{
	/**
	 * TODO：com.mocha.biz.common.ui.radar.vo.RadarNodeVO
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-1  下午01:30:22
	 */
	public class RadarNodeVO
	{
		public static const RED:String = "red";
		public static const YELLOW:String = "yellow";
		public static const GREEN:String = "green";
		
		public var nodeText:String;
		public var nodeData:Object;
		public var nodeIndex:uint = 0;
		public var nodeStatus:String = GREEN;
		
	}
}
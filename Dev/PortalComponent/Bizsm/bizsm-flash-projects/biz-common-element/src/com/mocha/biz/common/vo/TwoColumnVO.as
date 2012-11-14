package com.mocha.biz.common.vo
{
	/**
	 * TODO：com.mocha.biz.common.ui.radar.vo.TwoColumnVO
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-4  上午09:53:00
	 */
	public class TwoColumnVO
	{
		public static const LABEL:int = 1;
		public static const BUTTON:int = 2;
		public static const SELECTED:int = 3;
		public static const INPUT:int = 4;
		public static const TEXTAREA:int = 5;
		
		public static const COLUMN_SPLIT:String = "@_@";
		public static const ROW_SPLIT:String = "#_#";
		
		
		public var label:String;
		public var value:String;
		public var type:int = LABEL;
	}
}
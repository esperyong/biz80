package com.mocha.biz.common.ui.radar
{
	import com.mocha.biz.common.vo.RowVO;
	
	import spark.components.Group;
	import spark.components.supportClasses.SkinnableComponent;
	
	/**
	 * TODO：com.mocha.biz.common.ui.radar.RadarToolTip
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-4  上午10:34:56
	 */
	public class RadarToolTip extends SkinnableComponent implements IRadarToolTip
	{
		[SkinPart(required=false)]
		public var content:Group;
		
		public function RadarToolTip()
		{
			//TODO: implement function
			super();
		}
		
		public function get text():String
		{
			//TODO: implement function
			return null;
		}
		
		public function set text(value:String):void
		{
			//TODO: implement function
		}
		
		public function set rows(rows:Vector.<RowVO>):void
		{
			//TODO: implement function
		}
		
		public function get rows():Vector.<RowVO>
		{
			//TODO: implement function
			return null;
		}
		
		public function stringToRows(s:String):Vector.<RowVO>
		{
			//TODO: implement function
			return null;
		}
		
		public function rowsToString(rows:Vector.<RowVO>):String
		{
			//TODO: implement function
			return null;
		}
	}
}
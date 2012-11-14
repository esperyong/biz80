package com.mocha.biz.common
{
	import com.mocha.biz.common.vo.RowVO;
	
	/**
	 * TODO：com.mocha.biz.common.util.IPanel
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-4  上午10:25:11
	 */
	public interface IPanel
	{
		function set rows(rows:Vector.<RowVO>):void;
		
		function get rows():Vector.<RowVO>;
		
		function stringToRows(s:String):Vector.<RowVO>;
		
		function rowsToString(rows:Vector.<RowVO>):String;
	}
}
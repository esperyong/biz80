package com.mocha.biz.ui.cvo
{
	import com.mocha.common.vo.BaseVO;

	/**
	 * TODO：com.mocha.biz.comparent.cvo.NodeVO
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-21  上午11:52:26
	 */
	public class NodeVO //extends BaseVO
	{
		[XMLAttInspectable]
		public var nodeImg:String;
		
		[XMLAttInspectable]
		public var nodeText:String;
		[XMLAttInspectable]
		public var nodeType:String;
		[XMLAttInspectable]
		public var statusImg:String;
		[XMLAttInspectable]
		public var relationId:String;
		
		
		[TstInspectable]
		public var isRunning:Boolean = false;
		
//		override public function get aliasName():String
//		{
//			return "node";
//		}
	}
}
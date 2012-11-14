package com.mocha.biz.ui.cvo
{
	import com.mocha.common.vo.BaseVO;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * TODO：com.mocha.biz.ui.cvo.GraphVO
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-25  下午02:56:26
	 */
	public class GraphVO extends BaseVO
	{
		[ArrayElmentType("com.mocha.common.vo.NodeVO")]
		public var nodes:Array = [];
		public function GraphVO()
		{
			super();
		}
		
		override public function get aliasName():String
		{
			return "graph";
		}
	}
}
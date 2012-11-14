package com.mocha.biz.test.vo
{
	import com.mocha.biz.vo.BaseVO;

	public class BVO extends BaseVO
	{
		public var c:String;
		public var d:String;
		public var e:CVO;
		[ArrayElementType("com.mocha.biz.test.vo.CVO")]
		public var v:Array;
		
		override public function get xmlAttributes():Object
		{
			var attributes:Object = {};
			attributes["c"] = null;
			attributes["d"] = null;
			return attributes;
		}
		
		override public function get aliasName():String
		{
			return "BVOTEST";
		}
	}
}
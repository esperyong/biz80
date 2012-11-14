package com.mocha.biz.test.vo
{
	import com.mocha.biz.vo.BaseVO;

	public class AVO
	{
		public var a:String;
		private var _b:String;
		public var key:Number;
		public function set b(v:String):void
		{
			this._b = v;	
		}
		public function get b():String
		{
			return this._b;
		}
		
		public var bvo:BVO;
		
		[ArrayElementType("com.mocha.biz.test.vo.BVO")]
		public var bvos:Array;
		
		[ArrayElementType("String")]
		public var ids:Array;
		
	}
}
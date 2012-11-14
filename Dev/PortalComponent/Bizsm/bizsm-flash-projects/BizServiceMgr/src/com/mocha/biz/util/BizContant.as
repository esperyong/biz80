package com.mocha.biz.util
{
	import com.mocha.biz.core.common.NodeType;

	public class BizContant
	{
		public static const NODE_TYPE_PRIMITIVE_SHAPE:String = "primitive";
		public static const LINE_TYPE_COMMON:String = "commonLine";
		public static const LINE_TYPE_PLOY:String = "ployLine";
		
		public static const DEFAULT_STENCIL_NAME:String = "selector";
		
		/**
		 * 获取组件属性集合.
		 * 
		 */ 
		public static function getElementPropertieKeys(type:String):Array
		{
			var keys:Array;
			switch(type){
				case NodeType.BIZSERVICE:
				{
					keys = BizContant.subFlowPropertieKeys;
					break;
				}
				case NodeType.BIZUSER:
				{
					keys = BizContant.bizUserPropertieKeys;
					break;
				}
				case NodeType.RESOURCE:
				{
					keys = BizContant.resoucePropertieKeys;
					break;
				}
				case NODE_TYPE_PRIMITIVE_SHAPE:
				{
					keys = BizContant.primitiveShapePropertieKeys;
					break;
				}
				default:
				{
					keys = BizContant.defualtPropertieKeys;
				}
			}
			return keys;
		}
		
		private static function get defualtPropertieKeys():Array
		{
			return [
				{key:"name",			type:"String"}
			];
		}
		
		private static function get subFlowPropertieKeys():Array
		{
			return [
						{key:"name",			type:"String"},
						{key:"state",			type:"Number"},
						{key:"icon",           type:"String"}
					];
		}
		private static function get bizUserPropertieKeys():Array
		{
			return [
				{key:"name",			type:"String"},
				{key:"icon",           type:"String"}
			];
		}
		private static function get resoucePropertieKeys():Array
		{
			return [
				{key:"name",			type:"String"},
				{key:"icon",           type:"String"}
			];
		}
		private static function get primitiveShapePropertieKeys():Array
		{
			return [
				{key:"name",			type:"String"},
				{key:"icon",           type:"String"}
			];
		}
	}
}
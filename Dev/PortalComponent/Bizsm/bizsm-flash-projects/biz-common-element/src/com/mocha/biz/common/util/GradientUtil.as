package com.mocha.biz.common.util
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	

	/**
	 * TODO：com.mocha.biz.common.util.GradientUtil
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-11-2  下午01:53:52
	 */
	public class GradientUtil
	{
		
		public static function drawGradientBackGround(graphic:Graphics,w:Number,h:Number,
													  colors:Array,
													  rotation:Number=Math.PI/2,
													  type:String=GradientType.LINEAR,
													  tx:Number=0,
													  ty:Number=0):void
		{
			var angles:Array = getAngels(colors);
			var aphals:Array = getAphals(colors);
			
			var colormatrix:Matrix = new Matrix(); 
			colormatrix.createGradientBox(w,h,rotation,tx,ty)
			graphic.beginGradientFill(type,colors,aphals,
				angles,colormatrix);
			graphic.drawRect(0,0,w,h);
		}
		public static function getAphals(colors:Array):Array
		{
			var aphals:Array = [];
			for(var i:uint;i<colors.length;i++){
				aphals.push(1);
			}
			return aphals;
		}
		
		public static function getAngels(colors:Array):Array
		{
			var angles:Array = [];
			var intraval:Number = 255/colors.length;
			for(var j:uint;j<colors.length;j++){
				angles.push(intraval*(j));
			}
			return angles;
		}
	}
}
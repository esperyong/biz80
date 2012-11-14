package com.mocha.biz.util
{
	import com.mocha.biz.event.StencilEvent;
	import com.mocha.biz.model.BizControl;
	import com.mocha.biz.model.GraphLocator;
	import com.mocha.common.util.ObjectInfoUtil;
	
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.LineFormattedTarget;
	import mx.logging.targets.TraceTarget;



	/**
	 * @author chendg
	 * @version 1.0
	 * @created 14-����-2010 9:44:23
	 */
	public class BizUtil
	{
		function BizUtil(){
	
		}
		
		static public function logStart():void
		{
			var traceLogger:LineFormattedTarget = new TraceTarget();
			traceLogger.filters = [ "*"];
			traceLogger.level = LogEventLevel.DEBUG;
			traceLogger.includeDate = true;
			traceLogger.includeTime = true;
			traceLogger.includeCategory = true;
			traceLogger.includeLevel = true;
			Log.addTarget(traceLogger);
		}
		
		static public function getGraphFullXML():XML
		{
			var xmlArray:Array = ["<BizTopologyGraph>"];
			var bizXML:XML = ObjectInfoUtil.objectToXML(GraphLocator.getInstance().logicVO);
			xmlArray.push("<BizService>");
			xmlArray.push(bizXML.children());
			xmlArray.push("</BizService>");
			xmlArray.push("<GraphInfo>");
			xmlArray.push("\n\t<Info>");
			xmlArray.push("\n\t\t<![CDATA[");
			xmlArray.push(GraphLocator.getInstance().graphProxy.exportData());
			xmlArray.push("\n\t\t]]>");
			xmlArray.push("\n\t</Info>");
			xmlArray.push("</GraphInfo>");
			xmlArray.push("</BizTopologyGraph>");
			return XML(xmlArray.join("\n"));
		}
		
		static public function selectDefaultStencil():void
		{
			var bizControl:BizControl = GraphLocator.getInstance().bizControl;
			bizControl.dispatchStencilEvent(StencilEvent.SELECTED_STENCIL,BizContant.DEFAULT_STENCIL_NAME,null);
		}
		
		static public function uriConvertToURL(uri:String,append:String=".xml"):String
		{
			if(!uri){
				return uri;
			}
			if(GraphLocator.getInstance().webRootPath != ""){
				if(uri.indexOf(GraphLocator.getInstance().webRootPath) == -1){
					uri = GraphLocator.getInstance().webRootPath + uri;
				}
			}
			
			if(append){
				if(uri.indexOf(append) != (uri.length - append.length) ){
					uri = uri + append;
				}
			}
			return uri;
		}
		
	}
}
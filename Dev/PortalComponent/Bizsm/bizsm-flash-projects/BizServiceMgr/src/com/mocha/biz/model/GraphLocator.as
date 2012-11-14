package com.mocha.biz.model
{
	import com.mocha.biz.core.vo.logic.BizSerivceVO;
	import com.mocha.biz.ui.cvo.GraphVO;
	import com.mocha.biz.ui.data.GraphCanvasProxy;
	import com.mocha.biz.vo.FullGraphVO;

	
	/**
	 * @author chendg
	 * @version 1.0
	 * @created 14-����-2010 9:44:23
	 */
	public class GraphLocator
	{
		public var fullGraphVO:FullGraphVO;
		
		public var serviceId:String;
		
		public var selectedData:SelectedStencilData;
	
		public var graphProxy:GraphCanvasProxy;
		
		public var webRootPath:String = "";
		
		public var bizControl:BizControl;
		
		private static var instance:GraphLocator;
		function GraphLocator(){
			bizControl = new BizControl();
			selectedData = new SelectedStencilData();
		}
		
		public static function getInstance():GraphLocator{
			if(!instance){
				instance = new GraphLocator();
			}
			return instance;
		}
		
		public function initGraphData():void
		{
			this.fullGraphVO = new FullGraphVO();
			this.fullGraphVO.graphVO = new GraphVO();
			this.fullGraphVO.logicVO = new BizSerivceVO();
			this.serviceId = null;
			selectedData.init();
		}
		
		public function get graphVO():GraphVO
		{
			return fullGraphVO.graphVO;
		}
		
		public function get logicVO():BizSerivceVO
		{
			return fullGraphVO.logicVO;
		}
		
	
	}
}
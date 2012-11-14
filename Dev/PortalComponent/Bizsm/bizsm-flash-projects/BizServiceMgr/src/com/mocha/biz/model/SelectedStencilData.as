package com.mocha.biz.model
{
	
	import com.mocha.biz.core.vo.logic.BizSerivceVO;
	import com.mocha.biz.core.vo.logic.BizUser;
	import com.mocha.biz.core.vo.logic.MonitableResource;
	
	import flash.events.MouseEvent;

	/**
	 * TODO：com.mocha.biz.model.SelectedStencilData
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-27  上午11:29:58
	 */
	public class SelectedStencilData
	{
		public var selectedType:String;
		public var selectedUri:String;
		public var creatorMoserEvent:MouseEvent;
		
		public var bizService:BizSerivceVO;
		public var bizUser:BizUser;
		public var monitorResouce:MonitableResource;
		
		public function init():void
		{
			this.selectedType = null;
			this.selectedUri = null;
			this.bizService = null;
			this.bizUser = null;
			this.monitorResouce = null;
		}
	}
}
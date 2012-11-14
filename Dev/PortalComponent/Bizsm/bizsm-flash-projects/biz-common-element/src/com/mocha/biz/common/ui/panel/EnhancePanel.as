package com.mocha.biz.common.ui.panel
{
	import com.mocha.biz.common.event.PanelEvent;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	
	import spark.components.Button;
	import spark.components.Panel;
	
	[Event(name="close",type="com.mocha.biz.common.event.PanelEvent")]
	[Event(name="commit",type="com.mocha.biz.common.event.PanelEvent")]
	[Event(name="cancel",type="com.mocha.biz.common.event.PanelEvent")]
	
	/**
	 * TODO：com.mocha.biz.common.ui.EnhancePanel
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-10-27  下午04:22:31
	 */
	public class EnhancePanel extends Panel
	{
		[SkinPart(required="false")]
		public var closeImg:Image;
		[SkinPart(required="false")]
		public var commitBtn:Button;
		[SkinPart(required="false")]
		public var cancelBtn:Button;
		
		
		public function EnhancePanel()
		{
			super();
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == this.closeImg){
				this.closeImg.addEventListener(MouseEvent.MOUSE_DOWN,closeHander);
			} else if(instance == this.commitBtn){
				this.commitBtn.addEventListener(MouseEvent.MOUSE_DOWN,commitHandler);
			} else if(instance == this.cancelBtn){
				this.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN,cancelHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName,instance);
			if(instance == this.closeImg){
				this.closeImg.removeEventListener(MouseEvent.MOUSE_DOWN,closeHander);
			} else if(instance == this.commitBtn){
				this.commitBtn.removeEventListener(MouseEvent.MOUSE_DOWN,commitHandler);
			} else if(instance == this.cancelBtn){
				this.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN,cancelHandler);
			}
		}
		
		private function closeHander(e:MouseEvent):void
		{
			var event:PanelEvent = new PanelEvent(PanelEvent.CLOSE);
			this.dispatchEvent(event);
		}
		
		private function commitHandler(e:MouseEvent):void
		{
			var event:PanelEvent = new PanelEvent(PanelEvent.COMMIT);
			this.dispatchEvent(event);
		}
		
		private function cancelHandler(e:MouseEvent):void
		{
			var event:PanelEvent = new PanelEvent(PanelEvent.CANCEL);
			this.dispatchEvent(event);
		}
	}
}
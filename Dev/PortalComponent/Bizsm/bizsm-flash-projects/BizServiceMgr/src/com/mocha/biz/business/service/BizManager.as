package com.mocha.biz.business.service
{
	import com.mocha.biz.business.responder.BizServiceResponder;
	import com.mocha.biz.business.responder.BizUserResponder;
	import com.mocha.biz.business.responder.FullBizServiceResponder;
	import com.mocha.biz.business.responder.ResourceResponder;
	import com.mocha.biz.business.responder.SaveFullBizServiceResponder;
	import com.mocha.biz.model.GraphLocator;
	import com.mocha.biz.util.BizEditorUtil;
	import com.mocha.biz.vo.FullGraphVO;
	import com.mocha.common.business.remote.RemoteBean;
	import com.mocha.common.business.remote.RemoteService;
	import com.mocha.common.business.responder.BaseResponder;

	/**
	 * TODO：com.mocha.biz.business.service.BizManager
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-26  上午09:41:24
	 */
	public class BizManager
	{
		public function BizManager()
		{
		}
		
		public static function remoteSubBizService(url:String,isAdd:Boolean):void
		{
			var bean:RemoteBean = new RemoteBean();
			bean.url = url;
			bean.header = {url:url,isAdd:isAdd}
			
			var responder:BaseResponder = new BizServiceResponder(isAdd)
			responder.header = bean.header;
			bean.responder = responder;
			
			RemoteService.remoteHttpService(bean);
			
		}
		public static function remoteBizUser(url:String,isAdd:Boolean):void
		{
			var bean:RemoteBean = new RemoteBean();
			bean.url = url;
			bean.header = {url:url,isAdd:isAdd}
			
			var responder:BaseResponder = new BizUserResponder(isAdd);
			responder.header = bean.header;
			bean.responder = responder;
			
			RemoteService.remoteHttpService(bean);
			
		}
		public static function remoteMonitorResource(url:String,isAdd:Boolean):void
		{
			var bean:RemoteBean = new RemoteBean();
			bean.url = url;
			bean.header = {url:url,isAdd:isAdd}
			
			var responder:BaseResponder = new ResourceResponder(isAdd);
			responder.header = bean.header;
			bean.responder = responder;
			
			RemoteService.remoteHttpService(bean);
		}
		
		public static function openFullGraph(url:String):void
		{
			
//			GraphLocator.getInstance().graphProxy.removeAllComponents();
			
			var bean:RemoteBean = new RemoteBean();
			bean.url = url;
			bean.header = {url:url}
			
			var responder:BaseResponder = new FullBizServiceResponder();
			responder.header = bean.header;
			bean.responder = responder;
			
			RemoteService.remoteHttpService(bean);
		}
		
		public static function save(contentPath:String):void
		{
//			CallJS.callJSProxy(callback,contentPath,String(BizUtil.getGraphFullXML()));
			var fullvo:FullGraphVO = GraphLocator.getInstance().fullGraphVO;
			var bean:RemoteBean = new RemoteBean();
			var url:String = BizEditorUtil.uriConvertToURL(fullvo.uri);
			url = url + "?__http_method=PUT";
			bean.url = url;
			bean.header = {url:bean.url}
			bean.httpMethod = RemoteBean.POST;
			bean.parameters = BizEditorUtil.getGraphFullXML();
//			bean.parameters = GraphLocator.getInstance().graphProxy.exportData();
			bean.contentType = "application/xml";
			
			var responder:BaseResponder = new SaveFullBizServiceResponder();
			responder.header = bean.header;
			bean.responder = responder;
			
			RemoteService.remoteHttpService(bean);
		}
		
	}
}
package com.mocha.common.business.remote
{
	
	import com.mocha.common.business.responder.BaseResponder;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncToken;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;

	/**
	 * 调用远程服务通用组件.
	 * 
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-15  下午05:33:12
	 */
	public class RemoteService
	{
		private static var log:ILogger = 
			Log.getLogger("com.mocha.common.business.remote.RemoteService");
		
		/**
		 * 调用HTTPService服务.如果设置destination，请求将使用代理模式
		 * @param bean RemoteBean  封装所有请求参数和响应处理类,RemoteBean.parameters是键值对对象.
		 * @httpService HTTPService 外部传入HTTPService组件
		 * 
		 */ 
		public static function remoteHttpService(bean:RemoteBean,httpService:HTTPService=null):void
		{
			if(!httpService){
				httpService = new HTTPService();
			}
			httpService.url = bean.url;
			httpService.method = bean.httpMethod;
			if(bean.destination){
				httpService.destination = bean.destination;
				httpService.useProxy = true;
			}
			if(bean.parameters){
				httpService.request = bean.parameters;
			}
			httpService.showBusyCursor = bean.isShowBusyCursor;
			httpService.requestTimeout = bean.requestTimeOut;
			httpService.resultFormat = bean.resultFormat;
			httpService.contentType = bean.contentType;
			
			var token:AsyncToken = httpService.send();
			token[BaseResponder.HEADER] = bean.header;
			if(bean.responder){
				token.addResponder(bean.responder);
			} else {
				log.warn("remoteHttpService()::RemoteBean[url={0}] not found IResponder.",bean.url);
			}
			
		}
		
		/**
		 * 调用RemoteObject组件.
		 * @param bean RemoteBean  封装所有请求参数和响应处理类，RemoteBean.parameters对象类型是Array
		 * 			即，远程服务参数列表
		 * @objectService RemoteObject 外部传入HTTPService组件
		 * 
		 */ 
		public static function remoteObjectService(bean:RemoteBean,objectService:RemoteObject=null):void
		{
			if(!objectService){
				objectService = new RemoteObject();
			}
			
			objectService.destination = bean.destination;
			objectService.showBusyCursor = bean.isShowBusyCursor;			
			objectService.requestTimeout = bean.requestTimeOut;
			
			
			var operation:AbstractOperation = objectService.getOperation(bean.remoteMethod);
			if(!operation){
				log.error("RemoteBean[method={0},destination={1}]" +
					"not found in ObjectService.",bean.remoteMethod,bean.destination);
				return;
			}
			
			if(bean.parameters){
				if(bean.parameters is Array){
					operation.arguments = bean.parameters;
				} else {
					operation.arguments = [bean.parameters];
					log.warn("RemoteBean[method={0},destination={1}]" +
						"reqired an Array Parameter,but send parameterType={2}" +
						",System autoWrap an Array included one Element.",
						bean.remoteMethod,bean.destination,typeof bean.parameters);
				}
			}
			var token:AsyncToken = operation.send();
			token[BaseResponder.HEADER] = bean.header;
			if(bean.responder){
				token.addResponder(bean.responder);
			} else {
				log.warn("RemoteBean[method={0},destination={1}]" +
					"not found IResponder.",bean.remoteMethod,bean.destination);
			}
			
		}
	}
}
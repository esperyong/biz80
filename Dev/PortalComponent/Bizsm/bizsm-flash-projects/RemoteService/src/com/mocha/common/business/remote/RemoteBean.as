package com.mocha.common.business.remote
{
	import mx.rpc.IResponder;
	

	/**
	 * TODO：com.mocha.common.business.remote.RemoteBean
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-15  下午05:38:59
	 */
	public class RemoteBean
	{
		public static const POST:String = "POST";
		public static const GET:String = "GET";
		public static const HEAD:String = "HEAD";
		public static const OPTIONS:String = "OPTIONS";
		public static const PUT:String = "PUT";
		public static const TRACE:String = "TRACE";
		public static const DELETE:String = "DELETE";
		
		public var responder:IResponder;
		public var parameters:Object;
		public var destination:String;
		public var httpMethod:String = GET;
		public var remoteMethod:String;
		public var url:String;
		public var header:Object;
		public var isShowBusyCursor:Boolean = false;
		public var resultFormat:String = "xml";
		
		public var contentType:String = "application/x-www-form-urlencoded";
		
		
		/**
		 * 超时时间 单位：秒
		 */ 
		public var requestTimeOut:Number = 300;
	}
}
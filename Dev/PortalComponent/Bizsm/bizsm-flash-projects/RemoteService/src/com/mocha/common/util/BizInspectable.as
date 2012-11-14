package com.mocha.common.util
{
	
	/**
	 * TODO：com.mocha.common.util.BizInspectable
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-28  上午09:51:35
	 */
	public interface BizInspectable
	{
		function get prosAsXMLAttribute():Object;
		
		function get transientPros():Object;
		
		function get aliasName():String;
	}
}
package com.mocha.common.util
{
	/**
	 * XML写工具.
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-16  下午12:07:18
	 */
	public class XMLWriter 
	{
		public var xml:XML;
		
		public function XMLWriter(localName:* = null)
		{
			if(localName){
				xml=new XML("<" + localName + "/>");;
			} else {
				xml=<obj/>;
			}
		}        
		public function addProperty(propertyName:String, propertyValue:*):XML {
			
			var xmlProperty:XML=<new/>
			xmlProperty.setName(propertyName);
			xmlProperty.appendChild(propertyValue);
			xml.appendChild(xmlProperty);
			return xmlProperty;
		}  
		
		public function addAttribute(propertyName:String, propertyValue:*):void
		{
			xml.@[propertyName] = propertyValue;
		}
		
		public function modifyRootName(nodeName:String):void
		{
			xml.setName(nodeName);
		}
	}


}
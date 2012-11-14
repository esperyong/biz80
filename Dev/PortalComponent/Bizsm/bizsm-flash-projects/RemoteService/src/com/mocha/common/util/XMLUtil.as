package com.mocha.common.util
{
	/**
	 * TODO：com.mocha.biz.XMLUtil
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-10-26  上午11:36:45
	 */
	public class XMLUtil
	{
		static public function deleteXMLNode(xmlToDelete:XML):void
		{
			if(!xmlToDelete || !xmlToDelete.parent()){
				return;
			}
			var childs:XMLList =  XMLList(xmlToDelete.parent()).children();
			var childLength:Number = childs.length();
			for ( var i:Number = 0 ; i < childLength; i++ )
			{
				if ( childs[i] == xmlToDelete ) 
				{
					delete childs[i]; 
					break;
				}
			}    


		}
		
		static public function removeNullNodes(full:XML):void
		{
			if(!full ){
				return;
			}
			var childs:XMLList =  full..*;
			var childLength:Number = childs.length();
			for ( var i:Number = 0 ; i < childLength; i++ )
			{
				if(childs[i].name() == "null"){
					deleteXMLNode(childs[i]);
				}
			}    
			
			
		}
	}
}
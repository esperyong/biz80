package com.mocha.common.util
{
	
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	/**
	 *  The SimpleXMLDecoder class deserialize XML into a graph of ActionScript objects.
	 * Use  this class when no schema information is available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class XMLDecoder
	{
		//--------------------------------------------------------------------------
		//
		//  Class Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 *  @private
		 */
		public static function simpleType(val:Object):Object
		{
			return val;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  Constructor.
		 */
		public function XMLDecoder(makeObjectsBindable:Boolean = false)
		{
			super();
			
			this.makeObjectsBindable = makeObjectsBindable;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Converts a tree of XMLNodes into a tree of ActionScript Objects.
		 *
		 *  @param dataNode An XMLNode to be converted into a tree of ActionScript Objects.
		 *
		 *  @return A tree of ActionScript Objects.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function decodeXML(dataNode:XMLNode):Object
		{
			var result:Object;
			var isSimpleType:Boolean = false;
			
			if (dataNode == null)
				return null;
			
			// Cycle through the subnodes
			var children:Array = dataNode.childNodes;
			if (children.length == 1 && children[0].nodeType == XMLNodeType.TEXT_NODE)
			{
				// If exactly one text node subtype, we must want a simple
				// value.
				isSimpleType = true;
				result = XMLDecoder.simpleType(children[0].nodeValue);
			}
			else if (children.length > 0)
			{
				result = {};
				if (makeObjectsBindable)
					result = new ObjectProxy(result);
				
				for (var i:uint = 0; i < children.length; i++)
				{
					var partNode:XMLNode = children[i];
					
					// skip text nodes, which are part of mixed content
					if (partNode.nodeType != XMLNodeType.ELEMENT_NODE)
					{
						continue;
					}
					
					var partName:String = getLocalName(partNode);
					var partObj:Object = decodeXML(partNode);
					
					// Enable processing multiple copies of the same element (sequences)
					var existing:Object = result[partName];
					if (existing != null)
					{
						if (existing is Array)
						{
							existing.push(partObj);
						}
						else if (existing is ArrayCollection)
						{
							existing.source.push(partObj);
						}
						else
						{
							existing = [existing];
							existing.push(partObj);
							
							if (makeObjectsBindable)
								existing = new ArrayCollection(existing as Array);
							
							result[partName] = existing;
						}
					}
					else
					{
						result[partName] = partObj;
					}
				}
			}
			
			// Cycle through the attributes
			var attributes:Object = dataNode.attributes;
			for (var attribute:String in attributes)
			{
				if (attribute == "xmlns" || attribute.indexOf("xmlns:") != -1)
					continue;
				
				// result can be null if it contains no children.
				if (result == null)
				{
					result = {};
					if (makeObjectsBindable)
						result = new ObjectProxy(result);
				}
				
				// If result is not currently an Object (it is a Number, Boolean,
				// or String), then convert it to be a ComplexString so that we
				// can attach attributes to it.  (See comment in ComplexString.as)
//				if (isSimpleType && !(result is ComplexString))
//				{
//					result = new ComplexString(result.toString());
//					isSimpleType = false;
//				}
				
				result[attribute] = XMLDecoder.simpleType(attributes[attribute]);
			}
			
			return result;
		}
		
		/**
		 * Returns the local name of an XMLNode.
		 *
		 *  @param xmlNode The XMLNode. 
		 *
		 * @return The local name of an XMLNode.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function getLocalName(xmlNode:XMLNode):String
		{
			var name:String = xmlNode.nodeName;
			var myPrefixIndex:int = name.indexOf(":");
			if (myPrefixIndex != -1)
			{
				name = name.substring(myPrefixIndex+1);
			}
			return name;
		}
		
		private var makeObjectsBindable:Boolean;
	}
	
}
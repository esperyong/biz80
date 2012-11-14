package com.mocha.common.util
{
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ObjectUtil;
	
	/**
	 * 对象信息工具类.
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 14-����-2010 9:44:23
	 */
	public class ObjectInfoUtil
	{
		private static var log:ILogger = 
			Log.getLogger("com.mocha.common.util.ObjectInfoUtil");
		
		/**
		 * 通过类名称获取类对象.
		 * @param className 类全路径名称
		 */ 
		public static function getClass(className:String):Class
		{
			var c:Class;
			try{
				c = getDefinitionByName(className) as Class;
			} catch(e:Error){
			}
			return c;
		}
		
		/**
		 * 判断类是否包含别名定义.
		 * 
		 */ 
		public static function classHaveAliasDef(className:*):Boolean
		{
			var info:Object = getClassInfo(className);
			var dd:ObjectUtil;
			if(info["alias"] && info["alias"]!=""){
				return true;
			}
			return false;
		}
		
		/**
		 * 获取类的基本信息，不包括属性.
		 * 
		 */ 
		public static function getClassInfo(className:*):Object
		{
			var source:*;
			if(!className){
				return info;
			}
			if(className is Class){
				source = new className();
			} else if(className is String){
				var c:Class = getClass(className);
				if(!c){
					throw new Error("className=" + className + " not found!");
				}
				source = new c(); 
			} else {
				source = className;
			}
			
			
			
			var objDescriptor:XML=describeType(source);
			var info:Object = {};
			var names:Array = String(objDescriptor.@name).split("::");
			var classFullName:String = "";
			var name:String = "";
			if(names.length==2){
				classFullName = names[0] + "." + names[1];
				name =  names[1];
			} else {
				classFullName = names[0];
				name =  names[0];
			}
			
			info["name"] = name;
			info["classFullName"] = classFullName;
			info["alias"] = String(objDescriptor.@alias);
			//info["base"] = objDescriptor.@base.replace("::",".");
			info["isDynamic"] = Boolean(objDescriptor.@isDynamic);
			info["isFinal"] = Boolean(objDescriptor.@isFinal);
			info["isStatic"] = Boolean(objDescriptor.@isStatic);
			
			return info;
		}
		
		/**
		 * 根据类对象、类名称或者类实例获取类的属性信息.
		 * 
		 * @param className 类对象、类名称或者类实例
		 * @return {pro:{type:className,access:readonly,elementType:itemType}}
		 */ 
		public static function getClassAllProperties(className:*):Object
		{
			var source:*;
			var info:Object = {};
			if(!className){
				return info;
			}
			if(className is Class){
				source = new className();
			} else if(className is String){
				var c:Class = getClass(className);
				if(!c){
					throw new Error("className=" + className + " not found!");
				}
				source = new c(); 
			} else {
				source = className;
			}
			
			
			
			var objDescriptor:XML=describeType(source);
			var child:XML;
			var childs:XMLList = objDescriptor.children();
			for each(child in childs){
				if(child.name() == "variable" || child.name() == "accessor"){
					
				} else {
					continue;
				}
				var arrayElementType:XMLList = child.metadata.(@name=="ArrayElementType");
				var xmlAttributeInspectable:XMLList = child.metadata.(@name=="XMLAttInspectable");
				var trasientInspectable:XMLList = child.metadata.(@name=="TstInspectable");
				var obj:Object = {};
				if(arrayElementType && arrayElementType[0]){
					obj["elementType"] = arrayElementType.arg.@value;
				}
				
				if(xmlAttributeInspectable && xmlAttributeInspectable[0]){
					obj["xml"] = child.@name;
				}
				if(trasientInspectable && trasientInspectable[0]){
					obj["tst"] = child.@name;
				}
				
				if(child.name() == "variable"){
					obj["type"] = child.@type;
				}
				if(child.name() == "accessor"){
					obj["type"] = child.@type;
					obj["access"] = child.@access;
				}
				
				info[child.@name] = obj;
				
				
			}
			
			return info;
		}
		
		
		/**
		 * 对象转换为XML.
		 * @param source 源对象
		 * @return XML
		 */
		static public function objectToXML(source:Object,writer:XMLWriter=null,nodeName:String=null): XML
		{
			if(!source){
				return null;
			}
			if(!nodeName){
				if(source.hasOwnProperty("aliasName") && source["aliasName"]){
					nodeName = source["aliasName"]
				}
			}
			
			if(!nodeName){
				var objDescriptor:XML=describeType(source);
				
				var qualifiedClassName:String=objDescriptor.@name;
				if(qualifiedClassName.lastIndexOf("::") > 0){
					qualifiedClassName=qualifiedClassName.substr(qualifiedClassName.lastIndexOf("::")+2);
				}
				nodeName = qualifiedClassName;
			}
				
			if(writer){
				writer.modifyRootName(nodeName);
			} else {				
				writer = new XMLWriter(nodeName);
			}
			
			
			
			var properties:Object = getClassAllProperties(source);
			var xmlAttributes:Object = {};
			if(source.hasOwnProperty("prosAsXMLAttribute")){
				xmlAttributes = source["prosAsXMLAttribute"];
			}
			
			var transientPros:Object = {};
			if(source.hasOwnProperty("transientPros")){
				transientPros = source["transientPros"];
			}
			
			var childXML:XMLWriter;
			for(var pro:* in properties){
				if(transientPros.hasOwnProperty(pro)){
					continue;
				}
				if(pro == "prosAsXMLAttribute" || pro == "aliasName" || pro == "transientPros"){
					continue;
				}
				if(source[pro]){
					var type:String = properties[pro]["type"]+"";
					var writeonly:Boolean =  (properties[pro]["access"] == "writeonly") ? true : false;
					var elementType:String = properties[pro]["elementType"]+""; 
					
					//只写对象 pass
					if(writeonly){
						continue;
					}
					
					childXML = new XMLWriter();
					//普通对象
					if(checkClassIsPrimitive(type)){
						if(xmlAttributes.hasOwnProperty(pro)){
							writer.addAttribute(pro,source[pro]);
						} else {
							writer.addProperty(pro,source[pro]);
						}
					} else if(checkClassIsCollection(type)){      //集合类对象
						collectionToXML(source[pro],childXML,elementType);
						childXML.modifyRootName(pro);
						writer.xml.appendChild(childXML.xml);
					} else {
						objectToXML(source[pro],childXML);      //对象
						childXML.modifyRootName(pro);
						writer.xml.appendChild(childXML.xml);
					}
				}
			}
			return writer.xml;
		}
		
		/**
		 * 将集合对象转换为XML.
		 * @param arr 集合对象
		 * @param itemType 集合对象类型
		 * @param localName 集合对象根节点名称
		 * @return XML
		 * 
		 */ 
		static private function collectionToXML(arr:Object,writer:XMLWriter,itemType:String=null):XML
		{
			if(!arr){
				return null;
			}
			var childXML:*;
			if(!itemType){
				itemType = "noType";
			}
			for each(var item:* in arr){
				if(item && ObjectUtil.isSimple(item)){
					if(itemType == "String"){
						writer.addProperty("string",item);
					} else {
						writer.addProperty(itemType,item);
					}
					
				} else if(item) {
					var childWriter:XMLWriter = new XMLWriter(itemType);
					if(itemType.lastIndexOf(".") > 0){
						childWriter.modifyRootName(itemType.substr(itemType.lastIndexOf(".")+1));
					}
					objectToXML(item,childWriter);
					writer.xml.appendChild(childWriter.xml);
				}
			}
			return writer.xml;
		}
		
		/**
		 * XML转换为指定对象.
		 * @param xml
		 * @param className 类名称、类对象或者类实例
		 * @return className对应对象
		 */
		static public function xmlToObject(xml:XML,className:*): Object
		{
			var instance:Object;
			if(className){
				if(className is Class){
					instance = new className();
				} else if(className is String){
					try{
						var c:Class = getDefinitionByName(className) as Class;
						instance = new c();
					} catch(e:Error){
						instance = new Object();
					}
				} else {
					instance = className;
				}
			} else {
				instance = new Object();
			}
			var xmlDoc:XMLDocument = new XMLDocument(xml);
			xmlDoc.ignoreWhite = true;
			var decoder:XMLDecoder = new XMLDecoder(false);
			var decoded:Object;
			var xmlNode:XMLNode;
			if(xmlDoc.lastChild){
				xmlNode = xmlDoc.lastChild;
			} else {
				//至少包含一个节点
				var tempXML:XML = <tempXML/>;
				xml.appendChild(tempXML);
				xmlDoc = new XMLDocument(xml);
				xmlNode = xmlDoc.lastChild;
			}
			decoded = decoder.decodeXML(xmlNode);
			
			var classInfo:Object = getClassInfo(instance);
			if(classInfo["classFullName"]=="Object"){
				return decoded;
			}
			ObjectInfoUtil.objectPropertiesMerge(instance,decoded);
			return instance;
		}
		
		/**
		 * 对象属性拷贝.
		 * @param finalObj 源对象
		 * @param mergedObj 目标对象
		 * @renturn 源对象
		 */
		static public function objectPropertiesMerge(finalObj:Object, mergedObj:Object): Object
		{
			if(!finalObj || !mergedObj){
				return finalObj;
			}
			var finalObjPropertieInfos:Object = ObjectInfoUtil.getClassAllProperties(finalObj);
			for(var pro:* in mergedObj){
				if(finalObj.hasOwnProperty(pro)){
					var type:Object = finalObjPropertieInfos[pro]["type"]+"";
					var access:Object = finalObjPropertieInfos[pro]["access"];
					var isReadOnly:Boolean = (access=="readonly") ? true : false;
					if(isReadOnly){
						continue;
					}
					if(checkClassIsPrimitive(type)){
						finalObj[pro] = mergedObj[pro];
					} else {
						var c:Class = ObjectInfoUtil.getClass(type+"");
						var tempObj:Object = new c();
						if(checkClassIsCollection(type)){
							var elementType:String = finalObjPropertieInfos[pro]["elementType"]+"";
							finalObj[pro] = objectArrayPropertiesMerge(tempObj,mergedObj[pro],elementType);
						} else {							
							finalObj[pro] = objectPropertiesMerge(tempObj,mergedObj[pro]);
						}
					}
					
				} else {
					log.warn("propertie[{0}] not found in finalObj.",pro);
				}
			}
			return finalObj;
		}
		
		/**
		 * 数组元素拷贝.
		 * @param finalObj  最终输出对象
		 * @param mergedObj 待合并对象
		 * 
		 */ 
		static private function objectArrayPropertiesMerge(finalObj:Object, mergedObj:Object,arrayType:String): Object
		{
			if(!finalObj || !mergedObj || !arrayType){
				return finalObj;
			}
			var finalObjPropertieInfos:Object = ObjectInfoUtil.getClassAllProperties(arrayType);
			var arrayElementClass:Class = ObjectInfoUtil.getClass(arrayType);
			if(!arrayElementClass){
				return finalObj;
			}
			var arrayElementInstance:*;
			var isArrayCollection:Boolean = false;
			
			var item:Object;
			var isPrimitive:Boolean = checkClassIsPrimitive(arrayType);
			for each(var topPro:* in mergedObj){
				if(topPro is Array || topPro is ArrayCollection || topPro is ArrayList){
					for each(var bottomPro:* in topPro){
						if(isPrimitive){
							item = bottomPro;
						} else {
							arrayElementInstance = new arrayElementClass();
							item = objectPropertiesMerge(arrayElementInstance,bottomPro);
						}
						pushElementInCollection(finalObj,item);
					}
					
				} else {
					if(isPrimitive){
						item = topPro;
					} else {
						arrayElementInstance = new arrayElementClass();
						item = objectPropertiesMerge(arrayElementInstance,topPro);
					}
					pushElementInCollection(finalObj,item);
				}
				
			}
			return finalObj;
		}
		
		/**
		 * 向数组中增加元素.
		 * @param arr  数组
		 * @param item 元素
		 */ 
		static private function pushElementInCollection(arr:Object,item:Object):void
		{
			if(arr is Array){
				(arr as Array).push(item);
			} else if(arr is ArrayCollection || arr is ArrayList){
				ArrayCollection(arr).addItem(item);
			} else {
				log.error("method[pushElementInCollection] arr isn't Collection.");
			}
		}
		
		/**
		 *  检测类是否是基本类型.
		 */ 
		static public function checkClassIsPrimitive(className:*):Boolean
		{
			var isPrimitive:Boolean = false;
			switch(className){
				case "String":
				case "Number":
				case "Number":
				case "int":
				case "uint":
				case "Boolean":
				case "XML":
				case "XMLList":
				{
					isPrimitive = true;
					break;
				}
				default:
				{
					isPrimitive = false;
				}
			}
			return isPrimitive;
		}
		
		/**
		 * 检测类是否是集合类.
		 * 
		 */ 
		static private function checkClassIsCollection(className:*):Boolean
		{
			var isCollection:Boolean = false;
			switch(className){
				case "Array":
				case "mx.collections.ArrayCollection":
				case "mx.collections.ArrayList":
				{
					isCollection = true;
					break;
				}
				default:
				{
					isCollection = false;
				}
			}
			return isCollection;
		}
	}
}
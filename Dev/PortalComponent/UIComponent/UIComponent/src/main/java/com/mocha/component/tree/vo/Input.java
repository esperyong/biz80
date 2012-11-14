package com.mocha.component.tree.vo;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class Input {
	

	
	public static Element create(String type,Map<String,String> attr){
		Element input = DocumentHelper.createElement("input");
		input.addAttribute("type", type);
		if(attr!=null){
			Set<String> attrKeys = attr.keySet();
			for (Iterator iterator = attrKeys.iterator(); iterator.hasNext();) {
				String attrKey = (String) iterator.next();
				String attrVal = attr.get(attrKey);
				input.addAttribute(attrKey,attrVal);
			}
		}
		return input;
	}

	public static Element create(String type){
		return create(type,null);
	}
	
}

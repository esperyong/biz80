package com.mocha.component.tree.vo;

import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class Tool {
	public static Element create(String cls){
		
		Element span = DocumentHelper.createElement("span");
		span.addAttribute("class", cls);
		span.addAttribute("type", "tool");
		span.addText(" ");
		return span;
		
	}
}

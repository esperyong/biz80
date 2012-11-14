package com.mocha.component.tree.vo;

import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class Ico {
	public static Element create(String cls){
		
		Element span = DocumentHelper.createElement("span");
		span.addAttribute("class", cls);
		span.addAttribute("type", "ico");
		span.addText(" ");
		return span;
		
	}
}

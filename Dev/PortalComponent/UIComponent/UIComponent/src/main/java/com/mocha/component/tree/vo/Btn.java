package com.mocha.component.tree.vo;

import java.util.HashMap;
import java.util.Map;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;


public class Btn {


	
	public static Element create(boolean isLast,boolean isExpend,boolean isLeaf){
		String cls = "";
		
		if(isLast && isExpend && !isLeaf){ //如果是最后一个，并且是展开的,不是叶子节点   collapsable lastCollapsable
			cls="hitarea collapsable-hitarea lastCollapsable-hitarea";
		}else if(isLast && !isExpend && !isLeaf){ //如果是最后一个，并且是关闭的,不是叶子节点 expandable lastExpandable
			cls="hitarea expandable-hitarea lastExpandable-hitarea";  
		}else if(!isLast && !isExpend && !isLeaf){  //如果不是最后一个，并且是关闭的，不是叶子节点expandable
			cls="hitarea expandable-hitarea";
		}else if(!isLast && isExpend && !isLeaf){ //如果不是最后一个，并且是展开的，不是叶子节点collapsable
			cls="hitarea  collapsable-hitarea";
		}else if(isLast && isLeaf){  //如果是最后一个，并且是叶子节点
			cls="last";
		}
		
		Element div = DocumentHelper.createElement("div");
		div.addText("");
		//div.attributeValue("class", cls);
		div.addAttribute("class", cls);
		
		return div;
	}
	
}

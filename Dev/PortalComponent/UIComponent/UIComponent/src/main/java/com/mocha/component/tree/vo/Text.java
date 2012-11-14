package com.mocha.component.tree.vo;


import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * @author weiyi
 *
 */
public class Text {


	
	public static Element create(boolean isClick,String text){
		return create(isClick,text,false);
		
	}
	
	public static Element create(boolean isClick,String text,boolean isCurrent){
		Element span = DocumentHelper.createElement("span");
		span.addAttribute("type","text");
		span.addText(text);
		String bold ="normal";
		if(isCurrent){
			bold="bolder;color:#0b4f7a";
			span.addAttribute("isCurrent", "true");
		}
		if(isClick){
			span.addAttribute("style","cursor:pointer;font-weight:"+bold+";");
			span.addAttribute("clickable", "true");
		}
		return span;		
	}
	
	
	/**
	 * @param isClick
	 * @param text
	 * @param isCurrent
	 * @param showTitle
	 * @return
	 */
	public static Element create(boolean isClick,String text,boolean isCurrent,boolean showTitle){
		Element span = create(isClick,text,isCurrent);
		if(showTitle){
			span.addAttribute("title",text);
		}
		return span;		
	}
	public static Element create(boolean isClick,String text,boolean isCurrent,String title){
		Element span = create(isClick,text,isCurrent);
		if(title != null && (!"".equals(title))){
			span.addAttribute("title",title);
		}
		return span;		
	}
	
}

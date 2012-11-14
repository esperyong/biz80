package com.mocha.component.tree.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;


/**
 * @author fangzhx
 *
 */
/**
 * @author fangzhx
 *
 */
/**
 * @author fangzhx
 *
 */
public class TreeNode {
	private static String COLLAPSABLE = "collapsable";
	private static String EXPANDABLE = "expandable";
	private static String LAST = "last";
	private static String LAST_COLLAPSABLE=LAST+"Collapsable";
	private static String LAST_EXPANDABLE=LAST+"Expandable";
	
	private static String EXPENDCLS ="display:block";  //该节点展开，子结点ul，显示样式
	private static String COLLAPCLS ="display:none";   //该节点折叠，子结点ul，显示样式
	
	private static String LAST_EXPEND_ROOT = COLLAPSABLE + " "+LAST_COLLAPSABLE;  //如果是最后一个，并且是展开的,不是叶子节点   collapsable lastCollapsable
	private static String LAST_COLLAPS_ROOT = EXPANDABLE + " "+LAST_EXPANDABLE;  //如果是最后一个，并且是关闭的,不是叶子节点 expandable lastExpandable
	
	private boolean isExpend = false;  //该节点子结点是否展开
	//private boolean isLast = false; //该节点是否为同级最后一个节点
	private Boolean isLeaf = null;  //该节点是否为叶节点，即没有子结点
	
	private Element node = null;
	private List<Element> component = new ArrayList<Element>();
	private List<TreeNode> childs = null;
	
	private String id = null;
	private Map<String, String> values = null;
	public TreeNode(String id){
		this(id,false);
	}
	
	/**
	 * 构造方法.
	 * @param id  节点id.
	 * @param isExpend  节点是否展开.
	 */
	public TreeNode(String id,boolean isExpend){
		this.id = id;
		this.isExpend = isExpend;
		this.node = DocumentHelper.createElement("li");
	} 
	
	/**
	 * 构造方法.
	 * @param id 节点id.
	 * @param isExpend 节点是否展开.
	 * @param values 节点内含值.
	 */
	public TreeNode(String id,boolean isExpend,Map<String, String> values){
		this(id,isExpend);
		this.values = values;
	} 
	
	/**
	 * 构造方法.
	 * @param id 节点id.
	 * @param isExpend 节点是否展开.
	 * @param values 节点内含值.
	 * @param isLeaf  节点是否为隐藏节点
	 */
	public TreeNode(String id,boolean isExpend,Map<String, String> values,boolean isLeaf){
		this(id,isExpend,values);
		this.isLeaf = new Boolean(isLeaf);
	} 	
	
	

	/**
	 * 创建节点Element对象
	 * @param hasExpend  是否具有折叠功能
	 * @param isLast
	 * @return
	 */
	public Element create(boolean hasExpend,boolean isLast){
		boolean isLeaf = false;
		
		
		if(this.isLeaf!=null){  //手动设置是否为叶子节点
			isLeaf = this.isLeaf.booleanValue();
		}else { //没有手动设置，自动判断
			if(this.childs == null || this.childs.size()==0){  //如果没有子结点
				isLeaf = true;
			}else{
				isLeaf = false;
			}
		}
		String cls = null; 
		
		if(isLast && this.isExpend && !isLeaf){ 
			cls = LAST_EXPEND_ROOT;
		}else if(isLast && !this.isExpend && !isLeaf){ 
			cls = LAST_COLLAPS_ROOT;  
		}else if(!isLast && !this.isExpend && !isLeaf){  //如果不是最后一个，并且是关闭的，不是叶子节点expandable
			cls = EXPANDABLE;
		}else if(!isLast && this.isExpend && !isLeaf){ //如果不是最后一个，并且是展开的，不是叶子节点collapsable
			cls = COLLAPSABLE;
		}else if(isLast && isLeaf){  //如果是最后一个，并且是叶子节点
			cls = LAST;
		}else{
			cls = "";
		}
		
		this.node.addAttribute("nodeid", this.id);

		if(this.values != null){
			Set<String> valuekeys = this.values.keySet();
			for (Iterator<String> iterator = valuekeys.iterator(); iterator.hasNext();) {
				String key =  iterator.next();
				this.node.addAttribute(key, this.values.get(key));
			}
		}
		
		
		if(hasExpend){ //如果具有折叠功能
			this.node.addAttribute("class", cls);
			this.node.add(Btn.create(isLast,this.isExpend,isLeaf));
		}
		
		
		//添加节点功能配置，如单选，复选框，文本，按钮等。
		for(int i = 0,len = this.component.size();i<len;i++){
			this.node.add(component.get(i));
		}
		
		//添加子节点 如果是根节点，有子结点
		if(!isLeaf){  
			if(childs!=null){
				Element ul = DocumentHelper.createElement("ul");
				String display = COLLAPCLS;
				if(this.isExpend){  //如果默认展开
					display = EXPENDCLS;
				}
				this.addStyle(ul, display);
				boolean isLastc = false;
				
				for(int i=0,len=childs.size();i<len;){
					TreeNode treeNode = childs.get(i);
					if(++i==len){  //判断是子结点集合中最后一个
						isLastc = true;
					}
					ul.add(treeNode.create(hasExpend,isLastc));
				}
				this.node.add(ul);
			}
		}
		return this.node;
	}
	
	/**
	 * 异步获得该节点下的子结点.
	 * @return
	 */
	public String createAsynTreeNode(boolean hasExpend){
		Element treeUL = DocumentHelper.createElement("ul");
		boolean isLastc = false;
		for(int i=0,len=childs.size();i<len;){
			TreeNode treeNode = childs.get(i);
			if(++i==len){  //判断是子结点集合中最后一个
				isLastc = true;
			}
			treeUL.add(treeNode.create(hasExpend,isLastc));
		}
		Document childs = DocumentHelper.createDocument();
		childs.add(treeUL);
		return childs.asXML();
	}
	
	/**
	 * 是否为叶子节点.
	 * @return
	 */
	public boolean isLeaf(){
		return this.isLeaf;
	}
	
	/**
	 * 节点是否可以展开.
	 * @return
	 */
	public boolean isExpend(){
		return this.isExpend;
	}
	
	
	private Element addStyle(Element el,String styleValue){
		String styleVal = el.attributeValue("style");
		
		if(styleVal==null){
			styleVal = styleValue;
			el.addAttribute("style", styleVal);
		}else{
			styleVal = styleVal +";"+styleValue;
			el.attributeValue("style", styleVal);
		}
		return el;
	}
	
	/**
	 * 添加树节点组成
	 * @param comp dom节点
	 * @return
	 */
	public TreeNode addCompent(Element comp){
		this.component.add(comp);
		return this;
	}
	public TreeNode addChild(TreeNode node){
		if(this.childs == null){
			this.childs = new ArrayList<TreeNode>();
		}
		this.childs.add(node);
		return this;
	}
	
	public TreeNode setChilds(List<TreeNode> list){
		if(list!=null && list.size()>0){
			for(int i=0,len = list.size();i<len;i++){
				this.addChild(list.get(i));
			}
		}
		return this;
	}
	
	public TreeNode setExpend(boolean expend){
		this.isExpend = expend;
		return this;
	}
	
}

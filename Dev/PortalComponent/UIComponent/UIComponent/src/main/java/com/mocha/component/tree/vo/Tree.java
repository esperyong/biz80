package com.mocha.component.tree.vo;

import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class Tree {
	private List<TreeNode> childs = new ArrayList<TreeNode>();
	
	private String id="";
	
	
	public Tree(String id) {
		this.id = id;
	}
	public Tree(String id,List<TreeNode> childs){
		this.childs = childs;
		this.id = id;
	}
	
	public void addChild(TreeNode treeNode){
		this.childs.add(treeNode);
	}
	
	/**
	 * 创建树HTML
	 * @param isExpend  
	 * @return
	 */
	public String createTree(boolean hasExpend){
		
		Element treeUL = DocumentHelper.createElement("ul");
		treeUL.addAttribute("id", this.id);
		
		Element rootLI = DocumentHelper.createElement("li");
		rootLI.addAttribute("nodeid", "root");
		int childsize = this.childs.size();
		if(childsize>0){
			Element ul = DocumentHelper.createElement("ul");
			if(hasExpend){
				ul.addAttribute("class","treeview");
			}else{
				ul.addAttribute("class","nolinetreeview");
				
			}
			boolean isLast = false; 
			for(int i=0;i<childsize;){
				TreeNode treeNode = this.childs.get(i);
				if(++i==childsize){
					isLast = true;
				}else{
					isLast = false;
				}
				ul.add(treeNode.create(hasExpend,isLast));
			}
			rootLI.add(ul);
		}
		treeUL.add(rootLI);
		
		Document tree = DocumentHelper.createDocument();
		tree.add(treeUL);
		
		return tree.asXML();
	}
	
}

package com.mocha.component.tree.vo;

import java.util.ArrayList;
import java.util.List;

public class TestTree {

	public static void main(String[] args) {
		List<TreeNode> list = new ArrayList<TreeNode>();
		for(int i=0;i<10;i++){
			TreeNode firstNode = new TreeNode("first"+i,true); 
			firstNode.addCompent(Input.create("checkbox",null)).addCompent(Text.create(false,"first"+i)); 
			for(int j=0;j<3;j++){  
				TreeNode seNode = new TreeNode("se"+j+i,false); 
				seNode.addCompent(Input.create("checkbox",null)).addCompent(Text.create(false,"se"+j+i)); 	
				firstNode.addChild(seNode);
			}
			list.add(firstNode); 
		}
		
		Tree tree = new Tree("treeId",list);
		System.out.println(tree.createTree(true));
	}
}

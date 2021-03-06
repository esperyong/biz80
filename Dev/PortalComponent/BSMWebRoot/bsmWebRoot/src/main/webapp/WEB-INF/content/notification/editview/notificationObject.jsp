<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%--
	告警对象类型页面.
	weiyi.
 --%>
 <style>
 .treeview{	overflow:hidden; }
 </style>
<div class="monitor" id="contentDIV1" >
	<div class="panel-gray  table-noborder">
	<div class="panel-gray-top toplinegray">
		<span class=panel-gray-title>告警对象类型</span> 
	</div>
	</div>
	<div class="select-lr">
    	<div class="left">
        	<div class="h2 vertical-middle">待选告警对象类型：
	          <%--<span class="vertical-middle"><input name="textarea" type="text" value="请输入资源名称或IP地址" /></span>
	          <span class="ico ico-select"></span>--%>
        	</div>
        	<div class="time clear" id="unselect_res" style="overflow-y: auto;overflow-x: hidden;height:200px;"><s:property value="leftObjectTypeTree" escape="false" /></div>
		</div>
	    <div class="middle" style="margin:0px 8px">
	    	<span class="turn-right" id="objType-turn-right"></span> 
	    	<span class="turn-left" id="objType-turn-left"></span>
	    </div>
	    <div class="right" style="overflow:hidden;">
	    	<div class="h2 vertical-middle">已选告警对象类型：
	           <%--<span class="vertical-middle"><input name="textarea" type="text" value="请输入资源名称或IP地址" /></span>
	           <span class="ico ico-select"></span>--%>
	           </div>
	        <div class="time clear" id="selected_res" style="overflow-y: auto;overflow-x:hidden;height:200px;"><s:property value="rightObjectTypeTree" escape="false" /></div>
		</div>
	</div>
</div>
<script type="text/javascript">
var leftInstanceTree,
	rightInstanceTree;
$(function(){
	leftInstanceTree = new Tree({id : "leftObjectTypeTree"});
	rightInstanceTree = new Tree({id : "rightObjectTypeTree"});
	
	$('#objType-turn-right').click(function(){
		moveNodes(leftInstanceTree,rightInstanceTree);
		rightInstanceTree = new Tree({id : "rightObjectTypeTree"});
	});
	$('#objType-turn-left').click(function(){
		moveNodes(rightInstanceTree,leftInstanceTree);
		leftInstanceTree = new Tree({id : "leftObjectTypeTree"});
	});
	
});

function moveNodes(fromTree,toTree){
	var rootNode = fromTree.getNodeById('selectAll');
	var nodes = rootNode.getCheckedNodes(false);
	var toTreeHead = toTree.getNodeById('selectAll');
	var node_length = nodes.length;
	while(node_length > 0){
		$.each(nodes,function(i,e){
				var toNode = toTree.getNodeById(e.getId());	
				if(toNode.getId()){
					node_length --;
					return;
				}else{
					var toParentNode = toTree.getNodeById(e.parent().getId());
					if(toParentNode.getId()){
						toParentNode.appendChild({
							nodeId:e.getId(),
							text:e.getText(),
							isCheckBox:true,
							isClick:false,
							isLeaf:e.isLeaf()
						});
					}
				
				}
		});
	}
	nodes = rootNode.getCheckedNodes(true);
	$.each(nodes,function(i,e){
		delNode(fromTree,e);
	})


	rootNode.clearChecked();
};

function delNode(tree,node){
	var $node = tree.getNodeById(node.getId());
	if($node.isLeaf()){
		var parent = $node.parent();
		if(parent){
			if($node.getId() != 'selectAll'){
				$node.delNode();
				delNode(tree,parent);
			}
		}
	}
}
var pageObj = document.getElementById("contentDIV1");
var pHeight = pageObj.offsetHeight;
parent.setBodyHeight(pHeight);
</script>
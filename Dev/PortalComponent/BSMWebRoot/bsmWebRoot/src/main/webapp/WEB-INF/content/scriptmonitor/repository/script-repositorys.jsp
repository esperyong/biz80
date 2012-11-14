<!-- WEB-INF\content\scriptmonitor\repository\scriptRepositorys.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<div style="height:360px;overflow:auto">
<s:set name="treeName" value="'respositoryTree'" /> 
<s:if test="!scriptRepositorys.isEmpty()">
	<s:bean var="treeHelper"
		name="com.mocha.bsm.script.monitor.action.ScriptRepositoryTreeHelper">
		<s:property
			value="getRepositoryTreeHtml(#treeName,scriptRepositorys,scriptGroups)"
			escape="false" />
	</s:bean>
</s:if>
<s:else>
	<div class="add-button2"><span>请点击 <img
		src="${ctx}/images/add-button1.gif"> 按钮新建脚本库</span></div>
</s:else>
<div class="clear"></div>
</div>
<script type="text/javascript">
var respositoryTree;
var respositoryTreeMc;
$(document).ready(function () {
	respositoryTreeMc = new MenuContext({x:20,y:100,width:100,
			listeners:{click:function(id){alert(id)}}},
			{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});
	// 创建树
	respositoryTree = new Tree({id:"${treeName}",listeners:{
	  nodeClick:function(node){
		  loadContent(node.getId());
	  },
	  toolClick:function(node){
		  	mc.position(event.x,event.y)
		   //库节点
			if(node.getPathId().length == 1) {
				<s:if test="edit">
				 mc.addMenuItems([[{ico:"delete",text:"删除",id:"del",listeners:{
					click:function(){
						delScriptRepostiory(node.getId());
					  }
					}},{ico:"edit",text:"编辑",id:"edit",listeners:{
						click:function(){
							editScriptRepostiory(node.getId())
						  }
					}},{ico:"add",text:"添加分类",id:"edit",listeners:{
						click:function(){
							addScriptGroup(node.getId())
							 }
					}}]]);
				</s:if>
			}
			//分类节点
			if(node.getPathId().length == 2){
				 //节点id格式"库id-分类组id"
				  var groupId = node.getId().split("-")[1];
				 <s:if test="edit">
				 mc.addMenuItems([[{ico:"delete",text:"删除",id:"del",listeners:{
					click:function(){
						delScriptGroup(node.getId(),groupId);
					  }
					}},{ico:"edit",text:"编辑",id:"edit",listeners:{
						click:function(){
							editScriptGroup(node.getId(),groupId);
						  }
					}}]]);
				 </s:if>
			}
	  }
	  }});
	
	var selectNodeId ="${param.nodeId}";
	if(selectNodeId == ""){
		//第一个树结点id
		selectNodeId = getFirstId("${treeName}");
	}
	if(selectNodeId){
		setCurrentNode(selectNodeId);
		loadContent(selectNodeId);
	}else{
		clearContent();
	}
	
	$.unblockUI();
});

// 设置树的默认选中节点
function setCurrentNode(nodeId){
	respositoryTree.getNodeById(nodeId).setCurrentNode();
}
</script>
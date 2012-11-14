<!-- WEB-INF\content\scriptmonitor\repository\scriptRepositorys.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>

<s:set name="treeName" value="'modelExtendTree'" /> 
<s:set name="nodeStyles" value="#{'device':'tree-panel-ico tree-panel-ico-device',
	'networkdevice':'tree-panel-ico tree-panel-ico-network',
	'host':'tree-panel-ico tree-panel-ico-host',
	'storage':'tree-panel-ico tree-panel-ico-storage', 
	'other':'ico ico-policy-child',
	
	'application':'tree-panel-ico tree-panel-ico-app',
	'Database':'tree-panel-ico tree-panel-ico-storage',
	'DirectoryServer':'ico ico-policy-child',
	'J2EEAppServer':'tree-panel-ico tree-panel-ico-j2ee',
	'LotusDomino':'tree-panel-ico tree-panel-ico-lotus',
	'mailserver':'tree-panel-ico tree-panel-ico-mailserver',
	'Middleware':'ico ico-policy-child',
	'WebServer':'tree-panel-ico tree-panel-ico-webserver',
	'StandardGroup':'tree-panel-ico tree-panel-ico-standardapp',
	'HAGroup':'tree-panel-ico tree-panel-ico-ha',
	'Avaya':'ico ico-policy-child',
	'General':'ico ico-policy-child',
	'PingGroup':'ico ico-policy-child'}" /> 
<s:bean var="treeHelper"
	name="com.mocha.bsm.script.monitor.action.ScriptRepositoryTreeHelper">
	<div style="heigth:480px;overflow:auto">
	<s:property
		value="getExtensionTreeHtml(#treeName,resourceCategorys,#nodeStyles)"
		escape="false" />
	</div>
</s:bean>
<div class="clear"></div>

<script type="text/javascript">


$(document).ready(function () {
	var self = this;
	// 创建树
	this.tree = new Tree({id:"${treeName}",listeners:{
	  nodeClick:function(node){
		  loadModels(node.getId());
	  }}});
	
	var selectNodeId;
	if(selectNodeId){
		setCurrentNode(selectNodeId);
		loadModels(selectNodeId);
	}else{
		//alert(self.tree.getRoot().getFirstChild());
		selectNodeId = self.tree.getRoot().getFirstChild().getId();
		setCurrentNode(selectNodeId);
		loadModels(selectNodeId);
	}
	function loadModels(nodeId){
		$.blockUI({message:$('#loading')});
		try{
			$.loadPage($content,
					"${ctx}/scriptmonitor/repository/modelExtend!showModelsByType.action?resourceCategoryId="+nodeId,
					null,
					"",
					null
					);
		}catch(e){
		}
		$.unblockUI();
	}
	// 设置树的默认选中节点
	function setCurrentNode(nodeId){
		self.tree.getNodeById(nodeId).setCurrentNode();
	}
	$.unblockUI();
});

</script>
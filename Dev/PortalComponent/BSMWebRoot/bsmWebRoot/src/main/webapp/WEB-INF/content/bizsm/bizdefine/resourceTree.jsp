<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务展示tree view.
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefine-resourcetreeview
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务Tree View</title>
<link rel="stylesheet" href="${ctx}/css/jquery-ui/jquery.ui.treeview.css" />

<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script src="${ctx}/js/component/treeView/j-dynamic-treeview-1.1.js" type="text/javascript"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	
	//$.isReady = false;
	var treeview = new JDynamicTreeview({id:"resourceTree", animated:300, collapsed:true, unique: false});

	$.get('${ctx}/bsmresource/.xml',{},function(data){
		
		/*
		var data = '<BizService>';

		data += '<childBizServices>';
		data += '<BizService><name>业务服务2</name><refGraphId>1</refGraphId></BizService>';
		data += '</childBizServices>';

		data += '<monitableResources>';
		data += '<MonitableResource><resourceName>sub resource 1</resourceName><resourceInstanceId>123</resourceInstanceId></MonitableResource>';
		data += '<MonitableResource><resourceName>sub resource 2</resourceName><resourceInstanceId>234</resourceInstanceId></MonitableResource>';
		data += '<MonitableResource><resourceName>sub resource 3</resourceName><resourceInstanceId>345</resourceInstanceId></MonitableResource>';
		data += '</monitableResources>';

		data += '<bizUsers>';
		data += '<BizUser><name>北京电视台</name><id>1</id></BizUser>';
		data += '<BizUser><name>中央电视台</name><id>2</id></BizUser>';
		data += '<BizUser><name>河北电视台</name><id>3</id></BizUser>';
		data += '</bizUsers>';

		data += '</BizService>';
		*/

		var $BSMResourceNode = $(data).find('MonitableResource');
		$BSMResourceNode.each(function(cnt){
			var $thisNode = $(this);
			var nodeMap = {};

			var imgPath = $thisNode.find('>imgPath').text();

			var resNodeID = $thisNode.find('>resourceInstanceId').text();
			var resourceType = $thisNode.find('>resourceType').text();
			if(resourceType != "UNKNOWN"){
				imgPath = "${ctx}/images/tree-img/leaf.gif";
			}else{
				imgPath = "${ctx}/images/tree-img/no_leaf.jpg";
			}

			nodeMap["label"] = $thisNode.find('>resourceName').text();
			nodeMap["nodeID"] = resNodeID;
			nodeMap["parentNodeID"] = $thisNode.find('>parentID').text();
			nodeMap["imgPath"] = imgPath;
			nodeMap["isDataNode"] = $thisNode.find('>leaf').text();
			if(nodeMap["isDataNode"] == "true"){
				treeview.addTreeNode(nodeMap, true, {uri:"/bsmresource/"+resNodeID},function(dataMap){
					//call flash
					parent.choose("resource", dataMap["uri"]);
				});
			}else{
				treeview.addTreeNode(nodeMap, false, null, null);
			}
		});

		treeview.loadSubCount();
	
		if(parent.currentServiceRunState == "true"){
			treeview.setAllNodesDisabled(true);
		}

		treeview.appendToContainer($('body'));

		//$.isReady = true;
	});

});

</script>
</head>
<body>
</body>
</html>

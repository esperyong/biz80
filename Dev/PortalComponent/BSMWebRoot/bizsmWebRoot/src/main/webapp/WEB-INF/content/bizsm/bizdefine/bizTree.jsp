<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务展示tree view.
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefine-biztreeview
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<%
	String contentURI = request.getParameter("uri");
%>
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
	$.get('${ctx}<%=contentURI%>',{},function(data){
		
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

		var treeview = new JDynamicTreeview({id:"bizServiceTree", lineStyle:"treeview-black", animated:300, labelOverWidth:"130px", collapsed:true, unique: false});

		treeview.addTreeNode({nodeID:"rootLevelTop-1", label:"业务服务", parentNodeID:"", isDataNode:false}, false, null, null);
		treeview.addTreeNode({nodeID:"rootLevelTop-2", label:"资源" ,parentNodeID:"", isDataNode:false}, false, null, null);
		treeview.addTreeNode({nodeID:"rootLevelTop-3", label:"业务单位" ,parentNodeID:"", isDataNode:false}, false, null, null);

		var $subBizNodes = $(data).find('BizService:first>childBizServices>BizService');//.not('[reference]');;

		$subBizNodes.each(function(i){
			var $thisBiz = $(this);
			
			var runStateStr = $thisBiz.find('>monitered').text();//"false";

			var nodeMap = {};
			nodeMap["label"] = $thisBiz.find('>name').text();
			nodeMap["nodeID"] = $thisBiz.find('>bizId').text();
			nodeMap["parentNodeID"] = "rootLevelTop-1";
			nodeMap["isDataNode"] = true;
			
			treeview.addTreeNode(nodeMap, false, {runState:runStateStr}, null);
			/* 
			remove
			treeview.addTreeNode(nodeMap, true, {runState:runStateStr}, function(dataMap){
				//设置当前业务服务运行状态
				top.leftFrame.serviceRunStateGlobal = treeview.getUserData(dataMap["nodeID"], "runState");
				//parent.chooseTopo("biztopo/.xml?bizServiceId="+dataMap["nodeID"]);
				top.rightFrame.f_bizServiceDefine("bizdefine", dataMap["nodeID"]);
			});
			*/

			/*
			treeview.nodeClick(nodeMap["id"], function(currentNodeMap){
				parent.chooseTopo("biztopo/.xml?bizServiceId="+nodeMap["id"]);
			});
			*/
			
		});
		
		var $resourceNodes = $(data).find('BizService:first>monitableResources>MonitableResource');
		$resourceNodes.each(function(i){
			var $thisRes = $(this);

			var nodeMap = {};
			nodeMap["label"] = $thisRes.find('>resourceName').text();
			nodeMap["nodeID"] = $thisRes.find('>resourceInstanceId').text();
			nodeMap["parentNodeID"] = "rootLevelTop-2";
			nodeMap["isDataNode"] = false;

			treeview.addTreeNode(nodeMap, false, null, null);

		});
		//var $bizUsers = $($(data).find('BizService').get(0)).find('>bizUsers>BizUser');
		//var $bizUsers = $(data).find('>BizService>bizUsers>BizUser');
		var $bizUsers = $(data).find('BizService:first>bizUsers>BizUser');
		$bizUsers.each(function(i){
			var $thisBizUser = $(this);
			
			var nodeMap = {};
			nodeMap["label"] = $thisBizUser.find('>name').text();
			nodeMap["nodeID"] = $thisBizUser.find('>id').text();
			nodeMap["parentNodeID"] = "rootLevelTop-3";
			nodeMap["isDataNode"] = false;

			treeview.addTreeNode(nodeMap, false, null, null);

		});
		/**/
		
		treeview.appendToContainer($('body'));

	});

});

</script>
</head>
<body>
</body>
</html>

<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务管理导航
	uri:{domainContextPath}/bizsm/bizservice/ui/bizmanagement-navigate
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务管理导航</title>

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />

<style type="text/css" media="screen"> 
	html,body{height:100%;}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/toolBar/j-dynamic-vertical-toolbar.js"></script>

<script language="javascript">
	var vToolbar = new JDynamicVerticalToolbar({id: "jVerticalToolbar-1", height: "100%"});
	
	$(function() {

		var rightFrameObj = parent.document.all.rightFrame;

		vToolbar.addItem({itemID: "item1", title: "业务服务管理", className: "service-tool-ico-navi"}, {test:"aaa"}, function(dataMap){
			//$('#rightRoot').load("${ctx}/bizsm/bizservice/ui/bizmanagement-show");
			
			rightFrameObj.src = "${ctx}/bizsm/bizservice/ui/bizservice-manage";
			//alert(dataMap["test"]);
		});
		vToolbar.addItem({itemID: "item2", title: "业务服务监控", className: "service-tool-ico-jk"}, {test:"bbb"}, function(dataMap){
			rightFrameObj.src = "${ctx}/bizsm/bizservice/ui/bizservice-monitor?from=bizsm";
			//alert(dataMap["test"]);
		});
		vToolbar.addItem({itemID: "item3", title: "业务服务影响", className: "service-tool-ico-yx"}, null, function(dataMap){
			//alert(dataMap.title);
			rightFrameObj.src = "${ctx}/bizsm/bizservice/ui/bizservice-affect";
		
		});
		vToolbar.addItem({itemID: "item4", title: "业务服务分析", className: "service-tool-ico-fx"}, null, function(dataMap){
			//alert(dataMap.title);
			rightFrameObj.src = "${ctx}/bizsm/bizservice/ui/bizservice-analysis";
		});
		vToolbar.addItem({itemID: "item5", title: "业务服务一览", className: "service-tool-ico-yl"}, null, function(dataMap){
			rightFrameObj.src = "${ctx}/bizsm/bizservice/ui/bizservice-overview";
			//alert(dataMap.title);
		});
		
		//$('div[id="toolbarRoot"]').empty();
		vToolbar.appendToContainer($('body>div[id="toolbarRoot"]'));

		window.setTimeout(function(){vToolbar.pressItem("item1");}, 1000);

		//vToolbar.pressItem("item1");
		//alert($('body>div[id="toolbarRoot"]').height());
	});
</script>
</head>
<body>
<div id="toolbarRoot" style="min-height:100%;height:100%;"></div>
</body>
</html>
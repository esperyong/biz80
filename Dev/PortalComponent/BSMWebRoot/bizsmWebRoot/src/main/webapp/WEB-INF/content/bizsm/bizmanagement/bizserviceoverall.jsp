<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:单个业务服务总揽
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-overall

 -->

 <%
	String moduleName = request.getParameter("moduleName");
 %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务总揽</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	html,body{height:100%;width:100%}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>


<script language="javascript">

	var realWidth = 0, realHeight = 0;

	$(function() {

		realWidth = document.body.clientWidth;
		realHeight = document.body.clientHeight;

		//load flash.
		f_loadCurrFlash("biztopo/.xml?bizServiceId="+parent.currentServiceID_global);
	});
	function f_changeBizTop(serviceId){
		//call flash (切换当前业务服务topo)
		chooseTopo("biztopo/.xml?bizServiceId="+serviceId);
	}
	function f_loadCurrFlash(uri){
		var swfVersionStr = "10.0.0";
		var xiSwfUrlStr = "playerProductInstall.swf";
		var flashvars = {};
		//flashvars["uri"] = "./testAssets/FullData.xml";
		flashvars["state"] = "<%=moduleName%>";
		flashvars["webRootPath"] = "${ctx}/";
		flashvars["uri"] = encodeURIComponent(uri);

		var params = {};
		params.quality = "high";
		params.bgcolor = "#ffffff";
		params.allowscriptaccess = "always";
		params.wmode = 'transparent';
		params.allowfullscreen = "true";
		params.enablejs= "true";

		var attributes = {};
		attributes.id = "BizListView";
		attributes.name = "BizListView";
		attributes.align = "left";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/BizListView.swf", "flashContent",
			"97%", realHeight,
			swfVersionStr, xiSwfUrlStr,
			flashvars, params, attributes);
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");


		initFlashContentObj("BizListView");
	}
</script>
</head>
<body style="margin:0;">
	<div id="flashContent" style="position:absolute;top:0px;left:0px;width:97%"></div>
</body>
</html>
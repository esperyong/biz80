<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务一览
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-monitor
 -->
 <%@ page import="com.mocha.bsm.bizsm.web.util.SpringBeanUtil"%> 
<%@ page import="com.mocha.bsm.bizsm.adapter.bsmres.IBSMClientAdapter"%> 

<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	IBSMClientAdapter clientAdapter = (IBSMClientAdapter)SpringBeanUtil.getSpringBean(request.getSession().getServletContext(),"bizsm.bsmclientadapter");
    String domainPageName = clientAdapter.getDomainPageName();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务管理展示</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
<style type="text/css"> 
	html,body{height:100%;width:100%}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>


<script language="javascript">

	var domainPageName_JS = "<%=domainPageName%>";

	var realWidth = 0, realHeight = 0;
	$(function(){

		/*
		$(window).resize(function(event){
			event.preventDefault();
			event.stopPropagation();
			
			return false;
		});
		*/

		realWidth = document.body.clientWidth;
		realHeight = document.body.clientHeight;

		$('#flashContent').css("width", realWidth);
		//$('#flashContent').css("height", realHeight);

		init();
	});

	function init(){
		var swfVersionStr = "10.0.0";            
		var xiSwfUrlStr = "playerProductInstall.swf";
		var flashvars = {};
		//flashvars["uri"] = "./testAssets/FullData.xml";
		flashvars["webRootPath"] = "${ctx}/";

		var params = {};
		params.quality = "high";
		params.bgcolor = "#ffffff";
		params.allowscriptaccess = "always";
		params.wmode = 'transparent';
		params.allowfullscreen = "true";
		params.enablejs= "true"; 

		var attributes = {};
		attributes.id = "Biz3dCurve";
		attributes.name = "Biz3dCurve";
		attributes.align = "left";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/Biz3dCurve.swf", "flashContent", 
			realWidth-32, "100%", 
			swfVersionStr, xiSwfUrlStr, 
			flashvars, params, attributes);			
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");
		

		initFlashContentObj("Biz3dCurve");
	}
	
	function f_forwardToBizServiceDeep(serviceId){
		window.location.href = "${ctx}/bizsm/bizservice/ui/bizservice-deep?serviceId="+serviceId;
	}

	function f_getDomainPageName(){
		return domainPageName_JS;
	}

</script>
</head>
<body style="text-align:left;margin:0;">        
<div id="flashContent" style="position:absolute;top:0px;left:0px;"></div>	  	
</body>
</html>
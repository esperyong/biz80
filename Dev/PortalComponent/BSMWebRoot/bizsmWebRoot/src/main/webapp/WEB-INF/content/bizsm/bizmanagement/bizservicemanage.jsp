<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务管理
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-manage
	test
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>业务服务管理</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen"> 
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:center; 
		   background-color: #ffffff; }   
	object:focus { outline:none; }
	#flashContent { display:none; }
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>


<script language="javascript">
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
		$('#flashContent').css("height", realHeight);

		f_loadCurrFlash();
	});
	
	/**
	* 业务服务管理幕墙跳转
	* param String moduleID(monitor,affect,analysis,overview)
	*
	*/
	function f_forwardToModule(moduleID){
		var toolbarObj = parent.document.all.leftFrame.contentWindow.vToolbar;

		var srcID = moduleID;
		if(srcID == "monitor"){
			//window.location.href = "${ctx}/bizsm/bizservice/ui/bizservice-monitor";
			toolbarObj.pressItem("item2");
		}else if(srcID == "affect"){
			//window.location.href = "${ctx}/bizsm/bizservice/ui/bizservice-affect";
			toolbarObj.pressItem("item3");
		}else if(srcID == "analysis"){
			//window.location.href = "${ctx}/bizsm/bizservice/ui/bizservice-analysis";
			toolbarObj.pressItem("item4");
		}else if(srcID == "overview"){
			//window.location.href = "${ctx}/bizsm/bizservice/ui/bizservice-overview";
			toolbarObj.pressItem("item5");
		}
	}

	function f_loadCurrFlash(chartURI, chartTitle){
		var swfVersionStr = "10.0.0";            
		var xiSwfUrlStr = "playerProductInstall.swf";
		var flashvars = {};
		//flashvars["uri"] = "./testAssets/FullData.xml";
		flashvars["flashPath"] = "${ctx}/flash/bizsm/";

		var params = {};
		params.quality = "high";
		params.bgcolor = "#ffffff";
		params.allowscriptaccess = "always";
		params.wmode = 'transparent';
		params.allowfullscreen = "true";
		params.enablejs= "true";

		var attributes = {};
		attributes.id = "BizNavigator";
		attributes.name = "BizNavigator";
		attributes.align = "middle";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/BizNavigator.swf", "flashContent", 
			realWidth, realHeight, 
			swfVersionStr, xiSwfUrlStr, 
			flashvars, params, attributes);			
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");


		initFlashContentObj("BizNavigator");
	}
	

</script>
</head>
<body style="overflow:hidden">        
	<div id="flashContent" style="position:absolute;top:0px;left:0px;"></div>
</body>
</html>
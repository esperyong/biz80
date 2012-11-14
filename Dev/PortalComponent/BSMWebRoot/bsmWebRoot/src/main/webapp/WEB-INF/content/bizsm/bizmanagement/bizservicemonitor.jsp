<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务监控
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-monitor
	test
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务管理展示</title>

<style type="text/css" media="screen"> 
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:center; 
		   background-color: #ffffff; }   
	object:focus { outline:none; }
	#flashContent { display:none; }
</style>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>


<script language="javascript">
	
	var swfVersionStr = "10.0.0";            
	var xiSwfUrlStr = "playerProductInstall.swf";
	var flashvars = {};
	//flashvars["uri"] = "./testAssets/FullData.xml";
	flashvars["webRootPath"] = "${ctx}/";

	var params = {};
	params.quality = "high";
	params.bgcolor = "#ffffff";
	params.allowscriptaccess = "sameDomain";
	params.allowfullscreen = "true";
	var attributes = {};
	attributes.id = "BizMonitor";
	attributes.name = "BizMonitor";
	attributes.align = "middle";
	swfobject.embedSWF(
		"${ctx}/flash/bizsm/BizMonitor.swf", "flashContent", 
		"100%", "100%", 
		swfVersionStr, xiSwfUrlStr, 
		flashvars, params, attributes);			
	swfobject.createCSS("#flashContent", "display:block;text-align:left;");
	
	
	function init(){
		initFlashContentObj("BizMonitor");
	}
	
	

</script>
</head>
<body onload="init()">        
<div id="flashContent">        	
</div>	  	
 </body>
</html>
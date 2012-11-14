<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:单个业务服务总揽
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-view
 -->

 <%
	String serviceId = request.getParameter("serviceId");
	String moduleName = "listView";// request.getParameter("moduleName");

	String fromStr = request.getParameter("from")==null?"":request.getParameter("from");

 %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务</title>


<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen">
	html, body	{ height:100%; }
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>


<script language="javascript">
	$(function() {
		//load flash.
		$('.pop-m').css('height', (document.body.offsetHeight-52)+"px");

		$('#closeIcon').bind("click", function(){
			window.close();
		});

		$.get('${ctx}/bizservice/<%=serviceId%>.xml',{},function(data){
  			var serviceName = $(data).find('BizService:first>name').text();
			if(serviceName == "" || serviceName == null){
				//alert("业务服务不存在或者被删除。");
				var _information  = new information();
				_information.setContentText("业务服务不存在或者被删除。");
				_information.show();
				$('#closeIcon').click();
			}else{
				var sourcename=document.getElementById("sourcename");
				if(sourcename){
					sourcename.innerText=serviceName;
				}
				f_loadCurrFlash("biztopo/.xml?bizServiceId=<%=serviceId%>");
			}
  		});
	});
	function f_changeBizTop(serviceId){
		//call flash (切换当前业务服务topo)
		chooseTopo("biztopo/.xml?bizServiceId=<%=serviceId%>");
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
		attributes.align = "middle";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/BizListView.swf", "flashContent",
			"100%", "100%",
			swfVersionStr, xiSwfUrlStr,
			flashvars, params, attributes);
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");


		initFlashContentObj("BizListView");
	}

	if(window.HP){
		 HP.addActivate(function(){
			alert("invoke addActivate");
		 });
		 HP.addSleep(function(){
			alert("invoke addSleep");
		 });
		 HP.addDestory(function(){
			alert("invoke addDestory");
		 });
	}

</script>
</head>
<body>
<%
if(fromStr.equals("home")){
%>
	<div id="flashContent" style="position:absolute;top:0px;left:0px;width:100%;"></div>
<%
}else{
%>
	<div class="pop">
		<div class="pop-top-l">
			<div class="pop-top-r">
				<div class="pop-top-m"><a id="closeIcon" class="win-ico win-close"></a><span class="pop-top-title" id="sourcename"></span></div>
			</div>
		</div>
		<div class="pop-m">
			<div class="pop-content" style="background:url(../images/all-bg.jpg) 0 0 fixed;font-size:12px;font-family:Arial, Helvetica,sans-serif;height:99.5%">
				<div id="flashContent" style="position:absolute;top:0px;left:0px;width:100%;"></div>
			</div>
		</div>

		<div class="pop-bottom-l">
			<div class="pop-bottom-r">
				<div class="pop-bottom-m"></div>
			</div>
		</div>
	</div>
<%
}
%>
</body>
</html>
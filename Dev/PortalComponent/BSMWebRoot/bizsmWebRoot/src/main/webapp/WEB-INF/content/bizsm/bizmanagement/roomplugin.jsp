<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:嵌入机房
	uri:{domainContextPath}bizsm/bizservice/ui/bizmanagement-roomplugin
 -->

<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String serviceId = request.getParameter("serviceId");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>机房</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	html,body{height:100%;width:100%}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script language="javascript">
	$(function() {
		$('#info').hide();

		var srcURI = "/pureportal/roomDefine/BizsmAction.action";
		$('#pluginRoot').load(srcURI,{serviceId:"<%=serviceId%>"});

		window.setTimeout(function(){
			$.get('${ctx}/bizservice/'+'<%=serviceId%>'+'.xml',{},function(data){
				var $resource = $(data).find('BizService:first>monitableResources>MonitableResource');
				if($resource.size() == 0){
					 $('#info').show();
				}
			});
		}, 3000);
	});
</script>
</head>
<body style="overflow:hidden;text-align:left;margin:0;">
	<div id="pluginRoot" style="height:99%;width:95%"></div>

	<div class="pop" style="position:absolute;left:250px;top:200px;width:357px;" id="info">
		<div class="pop-top-l">
			<div class="pop-top-r">
				<div class="pop-top-m">
					<span class="pop-top-title">提示</span>
				</div>
			</div>
		</div>
		<div class="pop-m">
			<div class="pop-content">
				<div class="win-content" style="text-align:center; ">
					<span class="promp-win-ico promp-win-ico-alert"></span><span class="txt">没有资源！ </span>
				</div>
			</div>
		</div>
		<div class="pop-bottom-l">
			<div class="pop-bottom-r">
				<div class="pop-bottom-m"></div>
			</div>
		</div>
	</div>
</body>
</html>
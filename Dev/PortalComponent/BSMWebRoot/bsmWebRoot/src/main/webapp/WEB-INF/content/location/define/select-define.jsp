<!-- WEB-INF\content\location\define\select-define.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>Mocha BSM </title>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<style type="text/css">
ul {margin:0; padding:0}
</style>
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("#uploadtemplate").click(function(){
			var r_value = window.showModalDialog("${ctx}/location/relation/importDevices.action",null,"help=no;status=no;scroll=no;center=yes");
			location.reload();
		});
		$("#paintLocation").click(function(){
			location.href="${ctx}/location/define/location.action?location.locationId=main";
		});
	});
</script>
</head>

<body >
<page:applyDecorator name="headfoot">
 	<page:param name="body">
<!--透明层按钮 -->
<div class="alpha-button" style="background-image:url('${ctx }/images/alpha.png');">
    <a href="#"><img id="uploadtemplate" src="${ctx }/images/alpha-button1.gif" border="0"></a>
    <p class="alpha">    	<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;使用Excel导入设备，并按照内容创建区域下的子区域。</p>
    <p class="alpha">     	<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;创建区域成功，再左侧导航，进入区域及子区域进行图形化绘制状态定义操作。</p>
    <br />
    <a href="#"><img id="paintLocation" src="${ctx }/images/alpha-button2.gif" border="0"></a>
	<p class="alpha">		<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;创建区域及子区域。</p>
    <p class="alpha">		<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;设置区域或子区域的关联设备。</p>
    <p class="alpha">		<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;绘制图形化展示（用于物理位置一览）。</p>
    <p class="alpha">		<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;状态定义计算方式。</p>
    <p class="alpha">		<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;其它操作，如关联拓扑图等。</p>
</div>
	</page:param>
</page:applyDecorator>
</body>
</html>
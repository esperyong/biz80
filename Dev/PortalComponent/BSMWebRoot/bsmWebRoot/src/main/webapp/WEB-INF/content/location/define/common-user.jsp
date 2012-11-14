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
	
</script>
</head>

<body >
<page:applyDecorator name="headfoot">
 	<page:param name="body">
<!--透明层按钮 -->
<div class="alpha-button">
   
    <p class="alpha">    	<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;当前用户无权限使用物理位置定义功能，请知悉；若须访问可咨询管理员。</p>

</div>
	</page:param>
</page:applyDecorator>
</body>
</html>
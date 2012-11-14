<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<%@ include file="/WEB-INF/common/meta.jsp"%>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>无权限</title>
</head>
<body >
<page:applyDecorator name="headfoot">
 	<page:param name="body">
<!--透明层按钮 -->
<div style="position:relative;top:50%;left:35%;width:50%">
   <span style="color:#FFFFFF"><img src="${ctx }/images/ico/nodata-ico.png" align="absmiddle"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您没有权限定义机房</b></span>
</div>
	</page:param>
</page:applyDecorator>
</body>

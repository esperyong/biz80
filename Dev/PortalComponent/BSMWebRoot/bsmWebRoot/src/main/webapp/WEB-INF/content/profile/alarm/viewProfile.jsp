<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
	<form id="formname" name="formname">
	<input type="hidden" name="vp_id" value="${ruleId}" id="vp_id"/>
	<div style="color:black;">
	<span style="font-weight:bold; vertical-align:top;">使用此规则的策略：</span>
    <page:applyDecorator name="indexcirgrid">
       <page:param name="id">viewProfile_div</page:param>
       <page:param name="height">280px</page:param>
       <page:param name="linenum">10</page:param>
       <page:param name="tableCls">roundedform</page:param>
       <page:param name="gridhead">${titleList}</page:param>
       <page:param name="gridcontent">${dataList}</page:param>
     </page:applyDecorator>
	 </div>
	</form>
</body>
<script src="<%=request.getContextPath()%>/js/profile/alarm/viewProfile.js" type="text/javascript"></script>
</html>
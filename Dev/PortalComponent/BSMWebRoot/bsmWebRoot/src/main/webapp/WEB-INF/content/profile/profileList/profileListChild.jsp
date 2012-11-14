<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script>var pageCount = "${pageCount}";</script>
</head>
<body>
<input type="hidden" name="leftTreeNum" id="leftTreeNum" value="${leftTreeNum}"/>
<div style="color:black;" id="dataListDiv">
   <page:applyDecorator name="indexcirgrid">
      <page:param name="id">tableId</page:param>
      <page:param name="height">540px</page:param>
      <page:param name="lineHeight">27px</page:param>
      <page:param name="tableCls">roundedform</page:param>
      <page:param name="gridhead">${titleList}</page:param>
      <page:param name="gridcontent">${dataList}</page:param>
    </page:applyDecorator>
    <div id="page"></div>
</div>
</body>
</html>
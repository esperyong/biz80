<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script>
var pageCount = "${forPageVO.pageCount}";
</script>
</head>
<body>
<div style="color:black;" id="dataListDiv">
   <page:applyDecorator name="indexcirgrid">
      <page:param name="id">tableId</page:param>
      <page:param name="width">780px</page:param>
      <page:param name="height">450px</page:param>
      <page:param name="lineHeight">22px</page:param>
      <page:param name="tableCls">roundedform</page:param>
      <page:param name="gridhead">${forPageVO.titleList}</page:param>
      <page:param name="gridcontent">${forPageVO.dataList}</page:param>
    </page:applyDecorator>
    <div id="page"></div>
</div>
<script type="text/javascript" src="${ctx}/js/wireless/wirelessListChild.js"></script>
</body>
</html>
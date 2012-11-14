<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script>
var pageCount = ${pageCount};
var operateView = "${operateView}";
var path = "${ctx}";
</script>
</head>
<body>
	<div id="alarmRecord" style="color:black;">
    <page:applyDecorator name="indexcirgrid">
       <page:param name="id">tableId</page:param>
       <page:param name="lineHeight">27px</page:param>
       <page:param name="width">${pageWidth}px</page:param>
       <s:if test="pageHeight is null">
        <page:param name="height">545px</page:param>
       </s:if>
       <s:if test="pageHeight == ''">
        <page:param name="height">545px</page:param>
       </s:if>
       <s:else>
        <page:param name="height">${pageHeight}px</page:param>
       </s:else>
       
       <s:if test="operateView == 'view'">
       <page:param name="linenum">${totalRows}</page:param>
       </s:if>
       
       <page:param name="tableCls">roundedform</page:param>
       <page:param name="gridhead">${titleList}</page:param>
       <page:param name="gridcontent">${dataList}</page:param>
     </page:applyDecorator>
     <div id="page"></div>
	</div>
<script src="${ctx}/js/notification/notificationlist/notificationListChild.js"></script>
</body>
</html>
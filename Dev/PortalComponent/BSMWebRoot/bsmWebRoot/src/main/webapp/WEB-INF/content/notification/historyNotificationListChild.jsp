<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- historyNotificationListChild.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
<script>
	var pageCount = ${pageCount};
	var levelname = "${levelName}";
	var levelnames = levelname.split(";");
    var levelId = "${levelId}";
    var levelIds = levelId.split(";");
    var parentLocation = "${parentLocation}";
</script>
</head>
<body> 
<script type="text/javascript">
	var _height=${pageHeight};
</script>
<input type="hidden" name="orderBy" id="orderBy" value="${orderBy}"/>
<input type="hidden" name="orderType" id="orderType" value="${orderType}"/>
<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}"/>
<input type="hidden" name="pageSize" id="pageSize" value="${pageSize}"/>
<!-- input type="hidden" name="device" id="device" value="${device}"/> -->
<input type="hidden" name="notTime" id="notTime" value="${notTime}"/>
<s:hidden name="ok1" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_CONFIRM_UNATTENTION}"/>
<s:hidden name="ok2" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_CONFIRM_ATTENTION}"/>
<s:hidden name="active" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_ACTIVE_ATTENTION}"/>
<s:hidden name="unactive" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_ACTIVE_UNATTENTION}"/>

	<div style="color:black;">
    <page:applyDecorator name="indexcirgrid">
       <page:param name="id">tableId</page:param>
       <page:param name="width"></page:param>
       <page:param name="lineHeight">27px</page:param>
       <page:param name="linenum">${pageSize}</page:param>
       <s:if test="pageHeight is null">
       	<page:param name="height">545px</page:param>
       </s:if>
       <s:if test="pageHeight == ''">
       	<page:param name="height">545px</page:param>
       </s:if>
       <s:else>
        <page:param name="height">${pageHeight}px</page:param>
       </s:else>
       <page:param name="tableCls">roundedform</page:param>
       <page:param name="gridhead">${titleList}</page:param>
       <page:param name="gridcontent">${dataList}</page:param>
     </page:applyDecorator>
     <div id="page"></div>
	</div>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>    
<script src="${ctx}/js/notification/historynotificationlist/historyNotificationListChild.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
</body>
</html>
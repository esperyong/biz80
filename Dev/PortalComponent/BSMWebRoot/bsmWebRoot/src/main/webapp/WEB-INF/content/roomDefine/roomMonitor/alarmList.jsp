<!-- 机房-机房监控-告警管理alarmList.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>告警管理</title>
</head>

<form name="hisnftListForm" id="hisnftListForm" method="post">	
<div>
	<s:action name="historyNotificationlist"  namespace="/notification"  executeResult="true" ignoreContextParams="false" flush="false">
		<s:param name="notificationObjId"><s:property value='notificationObjId'/></s:param>
		<s:param name="device"><s:property value='device'/></s:param>
		<s:param name="nameorip"><s:property value='nameorip'/></s:param>
		<s:param name="nameoripvalue"><s:property value='nameoripvalue'/></s:param>
		<s:param name="radio"><s:property value='radio'/></s:param>
		<s:param name="sendTime"><s:property value='sendTime'/></s:param>
		<s:param name="notStartTime"><s:property value='notStartTime'/></s:param>
		<s:param name="notEndTime"><s:property value='notEndTime'/></s:param>
		<s:param name="notionState"><s:property value='confirm'/></s:param>
		<s:param name="searchDis">advancedSearchstr</s:param>
		<s:param name="pageHeight">550</s:param>
	</s:action>
</div>
</form>

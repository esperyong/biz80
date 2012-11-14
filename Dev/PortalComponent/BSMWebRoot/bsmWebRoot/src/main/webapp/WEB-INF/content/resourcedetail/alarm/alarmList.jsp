<!-- 详细信息页面-告警管理alarmList.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<head>
<title><s:text name="detail.alarm.wintitle" /></title>
</head>
<form name="hisnftListForm" id="hisnftListForm" method="post">
<div>
	<s:action name="historyNotificationlist"  namespace="/notification"  executeResult="true" ignoreContextParams="false" flush="false">
		<s:param name="device"><s:property value='device'/></s:param>
		<s:param name="notionState"><s:property value='notionState'/></s:param>
		<s:param name="radio"><s:property value='radio'/></s:param>
		<s:param name="sendTime"><s:property value='sendTime'/></s:param>
		<s:if test="notificationObjId1 != null">
			<s:param name="notificationObjId"><s:property value='notificationObjId1'/></s:param>
		</s:if>
		<s:param name="notStartTime"><s:property value='notStartTime'/></s:param>
		<s:param name="notEndTime"><s:property value='notEndTime'/></s:param>
		<s:param name="searchDis">advancedSearchstr</s:param>
		<s:param name="pageHeight">440</s:param>
		<s:param name="pageSize">20</s:param>
	</s:action>
</div>
</form>
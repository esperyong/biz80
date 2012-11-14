<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.bsm.commonrule.common.Constants"%>
<%@page import="com.mocha.bsm.commonrule.common.ModuleIdCollection"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<script>
		var path = "${ctx}";
		var panel = null;
		var win = null;
		var defaultRuleId="<%=Constants.DEFAULTRULEID%>";
		var moduleId = "<%=ModuleIdCollection.MODULEID_PROFILE%>";
	</script>
	<%@ include file="/WEB-INF/common/userinfo.jsp" %>
	<title>告警规则列表</title>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form name="alarmListForm" id="alarmListForm" method="post">
<input type="hidden" name="orderBy" value="${orderBy}" id="orderBy"/>
<input type="hidden" name="orderType" value="${orderType}" id="orderType"/>
<input type="hidden" name="currentPage" value="${currentPage}" id="currentPage"/>
<div class="main-right">
	<div class="h1">
		<span class="ico ico-help"></span><span>说明：用于设置告警方式、接收人、告警时间、告警升级等。可以在“监控策略>>选择告警规则”中使用。</span>
	</div>
	<div class="h1-1">
		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m" id="delete"><a>删除</a></span></span></span>
		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m" id="add"><a>新建</a></span></span></span>
		<span style="float:left;height:21px;line-height:21px;"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/>：</span> 
		<s:select id="domainId" name="domainId" list="doMainList" listKey="key" listValue="value" value="domainId" headerKey="" headerValue="全部" style="width:150px;"/>
		<span style="float:left;height:21px;line-height:21px;">通知方式：</span>
		<s:select id="sendType" name="sendType" list="sendTypeList" listKey="key" listValue="value" value="sendType" headerKey="" headerValue="全部"/>
	</div>
	<div id="child_cirgrid">
		<s:action name="alarmListChild"  namespace="/profile/alarm"  executeResult="true" ignoreContextParams="true" flush="false"> 
        </s:action> 
	</div>
</div>
</form>
<script src="${ctx}/js/profile/alarm/alarmList.js"></script>
<script src="${ctx}/js/profile/alarm/alarmListChild.js"></script>
</body>
</html>
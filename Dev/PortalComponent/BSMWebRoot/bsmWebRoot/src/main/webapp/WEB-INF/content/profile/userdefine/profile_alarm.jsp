<!-- content/profile/userdefine/profile_alarm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body>
<fieldset class="blue-border" style="width: 630px;"><legend>告警规则选择：</legend>
<div>
<div class="select-lr">
<div class="left-n" style="width: 260px; height: 300px;">
<div class="h1"><span class="r-ico r-ico-add" title="添加"></span>可选告警规则：</div>
<div class="gray-border" style="overflow: scroll; height: 240px;"
	id='allAlarmIds'>
<table>
	<tbody id='leftAlarm'>
		<s:iterator value="alarmRuleSelect.leftAlarmList" id="alarm">
			<tr>
				<td width="10%"><input type="checkbox" /> <input type="hidden"
					name="" value="${alarm.ruleId}" /></td>
				<td width="90%" align="left"><s:property
					value="#alarm.ruleName" /><span class='ico ico-find'
					id="alarm_detail_<s:property value="#alarm.ruleId"/>"></span></td>
			</tr>
		</s:iterator>
	</tbody>
</table>
</div>
</div>
<div class="middle"><span class="turn-right"
	id='addAlarmToProfile'></span> <span class="turn-left"
	id='delAlarmToProfile'></span></div>
<div class="right-n" style="width: 260px;">
<div class="h1">已选告警规则：</div>
<div class="gray-border" style="overflow: scroll; height: 240px;"
	id='mineAlarmIds'>
<table>
	<tbody id='rightAlarm'>
		<s:iterator value="alarmRuleSelect.rightAlarmList" id="mineAlarm">
			<tr>
				<td width="10%"><s:if
					test="#mineAlarm.ruleId == @com.mocha.bsm.commonrule.common.Constants@DEFAULTRULEID">
					<input type="checkbox" disabled="disabled" />
					<input type="hidden" name="alarmRuleSelect.ruleIds"
						value="<s:property value="%{@com.mocha.bsm.commonrule.common.Constants@DEFAULTRULEID}"/>" />
				</s:if> <s:else>
					<input type="checkbox" />
					<input type="hidden" name="alarmRuleSelect.ruleIds"
						value="${mineAlarm.ruleId}" />
				</s:else></td>
				<td width="90%" align="left"><s:property
					value="#mineAlarm.ruleName" /><span class='ico ico-find'
					id="alarm_detail_<s:property value="#mineAlarm.ruleId"/>"></span></td>
			</tr>
		</s:iterator>
	</tbody>
</table>
</div>
</div>
</div>
</div>
</fieldset>
</body>
</html>
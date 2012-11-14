<!-- content/profile/userdefine/profile_customevent.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body>
<div class="monitor">
<ul class="monitor-items">
	<li>
	<table class="monitor-items-head">
		<thead>
			<tr>
				<th width="9%">触发告警</th>
				<th width="13%">事件类型</th>
				<th width="52%">事件名称</th>
				<th width="20%">级别</th>
				<th width="6%">操作</th>
			</tr>
		</thead>
	</table>
	</li>
	<s:iterator value="customEvent" id="ce" status="st">
		<li>
		<table class="monitor-items-list">
			<tbody>
				<tr>
					<td width="9%"><s:checkbox
						name="customEvent[%{#st.index}].notificationEnable"
						value="#ce.notificationEnable" id="" /> <input type="hidden"
						name="customEvent[${st.index}].composeId" value="${ce.composeId}" />
					<input type="hidden" name="customEvent[${st.index}].profileId"
						value="${ce.profileId}" /></td>
					<td width="13%">自定义事件</td>
					<td width="52%"><span
						id='openCustom_<s:property value="#ce.composeId"/>'
						style="cursor: pointer;"><s:property value="#ce.eventName" /></span></td>
					<td width="20%"><s:select list="serverityList" listKey="key"
						listValue="value" name="customEvent[%{#st.index}].severity"
						value="#ce.severity" /></td>

					<td width="6%"><span class="ico ico-delete" title="删除"></span></td>
				</tr>
			</tbody>
		</table>
		</li>
	</s:iterator>
</ul>
</div>
</body>
</html>
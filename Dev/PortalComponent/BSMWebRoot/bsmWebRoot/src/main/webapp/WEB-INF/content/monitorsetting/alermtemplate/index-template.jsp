<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<table class="black-grid black-grid-blackb">
	<tr>
		<th style="color: ffffff;">告警类型</th>
		<th style="color: ffffff;">当前使用模板</th>
		<th style="color: ffffff;">描述</th>
		<th style="color: ffffff;">设置</th>
	</tr>
	<input type="hidden" name="domainId" id="domainId" value="${domainId}">
	<s:iterator id="list" value="tabList" status="i">
		<s:if test="#i.index%2==0">
			<tr class="black-grid-graybg">
		</s:if>
		<s:else>
			<tr>
		</s:else>
		<td><s:property value="#list.eventName" />
		</td>
		<td><s:property value="#list.templateName" />
		</td>
		<td><s:property value="#list.templateDesc" />
		</td>
		<td><div name="pageEdit" class="ico ico-equipment" title="编辑"
				id="<s:property value="#list.moduleId" />_<s:property value="#list.eventClass" />_<s:property value="#list.alermMethod" />_<s:property value="#list.language" />" />
		</td>
		</tr>
	</s:iterator>
</table>

<!-- content/profile/userdefine/refresh_result.jsp -->
<%@page import="com.mocha.bsm.profile.type.alarm.SendAlarmFreqEnum"%>
<%@page import="com.mocha.bsm.commonrule.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
</head>
<body>
<p>刷新结果</p>
<table  class="grayhead-table grayborder table-width100" id="result_table">
	<thead>
	<tr>
		<th width="25%" class="fold-top-title">资源名称</th>
		<th width="25%" class="fold-top-title">IP地址</th>
		<th width="15%" class="fold-top-title">是否成功</th>
		<th width="35%" class="fold-top-title">原因</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator id="obj" value="refreshResultVOs" status="st">
		<tr class="fold-greybg">
			<td class="gray-bottom"><div style="width: 170px; text-overflow: ellipsis; overflow: hidden;">
				<nobr><font title="<s:property value="#obj.instanceName"/>"><s:property value="#obj.instanceName"/></font></nobr></div>
			</td>
			<td class="gray-bottom">
				<div style="width: 130px; text-overflow: ellipsis; overflow: hidden;">
					<nobr>
							<s:if test="#obj.ip.length > 1">
								<s:select list="#obj.ip" style="width:120px;"/>
							</s:if>
							<s:else>
								<s:property value="#obj.ip"/>
							</s:else>
					</nobr>
				</div>
			</td>
			<td class="gray-bottom">
				<div style="width: 100px; text-overflow: ellipsis; overflow: hidden;">
				<nobr>
				<s:if test="#obj.success == true">
					<span class="ico ico-checkmark" style="cursor:none;"></span>
				</s:if>
				<s:else>
					<span class="ico ico-delete2" style="cursor:none;"></span>
				</s:else>
				</nobr></div>
			</td>
			<td>
				<div style="width: 230px; text-overflow: ellipsis; overflow: hidden;">
				<nobr><font title="<s:property value="#obj.reasonInfo"/>"><s:property value="#obj.reasonInfo"/></font></nobr></div>
			</td>
		</tr>
	</tbody>
	</s:iterator>
</table>
</body>
</html>
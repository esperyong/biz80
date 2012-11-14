<!-- 机房-机房定义-机柜属性-状态设置-关联资源页面 resStatusDevice.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.mocha.bsm.room.entity.Resource"%>
<title></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />

</head>
<form id="resourceForm" action="" name="resourceForm" method="post">
<div id="statusRes" class="clear">

<table>
	<thead>
		<tr>
			<th><input type="checkbox" />IP地址</th>
			<th>设备名称</th>
			<th>MAC地址</th>
			<th>设备类型</th>
			<th>机柜号</th>
			<th>机框号</th>
			<th>设备号</th>
			<th>备注</th>
		</tr>
	</thead>
	<tbody>
		<s:iterator value="RelaResMap" id="mapRelaRes" status="stat">
			<tr>
				<!-- IP地址 -->
				<td><input type="checkbox"
					name="<s:property value='#mapRelaRes.value.id' />_checkOne"
					value="<s:property value='#mapRelaRes.value.ipAddress' />" /></td>
				<!-- 设备名称 -->
				<td><span class="field" name='#mapRelaRes.value.id' />_devName" >
				<s:property value="#mapRelaRes.value.DevName" /></span>
				</td>
				<!-- MAC地址 -->
				<td><span class="field" name='#mapRelaRes.value.id' />_mac" >
				<s:property value="#mapRelaRes.value.macAddress" /></span>
				</td>
				<!-- 设备类型 -->
				<td><span class="field" name='#mapRelaRes.value.id' />_devtype" >
				<s:property value="#mapRelaRes.value.deviceType" /></span>
				</td>
				<!-- 机柜号 -->
				<td><span class="field" name='#mapRelaRes.value.id' />_jigui" >
				<s:property value="#mapRelaRes.value.jigui" /></span>
				</td>
				<!-- 机框号 -->
				<td><span class="field" name='#mapRelaRes.value.id' />_jikuang" >
				<s:property value="#mapRelaRes.value.jikuang" /></span>
				</td>
				<!-- 设备号 -->
				<td><span class="field" name='#mapRelaRes.value.id' />_deviceNo" >
				<s:property value="#mapRelaRes.value.deviceNo" /></span>
				</td>
				<!-- 备注 -->
				<td><span class="field" name='#mapRelaRes.value.id' />_notes" >
				<s:property value="#mapRelaRes.value.notes" /></span>
				</td>
				
			</tr>
		</s:iterator>
	</tbody>
</table>
</div>

<input type="hidden" name="roomId" id="roomId"
	value="<s:property value='roomId' />" />
</form>
</body>
</html>

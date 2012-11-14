<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div style="width:100%;height:565px;overflow-y:auto;background-color:#FFFFFF">
<span style="top:5px;position:relative"><b>目录</b></span>
<ul>
	<s:iterator value="reportInfo" var="info" status="reportInfoCollect">
		<li><s:property value="#info.getName()"/></li>
	</s:iterator>
</ul>
<!-- <span id="thisSPA"><s:property value="roomReportInfo.get(0)"/></span> -->
<s:iterator value="roomReportInfo" var="roomInfo" status="reportRem">
<div style="height:25px;width:100%;background-color:#0F7CE5" ><span><s:property value="#roomInfo.getReportInfo().getName()"/></span></div>
	<table class="tongji-grid table-width100 whitebg grayborder">
		<thead>
			<tr>
				<th>序号</th>
				<th>设备名称</th>
				<th>设备类型</th>
				<th>指标名称 </th>
				<th>最大值 </th>
				<th>平均值 </th>
				<th>最小值</th>
				<th>异常次数 </th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="#roomInfo.getReportMerticInfo()" var="metricInfo" status="metricRem">
			<tr>
				<td><s:property value="#metricRem.index"></s:property></td>
				<td><s:property value="#metricInfo.getDeviceName()"></s:property></td>
				<td><s:property value="#metricInfo.getDeviceType()"></s:property></td>
				<td><s:property value="#metricInfo.getMerticName()"></s:property></td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
			</tr>
			</s:iterator>
		</tbody> 
	</table>
</s:iterator>
</div>
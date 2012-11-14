<!-- content/profile/custom/childResInsMetric.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%--个性化页面load部分页面. @deprecate--%>
<script type="text/javascript">
var path = "${ctx}";
var rowIndex = "${rowIndex}";
</script>
<table>
	<thead><tr><th width="8%">是否监控</th>
				<th width="18%">指标名称</th>
				<th width="14%">监控频度</th>
				<th width="15%">阈值</th>
				<th width="15%">事件</th>
				<th width="10%">事件级别</th>
				<th width="12%"><input type="checkbox" id="isAlert_${index}" mIndex="${index}"/><span>是否告警</span></th>
				<th width="8%">设置</th></tr></thead>
	<s:iterator value="metricSettingList" id="metric" status="st2">
	<tbody><tr>
		<%-- 是否监控 --%>
		<td width="6%">
		<div style="display: block;">
		<input type="hidden" name="metricGruopList[${index}].list[${st2.index}].metricId" id="" value="${metric.metricId}"/>
		<input type="hidden" name="metricGruopList[${index}].list[${st2.index}].haveChange" id="" value="${metric.haveChange}"/><br/>
		<input type="hidden" name="metricGruopList[${index}].list[${st2.index}].monitor" id="" value="${metric.monitor}"/><br/>
		</div>
		<input type="checkbox" name="isMonitor"  <s:if test="!#metric.notEditMonitor">disabled="disabled"</s:if> <s:if test="#metric.monitor==true">checked="checked"</s:if> />
		</td>
		<%-- 指标名称 --%>
		<td width="18%" title="<s:property value="#metric.metricName" />"><s:property value="#metric.metricName"/></td>
		<%-- 监控频度 --%>
		<td  width="14%">
			<s:if test="#metric.monitorFreq.period">
				<s:select 
					list="#metric.monitorFreq.monitorFreqList" 
					name="metricGruopList[%{index}].list[%{#st2.index}].monitorFreq.frequencyId"
					listKey="key" listValue="value" value="%{#metric.monitorFreq.frequencyId}"></s:select>
			</s:if><s:else>
				<s:property value="#metric.monitorFreq.text"/>
			</s:else>
			<input type="hidden" name="metricGruopList[${index}].list[${st2.index}].monitorFreq.haveChange" id="" value="${metric.monitorFreq.haveChange}"/>
		</td>
		<%-- 阈值 --%>
		<td width="15%" style="vertical-align: middle;text-align: center;"><s:if test="#metric.haveThreshold">
 			<s:iterator value="#metric.thresholds" id="th" status="st3"> 
 				<s:if test="#th.unit != null">
 				<input type="hidden" value="${th.thresholdId}" name="metricGruopList[${index}].list[${st2.index}].thresholds[${st3.index}].thresholdId" id=""/>
 				<input type="hidden" value="${th.comparison}" name="metricGruopList[${index}].list[${st2.index}].thresholds[${st3.index}].comparison" id=""/>
 				<input type="hidden" value="${th.unit}" name="metricGruopList[${index}].list[${st2.index}].thresholds[${st3.index}].unit" id=""/>
 				<s:set name="unit" value="%{#th.unit}"></s:set>
 				<input type="hidden" value="${th.color}" name="metricGruopList[${index}].list[${st2.index}].thresholds[${st3.index}].color" id=""/>
 				<input type="hidden" value="${th.flapping}" name="metricGruopList[${index}].list[${st2.index}].thresholds[${st3.index}].flapping" id=""/>
 				<input type="hidden" value="${th.thresholdValue}" name="metricGruopList[${index}].list[${st2.index}].thresholds[${st3.index}].thresholdValue" id=""/>
 				<s:if test="#th.color=='red'"><s:set name="redHeight" value="#th.thresholdValue"/></s:if>
 				<s:if test="#th.color=='yellow'"><s:set name="yeHeight" value="#th.thresholdValue"/></s:if>
 				<input type="hidden" name="metricGruopList[${index}].list[${st2.index}].thresholds[${st3.index}].haveChange" id="" value="${th.haveChange}"/>
 				</s:if>
 			</s:iterator>
 				<%@ include file="../cue-min.jsp" %>
 			</s:if>
		</td>
		<%-- 事件名称 --%>
		<td width="15%" style="vertical-align: middle;text-align: center;">
		<ul><s:iterator value="#metric.eventDefs" id="event">
			<li><s:text name="%{#event.eventName}"/></li>
		</s:iterator></ul>
		</td>
				<%-- 事件级别 --%>
				<td width="10%" style="vertical-align: middle;text-align: center;">
				<ul><s:iterator value="#metric.eventDefs" id="event" status="st4">
				<li>
				<s:select list="ServerityList" 
					listKey="key" listValue="value" 
					name="metricGruopList[%{index}].list[%{#st2.index}].eventDefs[%{#st4.index}].severityId"
					value="%{#event.severityId}"
				/>
				<input type="hidden" name="metricGruopList[${index}].list[${st2.index}].eventDefs[${st4.index}].haveChange" value="${event.haveChange}"/>
				<input type="hidden" name="metricGruopList[${index}].list[${st2.index}].eventDefs[${st4.index}].eventDefId" value="${event.eventDefId}"/>
				</li></s:iterator></ul></td>
				<%-- 是否告警 --%>
		<td width="12%" style="vertical-align: middle;text-align: center;">
		<ul><s:iterator value="#metric.eventDefs" id="event" status="st4">
		<li style="text-align: center;">
			<s:checkbox name="metricGruopList[%{index}].list[%{#st2.index}].eventDefs[%{#st4.index}].notification" value="%{#event.notification}"/>
		</li></s:iterator></ul></td>
 			<%-- 高级设置 --%>
		<td width="8%" style="vertical-align: middle;text-align: center;">
			<s:if test="isNew==false"><s:if test="#metric.haveAdvSetting"><span class="ico ico-equipment" id="setting"></span></s:if></s:if>
			<s:else><s:if test="#metric.haveAdvSetting"><span class="ico ico-equipment-off"></span></s:if></s:else>
		</td>
		</tr></tbody>
	</s:iterator>
</table>
<!-- content/profile/userdefine/profile_metric.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body>
<ul class="monitor-items">
	<li>
	<table class="monitor-items-head">
		<thead>
			<tr>
				<th width="8%">类型</th>
				<th width="8%"><input id="monitorAllSelect" type="checkbox" align="center"/>监控</th>
  	    <th width="8%"><input id="criticalAllSelect" type="checkbox" align="center"/>关键</th>
				<th width="13%">指标名称</th>
				<th width="10%">监控频度</th>
				<th width="16%">阈值</th>
				<th width="13%">事件</th>
				<th width="9%">级别</th>
				<th width="9%"><input id="alarmAllSelect" type="checkbox" align="center"/>告警</th>
				<th width="6%" id="setting_title">设置</th>
			</tr>
		</thead>
	</table>
	</li>
	<s:iterator value="metricGruopList" id="group" status="st1">
		<li name="metric_group" style="display:none;"><input type="hidden" name="metricGruopList[${st1.index}].haveChange" value="${group.haveChange}" groupAttrid="metricgroupHaveChange_${st1.index}"/></li>
		<s:iterator value="#group.list" id="metric" status="st2">
			<li id="metricgroup_next" parentAttrid="metricgroupHaveChange_${st1.index}">
			<div style="display: none;"><input type="hidden"
				name="metricGruopList[${st1.index}].list[${st2.index}].metricId"
				value="${metric.metricId}" /> <input type="hidden"
				name="metricGruopList[${st1.index}].list[${st2.index}].haveChange"
				value="${metric.haveChange}"/></div>
			<table class="monitor-items-list">
				<tbody>
					<tr>
						<%-- 类型 --%>
						<td width="8%"><s:if test="#st2.isFirst()">
							<s:property value="#group.metricGroupName" />
						</s:if></td>
						<%-- 监控 --%>
						<td width="8%"><input type="checkbox" name="monitor"
							<s:if test="!#metric.notEditMonitor">disabled="disabled"</s:if>
							<s:if test="#metric.monitor">checked</s:if> /> <input
							type="hidden"
							name="metricGruopList[${st1.index}].list[${st2.index}].monitor"
							value="${metric.monitor}" /></td>
            <%-- 关键 --%>
						<td width="8%"><input type="checkbox" name="critical"
							<s:if test="!#metric.notEditMonitor">disabled="disabled"</s:if>
							<s:if test="#metric.critical">checked</s:if> /> <input
							type="hidden"
							name="metricGruopList[${st1.index}].list[${st2.index}].critical"
							value="${metric.critical}" /></td>
						<%-- 指标名称 --%>
						<td width="13%" style="text-align: left;"><span
							title="${metric.metricName}"><s:property
							value="#metric.metricName" /></span></td>
						<%-- 监控频度 --%>
						<td width="10%"><s:property
							value="#metric.monitorFreq.isPeriod" /> <s:if
							test="#metric.monitorFreq.period">
							<s:select list="#metric.monitorFreq.monitorFreqList"
								name="metricGruopList[%{#st1.index}].list[%{#st2.index}].monitorFreq.frequencyId"
								listKey="key" listValue="value"
								value="#metric.monitorFreq.frequencyId"></s:select>
						</s:if><s:else>
							<div id="monitorFreq" style="cursor: pointer;"><s:property
								value="#metric.monitorFreq.text" /></div>
						</s:else> <input type="hidden"
							name="metricGruopList[${st1.index}].list[${st2.index}].monitorFreq.haveChange"
							value="${metric.monitorFreq.haveChange}" /></td>
						<%-- 阈值 --%>
						<td width="16%"><s:if test="#metric.haveThreshold">
								
							<s:iterator value="#metric.thresholds" id="th" status="st3">
								<s:if test="#th.comparison==\">\"  || #th.comparison==\">=\" "><%--正常情况 --%>
								<s:set name="isInclue" value="true" />
									<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdId"
										value="${th.thresholdId}" />
									<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].comparison"
										value="${th.comparison}" />
									<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].unit"
										value="${th.unit}" />
									<s:set name="unit" value="%{#th.unit}"></s:set>
									<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].flapping"
										value="${th.flapping}" />
									<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].color"
										value="${th.color}" />
									<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdValue"
										value="${th.thresholdValue}" />
									<s:if test="#th.color=='red'">
										<s:set name="redHeight" value="#th.thresholdValue" />
									</s:if>
									<s:if test="#th.color=='yellow'">
										<s:set name="yeHeight" value="#th.thresholdValue" />
									</s:if>
									<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].haveChange"
										value="${th.haveChange}" />
								</s:if>
								<s:else><%--非正常情况(阈值相反，或者包含不包含) --%>
									<s:if test="#th.comparison!=\"equalsnull\"">
										<s:set name="isInclue" value="false" />
									</s:if>
								<span name="metric_number" style="display: block; text-align: center;" <s:if test="!#metric.critical">disabled</s:if>>
								<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdId"
										value="${th.thresholdId}" />
								<s:if test="#th.comparison == \"contains\"  || #th.comparison == \"!contains\" "><%-- 包含不包含 --%>
									<s:if test="#th.color=='red'||#th.color=='yellow'||#th.color=='green'">
									<s:select list="#{'contains':'包含','!contains':'不包含' }" 
									name="metricGruopList[%{#st1.index}].list[%{#st2.index}].thresholds[%{#st3.index}].comparison"
									value="#th.comparison"></s:select>
									</s:if><s:else>
											<input type="hidden"
													name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].comparison"
													value="${th.comparison}"  />
											</s:else>
								</s:if><s:else><%-- 阈值相反 --%>
								<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].comparison"
										value="${th.comparison}"  />
								</s:else>
								
								<s:if test="#th.color=='red'"><%-- 红色阈值 --%>
								<input type="text" style="color:#ff0000"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdValue"
										value="${th.thresholdValue}"  <s:if test="!#metric.critical">disabled</s:if> size="2"/><span title="${th.unit}" style="width: 23px; text-overflow: ellipsis; overflow: hidden;"><nobr><font color="#ff0000">${th.unit}</font></nobr></span>
								</s:if>
								<s:elseif test="#th.color=='yellow'"><%-- 黄色阈值 --%>
								<input type="text" style="color:#ff9933"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdValue"
										value="${th.thresholdValue}"  <s:if test="!#metric.critical">disabled</s:if> size="2"/><span title="${th.unit}" style="width: 23px; text-overflow: ellipsis; overflow: hidden;"><nobr><font color="#ff9933">${th.unit}</font></nobr></span>
								</s:elseif>
								<s:elseif test="#th.color=='green'"><%-- 绿色阈值 --%>
								<input type="text" style="color:green"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdValue"
										value="${th.thresholdValue}"  <s:if test="!#metric.critical">disabled</s:if> size="2"/><span title="${th.unit}" style="width: 23px; text-overflow: ellipsis; overflow: hidden;"><nobr><font color="green">${th.unit}</font></nobr></span>
								</s:elseif>
								<s:else><%-- 不显示的阈值 --%>
								<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdValue"
										value="${th.thresholdValue}"  size="2"/>
								</s:else>
								<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].unit"
										value="${th.unit}" />
								<input type="hidden"
										name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].flapping"
										value="${th.flapping}" />
								<input type="hidden"
								name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].haveChange"
								value="true" />
								</span>
								</s:else>
							</s:iterator>
							<s:if test="#isInclue==true">
							<%@ include file="../cue-min.jsp"%>
							</s:if>
						</s:if></td>
						<%-- 事件名称 --%>
						<td width="13%"><s:iterator value="#metric.eventDefs"
							id="event">
							<ul name="eventName_ul" <s:if test="!#metric.critical">disabled</s:if>>
								<li><s:text name="%{#event.eventName}" /></li>
						</s:iterator>
						</ul>
						</td>
						<%-- 事件级别 --%>
						<td width="9%">
						<ul name="event_ul" <s:if test="!#metric.critical">disabled</s:if>>
							<s:iterator value="#metric.eventDefs" id="event" status="st4">
								<li><s:select list="ServerityList" listKey="key"
									listValue="value"
									name="metricGruopList[%{#st1.index}].list[%{#st2.index}].eventDefs[%{#st4.index}].severityId" />
								<input type="hidden"
									name="metricGruopList[${st1.index}].list[${st2.index}].eventDefs[${st4.index}].haveChange"
									value="${event.haveChange}" /> <input type="hidden"
									name="metricGruopList[${st1.index}].list[${st2.index}].eventDefs[${st4.index}].eventDefId"
									value="${event.eventDefId}" /></li>
							</s:iterator>
						</ul>
						</td>
						<%-- 是否告警 --%>
						<td width="9%" align="center">
						<ul name="notification_ul" <s:if test="!#metric.critical">disabled</s:if>>
							<s:iterator value="#metric.eventDefs" id="event" status="st4">
								<li style="text-align: center;"><s:checkbox
									name="metricGruopList[%{#st1.index}].list[%{#st2.index}].eventDefs[%{#st4.index}].notification"
									flag="whetherAlarm" /></li>
							</s:iterator>
						</ul>
						</td>
						<%-- 高级 --%>
						<td width="6%" align="center" id="advSetting"><s:if
							test="#metric.haveAdvSetting">
							<span class="ico ico-equipment<s:if test='!#metric.critical'>-off</s:if>" id="setting" <s:if test="!#metric.critical">disabled</s:if>></span>
						</s:if></td>
					</tr>
				</tbody>
			</table>
			</li>
		</s:iterator>
	</s:iterator>
</ul>
</body>
</html>
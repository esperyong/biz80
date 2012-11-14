<!-- content/profile/userdefine/custom_metric.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body>
<ul class="monitor-items">
	<li style="line-height: 30px; padding-left: 10px;"><span
		class="sub-panel-tips"></span><span>设置监控哪些监控项、监控频度，以及指标阈值等内容。</span></li>
	<li>
	<table class="monitor-items-head">
		<thead>
			<tr>
				<th width="10%" align="center" style="display: none;">是否监控</th>
				<th width="15%" align="center">监控项名称</th>
				<th width="10%" align="center">&nbsp;</th>
				<th width="15%" align="center">监控频度</th>
				<th width="50%" align="center">操作</th>
			</tr>
		</thead>
	</table>
	</li>
</ul>
<ul id="monitorMetricSetting" class="monitor-items f-relative">
	<s:iterator value="metricGruopList" id="group" status="st1">
		<s:if test="#group.haveAdvSetting || #group.list.size > 0">
		<li index='${st1.index}' id="${group.metricGroupId}">
		<div id="hiddenDiv" name="hiddenDiv" style="display: none;"><input
			type="hidden" name="metricGruopList[${st1.index}].profileId" id=""
			value="${group.profileId}" /> <input type="hidden"
			name="metricGruopList[${st1.index}].haveChange" id=""
			value="${group.haveChange}" /> <input type="hidden"
			name="metricGruopList[${st1.index}].isChildResource" id=""
			value="${group.isChildResource}" /> <input type="hidden"
			name="metricGruopList[${st1.index}].metricGroupId" id=""
			value="${group.metricGroupId}" /></div>
		<table class="monitor-items-list">
			<tbody>
				<tr>
					<td width="10%" style="display: none;"><input type="checkbox" name="checkAllMetric"
						<s:if test="#group.metricGroupId == 'AvailabilityMetric'">disabled</s:if> /></td>
					<td width="15%" align="center"><s:property
						value="#group.metricGroupName" /></td>
					<td width="10%" align="center">
						<s:if test="!#group.isChildResource">
							<span class='monitor-ico monitor-ico-open'></span></td>
						</s:if>
					<td width="15%" align="center">
						<s:if test="!#group.isChildResource">
							<s:select list="#group.allFreqList" listKey="key"
								listValue="value" id="allFreqList" />
						</s:if>
					</td>
					<td width="50%" align="center">
						<s:if test="listen != null && listen.isNew==true">
              <s:if test="#group.haveAdvSetting">
								<span class="btn-gray-down" style="cursor:none;">高级</span>
								<span class="btn-gray-down" style="cursor:none;">批量设置</span>
							</s:if>
						</s:if> 
						<s:else>
							<s:if test="#group.haveAdvSetting">
								<span id="advSetting" class="btn-gray-on" style="cusor:none;">高级</span>
								<span id="batchSetting" class="btn-gray-on" style="cusor:none;">批量设置</span>
							</s:if>
						</s:else>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="monitor-target" style="display: none;">
		<s:if test="!#group.isChildResource">
			<table>
				<thead>
					<tr>
						<th width="8%"><input id="monitorAllSelect_${st1.index}" mid="${group.metricGroupId}"
       mIndex="${st1.index}" type="checkbox" align="center"/>监控</th>
  	        <th width="8%"><input id="criticalAllSelect_${st1.index}" mid="${group.metricGroupId}"
       mIndex="${st1.index}" type="checkbox" align="center"/>关键</th>
						<th width="18%">指标名称</th>
						<th width="12%">监控频度</th>
						<s:if test="#group.metricGroupId=='InformationalMetric'">
							<th width="60%"></th>
						</s:if>
						<s:else>
							<th width="13%">阈值</th>
							<th width="15%">事件</th>
							<th width="10%">事件级别</th>
							<th width="9%"><input type="checkbox"
								id="isAlert_${st1.index}" mid="${group.metricGroupId}"
								mIndex="${st1.index}"><span>告警</span></th>
							<th width="8%">设置</th>
						</s:else>
					</tr>
				</thead>
				<s:iterator value="#group.list" id="metric" status="st2">
					<tbody>
						<tr>
							<%-- 是否监控 --%>
							<td width="8%">
							<div style="display: block;"><input type="hidden"
								name="metricGruopList[${st1.index}].list[${st2.index}].metricId"
								id="" value="${metric.metricId}" /> <input type="hidden"
								name="metricGruopList[${st1.index}].list[${st2.index}].haveChange"
								id="" value="${metric.haveChange}" /> <input type="hidden"
								name="metricGruopList[${st1.index}].list[${st2.index}].monitor"
								id="" value="${metric.monitor}" /></div>
							<input type="checkbox" name="isMonitor"
								<s:if test="!#metric.notEditMonitor">disabled="disabled"</s:if>
								<s:if test="#metric.monitor==true">checked="checked"</s:if> />
							</td>
							<%-- 关键 --%>
				              <td width="8%"><input type="checkbox" name="critical"
						          <s:if test="!#metric.notEditMonitor">disabled="disabled"</s:if>
						           <s:if test="#metric.critical">checked</s:if> />
				                 <input type="hidden" name="metricGruopList[${st1.index}].list[${st2.index}].critical" value="${metric.critical}"/></td>
							<%-- 指标名称 --%>
							<td width="18%" title="<s:property value="#metric.metricName" />"><s:property value="#metric.metricName" /></td>
							<%-- 监控频度 --%>
							<td width="12%" style="white-space: normal;"><s:property
								value="#metric.monitorFreq.isPeriod" /> <s:if
								test="#metric.monitorFreq.period">
								<s:select list="#metric.monitorFreq.monitorFreqList"
									name="metricGruopList[%{#st1.index}].list[%{#st2.index}].monitorFreq.frequencyId"
									listKey="key" listValue="value"
									value="#metric.monitorFreq.frequencyId"></s:select>
							</s:if><s:else>
							<div id="monitorFreq" style="cursor: pointer;" title="<s:property value="#metric.monitorFreq.text" />">
								<s:property value="#metric.monitorFreq.text" /></div>
							</s:else> <input type="hidden"
								name="metricGruopList[${st1.index}].list[${st2.index}].monitorFreq.haveChange"
								value="${metric.monitorFreq.haveChange}" /></td>
							<s:if test="#group.metricGroupId=='InformationalMetric'">
								<td width="60%"></td>
							</s:if>
							<s:else>
								<%-- 阈值 --%>
								<td width="13%"
									style="vertical-align: middle; text-align: center;"><s:if
									test="#metric.haveThreshold">
									<s:set name="unit" value="null"></s:set>
									<s:iterator value="#metric.thresholds" id="th" status="st3">
										<s:if test="#th.unit != null">
											<input type="hidden" value="${th.thresholdId}"
												name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdId"
												id="" />
											<input type="hidden" value="${th.comparison}"
												name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].comparison"
												id="" />
											<input type="hidden" value="${th.unit}"
												name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].unit"
												id="" />
											<s:if test="#unit == null">
												<s:set name="unit" value="%{#th.unit}"></s:set>
											</s:if>
											<input type="hidden" value="${th.color}"
												name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].color"
												id="" />
											<input type="hidden" value="${th.flapping}"
												name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].flapping"
												id="" />
											<input type="hidden" value="${th.thresholdValue}"
												name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].thresholdValue"
												id="" />
											<s:if test="#th.color=='red'">
												<s:set name="redHeight" value="#th.thresholdValue" />
											</s:if>
											<s:if test="#th.color=='yellow'">
												<s:set name="yeHeight" value="#th.thresholdValue" />
											</s:if>
											<input type="hidden"
												name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].haveChange"
												id="" value="${th.haveChange}" />
										</s:if>
									</s:iterator>
									<%@ include file="../cue-min.jsp"%>
								</s:if></td>
								<%-- 事件名称 --%>
								<td width="15%"
									style="vertical-align: middle; text-align: center;">
								<ul name="eventName_ul" <s:if test="!#metric.critical">disabled</s:if>>
									<s:iterator value="#metric.eventDefs" id="event">
										<li><s:text name="%{#event.eventName}" /></li>
									</s:iterator>
								</ul>
								</td>
								<%-- 事件级别 --%>
								<td width="10%"
									style="vertical-align: middle; text-align: center;">
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
								<td width="9%"
									style="vertical-align: middle; text-align: center;">
								<ul name="notification_ul" <s:if test="!#metric.critical">disabled</s:if>>
									<s:iterator value="#metric.eventDefs" id="event" status="st4">
										<li style="text-align: center;"><s:checkbox
											name="metricGruopList[%{#st1.index}].list[%{#st2.index}].eventDefs[%{#st4.index}].notification" />
										</li>
									</s:iterator>
								</ul>
								</td>
								<%-- 高级设置 --%>
								<td width="8%"
									style="vertical-align: middle; text-align: center;">
                <s:if test="listen != null && listen.isNew==true">
									<s:if test="#metric.haveAdvSetting">
										<span class="ico ico-equipment-off" style="cursor:none;"></span>
									</s:if>
								</s:if> <s:else>
                  <s:if test="#metric.haveAdvSetting">
										<span class="ico ico-equipment<s:if test='!#metric.critical'>-off</s:if>" id="setting" <s:if test="!#metric.critical">disabled</s:if>></span>
									</s:if>
								</s:else></td>
							</s:else>
						</tr>
					</tbody>
				</s:iterator>
			</table>
		</s:if></div>
		</li>
		</s:if>
	</s:iterator>
</ul>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
<!--
$(document).ready(function(){
	$events = $("#events");
	eventIndex=${size};
	$delEvent = $("#delEvent");
	$addEvent = $("#addEvent");
	$delEvent.click(function(){
		$("input[name='eventCheck']:checked").parents("tr").remove();
		$("#checkAllId").removeAttr("checked");
		dialogResize();
	});
	
	$addEvent.click(function(){
		$events.append(newEvent(eventIndex++)).show();
		selectCondition(eventIndex-1);
		dialogResize();
	});
	isVisible($delEvent,$addEvent);
	$("#checkAllId").click(function(){
		if($(this).attr("checked")) {
			$("input[name='eventCheck']").attr("checked",'true');
		}else {
			$("input[name='eventCheck']").removeAttr("checked");
		}
	});

});
function newEvent(index){
	newEventIndex=index+1;
	return "<tr><td align=\"middle\"><input type=\"checkbox\" name=\"eventCheck\"/>" +
				"<input name=\"eventList["+index+"].profileId\" value=\""+profileId+"\" type=\"hidden\"/>"+
				"<input name=\"eventList["+index+"].eventId\" value=\"\" type=\"hidden\"/>"+
			"</td>"+
			"<td align=\"middle\"><input name=\"eventList["+index+"].produce\" value=\"true\" type=\"checkbox\"/></td>"+
			"<td align=\"left\"><input name=\"eventList["+index+"].eventName\" type=\"text\" size=\"10\" value=\"默认事件"+newEventIndex+"\"/></td>"+
			"<td align=\"left\"><select name=\"eventList["+index+"].lvel\">"+
				<s:iterator value="levels" >
					"<option value=\"${key}\">${value}</option>"+
				</s:iterator>
			"</select></td>"+
			"<td align=\"left\"><select name=\"eventList["+index+"].priority\">"+
				<s:iterator value="prioritys" >
					"<option value=\"${key}\">${value}</option>"+
				</s:iterator>
			"</select></td>"+
			"<td align=\"left\">"+
				"<span><select name=\"eventList["+index+"].metricId\" style=\"width:80px\" onchange='selectCondition("+index+")' id='condition"+index+"'>"
				+"<option value='-1'>请选择</option>"+
				<s:iterator value="scriptMetricList" >
					"<option value=\"${metricId}\" jsName=\"${dataType}\">${metricName}</option>"+
				</s:iterator>
				"</select></span>"+
				"<span id=\"relationSpan"+index+"\" style=\"padding-left:4px;\"><select id=\"operateModeId"+index+"\" name=\"eventList["+index+"].operateMode\" style=\"width:60px;\" validate=\"select-one\"/></span>"+
				"<span id=\"synSpan"+index+"\" style=\"padding-left:2px;\"><input id=\"thresholdText"+index+"\" type=\"text\" name=\"eventList["+index+"].threshold\" size=\"12\"/></span>"+
			"</td>"+
			"<td align=\"left\"><select name=\"eventList["+index+"].produceMode\" validate=\"select-one\">"+
				<s:iterator value="produceRules">
					"<option value=\"${key}\">${value}</option>"+
				</s:iterator>
			"</select></td>"+
			"<td align=\"middle\"><input name=\"eventList["+index+"].alarm\" value=\"true\" type=\"checkbox\"/></td></tr>";
}
//-->
</script>
<div class="blackbg01"><span class="ico ico-help"></span>说明：添加事件，并设置事件的触发条件和规则。</div>
<li><span id="delEvent" class="panel-gray-ico panel-gray-ico-close" title="删除"></span>
<span id="addEvent" class="panel-gray-ico panel-gray-ico-add" title="添加"></span></li>
<div style="margin: 10px;" class="greywhite-border">
<table class="hundred">
	<thead>
		<tr class="monitor-items-head">
			<th width="4%"><input type='checkbox' name='checkAll' id='checkAllId' style='cursor: pointer' /></th>
			<th width="8%">是否产生</th>
			<th width="15%">事件名称</th>
			<th width="10%">级别</th>
			<th width="8%">优先级</th>
			<th width="33%">条件</th>
			<th>产生规则</th>
			<th>是否告警</th>
		</tr>
	</thead>
	<tbody id="events">
	<s:iterator value="scriptEventList" id="eventList" status="status">
	<tr>
	<td align="middle"><input type="checkbox" name="eventCheck"/>
	<input name="eventList[<s:property value="#status.index"/>].profileId" value="<s:property value="#eventList.profileId"/>" type="hidden"/>
	<input name="eventList[<s:property value="#status.index"/>].eventId" value="<s:property value="#eventList.eventId"/>" type="hidden"/>
	</td>
	<td align="middle"><input name="eventList[<s:property value="#status.index"/>].produce" type="checkbox" <s:if test="#eventList.produce==true">checked</s:if>/></td>
	<td align="left"><input name="eventList[<s:property value="#status.index"/>].eventName" type="text" size="10" value="<s:property value="#eventList.eventName"/>"/></td>
	<td align="left"><s:select name="eventList[%{#status.index}].lvel" value="#eventList.lvel" list="levels" listKey="key" listValue="value"/></td>
	<td align="left"><s:select name="eventList[%{#status.index}].priority" value="#eventList.priority" list="prioritys" listKey="key" listValue="value"/></td>
	<td align="left">
	<select name="eventList[${status.index}].metricId" style="width:80px" onchange='selectCondition(${status.index})' id='condition${status.index}'>
		<option value='-1'>请选择</option>
		<s:iterator value="scriptMetricList" id="metric">
			<s:if test="#metric.metricId == #eventList.metricId">
				<s:set name="dataTypeVal" value="#metric.dataType"/>
				<option value="${metric.metricId}" jsName="${metric.dataType}" selected>${metric.metricName}</option>
			</s:if>
			<s:else>
				<option value="${metric.metricId}" jsName="${metric.dataType}">${metric.metricName}</option>
			</s:else>
		</s:iterator>
	</select>
	<span id="relationSpan<s:property value="#status.index"/>">
		<s:if test="'BOOLEAN'.equals(#dataTypeVal.name())">
			<span >等于</span>
			<input type="hidden" name="eventList[<s:property value="#status.index"/>].operateMode" value="TRUE"/>
		</s:if>
		<s:elseif test="'NUMBER'.equals(#dataTypeVal.name())">
			<s:select name="eventList[%{#status.index}].operateMode" style="width:60px" id='relation%{#status.index}' list="@com.mocha.bsm.script.monitor.obj.monitor.type.ConditionNumber@values()" listKey="key" listValue="value" value="%{#eventList.operateMode}"/>
		</s:elseif>
		<s:elseif test="'STRING'.equals(#dataTypeVal.name())">
			<s:select name="eventList[%{#status.index}].operateMode" style="width:60px" id='relation%{#status.index}' list="@com.mocha.bsm.script.monitor.obj.monitor.type.ConditionString@values()" listKey="key" listValue="value" value="%{#eventList.operateMode}"/>
		</s:elseif>		
	</span>
	<span id="synSpan${status.index}">
	<s:if test="'BOOLEAN'.equals(#dataTypeVal.toString())">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<select id="thresholdSelect${status.index}" name="eventList[<s:property value="#status.index"/>].threshold" style="width:80px">
		<option value="TRUE" <s:if test="#eventList.threshold=='TRUE'">selected</s:if>>TRUE</option>
		<option value="FALSE" <s:if test="#eventList.threshold=='FALSE'">selected</s:if>>FALSE</option>
	</select>
	</s:if><s:else>
		<input id="thresholdText${status.index}" type="text" name="eventList[<s:property value="#status.index"/>].threshold" value="<s:property value='#eventList.threshold'/>" size="12"/>
	</s:else>
	</span>
	<td align="left"><s:select name="eventList[%{#status.index}].produceMode" value="#eventList.produceMode" list="produceRules" listKey="key" listValue="value"/></td>
	<td align="middle"><input name="eventList[<s:property value="#status.index"/>].alarm" type="checkbox" <s:if test="#eventList.alarm==true">checked</s:if>/></td>
	</td>
	</tr>
	</s:iterator>
	</tbody>
</table>
</div>
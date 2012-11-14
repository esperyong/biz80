<!-- content/profile/advsetting/nonAccessTime.jsp -->
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<link href="${ctx}/css/datepicker.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
<div class="monitor">
	<s:if test="source == 'offtime'">
		<div class="h2">
			<span class="left" style="font-weight:bold;">计划不在线时间</span>
			<span id="delNatLine" class="right r-ico r-ico-delete" title="删除"></span>
			<span id="addNatLine" class="right r-ico r-ico-add" title="添加"></span>
		</div>
	</s:if>
	<s:else>
		<div style="width: 100%; text-align: right; height: 20px;">
			<span id="delNatLine" class="right r-ico r-ico-delete"  <s:if test="isEdit">style="cursor:default;"</s:if> title="删除"></span>
			<span id="addNatLine" class="r-ico r-ico-add" <s:if test="isEdit">style="cursor:default;"</s:if> title="添加"></span>
		</div>
	</s:else>
</div>
<div style="display: none;">
<s:select list="@com.mocha.bsm.profile.type.NatType@values()" listKey="key" listValue="value" id="nat_Type"></s:select>
</div>
<ul id="natPanel" class="monitor-items">
	<li>
		<table class="monitor-items-head">
	  		<thead><tr><th width="10%"><input type="checkbox" id="checkAll"></th>
	  			<th width="30%">时间段</th>
	  			<th width="60%">&nbsp;</th>
	  			</tr></thead></table>
	</li>
<s:iterator value="nonAccessTimes" id="nat" status="i">
<li>
<table class="monitor-items-list" id="timeList"><tbody><tr><td width="10%"><input type="hidden" name="nonAccessTimes[${i.index}].inUse" value="${nat.inUse}" /><input type="checkbox" onclick="cancelChecked()"/></td>
<td width="30%"><s:select list="@com.mocha.bsm.profile.type.NatType@values()" listKey="key" listValue="value" id="nat_Type[%{#i.index}]" name="nonAccessTimes[%{#i.index}].type"></s:select></td>
<td width="60%">
<s:if test="#nat.type=='Daily'">从<s:textfield name="nonAccessTimes[%{#i.index}].startTime" size="6" cssClass="validate[funcCall[noAccStartTimeLarge]]"/>到<s:textfield name="nonAccessTimes[%{#i.index}].endTime" size="6" cssClass="validate[funcCall[noAccEndTimeSmall]]"/></s:if>
<s:elseif test="#nat.type=='Weekly'"><s:select name='nonAccessTimes[%{#i.index}].date' list='@com.mocha.bsm.profile.type.DayOfWeek@values()' listKey='key' listValue='value' />从<s:textfield name="nonAccessTimes[%{#i.index}].startTime" size="6" cssClass="validate[funcCall[noAccStartTimeLarge]]"/>到<s:textfield name="nonAccessTimes[%{#i.index}].endTime" size="6" cssClass="validate[funcCall[noAccEndTimeSmall]]"/></s:elseif>
<s:else><s:textfield name='nonAccessTimes[%{#i.index}].date' id='exactTime[%{#i.index}]' size='10'/>从<s:textfield name="nonAccessTimes[%{#i.index}].startTime" size="6" cssClass="validate[funcCall[noAccStartTimeLarge]]"/>到<s:textfield name="nonAccessTimes[%{#i.index}].endTime" size="6" cssClass="validate[funcCall[noAccEndTimeSmall]]"/></s:else>
</td>
</tr></tbody></table></li>
</s:iterator>
</ul>

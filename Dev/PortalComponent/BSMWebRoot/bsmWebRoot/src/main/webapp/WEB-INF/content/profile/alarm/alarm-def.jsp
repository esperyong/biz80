<%@page import="com.mocha.bsm.profile.type.alarm.SendAlarmFreqEnum" %>
<%@page import="com.mocha.bsm.commonrule.common.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
	<link type="text/css" href="${ctx}/css/jquery-ui/jquery.ui.datepicker.css" rel="stylesheet" />
	<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
	<script>
	var path = "${ctx}";
	var ruleId = "${ruleId}";
	var moduleId = "${commonRule.basicInfo.moduleId}";
	var constants_daliy = "<%=SendAlarmFreqEnum.DAILY%>";
	var constants_weekly = "<%=SendAlarmFreqEnum.WEEKLY%>";
	var constants_figurely = "<%=SendAlarmFreqEnum.FIGURELY%>";
	</script>
	<%@ include file="/WEB-INF/common/userinfo.jsp" %>
	<title>告警规则定义</title>
<style>
.addBackground {
	background:gray;
	color:white;
}
.timeEntry_control {
 vertical-align: middle;
 margin-left: 1px;
}
.timeEntry_wrap{
} 
</style>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form name="formname" id="formname" method="post">
<input type="hidden" name="ruleId" value="${ruleId}" id="ruleId"/>
<input type="hidden" name="commonRule.basicInfo.start" value="${commonRule.basicInfo.start}"/>
<input type="hidden" name="commonRule.basicInfo.moduleId" id="moduleId" value="${commonRule.basicInfo.moduleId}"/>
<s:if test="commonRule.basicInfo.createUserId != null">
<input type="hidden" name="commonRule.basicInfo.createUserId" value="${commonRule.basicInfo.createUserId}"/>
</s:if>
<s:else>
<input type="hidden" name="commonRule.basicInfo.createUserId" value="<s:property value="%{@com.mocha.bsm.profile.business.admin.UserMgr@getCurrentUserId()}"/>"/>
</s:else>
<input type="hidden" name="click_btn_type" value=""/>
<!-- 废弃的按钮
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">application_button</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param> -->
<page:applyDecorator name="popwindow" title="告警规则定义">
	<page:param name="width">650px;</page:param>
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">confirm_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>

	
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="content">
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">one</page:param>
		<page:param name="title">基本信息</page:param>
		<page:param name="height">590px</page:param>
		<page:param name="width">650px</page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
			<div>
				<fieldset class="blue-border" style="width:600px">
				<legend>告警基本信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="field"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/><s:text name="i18n.profile.space"/></span>
						<span><s:text name="i18n.profile.colon"/></span>
						<span>
							<s:if test="ruleDomainId != null">
								<input type="hidden" name="commonRule.basicInfo.userDomainId" value="${ruleDomainId}"/>
								<s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDoMainNameById(ruleDomainId)"/>
							</s:if>
							<s:else>
								<s:if test="ruleId != null">
									<input type="hidden" name="commonRule.basicInfo.userDomainId" value="${commonRule.basicInfo.userDomainId}"/>
									<s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDoMainNameById(commonRule.basicInfo.userDomainId)"/>
								</s:if>
								<s:else>
									<s:select name="commonRule.basicInfo.userDomainId"  list="doMainList" listKey="key"  listValue="value" value="commonRule.basicInfo.userDomainId"/>    
								</s:else>
							</s:else>
						</span>
						
					</li>
					<li>
						<span class="field">规则名称</span>
						<span><s:text name="i18n.profile.colon"/></span>
						<span><input type="text" id="ruleName" name="commonRule.basicInfo.ruleName" value="${commonRule.basicInfo.ruleName}" class="validate[required[规则名称],length[0,50,规则名称],noSpecialStr[规则名称],ajax[duplicateName]]"/><span class="red">*</span>
					</span>
					</li>
					<li>
						<span class="field">备注</span>
						<span><s:text name="i18n.profile.colon"/></span>
						<span><s:textarea name="commonRule.basicInfo.ruleDesc" cols="80" rows="3"  cssClass="validate[length[0,200,备注]]"/></span>
					</li>
				</ul>
				</fieldset>
				<fieldset class="blue-border" style="width:600px">
				<legend>接收信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="field">接收方式<span class="red">*</span></span>
						<span>&nbsp;<s:text name="i18n.profile.colon"/></span>
						<span>
						<s:iterator id="id" value="alarmsMethods" status="st">
							<s:iterator id="obj" value="commonRule.basicInfo.sendMethod" status="status">
								<s:if test="#id.key == #obj">
									<s:set name="tempValue" value="true"/>
								</s:if>
							</s:iterator>
							<input type="checkbox" name="commonRule.basicInfo.sendMethod" value="${id.key }" class="validate[minCheckbox[1]]" id="send_Method" <s:if test="#tempValue == true">checked</s:if> /><span>${id.value }</span>
							<s:set name="tempValue" value="false"/>
						</s:iterator>
						 
						 <%--<s:checkboxlist name="commonRule.basicInfo.sendMethod" list="alarmsMethods" listKey="key" listValue="value" value="commonRule.basicInfo.sendMethod" cssClass="validate[minCheckbox[1]]" />--%>
						</span>
					</li>
					<li>
						<span class="field">接收人员</span> 
						<span><s:text name="i18n.profile.colon"/></span>
						<span>
							<s:select id="receiveUserIds" name="commonRule.receiver.receiveUserIds"  list="commonRule.receiver.receiveUserNames" listKey="key"  listValue="value"  multiple="true"  size="3"  cssStyle="width:300px;height:80px;" cssClass="validate[required]" value=""/>  
							<span class="red" style="padding-top:30px;">*</span>
						</span>
						<div class="for-inline">
							<span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a id="common_selectUser_button" style="cursor:pointer;">添加</a></span></span></span>
							<span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a id="common_deleteUser_button" style="cursor:pointer;">删除</a></span></span></span>
						</div>
						
						
					</li>
				</ul>
				</fieldset>
				<fieldset class="blue-border" style="width:600px">
				<legend>告警条件</legend>
				<ul class="fieldlist-n">
					<li id="li_SendImmediately">
						<span class="field">发送条件</span>
						<span><s:text name="i18n.profile.colon"/></span>
						<span><input name="commonRule.commonRuleCondition.sendCondition" type="radio" value="SendImmediately" 
								<s:if test="commonRule.commonRuleCondition.sendCondition == 'SendImmediately'">
										checked
								</s:if>
							 />事件触发告警后，立即发送告警。
						</span>
					</li>
					<li id="li_PeriodicalCondition">
						<span class="field"><s:text name="i18n.profile.space"/></span> 
						<span><s:text name="i18n.profile.colon"/></span>
						<span>
							<input name="commonRule.commonRuleCondition.sendCondition" type="radio" value="PeriodicalCondition" 
								<s:if test="commonRule.commonRuleCondition.sendCondition == 'PeriodicalCondition'">
										checked
								</s:if>
							/> 同一事件触发的告警，间隔
							<s:textfield name="commonRule.commonRuleCondition.periodical.interval"  id="sdc_1" size="2" cssClass="validate[onlyPositiveNumber]" />
							<s:select name="commonRule.commonRuleCondition.periodical.intervalUnit" list="@com.mocha.bsm.profile.type.alarm.TimeEnum@values()" listKey="key" listValue="value" value="commonRule.commonRuleCondition.periodical.intervalUnit" />
							连续发送，直到告警被确认 。
						</span>
					</li>
					<li id="li_TimeRangeCondition">
						<span class="field"><s:text name="i18n.profile.space"/></span> 
						<span><s:text name="i18n.profile.colon"/></span>
						<span>
							<input name="commonRule.commonRuleCondition.sendCondition" type="radio" value="TimeRangeCondition" 
								<s:if test="commonRule.commonRuleCondition.sendCondition == 'TimeRangeCondition'">
										checked
								</s:if>
							/>
							<s:textfield name="commonRule.commonRuleCondition.timeRange.timeRange"  id="sdc_2" size="2" cssClass="validate[onlyPositiveNumber]" />
							<s:select name="commonRule.commonRuleCondition.timeRange.rangeUnit" list="@com.mocha.bsm.profile.type.alarm.TimeEnum@values()" listKey="key" listValue="value" value="commonRule.commonRuleCondition.timeRange.rangeUnit" />
							内产生的同一事件，触发的告警只发送一次。
						</span>
					</li>
					<li id="li_MaxLogCondition">
						<span class="field">发送条件</span> 
						<span><s:text name="i18n.profile.colon"/></span>
						<span>
						<input type="checkbox" name="commonRule.commonRuleCondition.maxLog.checked" value="true"
						 <s:if test="commonRule.commonRuleCondition.maxLog.checked == true">checked</s:if> 
						 id="log_condition" class="validate[minCheckbox[1]]"/>条件1：产生的日志事件在
							<s:textfield name="commonRule.commonRuleCondition.maxLog.period"  id="max_1" size="2" cssClass="validate[onlyNumber]" />
							<input type="hidden" name="commonRule.commonRuleCondition.maxLog.periodUnit" value="M"/>
							分钟内发生的次数大于
							<s:textfield name="commonRule.commonRuleCondition.maxLog.maxNumber"  id="max_2" size="2" cssClass="validate[onlyNumber]" />
							次
						</span>
					</li>
					<li id="li_MinLogCondition">
						<span class="field"><s:text name="i18n.profile.space"/></span> 
						<span><s:text name="i18n.profile.colon"/></span>
						<span>
						<input type="checkbox" name="commonRule.commonRuleCondition.minLog.checked" value="true"
						 <s:if test="commonRule.commonRuleCondition.minLog.checked == true">checked</s:if> 
						 id="log_condition" class="validate[minCheckbox[1]]"/>条件2：产生的日志事件在
							<s:textfield name="commonRule.commonRuleCondition.minLog.period"  id="min_1" size="2" cssClass="validate[onlyNumber]" />
							<input type="hidden" name="commonRule.commonRuleCondition.minLog.periodUnit" value="M"/>
							分钟内发生的次数小于
							<s:textfield name="commonRule.commonRuleCondition.minLog.minNumber"  id="min_2" size="2" cssClass="validate[onlyNumber]" />
							次
						</span>
					</li>
					<li id="li_MaxAndMin">
						<span class="field">发送次数</span> 
						<span><s:text name="i18n.profile.colon"/></span>
						<span>
						同一条件连续满足时
						<s:select id="maxLog_checkSend" name="commonRule.commonRuleCondition.maxLog.checkSend" list="#{'false':'仅发送一次', 'true':'连续发送'}"></s:select>
						<input type="hidden" name="commonRule.commonRuleCondition.minLog.checkSend" id="min_send" value="${commonRule.commonRuleCondition.maxLog.checkSend}"/>
						<input type="hidden" name="commonRule.commonRuleCondition.sendCondition" value="MaxLogCondition"/>
						
						报警
						</span>
					</li>
				</ul>
				</fieldset>
				<fieldset class="blue-border" style="width:600px" id="over_period">
					<legend>
					<s:checkbox name="commonRule.basicInfo.enable" id="upgrade_checkbox" value="commonRule.basicInfo.enable"/>
					告警升级
					</legend>
					
					<ul class="fieldlist-n" id="upgrade_ul" <s:if test="commonRule.basicInfo.enable != true">style="display:none;"</s:if>>
						<li id="li_OverPeriodCondition">
						<span class="field">升级条件<span class="red">*</span></span>
						<span>&nbsp;<s:text name="i18n.profile.colon"/></span>
						<span><input type="checkbox" name="commonRule.commonRuleCondition.overPeriod.checked" value="true" <s:if test="commonRule.commonRuleCondition.overPeriod.checked == true">checked</s:if> id="upgrade_condition"/>
							   事件超过
							 
							 <s:textfield name="commonRule.commonRuleCondition.overPeriod.period"  id="sdc_3" size="2" cssClass="validate[onlyNumber]" />
							 <s:select name="commonRule.commonRuleCondition.overPeriod.periodUnit" list="@com.mocha.bsm.profile.type.alarm.TimeEnum@values()" listKey="key" listValue="value" value="commonRule.commonRuleCondition.overPeriod.periodUnit" />
							 以上没有恢复时发送告警。 
						</span>
						</li>
						<li id="li_PeriodCountCondition">
							<span class="field"><s:text name="i18n.profile.space"/></span> 
							<span><s:text name="i18n.profile.colon"/></span>
							<span>
								<input type="checkbox" name="commonRule.commonRuleCondition.periodCount.checked" value="true" <s:if test="commonRule.commonRuleCondition.periodCount.checked == true">checked</s:if> id="upgrade_condition"/>
								事件在 
								<s:textfield name="commonRule.commonRuleCondition.periodCount.period"  id="sdc_4" size="2" cssClass="validate[onlyNumber]" />
								<s:select name="commonRule.commonRuleCondition.periodCount.periodUnit" list="@com.mocha.bsm.profile.type.alarm.TimeEnum@values()" listKey="key" listValue="value" value="commonRule.commonRuleCondition.periodCount.periodUnit" />
								内发生<s:textfield name="commonRule.commonRuleCondition.periodCount.sendCount"  id="sdc_5" size="2" cssClass="validate[onlyNumber]" />次时才发送告警。
							 </span>
						 </li>
						 <li>
							 <span class="field">升级人员</span> 
							 <span><s:text name="i18n.profile.colon"/></span>
							 <span>
							 	<s:select id="upgradeUserIds" name="commonRule.receiver.upgradeUserIds"  list="commonRule.receiver.upgradeUserNames" listKey="key"  listValue="value"  multiple="true"  size="3"  cssStyle="width:300px;height:60px;" value=""/>
							 	<span class="red" style="padding-top:30px;">*</span>
							 </span>
							 <div class="for-inline">
								<span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a id="upgrade_selectUser_button" style="cursor:pointer;">添加</a></span></span></span>
								<span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a id="upgrade_deleteUser_button" style="cursor:pointer;">删除</a></span></span></span>
							</div>
						 </li>
					</ul>
					 
				</fieldset>
			</div>
		</page:param>
	</page:applyDecorator>
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">two</page:param>
		<page:param name="title">发送告警时间</page:param>
		<page:param name="height">300px</page:param>
		<page:param name="width">650px</page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="display">collect</page:param>
		<page:param name="content">
		<div class="fold-content">
		
			<div class="select-lr" style="width:600px">
				<div class="h1">
					<s:radio id="key" name="commonRule.timePeriod.timeType" list="@com.mocha.bsm.profile.type.alarm.SendAlarmTypeEnum@values()" listKey="key" listValue="value" value="commonRule.timePeriod.timeType"/>
				</div>
				<div id="alarmtimePeriod" <s:if test="commonRule.timePeriod.timeType=='ANYTIME'">style="display:none;"</s:if>>
				<div class="left" style="width:250px">
					<div class="h2">
						<s:radio id="key" name="commonRule.timePeriod.timeFrequency" list="@com.mocha.bsm.profile.type.alarm.SendAlarmFreqEnum@values()" listKey="key" listValue="value"/>
					</div>
					<div id="week" class="h1" style="display:none;">
						<s:select name="weekly" list="@com.mocha.bsm.profile.type.alarm.WeekEnum@values()" listKey="key" listValue='value' />               
					</div>
					<div id="date" class="h1" style="display: none;">
						日期<s:text name="i18n.profile.colon"/><input id="datepicker" name="figurely" type="text" size="10" readonly="readonly" class="validate[funcCall[validateFigruely]]"/><!-- <span class="ico ico-date"></span> -->
					</div>
					<div id="time">
						从<s:textfield name="startTime" id="startTime" cssStyle="width:80px" value="09:00:00"/>
						至<s:textfield name="endTime" id="endTime" cssStyle="width:80px" value="10:00:00"/>
					</div>
				</div>
				<div class="middle">
					<span id="pre_right" class="turn-right"></span>
					<span id="pre_left" class="turn-left"></span>
				</div>
				<div class="right" style="width:250px">
					<s:if test="commonRule.timePeriod.onLineTimes == null">
						<input type="hidden" name="array_index" value="0"/>
					</s:if>
					<s:iterator id="id" value="commonRule.timePeriod.onLineTimes" status="st">
						<div id="addDiv_${st.index}" class="h1" style="cursor:pointer;">
							<input type="hidden" name="commonRule.timePeriod.onLineTimes[${st.index}].timeFrequency" value="${id.timeFrequency}"/>
							<input type="hidden" name="commonRule.timePeriod.onLineTimes[${st.index}].dateTime" value="${id.dateTime}"/>
							<input type="hidden" name="commonRule.timePeriod.onLineTimes[${st.index}].startTime" value="${id.startTime}"/>
							<input type="hidden" name="commonRule.timePeriod.onLineTimes[${st.index}].endTime" value="${id.endTime}"/>
							<s:if test="#st.last">
								<input type="hidden" name="array_index" value="${st.index}"/>
							</s:if>
							<s:property value="#id.text"/>
						</div>
					</s:iterator>
				
				</div>
				</div>
			</div>
			</div>
	</page:param>
	</page:applyDecorator>
	</page:param>
</page:applyDecorator>
</form>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script> 
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/profile/alarm/alarmDef.js"></script>

<script type="text/javascript">
//各模块显示警告事件的权限
var power={"BSM_PROFILE":{'SendImmediately':true,'PeriodicalCondition':true,'TimeRangeCondition':true,'MaxLogCondition':false,
		'MinLogCondition':false,'OverPeriodCondition':true,'PeriodCountCondition':true},
		"MODULEID_BIZSERVICE":{'SendImmediately':true,'PeriodicalCondition':true,'TimeRangeCondition':true,'MaxLogCondition':false,
		'MinLogCondition':false,'OverPeriodCondition':true,'PeriodCountCondition':true},
		"MODULEID_ROOM":{'SendImmediately':true,'PeriodicalCondition':true,'TimeRangeCondition':true,'MaxLogCondition':false,
		'MinLogCondition':false,'OverPeriodCondition':true,'PeriodCountCondition':true},
		"MODULEID_NTA":{'SendImmediately':true,'PeriodicalCondition':true,'TimeRangeCondition':true,'MaxLogCondition':false,
		'MinLogCondition':false,'OverPeriodCondition':false,'PeriodCountCondition':true},
		"SCRIPTMONITOR":{'SendImmediately':true,'PeriodicalCondition':true,'TimeRangeCondition':true,'MaxLogCondition':false,
		'MinLogCondition':false,'OverPeriodCondition':false,'PeriodCountCondition':true},
		"MODULEID_SYSLOG":{'SendImmediately':false,'PeriodicalCondition':false,'TimeRangeCondition':false,'MaxLogCondition':true,
		'MinLogCondition':true,'OverPeriodCondition':false,'PeriodCountCondition':false},
		"MODULEID_COMMONLOG":{'SendImmediately':false,'PeriodicalCondition':false,'TimeRangeCondition':false,'MaxLogCondition':true,
		'MinLogCondition':true,'OverPeriodCondition':false,'PeriodCountCondition':false}
		};
$(function(){

	showWarn("${commonRule.basicInfo.moduleId}");

	$("#min_send").val($("#maxLog_checkSend").val());
	
	$("#maxLog_checkSend").change(function(){
		 $("#min_send").val(this.value);
		});
		
		
		
	});

function showWarn(moduleId){
	var powerKeys=['SendImmediately','PeriodicalCondition','TimeRangeCondition','MaxLogCondition',
			'MinLogCondition','OverPeriodCondition','PeriodCountCondition'];
	if(power[moduleId]!=undefined && power[moduleId]!=null && power[moduleId]!=""){

		for(var i=0 ;i<powerKeys.length ;i++){
			if(!power[moduleId][powerKeys[i]]){
				document.getElementById("li_"+powerKeys[i]).innerHTML="";
				document.getElementById("li_"+powerKeys[i]).style.display="none";
			}
		}
		
		
		if(!power[moduleId]["MaxLogCondition"] && !power[moduleId]["MaxLogCondition"]){
			document.getElementById("li_MaxAndMin").innerHTML="";
			document.getElementById("li_MaxAndMin").style.display="none";
		}
		if(!power[moduleId]["OverPeriodCondition"] && !power[moduleId]["PeriodCountCondition"]){
			document.getElementById("over_period").innerHTML="";
			document.getElementById("over_period").style.display="none";
		}
	}else{
		document.getElementById("li_MaxLogCondition").innerHTML="";
		document.getElementById("li_MaxLogCondition").style.display="none";
		document.getElementById("li_MinLogCondition").innerHTML="";
		document.getElementById("li_MinLogCondition").style.display="none";
		document.getElementById("li_MaxAndMin").innerHTML="";
		document.getElementById("li_MaxAndMin").style.display="none";
	}

}


</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="gray-bg">
	<s:form id="queryform">
		<div style="overflow:hidden;" class="h1">
			<span style="float:left;height:18px;line-height:18px;">事件对象：</span>
			<s:select list="%{@com.mocha.bsm.event.common.QueryConditionFactory@eventObjects()}" name="eventQuery.resourceCategoryId" id="eventObj" listKey="key" listValue="value" headerKey="-1" headerValue="全部" cssStyle="width:200px;"/>
			<s:select list="%{@com.mocha.bsm.event.common.QueryConditionFactory@queryTypes()}" name="eventQuery.queryType" listKey="key" listValue="value" cssStyle="width:60px;"/>
			<s:textfield name="eventQuery.queryValue" cssStyle="float:left;"/>
			<span style="float:left;height:18px;line-height:18px;"><s:property value="@com.mocha.bsm.event.common.RangeName@rangeName()"/>：</span>
			<s:select list="%{@com.mocha.bsm.event.common.QueryConditionFactory@userDomains()}" name="eventQuery.userDomainID" listKey="key" listValue="value" headerKey="-1" headerValue="全部" cssStyle="width:100px;"/>
			<span style="float:left;height:18px;line-height:18px;">级别：</span>
			<s:select list="%{@com.mocha.bsm.event.common.QueryConditionFactory@serveritys()}" name="eventQuery.serverity" listKey="key" listValue="value" headerKey="-1" headerValue="全部"/>
			<span style="float:left;height:18px;line-height:18px;">平台：</span>
			<s:select list="%{@com.mocha.bsm.event.common.QueryConditionFactory@dependencySystems()}" name="eventQuery.dependencySystem" listKey="key" listValue="value" headerKey="-1" headerValue="全部" cssStyle="width:100px;"/>
		</div>
		
		<div style="overflow:hidden;" class="h1">
			<span style="float:left;height:18px;line-height:18px;">事件类型：</span>
			<span id="eventTypeList"><select id="eventTypeListSelectId" disabled="disabled"><option value='-1'>全部</option></select></span>
			<!-- s:select list="%{@com.mocha.bsm.event.common.QueryConditionFactory@eventTypes()}" name="eventQuery.eventType" listKey="key" listValue="value" headerKey="-1" headerValue="全部"/> -->
			<span style="float:left;height:18px;line-height:18px;">产生时间：</span>
			<input type="radio" name="eventQuery.timeType" value="timePoint" checked="checked" style="float:left;">
			<s:select list="%{@com.mocha.bsm.event.common.QueryConditionFactory@timePoints()}" name="eventQuery.timePoint" listKey="key" listValue="value" value="'1days'" />
			<input type="radio" name="eventQuery.timeType" value="timeRange" style="float:left;">
			<span style="float:left;height:18px;line-height:18px;">从：</span>
			<s:textfield id="startTime" name="eventQuery.startTime" cssClass="validate[funcCall[startTimeNull],funcCall[startTimeLarge]]" cssStyle="float:left;"/>
			<span style="float:left;height:18px;line-height:18px;">到：</span>
			<s:textfield id="endTime" name="eventQuery.endTime" cssClass="validate[funcCall[endTimeNull],funcCall[endTimeSmall]]" cssStyle="float:left;"/>
			<span class="ico"></span>
			<span class="black-btn-l f-absolute" style="right:2px; bottom1px;"><span class="btn-r"><span class="btn-m"><a id="export_active">导出</a></span></span></span>
		</div>
		<div class="h2">
			<span>* 资源配置、自定义事件、脚本、日志、Syslog、SNMP Trap、IP-MAC、进程、流量分析事件没有恢复事件，产生24小时后系统自动确认。</span>
			<!-- <span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="export_active">导出</a></span></span></span>  --> 
		</div>
	</s:form>
</div>
<div id="active_list">
</div>
<script type="text/javascript">
$(document).ready(function(){

    var $eventObj = $("#eventObj");
    $eventObj.bind("change", function(event) {
        var val = $(this).val();
        var url = "${ctx}/event/eventType!getEventType.action?moduleId=" + val;
        $.ajax({
            type: "GET",
            dataType:'json',
            url: url,
            success: function(data, textStatus){
                var eventTypeList = (new Function("return "+data.eventTypeJson))();
                $eventTypeList = $("#eventTypeList");
                $eventTypeList.html("");
                var arr = new Array;
                var selectId ="eventTypeListSelectId";
                
                arr.push("<select id="+selectId+" name='eventQuery.eventType'>");
                if(eventTypeList.length == 0 || eventTypeList.length > 1){
                    arr.push("<option value='-1'>全部</option>");
                }
                for(var i = 0; i < eventTypeList.length; i++){
                    arr.push("<option value='"+eventTypeList[i].key+"'>"+eventTypeList[i].value+"</option>"); 
                }
                arr.push("</select>");
                $eventTypeList.append(arr.join(""));
                var selectIdArray = new Array;
                selectIdArray.push(selectId);
                SimpleBox.renderTo(selectIdArray)
                //$eventTypeList.change();
            }
        });
        return false; 
    })
    
	$("#queryform").validationEngine({
		//promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	    //,failure : function() { callFailFunction()  } 
	});

	$.validationEngineLanguage.allRules.startTimeNull = {
		  "nname":"validateStartTimeNull",
		  "alertText":"* 起始时间不能为空"
	}
	$.validationEngineLanguage.allRules.endTimeNull = {
		  "nname":"validateEndTimeNull",
		  "alertText":"* 结束时间不能为空"
	}
	$.validationEngineLanguage.allRules.startTimeLarge = {
		  "nname":"validateTimeRange",
		  "alertText":"* 起始时间不能大于结束时间"
	}
	$.validationEngineLanguage.allRules.endTimeSmall = {
		  "nname":"validateTimeRange",
		  "alertText":"* 结束时间不能小于起始时间"
	}
	
	$(".ico").bind("click", function(){
		submitForm();
	});
	
	$("#startTime","#queryform").bind("click", function(){
		WdatePicker({
			//startDate:getDate(n),
			dateFmt:'yyyy/MM/dd HH:mm:ss'
		});
	});
	
	$("#endTime","#queryform").bind("click", function(){
		WdatePicker({
			//startDate:getDate(n),
			dateFmt:'yyyy/MM/dd HH:mm:ss'
		});
	});
	var win = new confirm_box({
		title:'提示',
		text:'最多能导出最近1000条记录，是否继续？',
		cancle_listener:function(){win.hide();},
		confirm_listener:function(){exportActiveEvent();win.hide();}
		});
	$("#export_active").bind("click", function(){
		win.show();
	});
	submitForm();
});

function time() {
	
}

function validateStartTimeNull() {
	var timeType = $("input[name='eventQuery.timeType']:checked","#queryform").val();
	var startTimeValue = $("input[name='eventQuery.startTime']","#queryform").val();
	if((timeType == "timeRange") && (startTimeValue == "")){
		return true;
	}
	return false;
}

function validateEndTimeNull() {
	var timeType = $("input[name='eventQuery.timeType']:checked","#queryform").val();
	var endTimeValue = $("input[name='eventQuery.endTime']","#queryform").val();
	if((timeType == "timeRange") && (endTimeValue == "")){
		return true;
	}
	return false;
}

function validateTimeRange() {
	var timeType = $("input[name='eventQuery.timeType']:checked","#queryform").val();
	var startTimeValue = $("input[name='eventQuery.startTime']","#queryform").val();
	var endTimeValue = $("input[name='eventQuery.endTime']","#queryform").val();
	if(timeType == "timeRange"){
		if(startTimeValue != "" && endTimeValue != ""){
			if(startTimeValue > endTimeValue){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}
	return false;
}

function openEventExportPrompt() {
	var src = "${ctx}/event/eventExport.action";
	var width=350;
	var height=130;
	return window.showModalDialog(src,window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}

function exportActiveEvent() {
	$("#hiddenForm_active").attr("action", "${ctx}/event/eventExport!export.action?type=active");
	$("#hiddenForm_active").submit();
}

function submitForm() {
	//$.blockUI({message:$('#loading')});
	if(!$.validate( $("#queryform") )) return;
	var ajaxParam = $("#queryform").serialize();
	$.ajax({
		type: "POST",
		dataType:'html',
		url: "${ctx}/event/eventManage!activeEventList.action",
		data: ajaxParam,
		success: function(data, textStatus){
			$active_list_div = $("#active_list");
			$active_list_div.find("*").unbind();
			$active_list_div.html(data);
		}
	});
	//$.unblockUI();
}

settings = {
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	    //,failure : function() { callFailFunction()  } 
		}	
$.validate = function(form){
	$.validationEngine.onSubmitValid = true;
    if($.validationEngine.submitValidation(form,settings) == false){
        if($.validationEngine.submitForm(form,settings) == true){
        	return false;
        }else{
        	return true;
        }
    }else{
       settings.failure && settings.failure(); 
       return false;
    }
};
SimpleBox.renderAll();
</script>
</html>
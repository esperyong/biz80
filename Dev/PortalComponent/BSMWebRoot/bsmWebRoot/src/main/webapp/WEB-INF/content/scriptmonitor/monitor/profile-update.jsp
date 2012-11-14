<!-- WEB-INF\content\location\relation\batchAdd.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ page import="com.mocha.bsm.script.monitor.obj.monitor.type.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp"%>
<title>脚本监控设置</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js"
	type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/jquery.select.js"></script>
<s:if test="#request.succeed==true">
	<script type="text/javascript">
//新建区域完成，刷新父页面
returnValue="true";
window.close();
</script>
</s:if>
<script type="text/javascript">
var profileId = "${scriptProfile.profileId}";
function newMetric(id,index){
	return "<tr><td align=\"middle\"><input type=\"checkbox\"/></td>"+
	"<td align=\"left\">第<span id=\"rowIndex\">"+(index+1)+"</span>列</td>"+
	"<td align=\"left\">"+
	"<input name=\"scriptProfile.metricList["+index+"].profileId\" value=\""+profileId+"\" type=\"hidden\"/>"+
	"<input name=\"scriptProfile.metricList["+index+"].metricId\"  value=\""+id+"\" jsName=\"metricId\" type=\"hidden\"/>"+
	"<input name=\"scriptProfile.metricList["+index+"].dataIndex\" value=\""+index+"\"type=\"hidden\"/>"+
	"<input name=\"scriptProfile.metricList["+index+"].metricName\" jsName=\"metricName\" type=\"text\" size=\"10\" />"+
	"</td>"+
	"<td align=\"left\"><select name=\"scriptProfile.metricList["+index+"].dataType\" style=\"width:80px\">"+
		<s:iterator value="@com.mocha.bsm.script.monitor.impl.profile.common.type.MetricTypeEnum@values()" >
			"<option vaule=\"${key}\">${value}</option>"+
		</s:iterator>
	"</select></td></tr>";
}

var eventIndex = 0;
function newEvent(id,index){
	return "<tr><td align=\"middle\"><input type=\"checkbox\"/>" +
				"<input name=\"scriptProfile.eventList["+index+"].profileId\" value=\""+profileId+"\" type=\"hidden\"/>"+
				"<input name=\"scriptProfile.eventList["+index+"].eventId\" value=\""+id+"\" type=\"hidden\"/>"+
			"</td>"+
			"<td align=\"middle\"><input name=\"scriptProfile.eventList["+index+"].isProduce\" value=\"true\" type=\"checkbox\"/></td>"+
			"<td align=\"left\"><input name=\"scriptProfile.eventList["+index+"].eventName\" type=\"text\" size=\"10\" /></td>"+
			"<td align=\"left\"><select name=\"scriptProfile.eventList["+index+"].lvel\">"+
				<s:iterator value="@com.mocha.bsm.script.monitor.impl.profile.common.type.LevelEnum@values()" >
					"<option vaule=\"${key}\">${key}</option>"+
				</s:iterator>
			"</select></td>"+
			"<td align=\"left\"><select name=\"scriptProfile.eventList["+index+"].priority\">"+
				<s:iterator value="@com.mocha.bsm.script.monitor.impl.profile.common.type.PriorityEnum@values()" >
					"<option vaule=\"${key}\">${key}</option>"+
				</s:iterator>
			"</select></td>"+
			"<td align=\"left\">"+
				"<select name=\"scriptProfile.eventList["+index+"].metricId\" style=\"width:80px\">"+getMetrices()+"</select>"+
				"<select name=\"scriptProfile.eventList["+index+"].operateMode\" style=\"width:40px\"/>"+
				"<input type=\"text\" name=\"scriptProfile.eventList["+index+"].threshold\" size=\"12\"/>"+
			"</td>"+
			"<td align=\"left\"><select name=\"scriptProfile.eventList["+index+"].produceMode\">"+
				<s:iterator value="@com.mocha.bsm.script.monitor.impl.profile.common.type.EventProduceEnum@values()" status="produces">
					<s:if test="#produces.index<2">
					"<option vaule=\"${key}\">${value}</option>"+
					</s:if>
				</s:iterator>
			"</select></td>"+
			"<td align=\"middle\"><input name=\"scriptProfile.eventList["+index+"].isAlarm\" value=\"true\" type=\"checkbox\"/></td></tr>";
}
var ruleIndex = 0;
function newRule(rule,index){
	return "<tr><td align=\"middle\"><input type=\"checkbox\"/>" +
				"<input name=\"scriptProfile.alarmList["+index+"].profileId\" value=\""+profileId+"\" type=\"hidden\"/>"+
				"<input name=\"scriptProfile.alarmList["+index+"].alarmRuleId\" value=\""+rule.ruleId+"\" type=\"hidden\"/>"+
			"</td>"+
			"<td align=\"middle\"><span>"+rule.ruleName+"<span></td>"+
			"<td align=\"left\"><span>"+rule.ruleDesc+"<span></td></tr>";
}
function getMetrices(){
	var options="";
	var $metricIds = $("input[jsName=\"metricId\"]");
	var $metricNames = $("input[jsName=\"metricName\"]");
	if($metricIds && $metricIds.length>0){
		for(var i=0; i<$metricIds.length; i++){
			options += "<option value=\""+$metricIds[i].value+"\">"+$metricNames[i].value+"</option>";
		}
	}
	return options;
}

var $metrics;
var $events;
var $alarmRules;
	//表单验证
	$(document).ready(function() {
		var tp = new TabPanel({id:"mytab",//isclear:true,
			listeners:{
				changeAfter:function(tab){
		        	dialogResize();
		        	//tp.loadContent(tab.index,{url:"${ctx}/location/relation/device!batchAddDevices.action?location.locationId=${location.locationId}&resType=" + resType});
		        }
        	}	
		}); 

		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false/*,
			failure: function() { 
				alert("没有添加已选设备");
			}*/
		});

		$("#selectScript").click(function (){
			var scritpId = window.showModalDialog("${ctx}/scriptmonitor/repository/scriptTemplate!selectScriptTemplates.action","help=no;status=no;scroll=yes;center=yes");
			if(scritpId){
				$.ajax({
					url:		"${ctx}/scriptmonitor/repository/scriptTemplate!getScriptById.action",
					data:		"scriptTemplate.id="+scritpId,
					dataType:	"json",
					cache:		false,
					success: function(data, textStatus){
						$("input[name=scriptProfile.scriptId]").val(data.scriptTemplate.id);
						$("input[name=scriptTemplate.name]").val(data.scriptTemplate.name);
						$("input[name=scriptTemplate.filePath]").val(data.scriptTemplate.filePath);
						// 设置脚本参数
						if(data.scriptTemplate.scriptParameters){
							var scriptParams = data.scriptTemplate.scriptParameters;
							$("#params").clearAll().addOptions(scriptParams,"key","name");

							$.ajax({
								url:		"${ctx}/scriptmonitor/repository/scriptPropfile!createIds.action",
								data:		"idsCount="+scriptParams.length,
								dataType:	"json",
								cache:		false,
								success: function(data, textStatus){
									
									var paramValues="";
									
									for(var i=0; i<scriptParams.length; i++){
										paramValues+="<li><span class=\"field\">" + scriptParams[i].name + "</span>"+
														"<input name=\"scriptProfile.sptParameterList["+i+"].profileId\" value=\""+profileId+"\" type=\"hidden\"/>"+
														"<input name=\"scriptProfile.sptParameterList["+i+"].parameterId\" value=\""+scriptParams[i].key+"\" type=\"hidden\"/>"+
														"<input name=\"scriptProfile.sptParameterList["+i+"].parameterValue\" value=\""+scriptParams[i].parameter.defaultValue+"\"/></li>";
									}
									$("#paramValues").html("").append(paramValues);
									dialogResize();
								}
							});
						}
					}
				});
			}
		});
		
		$("#closeId").click(function (){
			window.close();
		});
		
		$metrics = $("#metrics");
		$("#createMetrics").click(function(){
			var values = $("input[name=\"runResult\"]").val().split(",");
			$.ajax({
				url:		"${ctx}/scriptmonitor/repository/scriptPropfile!createIds.action",
				data:		"idsCount="+values.length,
				dataType:	"json",
				cache:		false,
				success: function(data, textStatus){
					
					for(var i=0;i<values.length; i++){
						$metrics.append(newMetric(data.ids[i],i));
					}
					$metrics.show();
				}
			});
		})
		
		$("#delMetrics").click(function(){
			$("input:checkbox:checked",$metrics).parents("tr").remove();
		})
		
		$events = $("#events");
		$("#delEvent").click(function(){
			$("input:checkbox:checked",$events).parents("tr").remove();
		});
		
		$("#addEvent").click(function(){
			$.ajax({
				url:		"${ctx}/scriptmonitor/repository/scriptPropfile!createIds.action",
				data:		"idsCount=1",
				dataType:	"json",
				cache:		false,
				success: function(data, textStatus){
					$events.append(newEvent(data.ids[0],eventIndex++)).show();
				}
			});
		});
		
		$alarmRules=$("#alarmRules");
		$("#delAlarmRules").click(function(){
			//$("input:checkbox:checked",$events).parents("tr").remove();
		});
		
		$("#addAlarmRules").click(function(){
			var height = "700";
			var width = "630";
			var left = event.pageX-width;
			var top = event.pageY+height/2;
			window.open("${ctx}/profile/alarm/alarmDef.action?moduleId=MODULEID_ROOM", "alarmDefWindowSJ", "height="+height+", width="+width+",left="+left+",top="+top+",toolbar=no,menubar=no,scrollbars=auto,resizable=no,location=no,status=no");
		});
		
		$("#submit").click(function (){
			$("#params option").attr("selected", true);
			var action = $("#addForm").attr("action");
			$("#addForm").attr("action",action+"?profileList.pageNumber=1").submit();
		});
		
		$("#cancel").click(function(){
			window.close();
		});
	});
	//刷新页面
	function reloadParentPage(ruleId){
		$.ajax({
			url:		"${ctx}/scriptmonitor/repository/scriptPropfile!queryRule.action",
			data:		"rule.ruleId=" + ruleId,
			dataType:	"json",
			cache:		false,
			success: function(data, textStatus){
				$alarmRules.append(newRule(data.rule,ruleIndex++)).show();
			}
		});
	}
	$(document).ready(function(){
		$("#frequencyId").change(function(){
			var type = $(this).val();
			var $week = $("#frequencyWeek");
			var $month = $("#frequencyMonth");
			var $time = $("#monitorTime");
			if(type=="EVERY_DAY"){
				$week.hide().attr("disabled","true");
				$month.hide().attr("disabled","true");
				$time.show().removeAttr("disabled");
			}else if(type=="EVERY_WEEK"){
				$week.show().removeAttr("disabled");
				$month.hide().attr("disabled","true");
				$time.show().removeAttr("disabled");
			}else if(type=="EVERY_MONTH"){
				$week.hide().attr("disabled","true");
				$month.show().removeAttr("disabled");
				$time.show().removeAttr("disabled");
			}else{
				$week.hide().attr("disabled","true");
				$month.hide().attr("disabled","true");
				$time.hide().attr("disabled","true");
			}
		});
	});
</script>
</head>

<body>

<page:applyDecorator name="popwindow" title="添加监控">

	<page:param name="width">800px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>

	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">app</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>

	<page:param name="content">

		<s:form id="addForm"
			action="/scriptmonitor/repository/scriptPropfile!update.action">

			<page:applyDecorator name="tabPanel">
				<page:param name="id">mytab</page:param>

				<page:param name="tabBarWidth">800</page:param>
				<page:param name="width">780</page:param>
				<page:param name="background">white</page:param>
				<page:param name="cls">tab-grounp</page:param>
				<page:param name="current">1</page:param>
				<page:param name="tabHander">[{text:"常规信息",id:"basicinfo"},{text:"指标定义",id:"metricinfo"},{text:"事件定义",id:"eventinfo"},{text:"告警定义",id:"alarminfo"}]</page:param>
				<!--　策略定义　-->
				<page:param name="content_1">
					<div class="blackbg01"><span class="ico ico-tips"></span>说明：脚本监控的前提是监控服务器能与被监控设备网络连接，否则无法进行脚本监控。</div>
					<div class="greytable-titlebg"><span class="greytable-titlebg-ico"></span><b>选择脚本</b></div>
					<s:hidden name="scriptProfile.profileId" />
					<div>
					<ul class="fieldlist-n">
						<li><span class="field-middle">域</span><span>：</span> <s:select
							name="scriptProfile.domainId" id="domainId" list="domains"
							listKey="ID" listValue="name" headerKey="-1" headerValue="请选择" value="%{scriptProfile.domainId}"></s:select><span
							class="red">*</span>
						<li><span class="field-middle">脚本名称</span><span>：</span> <s:hidden
							name="scriptProfile.scriptId" /> <s:textfield
							name="scriptTemplate.name" cssClass="validate[required]" disabled="true" value="%{scriptProfile.scriptTemplate.name}"></s:textfield><span
							class="red">*</span> <span id="selectScript" class="ico"></span>
						</li>
						<li><span class="field-middle">脚本库路径及文件名</span><span>：</span> <s:textfield
							name="scriptTemplate.filePath" disabled="true" value="%{scriptProfile.scriptTemplate.filePath}"></s:textfield>
						</li>
						<li><span class="field-middle" style="float:left;">脚本参数选择</span><span style="float:left;">：</span>
						<s:select style="width:150px; height:100px; y-overflow:scroll; margin-left:10px; float:left;" id="params" name="params" size="6"
							multiple="true" list="parameters" listKey="parametekey" listValue="parameteName">
						</s:select>
						</li>
						
						<li>
						<span class="field-middle">执行频度</span><span>：</span>
						<s:select name="scriptProfile.frequencyId" id="frequencyId" list="frequencys" listKey="key" listValue="value"></s:select>
						
						<s:if test="scriptProfile.frequencyId=='EVERY_WEEK'">
						<s:select name="scriptProfile.frequencyDay" id="frequencyWeek" list="{1,2,3,4,5,6,7}"></s:select>
						</s:if>
						<s:else>
						<s:select disabled="true" name="scriptProfile.frequencyDay" id="frequencyWeek" list="{1,2,3,4,5,6,7}" style="display:none"></s:select>
						</s:else>
						
						<s:if test="scriptProfile.frequencyId=='EVERY_MONTH'">
						<s:select name="scriptProfile.frequencyDay" id="frequencyMonth" list="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}"></s:select>
						</s:if>
						<s:else>
						<s:select disabled="true" name="scriptProfile.frequencyDay" id="frequencyMonth" list="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}" style="display:none"></s:select>
						</s:else>
						
						<s:if test="scriptProfile.frequencyId=='EVERY_DAY'||scriptProfile.frequencyId=='EVERY_WEEK'||scriptProfile.frequencyId=='EVERY_MONTH'">
						<s:textfield name="scriptProfile.monitorTime" id="monitorTime" value="12:10:00"></s:textfield>
						</s:if>
						<s:else>
						<s:textfield disabled="true" name="scriptProfile.monitorTime" id="monitorTime" value="%{scriptProfile.monitorTime}" style="display:none"></s:textfield>
						</s:else>
						</li>
						
						<li><span class="field-middle">备注</span><span>：</span> <s:textarea
							name="scriptProfile.remark" rows="4" cols='40' value="%{scriptProfile.remark}"></s:textarea></li>
						<li><span class="field-middle"></span></li>
					</ul>
					</div>
					<div class="greytable-titlebg"><span
						class="greytable-titlebg-ico"></span><b>参数设置</b> <span
						class="black-btn-l f-right"><span class="btn-r"><span
						class="btn-m" id="execute"> <a>脚本测试</a></span></span></span></div>
					<div id="paramValues">		
				<s:iterator value="parameters" status="status">		
					<li><span class="field"><s:property value='parameteName'/></span>
						<input name="scriptProfile.sptParameterList[<s:property value="#status.index"/>].profileId" value="<s:property value='profileId'/>" type="hidden"/>
						<input name="scriptProfile.sptParameterList[<s:property value="#status.index"/>].parameterId" value="<s:property value='proParameterId'/>" type="hidden"/>
						<input name="scriptProfile.sptParameterList[<s:property value="#status.index"/>].parameterValue" value="<s:property value='proParameterValue'/>"/>
					</li>
				</s:iterator>
			</div>
				</page:param>
				<!--　指标定义　-->
				<page:param name="content_2">
					<div class="blackbg01"><span class="ico ico-help"></span>说明：待定...。</div>
					<div class="greytable-titlebg"><span
						class="greytable-titlebg-ico"></span><b>脚本返回值</b></div>
					<div>
					<ul class="fieldlist-n">
						<li><span class="field-middle">脚本参数：</span> <s:textfield
							name="scriptParam"></s:textfield><span
							class="black-btn-l  multi-line"> <span class="btn-r">
						<span class="btn-m"><a>获取返回值</a></span> </span> </span><span class="red">*</span>(最多获取500字符)</li>
						<li><span class="field-middle multi-line"></span> <s:textfield
							name="runResult" value="aa,11,bb" size="58"></s:textfield></li>
					</ul>
					</div>
					<div class="greytable-titlebg"><span
						class="greytable-titlebg-ico"></span><b>指标定义</b></div>
					<div>
					<ul class="fieldlist-n">
						<li><span class="field-middle">分隔符：</span><s:textfield
							name="split" cssClass="validate[required]" value=","></s:textfield>
						<span class="ico ico-what"></span> <span id="createMetrics"
							class="black-btn-l  multi-line"> <span class="btn-r">
						<span class="btn-m"><a>生成指标</a></span> </span> </span><span class="red">*</span>(最多支持10列，每列最多支持50字符)
						<span id="delMetrics" class="panel-gray-ico panel-gray-ico-close"></span>
						<span id="addMetrics" class="panel-gray-ico panel-gray-ico-add"></span>
						</li>
					</ul>
					</div>
					<div style="margin: 10px;" class="greywhite-border">
					<table class="hundred">
						<thead>
							<tr class="monitor-items-head">
								<th width="10%">&nbsp;</th>
								<th>返回值</th>
								<th>指标名称</th>
								<th>类型</th>
							</tr>
						</thead>
						<tbody id="metrics">
						</tbody>
					</table>
					</div>
				</page:param>
				<!--事件定义-->
				<page:param name="content_3">
					<div class="blackbg01"><span class="ico ico-help"></span>说明：待定...。</div>
					<li><span id="delEvent"
						class="panel-gray-ico panel-gray-ico-close"></span> <span
						id="addEvent" class="panel-gray-ico panel-gray-ico-add"></span></li>
					<table class="hundred">
						<thead>
							<tr class="monitor-items-head">
								<th width="4%"><input type='checkbox' name='checkAll'
									id='checkAllId' style='cursor: pointer' /></th>
								<th width="8%">是否产生</th>
								<th width="15%">事件名称</th>
								<th width="10%">级别</th>
								<th width="8%">优先级</th>
								<th width="30%">条件</th>
								<th>产生规则</th>
								<th>是否告警</th>
							</tr>
						</thead>
						<tbody id="events">
						</tbody>
					</table>
				</page:param>
				<!--告警定义-->
				<page:param name="content_4">
					<div class="blackbg01"><span class="ico ico-help"></span>说明：待定...。</div>
					<div class="greytable-titlebg"><span
						class="greytable-titlebg-ico"></span><b>激活告警</b></div>
					<div>
					<ul class="fieldlist-n">
						<li><input name="scriptProfile.alarmActived" value="true"
							type="checkbox" />激活告警</li>
					</ul>
					</div>
					<div class="greytable-titlebg"><span
						class="greytable-titlebg-ico"></span><b>报警规则</b></div>
					<li><span id="delAlarmRules"
						class="panel-gray-ico panel-gray-ico-close"></span> <span
						id="addAlarmRules" class="panel-gray-ico panel-gray-ico-add"></span>
					</li>
					<div style="margin: 10px;" class="greywhite-border">
					<table class="hundred">
						<thead>
							<tr class="monitor-items-head">
								<th width="10%">&nbsp;</th>
								<th>规则名称</th>
								<th>备注</th>
							</tr>
						</thead>
						<tbody id="alarmRules">
						</tbody>
					</table>
					</div>
				</page:param>
			</page:applyDecorator>
		</s:form>
	</page:param>
</page:applyDecorator>
</body>
</html>
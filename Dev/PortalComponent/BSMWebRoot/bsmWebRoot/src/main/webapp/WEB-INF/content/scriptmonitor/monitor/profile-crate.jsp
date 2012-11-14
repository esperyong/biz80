<!-- WEB-INF\content\location\relation\batchAdd.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ page import="com.mocha.bsm.script.monitor.obj.monitor.type.*" %>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<s:if test="#parameters.flag == null">
	<s:set name="titleName" value="\"编辑监控\"" scope="request"/>
</s:if>
<s:else>
	<s:set name="titleName" value="\"添加监控\"" scope="request"/>
</s:else>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<title>脚本监控设置</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/jquery-ui/jquery.ui.datepicker.css" rel="stylesheet" type="text/css"></link>
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/component/popwindow/popwin.js" ></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/jquery.select.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script src="${ctxJs}/component/popwindow/popwin.js" ></script>
<script src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
<script type="text/javascript">
var profileId = "${scriptProfile.profileId}";
var saveFlag = false;
var actived = false;
var canEdit = <s:property value="@com.mocha.bsm.script.monitor.bean.ScriptBean@canEdit()"/>;
function ajaxChangeTabPageVisitFun(profileId,targetType){
		var urlObj = "${ctx}/scriptmonitor/repository/scriptMonitor!dispatch.action?targetType="+targetType;
		if(targetType == 'basicinfo'){
			urlObj = "${ctx}/scriptmonitor/repository/scriptPropfile!edit.action?scriptProfile.profileId="+profileId+"&targetType="+targetType;
		}
		$.blockUI({message:$('#loading')});
		$.ajax({
			type: "POST",
			cache: false,
			data: "profileId="+profileId,
			dataType: "html",
			url: urlObj,
			success: function(data,textStatus){
				var $scriptRepostiory = $("#scriptFrame");
				$scriptRepostiory.find("*").unbind();
				$scriptRepostiory.html(data);
				dialogResize();
				$.unblockUI();
			}
		});
}
</script>	
<s:if test="#request.success==true">
<script type="text/javascript">
//新建区域完成，刷新父页面
returnValue="true";
window.close();
</script>
</s:if>
<s:elseif test="#request.success=='edit'">
	<script type="text/javascript">
		saveFlag = ${requestScope.saveFlag};
		actived = ${requestScope.isActived};
	</script>	
</s:elseif>
<script type="text/javascript">
<!--
var targetType="basicinfo";
var metricIndex=0;
var eventIndex = 0;
var $metrics;
var $events;
	//表单验证
	$(document).ready(function() {
		var $submit = $("#submit");
		var $app = $("#app");
		var tp = new TabPanel({id:"mytab",//isclear:true,
			listeners:{
				changeAfter:function(tab){
					dialogResize();
				},
				change:function(tab){
					
					targetType = tab.id=="basicinfo"?"basicinfo"
								:tab.id=="metricinfo"?"metricinfo"
			        		 	:tab.id=="eventinfo"?"eventinfo"
			        		 	:tab.id=="alarminfo"?"alarminfo":"alarminfo";
					ajaxChangeTabPageVisitFun(profileId,targetType);
				},
				changeBefore:function(tab){
					if(saveFlag==false){
						var _information = new information({text:"新建脚本监控请保存。"});
						_information.show();
						return false;
					}
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
		$("#closeId").click(function (){
			returnValue="true";
			window.close();
		});
		$submit.click(function (){
			submitData(true);
		});
		$("#cancel").click(function(){
			returnValue="true";
			window.close();
		});
		$app.click(function(){
			submitData(false);
		});
		isVisible($submit,$app);
	});
	function isVisible(){
		for(i=0;i<arguments.length;i++){
			var object = arguments[i];
			if(actived||!canEdit){
				object.hide().attr("disabled","true");
			}else{
				object.show().removeAttr("disabled");
			}
		}
		if(!canEdit){
			$.each($(":input"),function(i,n){
				if(n.type != 'hidden'){
				     n.disabled=true;
				}
			});
		}
	}
	function executeScript(){
		$.blockUI({message:$('#loading')});
		$.ajax({
			url: "${ctx}/scriptmonitor/repository/scriptPropfile!runScript.action",
			dataType: "json",
			data: "scriptProfile.profileId="+profileId,
			cache: false,
			success: function(data, textStatus){
				if(data.runResult.code!="<%=com.mocha.bsm.script.monitor.obj.ScriptRunResult.SUCCESS%>"){
					$.unblockUI();
					var _information = new information({text:data.runResult.errorMessage});
					_information.show();
				}else{
					var resultContent = "";
					for(var i=0; i<data.runResult.content.length; i++){
							resultContent+=data.runResult.content[i]+"\n";
					}
					$("#runResultFirst").val(data.runResult.content[0]);
					$("#runResult").val(resultContent);
					$.unblockUI();
				}
				
			}
		});
	}
	function creatMetricTable(idsCount){
		for(var i=0;i<idsCount.length; i++){
			//最多支持10列 (huaf修改)
			if(i <10){
				$metrics.append(newMetric(metricIndex++,idsCount[i]));
			}
		}
		$metrics.show();
		dialogResize();
	}
	function selectCondition(index){
		var paramType=$("#condition"+index).find("option:selected").attr("jsName");
		var relation = $("#relation"+index);
		var threshold = $("#thresholdText"+index);
		var defaultV = relation.attr("defautValue");
		if(paramType=="STRING"){
			$("#relationSpan"+index).empty();
			var html = "<select id=\"operateModeId"+index+"\" name=\"eventList["+index+"].operateMode\" style=\"width:60px\">";
			<s:iterator value="@com.mocha.bsm.script.monitor.obj.monitor.type.ConditionString@values()">
				if(defaultV == "${key}"){
					html+="<option value=\"${key}\" selected>${value}</option>";
				}else{
					html+="<option value=\"${key}\">${value}</option>";
				}
			</s:iterator>
			html+="</select>";
			$("#relationSpan"+index).append(html);
			$("#synSpan"+index).empty();
			$("#synSpan"+index).append("<input id=\"thresholdText"+index+"\" type=\"text\" name=\"eventList["+index+"].threshold\" size=\"12\"/>");
		}else if(paramType=="NUMBER"){
			$("#relationSpan"+index).empty();
			var html = "<select id=\"operateModeId"+index+"\" name=\"eventList["+index+"].operateMode\" style=\"width:60px\">";
			<s:iterator value="@com.mocha.bsm.script.monitor.obj.monitor.type.ConditionNumber@values()">
				if(defaultV == "${key}"){
					html+="<option value=\"${key}\" selected>${value}</option>";
				}else{
					html+="<option value=\"${key}\">${value}</option>";
				}
			</s:iterator>
			html+="</select>";
			$("#relationSpan"+index).append(html);
			$("#synSpan"+index).empty();
			$("#synSpan"+index).append("<input id=\"thresholdText"+index+"\" type=\"text\" name=\"eventList["+index+"].threshold\" size=\"12\"/>");
		}else if(paramType=="BOOLEAN"){
			$("#relationSpan"+index).empty();
			$("#relationSpan"+index).append("<span style=\"width:60px\">等于</span>");
			$("#relationSpan"+index).append("<input id=\"operateModeId"+index+"\" type=\"hidden\" name=\"eventList["+index+"].operateMode\" value=\"TRUE\"/>");
			$("#synSpan"+index).empty();
			$("#synSpan"+index).append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id=\"thresholdSelect"+index+"\" name=\"eventList["+index+"].threshold\" style=\"width:80px\"><option value=\"TRUE\">TRUE</option><option value=\"FALSE\">FALSE</option></select>");
		}
	}
	function submitData(operType){
	
			var url;
			var data = $("#addForm").serialize();
 			if(targetType=="basicinfo"){
 				var _domainName=$("select[name='scriptProfile.domainId']").val();
 				var _scriptname=$("input[name='scriptTemplate.name']").val();
 				if(_domainName==-1||_scriptname==""){
 					$.unblockUI();
 					var _information = new information({text:"请先填写必填项后再保存。"});
 					_information.show();
 					return;
 				}
				$("#params option").attr("selected", true);
				url = "${ctx}/scriptmonitor/repository/scriptPropfile!update.action?targetType=basicinfo&operationType=app";
				refleshFun(url,data,operType);
 			}else if(targetType=="metricinfo"){
				url = "${ctx}/scriptmonitor/repository/scriptMetric!update.action?targetType=metricinfo&operationType=app&profileId="+profileId;
				refleshFun(url,data,operType);
			}else if(targetType=="eventinfo"){
				var b;
				var c;
				$("[id*=condition]").each(function(i){
					if($(this).val()=="-1"){
						var _information = new information({text:"请选择一个条件。"});
	 					_information.show();
						b = "true";
						return;
					}
				});
				if(b!="true"){
					$("[id*=thresholdText]").each(function(i){
						if(!$(this).val()){
							var $thisObj = $(this);
							var _information = new information({text:"阈值不能为空。"});
		 					_information.show();
							c = "true";
							_information.setConfirm_listener(function(){
								_information.hide();
								$thisObj.focus();
							});
						}
					});
				}
					if(b=="true" || c=="true"){
					}else{
						url = "${ctx}/scriptmonitor/repository/scriptEvent!update.action?targetType=eventinfo&operationType=app&profileId="+profileId;
						refleshFun(url,data,operType);
					}	
			}else if(targetType=="alarminfo"){
				url = "${ctx}/scriptmonitor/repository/scriptMonitor!activeAlarmRule.action?targetType=alarminfo&profileId="+profileId;
				data = $("input[name='acCheck']:checkbox:checked").serialize();
				refleshFun(url,data,operType);
			}
			
	}
	function refleshFun(url,data,operType){
		$.blockUI({message:$('#loading')});
		$.ajax({
			type: "POST",
			url: url,
			data: data,
			dataType: "html",
			cache: false,
			success: function(data){
				var $scriptRepostiory = $("#scriptFrame");
				$scriptRepostiory.find("*").unbind();
				$scriptRepostiory.html(data);
				$.unblockUI();
				dialogResize();
				if(operType){
					returnValue="true";
					window.close();
				}else{
					saveFlag = true;
				}
			}
		});
	}
-->
</script>
</head>
<body>
<div class="loading" id="loading" style="display:none;">
	 <div class="loading-l">
	  <div class="loading-r">
	    <div class="loading-m">
	       <span class="loading-img">正在执行，请稍候...</span> 
	    </div>
	  </div>
	  </div>
</div>
<page:applyDecorator name="popwindow" title="${titleName}">

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

		<s:form id="addForm" action="/scriptmonitor/repository/scriptPropfile!add.action">

			<page:applyDecorator name="tabPanel">
				<page:param name="id">mytab</page:param>

				<page:param name="tabBarWidth">800</page:param>
				<page:param name="width">780</page:param>
				<page:param name="background">white</page:param>
				<page:param name="cls">tab-grounp</page:param>
				<page:param name="current">1</page:param>
				<page:param name="tabHander">[{text:"常规信息",id:"basicinfo"},{text:"指标定义",id:"metricinfo"},{text:"事件定义",id:"eventinfo"},{text:"告警定义",id:"alarminfo"}]</page:param>
				<page:param name="content">
				<div id="scriptFrame">
					<s:action name="scriptMonitor!dispatch" namespace="/scriptmonitor/repository" executeResult="true" flush="false">
					</s:action>
				</div>
				</page:param>
			</page:applyDecorator>
		</s:form>
	</page:param>
</page:applyDecorator>
</body>
</html>
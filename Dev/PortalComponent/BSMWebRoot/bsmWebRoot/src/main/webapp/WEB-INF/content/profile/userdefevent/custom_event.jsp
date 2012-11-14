<%@page import="com.mocha.bsm.profile.type.CustomEventMetricTypeEnum"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form id="formname">
<input type="hidden" name="resourceId" value="${resourceId}" id="resourceId"/>
<input type="hidden" name="eventDef.profileId" value="${eventDef.profileId}" id="profileId"/>
<input type="hidden" name="eventDef.composeId" value="${eventDef.composeId}" id="composeId"/>

<input type="hidden" name="metricType" value="${metricType}" id="metricType"/>
<input type="hidden" name="metricId" value="${metricId}" id="metricId"/>
<input type="hidden" name="enable" value="${enable}" id="enable"/>
<page:applyDecorator name="popwindow" title="自定义事件">
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
	<div class="fold-blue">
	  <div class="vertical-middle title">事件名称：<s:textfield name="eventDef.eventName" size="30" cssClass="validate[required[事件名称],length[0,30,事件名称],noSpecialStr[策略名称]],ajax[duplicateCustomEventName]]"/><span class="red">*</span></div>
	  <div class="fold-top"> <span class="right r-ico r-ico-delete" title="删除"></span> <span class="right ico ico-add" title="添加"></span> <span class="fold-top-title">事件内容</span> </div>
	  <div class="fold-content-padding">
	  <div class="title">逻辑关系：与
	  	</div>
	  	
	  	<table width="100%" class="tableboder" style="overflow: scroll;">
	            <thead>
	              <tr>
	                <th width="10%"><s:checkbox name="allSelect" id="allSelect"/></th>
	                <th width="25%">指标类型</th>
	                <th width="35%">指标名称</th>
	                <th width="30%">事件</th>
	              </tr>
	            </thead>
	            
	            <tbody>
	            <tr><td colspan="5" style="padding: 0 0 0 0;">
	            <div style="width: 100%;height: 135px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
		            <table id="dataTbody" border="0" width="100%" cellpadding="0" cellspacing="0">
	            	    <s:iterator value="records" id="ins" status="st">
		            		<s:if test="#st.odd == true">
								<tr id="custome" class="tr-grey">
		            		</s:if>
		            		<s:else>
								<tr id="custome">
		            		</s:else>
								<td width="10%" align="left"><input type="checkbox" name="checkboxItem""/></td>
							 	<td width="25%"><s:select list="%{#ins.metricTypes}" name="" listKey="key" listValue="value" value="%{#ins.metricType}" cssClass="typeSelect" cssStyle="width:150px;"/></td>
							 	<td width="35%"><s:select list="%{#ins.metrics}" name="composes[%{#st.index}].metricId" listKey="key" listValue="value" value="%{#ins.metricId}" cssClass="metricSelect" cssStyle="width:250px;"/></td>
							 	<td width="30%"><s:select list="%{#ins.events}" name="composes[%{#st.index}].eventDefId" listKey="key" listValue="value" value="%{#ins.eventId}" cssClass="eventSelect" cssStyle="width:170px;"/></td>
								<s:if test="#st.last">
									<input type="hidden" name="array_index" value="${st.index}"/>
								</s:if>
							</tr>
						</s:iterator>
					</table>
				</div>
	            </td></tr>
	            </tbody>
				
	        </table>
	    
	  </div>
	</div>
	<div class="fold-blue">
	  <div class="fold-top"><span class="fold-top-title">触发条件</span></div>
	   <div class="fold-content-padding">以上事件在<s:textfield name="eventDef.time" size="2" cssClass="validate[required,onlyPositiveNumber,length[0,2]]"/>分钟内产生，则触发当前自定义事件。<br/>
	   * 未手工确认的自定义事件产生24小时后将自动转移到已恢复事件列表</div>
	</div>		
	</page:param>
</page:applyDecorator>
</form>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script> 
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script> 
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script>
var panel = null;
var path = "${ctx}";
var metricTypeArray;
$(function(){
	var $topBtn1 = $("#topBtn1");
	$topBtn1.click(function() {
		window.close();
	});
	//校验是否是查看编辑页面
	/*if(setProfileWhetherEdit()) {
		return;
	}*/
	var $addButton = $('.ico-add');
	var $deleteButton = $('.r-ico-delete');
	var $confirmButton = $("#confirm_button");
	var $cancelButton = $("#cancel_button");
	var $formObj = $("#formname");
	var $datTbody = $("#dataTbody");
	var $allSelect = $("#allSelect");
	var $composeId = $("#composeId");
    var $profileId = $("#profileId");
	var index = parseInt($("input[name='array_index']").val());
	if(isNaN(index)) {index = 0;}

	$.validationEngineLanguage.allRules.duplicateCustomEventName = {
			  "file":path + "/profile/customEvent/duplicateCustomEventName.action?profileId="+$profileId.val()+"&composeId="+$composeId.val(),
			  "alertTextLoad":"* 正在验证，请等待",
			  "alertText":"* 有重复的事件名称"
	}
	
	$formObj.validationEngine({
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  } 
	});

 	$allSelect.click(function() {
 	 	$("input[name='checkboxItem']").attr("checked",$allSelect.attr("checked"));
    });
     
	$addButton.click(function() {
    	index++;
		addLine(index);
	});
	
	$deleteButton.click(function() {
		$datTbody.find("input[type='checkbox']:checked").parent().parent().remove();
		$allSelect.attr("checked", false);
	});
	
	$confirmButton.click(function(){
		  var ajaxParam = $formObj.serialize();
		  if(!$.validate( $formObj )) return;
		  if($("input[name='checkboxItem']").size()==0){
			  var _information = new information({text:"请至少添加一个事件"});
			  _information.show();
			  return;
		  }
		  $.ajax({
			   type: "POST",
			   url: path+"/profile/customEvent/saveCustomEvent.action",
			   data: ajaxParam,
			   success: function(data, textStatus){
			      try{
			   		//if($composeId.val() != undefined && $composeId.val() != "") {
			   		//	opener.deleteCustomEvent($composeId.val());
			   		//}
					//opener.addCustomEvent(data.eventDef.composeId,data.eventDef.eventName);
			   		opener.loadCustomEvent(true);
			      }catch(e) {
			      }
			 		window.close();
			   },
			   error: function(data, textStatus) {
				   alert("error");
			   }
		 });	
	});

	refreshSelect();
	
    $cancelButton.click(function(){
	  window.close();
    });
});

function refreshSelect() {
	$typeSelect = $(".typeSelect");
	$metricSelect = $(".metricSelect");
	
	$typeSelect.unbind();
	$typeSelect.change(function() {
		changeMetricType($(this));
	});

	$metricSelect.unbind();
	$metricSelect.change(function() {
		changeMetric($(this));
	});

	$checkboxItems = $("checkboxItem");
	$checkboxItems.unbind();
	$checkboxItems.click(function() {
		singleSelect($(this)[0]);
	});
	
	//$metricSelect.unbind();
	//$metricSelect.change(function() {
	//	changeMetric($(this));
	//});

}
function singleSelect(obj) {
   if(obj.checked == false) {
	   $("#allSelect").attr("checked", false);
   }
}
settings = {
		inlineValidation: true,
		scroll:false,
		success:false/*,
	    failure : function() { callFailFunction()  } */
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

function addLine(index) {
	$select = $("<select></select>");
	var $tr = $("<tr></tr>");
	var $td = $("<td></td>");
	if(index%2 != 0) {
		$tr.addClass("tr-grey");
	}
	var ajaxParam = $("#formname").serialize();
	
	$.ajax({
		   type: "POST",
		   url: path+"/profile/customEvent/addLine.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
				var json_metricTypes = (new Function("return "+data.json_metricTypes))();
				var json_metrics = (new Function("return "+data.json_metrics))();
		   		var json_events = (new Function("return "+data.json_events))();
			    $tr.append($td.clone().attr("width","10%").append("<input type='checkbox' name='checkboxItem'/>"));
		   		if(json_metricTypes){
					$tr.append($td.clone().attr("width","25%").append($select.clone().append(fillselect(json_metricTypes)).addClass("typeSelect").css("width", "150px")));
			    }
		   		if(json_metrics){
					$tr.append($td.clone().attr("width","35%").append($select.clone().append(fillselect(json_metrics)).attr("name", "composes["+index+"].metricId").addClass("metricSelect").css("width", "250px")));
			    }
			    if(json_events){
					$tr.append($td.clone().attr("width","30%").append($select.clone().append(fillselect(json_events)).attr("name", "composes["+index+"].eventDefId").addClass("eventSelect").css("width", "170px")));
			    } 
				$("#dataTbody").append($tr);
				refreshSelect();
		   },
		   error:function(msg) {
				alert( msg.responseText);
		   }
	 });
}

function changeMetricType(obj) {
	$("#metricType").val(obj.val());
	var ajaxParam = $("#formname").serialize();
	$.ajax({
		   type: "POST",
		   url: path+"/profile/customEvent/changeMetricType.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
				var json_metrics = (new Function("return "+data.json_metrics))();
		   		var json_events = (new Function("return "+data.json_events))();
			    var $tds = obj.parent().parent().children('td');
			    if($tds.length == 4) {
			    	if(json_metrics){
			   			$($tds[2]).children().empty().append(fillselect(json_metrics));
				    }
				    if(json_events){
				    	$($tds[3]).children().empty().append(fillselect(json_events));
				    }
					
					
				}
		   },
		   error:function(msg) {
				alert( msg.responseText);
		   }
	 });
}

function changeMetric(obj) {
	var $tds = obj.parent().parent().children();
    if($tds.length == 4) {
		$("#metricType").val($($tds[1]).children("select").val());
	}
	$("#metricId").val(obj.val());
	var ajaxParam = $("#formname").serialize();
	$.ajax({
		   type: "POST",
		   url: path+"/profile/customEvent/changeMetric.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
		   		var json_events = (new Function("return "+data.json_events))();
			    var $tds = obj.parent().parent().children('td');
			    if($tds.length == 4) {
			    	if(json_events){
						$($tds[3]).children().empty().append(fillselect(json_events));
				    }
				}
		   },
		   error:function(msg) {
				alert( msg.responseText);
		   }
	 });
}

function fillselect(dataArray) {
   var html = "";
      for(var i=0;i<dataArray.length;i++){
    	  html += "<option value='"+dataArray[i].key+"'>"+dataArray[i].value+"</option>"; 
      }
      return html;
}
function setProfileWhetherEdit() {
	var enable = $("#enable").val();
	if(enable=='true'){
		$(':input').attr('disabled','true');
		$('select').attr('disabled','true');
		$(".ico-delete").hide();
		$(".r-ico-add").hide();
		$('#confirm_button').hide();
		$('#apply_button').hide();
		$('#cancel_button').hide();
		return true;
	}
	return false;
}
</script>
</body>
</html>
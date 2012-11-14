<!-- 机房-机房定义-属性-指标页面 resMetric.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.mocha.bsm.room.entity.Resource"%>
<title></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />


</head>

<body>
<form id="formResMetricID" action="" name="ResourcePropertyForm" method="post">

<div>
<ul class="fieldlist-n">
	<li style="width:100%"><span class="field-max">机房设施类型</span><span style="left:-23px;position:relative">：<s:property value="type" /></span></li>
	<li>
	<s:if test="jigui=='true'">
	<span class="field">机柜号</span>
	</s:if>
	<s:else>
	<span class="field">名称</span>
	</s:else> <span>：<input type="text"
		class="validate[required,noSpecialStr,length[0,30]]" name="name"
		id="name" size="40" value="${fitRes.name}"></input></span>
	<span class="txt-red" style="top:3px">*</span>
	</li>

	<li><span class="field" style="position:relative;top:-3px">备注</span> <span style="position:relative;top:-3px">：</span><textarea name="notes"
		id="notes" cols="42" rows="3" class="validate[length[0,200]]"><s:property
		value="fitRes.desc" /></textarea></li>
</ul>

<div class="monitor-target" id="metricTab" >

<div id="tableData"  >
		<s:action name="ResMetricTableVisit" namespace="/roomDefine" executeResult="true" >
			<s:param name="roomId" value="<s:property value='roomId' />"/>
		</s:action>
</div>

</div >
	<s:if test="treeTarget=='true'">
		<ul class="panel-button">
			<li><span></span><a  onclick="submitUseFun();">应用</a></li>
	    </ul>
	    <input type="hidden" name="capacityId" id="capacityId" value="<s:property value='capacityId' />" />
		<input type="hidden" name="componentId" id="componentId" value="<s:property value='resourceId' />" />
		<input type="hidden" name="isJigui" id="isJigui" value="1" />
		<input type="hidden" name="commitType" id="commitType" value="normalInfo" />
	</s:if>
</div>
<input type="hidden" name="roomId" id="roomId"
	value="<s:property value='roomId' />" />
<input type="hidden" name="delMetricId" id="delMetricId"
	value="" />
<input type="hidden" name="isModelRes" id="isModelRes"
	value="<s:property value='isModelRes' />" />
<input type="hidden" name="metricType" id="metricType"
	value="" />
</form>
</body>
</html>
<script type="text/javascript">
$(document).ready(function() {
	$("#formResMetricID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	});
});
//添加指标
function addMetricFun(roomId,catalogId,resourceId) {
	var hasName = $("#name").val();
	if(hasName != null && hasName != ""){
		window.open("${ctx}/roomDefine/AddMetricVisit.action?modifytype=prop&roomId="+roomId+"&resourceId="+resourceId+"&resourceName="+hasName+"&catalogId="+catalogId,"_blank","width=450,height=330,scrollbars=yes");
	}else{
		alert("名称或机柜号不能为空");
	}
	
}
//编辑指标
function modifyMetricFun(roomId,catalogId,resourceId,metricId,metricType){
	var hasName = $("#name").val();
	if(hasName != null && hasName != ""){
		window.open("${ctx}/roomDefine/UpdateMetricVisit.action?roomId="+roomId+"&catalogId="+catalogId+"&resourceId="+resourceId+"&resourceName="+hasName+"&metricId="+metricId+"&metricType="+metricType+"&modifytype=prop","_blank","width=450,height=330,scrollbars=yes");
	}else{
		alert("名称或机柜号不能为空");
	}
	
}
                           
//删除指标
function delMetricFun(roomId,catalogId,resourceId) {
	var _confirm = new confirm_box({text:"是否确认执行此操作？"});
	 _confirm.setContentText("是否确认执行此操作？");
	 _confirm.setConfirm_listener(function(){
		 var checkName = resourceId+"_checkOne";
			//var che = $("input[name='"+checkName+"']:checkbox:checked");  
			
			// if(che != null && (che.length>0)) {
			//	 for(i=0;i<che.length;i++) {
			//		 var temp = $(che[i]).parent();
			//		 $(temp).parent().toggle();
			//	 }
			// }
			 
			 var uddelId = "";
			 var unche =  $("input[name='"+checkName+"']:checkbox");
			 if(unche != null && (unche.length>0)) {
				 for(i=0;i<unche.length;i++) {
					 if($(unche[i]).attr("checked")==true){
						 if(uddelId ===""){
							 uddelId += $(unche[i]).val();
						 }else{
							 uddelId +=  ","+$(unche[i]).val();
						 }
					 }
				 }
			 }
			 ajaxDelDeviceInfoFun("${ctx}/roomDefine/DeleteMetric.action?type=prop&roomId="+roomId+"&resourceId="+resourceId+"&catalogId="+catalogId+"&delId="+uddelId);
			_confirm.hide();
	 });
	 _confirm.show();
	
}
function ajaxDelDeviceInfoFun(url) {
	
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var delId = data.delId;
			if(null != delId){
				var checkName = "<s:property value='resourceId' />_checkOne";
				var che = $("input[name='"+checkName+"']:checkbox:checked");
		    	if(che != null && (che.length>0)) {
		 		for(i=0;i<che.length;i++) {
				var temp = $(che[i]).parent();
			 	$(temp).parent().hide();
		 		}
			 }
			}
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}
function submitUseFun() {
	//alert($("#capacityId").val());
	//alert($("#componentId").val());
	//alert($("#isJigui").val());
	$("#formResMetricID").attr("action","${ctx}/roomDefine/ResourceProperty.action");
	$("#formResMetricID").attr("target","submitIframe");
	$("#formResMetricID").submit();
}
function loadDataTable(roomId){
	$.loadPage($("#tableData"),"${ctx}/roomDefine/ResMetricTableVisit.action?roomId="+roomId);
}
</script>
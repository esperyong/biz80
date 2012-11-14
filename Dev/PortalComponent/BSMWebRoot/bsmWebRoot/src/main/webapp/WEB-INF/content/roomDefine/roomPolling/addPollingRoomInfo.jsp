<!-- 机房-机房巡检-添加巡检机房 addPollingRoomInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:if test="roomPolling.name!=null && roomPolling.name !=''">编辑巡检机房</s:if><s:else>新建巡检机房</s:else></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/tongjifenxi.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
</head>

<script>
var toast = new Toast({position:"CT"});
if("<s:property value='saveFlag' />" != null && "<s:property value='saveFlag' />" == "true") {
	try{
		parent.window.opener.toast.addMessage("添加成功");
		setTimeout(function(){
			parent.window.opener.location.href=parent.window.opener.location;
			//parent.window.opener.reload();
			parent.winClose();
			},1000);
		//parent.winClose();
	}catch(e){
		alert(e);
	}
}else if("<s:property value='saveFlag' />" == "editOK"){
	try{
		parent.window.opener.toast.addMessage("修改成功");
		setTimeout(function(){
			parent.window.opener.location.href=parent.window.opener.location;
			//parent.window.opener.reload();
			parent.winClose();
			},1000);
		//parent.winClose();
	}catch(e){
		alert(e);
	}
}
</script>
<body>

<page:applyDecorator name="popwindow" >
<page:param name="title"><s:if test="roomPolling.name!=null && roomPolling.name !=''">编辑巡检机房</s:if><s:else>新建巡检机房</s:else></page:param>	
<page:param name="width">400px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">closeId</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>

<page:param name="bottomBtn_index_1">2</page:param>
<page:param name="bottomBtn_id_1">submit</page:param>
<page:param name="bottomBtn_text_1">确定</page:param>

<page:param name="bottomBtn_index_2">3</page:param>
<page:param name="bottomBtn_id_2">cancel</page:param>
<page:param name="bottomBtn_text_2">取消</page:param>

<page:param name="content">
<form id="addPollingRoomformID" action="" name="addPollingRoomForm" method="post" >
<div>
 	<ul class="fieldlist-n">
  		<li>
  			<span  class="field">机房名称</span>
  			<span>：<input type="text" class="validate[required,noSpecialStr,length[0,30],ajax[duplicateMetricName]]" name="roomName" id="roomName" size="40" value="<s:property value='roomPolling.name' />" /></span>
  			<span class="red">*</span>
  		</li>
  		<li>
  			<span class="field">是否关联机房</span>
  			<!-- 判断编辑机房roomPolling.relaRoom!=null -->
  			<span>：
  			<s:if test="roomPolling.name!=null && roomPolling.name !=''"> 
  				<input type="radio" name="relevanceRadioName" value="true"  style="width:20px;" disabled="true" <s:if test="roomPolling.relaRoom!=''">checked</s:if> />是
	  			<input type="radio" name="relevanceRadioName" value="false" style="width:20px;" disabled="true" <s:if test="roomPolling.relaRoom==''">checked</s:if> />否
  			</s:if>
  			<s:else> 
	  			<input type="radio" name="relevanceRadioName" value="true" style="width:20px;"  />是
	  			<input type="radio" name="relevanceRadioName" value="false" checked style="width:20px;" />否
  			</s:else>
  			</span>
  		</li>
  		<li <s:if test="roomPolling.relaRoom!=''">style="vertical-align:baseline;"</s:if><s:else>style="vertical-align:baseline;display:none;"</s:else>  id="relaLiId">
  			<span class="field">关联监控机房</span>
  			<span>：</span><span>
  			<select id="relevanceRoomSel" name="relevanceRoomSel" <s:if test="roomPolling.name!=''">disabled</s:if> onchange="selectRoomFun(this)">
  			<option value="">请选择</option>
  				<s:iterator value="allRoom" id="map" >
		   					<option value="<s:property value="#map.value.id" />" <s:if test="roomPolling.relaRoom==#map.value.id">selected</s:if> >
		   						<s:property value="#map.value.name" />
		   					</option>
				</s:iterator>
  			</select>
  			</span>
  			<span class="red">*</span>
  			
  			<s:iterator value="allRoom" id="allRoomMap" >
  				<input type="hidden" id="<s:property value='#allRoomMap.value.id'/>_hidden" value="<s:property value='#allRoomMap.value.domain'/>"/>
  			</s:iterator>
  		</li>
  		
  		<li style="vertical-align:baseline;">
  			<span class="field" style="width:100px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;" title="所属<s:property value='domainPageName' />">所属<s:property value='domainPageName' /></span>
  			<span>：</span><span style="top:3px;position:relative">
  			<s:if test="roomPolling.domain!=null">
	  			<s:select theme="simple" style="width:235px"  disabled="true" list="allDomains" cssClass="validate[required]" name="field1" id="field1" listKey="ID" listValue="name" value="roomPolling.domain" />
  			</s:if>
  			<s:else>
  				<s:select theme="simple" style="width:235px" list="allDomains" cssClass="validate[required]" name="field1" id="field1" listKey="ID" listValue="name" value="roomPolling.domain' />" />
  			</s:else>
  			</span>
  			<input type="hidden" id="field" name="field"/>
  			<span class="red">*</span>
  		</li>
  	</ul>
</div>
<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
<input type="hidden" name="pollingId" id="pollingId" value="<s:property value='pollingId' />" />
<s:if test="roomPolling.name!=null && roomPolling.name !=''">
<input type="hidden" name="editPoolId" id="editPoolId" value="yes" />
</s:if>
</form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</page:param>
</page:applyDecorator>
</body>
</html>
<script>
$("#closeId").click(winClose);
$("#submit").click(function (){
	var editPoolId = $("#editPoolId").val();
	if(editPoolId != null && editPoolId=="yes"){
		$("#addPollingRoomformID").attr("action","${ctx}/roomDefine/AddPollingRoomVisit!editForm.action");
		//$("#addPollingRoomformID").attr("target","submitIframe");
		$("#addPollingRoomformID").submit();
	}else{
		$("#addPollingRoomformID").attr("action","${ctx}/roomDefine/AddPollingRoomVisit!commitForm.action");
		//$("#addPollingRoomformID").attr("target","submitIframe");
		$("#addPollingRoomformID").submit();
	}
})
$("#cancel").click(winClose);
function winClose() {
	window.close();
}
$(document).ready(function() {
	$("input[name='relevanceRadioName']").bind("click",show);
	$.validationEngineLanguage.allRules.duplicateMetricName={
    		"file":"${ctx}/roomDefine/AddPollingRoomVisit!vaildatePollingName.action",
    	    "alertTextLoad":"* 正在验证，请等待",
    	    "alertText":"* 名称已经存在"
    	}
	$("#field").val($("#field1").val());
	show();	
	//SimpleBox.renderAll();
});
$("#field1").change(function(){
	$("#field").val($("#field1").val());
});

function show() {
	var checkVal = $("input[name='relevanceRadioName']:checked").val();

	if(null != checkVal && checkVal == "true"){
		$("#relaLiId").show('slow');
		$("#field1").attr("disabled",true);
		window.resizeTo(410,200);
	}else{
		$("#relaLiId").hide('slow');
		$("#field1").attr("disabled",false);
		//$("#field").disabled = true;
		window.resizeTo(410,175);
	}
	/*
	var thisSelect = SimpleBox.instanceContent["field"];

	
	if (thisSelect){
		thisSelect.disable();
		thisSelect.enable();
		
	}
	*/
}

function selectRoomFun(param){
	$("#field1").val($("#"+param.value+"_hidden").val());
	$("#field").val($("#"+param.value+"_hidden").val());
	$("#roomName").val(param.options[param.selectedIndex].text);
}
</script>
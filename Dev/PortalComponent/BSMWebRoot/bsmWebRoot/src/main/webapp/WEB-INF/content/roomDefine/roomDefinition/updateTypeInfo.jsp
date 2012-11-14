<!-- 机房-机房定义-机房设施管理-单个修改类型   updateTypeInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>修改类型</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>

<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && "true".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
	}
%>
</head>
<script>
if("<%=saveFlag%>" != null && "<%=saveFlag%>" != "") {
	//var loadStr = window.opener.location.href;
	window.opener.location.href=window.opener.location; 
	window.close();
}
</script>
<body>
<page:applyDecorator name="popwindow"  title="修改类型">
	
	<page:param name="width">380px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
		<form id="formID" action="${ctx}/roomDefine/UpdateType.action" name="UpdateTypeForm" method="post">
	<div>
	   		<ul class="fieldlist-n">
		   		<li>
		   			<span  class="field">所属一级类型</span>
		   			<span>：</span>
		   			<select name="chooseOneTypeSel" id="chooseOneTypeSel" disabled="true">
		   			<s:iterator value="catalog" id="map" status="index">
		   				<s:if test="oneId==#map.key">
		   					<option value="<s:property value='#map.key' />" selected="selected" ><s:property value="#map.value.desc" /></option>
		   				</s:if>
		   				<s:else>
		   					<option value="<s:property value='#map.key' />"><s:property value="#map.value.desc" /></option>
		   				</s:else>
		   			</s:iterator>
		   			</select>
		   		</li>
		   		<li>
		   			<span  class="field">类型名称</span>
		   			<span>：</span>
		   			<input type="text" class="validate[length[0,30]]" name="typeName" id="typeName" size="40" style="width:200px" value="<s:property value='descStr'/>"/>
		   			<span class="red">*</span>
		   		</li>
		   	</ul>
   		</div>	
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		<input type="hidden" name="resourceId" id="resourceId" value="<s:property value='twoId' />" />
		<input type="hidden" name="oldcatalogId" id="oldcatalogId" value="<s:property value='oneId' />" />
		<input type="hidden" name="chooseOneType" id="chooseOneType" value="" />
   		</form>
	</page:param>
</page:applyDecorator>
</body>

</html>
<script type="text/javascript">

$(document).ready(function() {
	var catalogIdVal = "<s:property value='oneId' />";
	var resourceIdVal = "<s:property value='twoId' />";
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})

	$.validationEngineLanguage.allRules.typeInUse={
		"file":"${ctx}/roomDefine/UpdateType!isTypeInUse.action?oldcatalogId="+catalogIdVal+"&resourceId="+resourceIdVal,
	    "alertTextLoad":"* 正在验证，请等待",
	    "alertText":"* 设备类型已被机房内设备使用"
	}
	
});

$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	var selVal = $("#chooseOneTypeSel option:selected").val();
	$("#chooseOneType").val(selVal);
	//alert($("#chooseOneType").val());
	$("#formID").submit();
})
$("#cancel").click(function(){
	window.close();
})

</script>
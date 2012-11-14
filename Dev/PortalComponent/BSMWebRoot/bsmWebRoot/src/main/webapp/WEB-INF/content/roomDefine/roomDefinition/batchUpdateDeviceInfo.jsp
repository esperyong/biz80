<!-- 机房-机房定义-批量编辑设备  batchUpdateDeviceInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>批量编辑设备</title>
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
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
	}
%>
</head>
<script>
if("<%=saveFlag%>" == "true") {
	var loadStr = window.opener.location.href;
	if(loadStr.indexOf("IndexVisit")>=0){
		window.opener.deviceManagerFunClk();
	}else if(loadStr.indexOf("ResourcePropertyVisit")>=0){
		window.opener.deviceManagerFunClk();
	}else{
		window.opener.location.href=window.opener.location;
	}
	
	window.close();
}
</script>
<body>
<page:applyDecorator name="popwindow"  title="批量编辑设备">
	
	<page:param name="width">600px;</page:param>
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
		<form id="formID" action="${ctx}/roomDefine/BatchUpdateDeviceInfoVisit!updateDeviceInfo.action" name="BatchUpdateDeviceInfoVisitForm" method="post" >
	<div><span class="ico ico-note"></span><span>说明：请选择本次要修改的项，未选中的项保留原有数据。</span></div>
	<div>
	   		<ul class="fieldlist-n">
<!--	   			<li>-->
<!--		   			<span  class="field">设备类型:</span>-->
<!--		   			<SELECT id="chooseDev" name="chooseDev" class="validate[required]">-->
<!--		   				<option value="" >请选择设备类型</option>-->
<!--		   				<s:iterator value="capacityMap" id="map">-->
<!--		   					<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>-->
<!--		   				</s:iterator>-->
<!--		   			</SELECT>-->
<!--		   		</li>-->
		   		
		   		<s:if test="jiguiNo==''">
		   		<li>
		   			<input type="checkbox" name="cabinetcbx" />
		   			<span  class="field">机柜号</span>
		   			<span style="position:relative;left:-3px">：<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="cabinetNo" id="cabinetNo" size="40"/></span>
		   		</li>
		   		</s:if>
		   		<s:else>
		   			<li><span class="field" size="40" style="left:25px;position:relative">机柜号&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span></li>
					<span style="left:28px;position:relative">：<s:property value='jiguiNo' /><input type="hidden" class="validate[length[0,30]]" name="cabinetNo" id="cabinetNo" value="<s:property value='jiguiNo' />"/></span>
		   		</s:else>
		   		
		   		<li>
		   			<input type="checkbox" name="frameNocbx" />
		   			<span  class="field">机框号</span>
		   			<span>：<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="frameNo" id="frameNo" size="40"/></span>
		   		</li>
		   		
		   		<li>
		   			<input type="checkbox" name="deviceNocbx" />
		   			<span  class="field">设备号</span>
		   			<span>：<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="deviceNo" id="deviceNo" size="40"/></span>
		   		</li>
<!--		   		<li>-->
<!--		   			<span  class="field">用户名:</span>-->
<!--		   			<input type="text" class="validate[length[0,30]]" name="userName" id="userName" size="40"/>-->
<!--		   		</li>-->
<!--		   		<li>-->
<!--		   			<span  class="field">所在部门:</span>-->
<!--		   			<input type="text" class="validate[length[0,30]]" name="department" id="department" size="40"/>-->
<!--		   		</li>-->
		   		<li>
		   			<input type="checkbox" name="notescbx" style="position:relative;top:-5px"/>
		   			<span class="field" style="position:relative;top:-5px">备注</span>
		   			<span style="position:relative;top:-5px">：</span><span><textarea name="notes" id="notes" cols="42" rows="2" class="validate[length[0,200]]"></textarea></span>
		   		</li>
		   	</ul>
   		</div>	
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		<input type="hidden" name="resourceIds" id="resourceIds" value="<s:property value='resourceIds' />" />
   		</form>
	</page:param>
</page:applyDecorator>
	
</body>


</html>
<script type="text/javascript">

$(document).ready(function() {
	
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
	
});

$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	
	$("#formID").submit();
})
$("#cancel").click(function(){
	window.close();
})

</script>
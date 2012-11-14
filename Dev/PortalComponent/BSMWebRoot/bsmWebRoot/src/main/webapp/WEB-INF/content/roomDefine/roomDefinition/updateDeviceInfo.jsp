<!-- 机房-机房定义-单个更新设备  updateDeviceInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>更新设备</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>


</head>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
	}
%>
<script>
if("<%=saveFlag%>" == "true") {
	var loadStr = window.opener.location.href;
	if(loadStr.indexOf("IndexVisit")>=0){
		window.opener.deviceManagerFunClk();
	}else if(loadStr.indexOf("ResourcePropertyVisit")>=0){
		window.opener.deviceManagerFunClk(); 
	}else{
		var loadStr2 = window.opener.opener.location.href;
		if(loadStr2.indexOf("ResourcePropertyVisit")>=0){
			window.opener.deviceManagerFunClk();
		}
	}
	parent.window.opener.toast.addMessage("更新设备成功");
	window.close();
}
</script>
<body>
<page:applyDecorator name="popwindow"  title="编辑">
	
	<page:param name="width">500px;</page:param>
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
		<form id="formID" action="${ctx}/roomDefine/UpdateDeviceInfo.action" name="UpdateDeviceInfoForm" method="post" >
	<div class="h2"><span class="ico ico-note"></span><span>说明：对选中表单项的制定列进行编辑。</span></div>
	<div>
	   		<ul class="fieldlist-n">
	   			<li>
		   			<span  class="field">IP地址</span>
		   			<span>：</span>
		   			<span id="IPAddress"></span>
		   			<select id="groupIpAddress"></select>
		   		</li>
		   		<li>
		   			<span  class="field">MAC地址</span>
		   			<span>：</span>
		   			<span id="macAddress"></span>
		   		</li>
		   		<li>
		   			<span  class="field">设备名称</span>
		   			<span>：</span>
					<span id="deviceName"></span>
		   		</li>
		   		<li>
		   			<span  class="field">设备类型</span>
		   			<span>：</span>
					<span id="chooseDev"></span>
		   		</li>
		   		<li>
		   		<s:if test="jiguiNo==''">
		   			<span  class="field">机柜号</span>
		   			<span>：</span>
		   			<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="cabinetNo" id="cabinetNo" size="40"/>
		   		</s:if>
		   		<s:else>
		   			<span class="field" size="40">机柜号:</span><span><s:property value='jiguiNo' /></span>
					<input type="hidden" class="validate[noSpecialStr2,length[0,30]]" name="cabinetNo" id="cabinetNo" value="<s:property value='jiguiNo' />"/>
		   		</s:else>
		   		</li>
		   		<li>
		   			<span  class="field">机框号</span>
		   			<span>：</span>
		   			<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="frameNo" id="frameNo" size="40"/>
		   		</li>
		   		<li>
		   			<span  class="field">设备号</span>
		   			<span>：</span>
		   			<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="deviceNo" id="deviceNo" size="40"/>
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
		   			<span class="field">备注</span>
		   			<span>：</span>
		   			<textarea name="notes" id="notes" cols="42" rows="2" class="validate[length[0,200]]"></textarea>
		   		</li>
		   	</ul>
   		</div>	
		<input type="hidden" name="resourceId" id="resourceId" value="<s:property value='resourceId' />" />
		<input type="hidden" name="rowIndex" id="rowIndex" value="<s:property value='rowIndex' />" />
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
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
	var rowIndex = $("#rowIndex").val();
	var resourceId = $("#resourceId").val();
	try {
		var rowval = opener.gp.getRowByIndex(rowIndex);

		var groupIP = rowval.cells[1].html.split(",");
		if (groupIP.length <=1){
			$("#groupIpAddress").css({"display":"none"});
			$("#IPAddress").text(rowval.cells[1].html);
		}else{
			$("#IPAddress").css({"display":"none"});
			for (var i=0;i<groupIP.length;i++){
				$("<option value='"+i+"'>"+groupIP[i]+"</option>").appendTo($("#groupIpAddress"))
			}
			
		}
		
		
		$("#macAddress").text(rowval.cells[2].html);
	   	$("#deviceName").text(rowval.cells[3].html);
	   	$("#chooseDev").text(rowval.cells[4].html);
	   	$("#cabinetNo").val(rowval.cells[5].html);
	   	$("#frameNo").val(rowval.cells[6].html);
	   	$("#deviceNo").val(rowval.cells[7].html);
	   	var arr= rowval.cells[8].html.split(":");
	   	if (arr[0] != "null"){
	   		$("#notes").val(arr[0]);   	
		}
	   		
	   	//alert("resourceId=="+resourceId);
	}catch(e) {
		//alert("haha ");
		//alert(e);
	}
	
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
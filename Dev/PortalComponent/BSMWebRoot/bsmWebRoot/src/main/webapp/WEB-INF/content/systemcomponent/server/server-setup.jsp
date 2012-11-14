<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="discovery.page"/></title>
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
 <link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
</head>
<body>
<form id="formsetup" name="formsetup" method="post">
<div class="margin5 gray-bottom">
<input type="hidden" name="serverId" id="serverId" value="${serverId}" />
<ul class="fieldlist-n">
<li> <span class="field-middle">域名/IP地址</span><span>：</span><span>${serverIp}</span></li>
<li> <span class="field-middle">数据源URL</span><span>：</span><s:textfield cssClass="validate[required[数据源URL]]" id="jdbcUrl" name="jdbcUrl" value="%{#request.jdbcUrl}"/> <span class="red">*</span></li>
<li> <span class="field-middle">数据源用户名</span><span>：</span><s:textfield cssClass="validate[required[数据源用户名],noSpecialStr2[数据源用户名],length[0,20,数据源用户名]]" id="userName" name="userName" value="%{#request.userName}"/> <span class="red">*</span></li>
<li> <span class="field-middle">数据源密码</span><span>：</span><input type="password" class="validate[length[0,20,数据源密码]]" id="password" name="password" value="<s:property value="%{#request.password}"/>"/></li>
<li> <span class="field-middle">JVM最大值</span><span>：</span><s:textfield cssClass="validate[required[JVM最大值],length[0,4,JVM最大值],onlyNumber[JVM最大值]]" id="maxJvm" name="maxJvm" value="%{#request.maxJvm}"/> <span class="red">*</span></li>
<li> <span class="field-middle">JVM最小值</span><span>：</span><s:textfield cssClass="validate[required[JVM最小值],length[0,4,JVM最小值],onlyNumber[JVM最小值]]" id="minJvm" name="minJvm" value="%{#request.minJvm}"/> <span class="red">*</span></li>
<li> <span class="field-middle">WMI Agent IP</span><span>：</span><s:textfield cssClass="validate[required[WMI Agent IP],ipAddress[WMI Agent IP]]" id="plugIp" name="plugIp" value="%{#request.plugIp}"/> <span class="red">*</span></li>
<li> <span class="field-middle">WMI Agent 端口</span><span>：</span><s:textfield cssClass="validate[required[WMI Agent 端口],onlyNumber[WMI Agent 端口]]" id="plugPort" name="plugPort" value="%{#request.plugPort}"/> <span class="red">*</span></li>
</ul>
</div>
<div class="margin5">
<span class="black-btn-l right" id="sp_apply"> <span class="btn-r"> <span class="btn-m"><a >应用</a></span> </span> </span>
</div>
</form>
</body>
<script type="text/javascript">
var toast = new Toast({position:"CT"});
$("#formsetup").validationEngine();
var form = $("#formsetup");
settings = {
	promptPosition:"centerRight",
	validationEventTriggers:"keyup blur change",
	inlineValidation: true,
	scroll:false,
	success:false,
		failure : function() {}
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
$(document).ready(function() {
	$.blockUI({message:$('#loading')});
	$.unblockUI();		
	$("#sp_apply").bind("click", function(){
		if($.validate(form)){
			var serverId = $("#serverId").val();
			var jdbcUrl = $("#jdbcUrl").val();
			var userName = $("#userName").val();
			var password = $("#password").val();
			var maxJvm = $("#maxJvm").val();
			var minJvm = $("#minJvm").val();
			var plugIp = $("#plugIp").val();
			var plugPort = $("#plugPort").val();
			var ajaxParam = "serverId="+serverId+"&jdbcUrl="+jdbcUrl+"&userName="+userName+"&password="+password+"&maxJvm="+maxJvm+"&minJvm="+minJvm+"&plugIp="+plugIp+"&plugPort="+plugPort;
			//alert(ajaxParam);
			$.blockUI({message:$('#loading')});
			$.ajax( {
				type : "post",
				url : "server-setup-apply!apply.action",
				data : ajaxParam,
				success : function(data, textStatus) {
					$.unblockUI();	
					toast.addMessage("操作成功，重启系统组件后生效。");;
				}
			});
		}
	});
});

</script>
</html>
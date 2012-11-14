<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="discovery.page"/></title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
</head>
<body>
<form id="createAgentform" name="createAgentform" method="post" >
<input type="hidden" name="parentId" id="parentId" value="${parentId}"/>
	<fieldset class="blue-border-nblock">
      <legend> Agent 发现</legend>
      <ul class="fieldlist-n">
        <li> <span class="field-middle">名称</span><span>：</span><s:textfield cssClass="validate[required[名称],length[0,30,名称],noSpecialStr[名称],ajax[createAgentName]]" id="agentName" key="agentName" value=""/> <span class="red">*</span></li>
        <li> 
        	<span class="field-middle">类型</span><span>：</span><select id="installType" name="installType">
        		<s:if test="parentId==0">	
        		<option value="1">被监控端Agent</option>
        		</s:if>
        		<s:else>
        		<option value="0">组件Agent</option>
        		<option value="1">被监控端Agent</option>
        		</s:else>
        	</select> 
        	<span class="red">*</span>
        </li>
        <li> <span class="field-middle">上级Agent</span><span>：</span><span>${parentName}</span></li>
        <li> <span class="field-middle">域名/IP地址</span><span>：</span><span>
          <s:textfield cssClass="validate[required[域名/IP地址],length[0,50,域名/IP地址],noSpecialStr[域名/IP地址],ipOrDomain[域名/IP地址]]" id="ip"/> 
          </span> <span class="red">*</span> <span class="ico ico-what valign" title="Agent所在机器的域名或IP地址。&#10;例如域名：tjmdcl，IP地址：192.168.50.23。"></span> </li>
        <li> <span class="field-middle">端口</span><span>：</span><s:textfield cssClass="validate[required[端口],onlyNumber[端口]]" id="port"/><span class="red">*</span>
        <span class="ico ico-what valign" title="Agent服务使用的端口号。"></span></li>
        <li class="line"> </li>
        <li><span class="ico ico-tips"/>注：一、建议通过域名发现Agent。(1、可以适应服务器IP地址发生变更的情况。2、可以适应不同网段访问同一服务器时映射为不同IP地址的情况。) 二、域名可以通过DNS服务器或者本机Host表配置。另外要求本机能够通过域名或者IP地址访问到自身。三、相同Agent请通过域名或者IP地址发现一次。 </li>
        
      </ul>
    </fieldset>
      <span class="black-btn-l right" id="sp_create_apply"><span class="btn-r"><span class="btn-m"><a>发现</a></span></span></span>
</form>
</body>
<script type="text/javascript">
$formObj = $("#createAgentform");	
var toast = new Toast({position:"CT"});
var info  = new information();
$.validationEngineLanguage.allRules.createAgentName = {
		  file:"${ctx}/system-component/agentNamejsonValidate.action",
		  alertTextLoad:"正在验证，请稍后",
		  alertText:"<span class='red'>*</span> @@已存在。"
}
$("#createAgentform").validationEngine();
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
	$("#sp_create_apply").bind("click", function() {
		if($.validate($formObj)){
			$.ajax({
		   		type: "POST",
		   		url: "/pureportal/system-component/agent-create-isIpExist!isAgentIpExist.action",
		   		data: "ip=" + $("#ip").val(),
		   		dataType: "json",
		   		success: function(msg){
				//alert(msg.returnResult);
					if(msg.returnResult=="true"){
						info.setContentText("当前Agent已经被发现，不能再次发现。"); 
						info.show();
					}else{
						var agentName = $("#agentName").val();
						var installType =$("#installType").val();
						var parentId = $("#parentId").val();
						var ip = $("#ip").val();
						var port = $("#port").val();
						// alert(agentName + "," + installType + "," + parentId + "," + ip + "," + port);
						
						$.blockUI({message:$('#loading')});
						$.ajax({
						   	type: "POST",
						   	url: "/pureportal/system-component/agent-create-apply!apply.action",
						   	data: "agentName=" + agentName + "&installType=" + installType + "&parentId=" + parentId 
						   				+ "&ip=" + ip + "&port=" + port,
						   	dataType: "json",
						   	success: function(msg){
								//alert(msg.returnResult);
								$.unblockUI();
								if(msg.returnResult=="true"){
									//window.location.href=window.location.href;
									//alert(msg.agentId);
									load("div_syscomp_right","/pureportal/systemcomponent/agent-main.action?agentId="+msg.agentId,function(){
									//alert(tree.getNodeById(msg.agentId).getId());
									tree.clearCurrentNode();
									tree.getNodeById(msg.agentId).setCurrentNode();
									$(".formError").remove();
										});
									//load("agent_right","/pureportal/systemcomponent/agent-info.action?agentId=" + msg.agentId);
									
								}else{
									$(".formError").remove();
									toast.addMessage("发现失败！Agent无法访问。");
								}
						   	}
						});
					 }
		   		}
			});
		}
	});
});
</script>
</html>

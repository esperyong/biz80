<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="discovery.page"/></title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
</head>
<body>
<form id="updateagentform" name="updateagentform" method="post" >
      <ul class="fieldlist-n">
        <li> <span class="field-middle">名称</span><span>：</span><s:textfield cssClass="validate[required[名称],length[0,30,名称],noSpecialStr[名称],ajax[updateAgentName]]" id="agentName" value="%{#request.agentName}"/><span class="red">*</span></li>
        <li> <span class="field-middle">上级Agent</span><span>：</span><span><s:if test="parentName=='' || null==parentName">-</s:if><s:else><s:property value="parentName"/></s:else></span> </li>
        <li> <span class="field-middle">可用性状态</span><span>：</span><span id="status" class="${status}"></span> 
        <span class="gray-btn-l" id="refurbish_status"><span class="btn-r"><span class="btn-m"><a>刷新</a></span></span></span> </li>
        <li> <span class="field-middle">启动时间</span><span>：</span><span><s:if test="lastStartTime=='' || null==lastStartTime">-</s:if><s:else><s:property value="lastStartTime"/></s:else></span> </li>
        <li> <span class="field-middle">域名/IP地址</span><span>：</span><span>
          <s:textfield cssClass="validate[required[域名/IP地址],length[0,50,域名/IP地址],noSpecialStr[域名/IP地址],ipOrDomain[域名/IP地址]]" id="ip" value="%{#request.ip}"/>
          </span> <span class="red">*</span> <span class="ico ico-what valign" title="Agent所在机器的域名或IP地址。&#10;例如域名：tjmdcl，IP地址：192.168.50.23。"></span> </li>
        <li> <span class="field-middle">端口</span><span>：</span>${port} </li>
        <li class="line"> </li>
      </ul>
      <span class="black-btn-l right" id="sp_update_apply"><span class="btn-r"><span class="btn-m"><a>应用</a></span></span></span> 
      <span class="black-btn-l right" id="sp_update_afresh"><span class="btn-r"><span class="btn-m"><a>重启</a></span></span></span> 
</form>

</body>
<script type="text/javascript">
$(document).ready(function() {
	var toast = new Toast({position:"CT"});
	agentId = '${agentId}';
	//alert(agentId);
	$formObj = $("#updateagentform");	
	$.validationEngineLanguage.allRules.updateAgentName = {
			  "file":"${ctx}/system-component/agentNamejsonValidate.action?agentId="+agentId,
			  "alertTextLoad":"正在验证，请稍后",
			  "alertText":"<span class='red'>*</span> @@已存在。"
	}
	$("#updateagentform").validationEngine();
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
	//alert('${status}');
	$("#sp_update_apply").bind("click", function() {
		if($.validate($formObj)){
			var agentName = $("#agentName").val();
			var installType =$("#installType").val();
			var parentId = $("#parentId").val();
			var ip = $("#ip").val();
			var port = $("#port").val();
			// alert(agentName + "," + installType + "," + parentId + "," + ip + "," + port);
			// alert("agentId=" + agentId);
			$.blockUI({message:$('#loading')});
			$.ajax({
		   		type: "POST",
		   		url: "/pureportal/systemcomponent/agent-update-apply!apply.action",
		   		data: "agentName=" + agentName + "&ip=" + ip + "&agentId=" + agentId,
		   		dataType: "text",
		   		success: function(msg){
					$.unblockUI();
					//alert("ok");
					//alert($("#agentName").val());
					//alert(tree.getCurrentNode().getText());
					if(tree.getCurrentNode().getText()!=$("#agentName").val()){
						tree.getCurrentNode().setText($("#agentName").val());
					}
		   		}
			});
		}
	});
	$("#sp_update_afresh").bind("click",function(){
		$.blockUI({message:$('#loading')});
		$("#setup").hide();
		$.ajax({
			   type: "POST",
			   url: "/pureportal/systemcomponent/agent-main-restart!restart.action",
			   data: "agentId=" + agentId,
			   dataType: "text",
			   success: function(msg){
					$.unblockUI();	
			   },
	           error:function(e){
	              //alert(e.responseText);
	              $.unblockUI();
	              toast.addMessage("重启失败，Agent无法访问。");
	           }
			});
	})
	$("#refurbish_status").bind("click", function(){
		//alert(agentId);
		$.blockUI({message:$('#loading')});
		$.ajax({
			type: "POST",
			url: "/pureportal/system-component/agent-Status-refresh!refresh.action",
			data: {"agentId": agentId},
			dataType: "json",		
			success: function(json){
				$.unblockUI();
				//alert(json);
				//for (var i in json){
					//alert(i+"#"+json[i]);
				//}
				//alert(json.status);
				//alert($("#status").attr("class"));
				//alert(tree.getCurrentNode());
				//alert(tree.getCurrentNode()._get$Ico().attr("class"));
				if($("#status").attr("calss") != json.status){
					$("#status").removeClass();
					$("#status").addClass(json.status);
					tree.getCurrentNode()._get$Ico().removeClass();
					tree.getCurrentNode()._get$Ico().addClass(json.status);
				}
				//window.location.href=window.location.href;
			},
              error:function(e){
              	//alert(e.responseText);
              	$.unblockUI();
              	toast.addMessage("刷新失败，Agent无法访问。");
              }
		});
	})
});
</script>
</html>
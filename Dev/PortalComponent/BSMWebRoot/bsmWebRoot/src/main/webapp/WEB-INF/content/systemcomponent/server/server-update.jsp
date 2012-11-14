<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>System Component</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
</head>
<body>
<form id="updateServerform" name="updateServerform" method="post" >
<input type="hidden" name="resourceTypeId" id=resourceTypeId value="${resourceTypeId}" />
<input type="hidden" name="serverId" id="serverId" value="${serverId}" />
      <ul class="fieldlist-n">
        <li> <span class="field-middle">名称</span><span>：</span><s:textfield cssClass="validate[required[名称],length[0,30,名称],noSpecialStr[名称],ajax[updateServerName]]" id="name" value="%{#request.name}"/> <span class="red">*</span></li>
        <li> 
        	<span class="field-middle">类型</span><span>：</span>      	
        	<span><s:if test="resourceTypeName=='StandAlone'">Server</s:if><s:else>${resourceTypeName}</s:else></span>
        </li>
        <li> <span class="field-middle">可用性状态</span><span>：</span><span id="status" class="${statusCss}"></span>
        	<span class="gray-btn-l" id="sp_refresh"><span class="btn-r"><span class="btn-m"><a>刷新状态</a></span></span></span>
        </li>
        <li> <span class="field-middle">启动时间</span><span>：</span><span>${lastStartupTime}</span></li>
        <li> <span class="field-middle">Agent</span><span>：</span><span>${agentName}</span>			
        </li>
        <li> <span class="field-middle">安装位置</span><span>：</span><span>${location}</span> 
        </li>
        <li class="line"> </li>
      </ul>
      <span class="black-btn-l right" id="sp_create_apply"><span class="btn-r"><span class="btn-m"><a>应用</a></span></span></span>
      <s:if test="healthStatus!='gray'">
      	<div id="startStr" <s:if test="healthStatus!='red'">style="display: none;"</s:if>>
      		<span class="black-btn-l right" id="sp_start"><span class="btn-r"><span class="btn-m"><a>启动</a></span></span></span>
      		<span class="black-btn-l-off right"><span class="btn-r"><span class="btn-m"><a>停止</a></span></span></span>
      	</div>
      	<div id="stopStr" <s:if test="healthStatus=='red'">style="display: none;"</s:if>>
      		<span class="black-btn-l-off right"><span class="btn-r"><span class="btn-m"><a>启动</a></span></span></span>
      		<span class="black-btn-l right" id="sp_stop"><span class="btn-r"><span class="btn-m"><a>停止</a></span></span></span>
      	</div>
	  </s:if>
</form>
</body>
<script type="text/javascript">
$(document).ready(function() {
	serverId = $("#serverId").val();
	resourceTypeId = $("#resourceTypeId").val();
	var form = $("#updateServerform");	
	$.validationEngineLanguage.allRules.updateServerName = {
			  "file":"${ctx}/system-component/serverNamejsonValidate.action?serverId="+serverId+"&resourceTypeId="+resourceTypeId,
			  "alertTextLoad":"正在验证，请稍后",
			  "alertText":"<span class='red'>*</span> @@已存在。"
	}
	$("#updateServerform").validationEngine();
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
	$("#sp_create_apply").bind("click", function() {
		if($.validate(form)){
			var name = $("#name").val();
			var resourceType = $("#resourceType").val();
			var param = "name=" + name+"&resourceTypeName="+resourceType+"&serverId="+serverId ;
			//alert(param);
			$.blockUI({message:$('#loading')});
			$.ajax({
		   		type: "POST",
		   		url: "/pureportal/systemcomponent/server-update-apply!apply.action",
		   		data: param,
		   		dataType: "text",
		   		success: function(msg){
			   		$.unblockUI();
					//alert($("#name").val());
					//alert(tree.getCurrentNode().getText());
					if(tree.getCurrentNode().getText()!=$("#name").val()){
						tree.getCurrentNode().setText($("#name").val());
					}
		   		}
			});
		}
	});
	$("#sp_refresh").bind("click", function(){
		$.blockUI({message:$('#loading')});
		$.ajax({
			   type: "POST",
			   url: "/pureportal/system-component/server-Status-refresh!refresh.action",
			   data: {"serverId": serverId},
			   dataType: "json",
			   success: function(data){ 
				   $.unblockUI();
			    //alert(data.statusCss);
			    if($("#status").attr("calss") != data.statusCss){
					//$("#status").removeClass();
					//$("#status").addClass(data.statusCss);
					tree.getCurrentNode()._get$Ico().removeClass();
					tree.getCurrentNode()._get$Ico().addClass(data.statusCss);
					load("server_right","/pureportal/systemcomponent/server-info.action?serverId=" + serverId);
				}
			   }
		});
	});
	$("#sp_start").bind("click", function(){
		$.blockUI({message:$('#loading')});
		$.ajax({
			   type: "POST",
			   url: "/pureportal/system-component/server-main-start!start.action",
			   data: {"serverId": serverId},
			   dataType: "json",
			   success: function(data){ 
			    //alert(data.statusCss);
			    $.unblockUI();
			    if($("#status").attr("calss") != data.statusCss){

					tree.getCurrentNode()._get$Ico().removeClass();
					tree.getCurrentNode()._get$Ico().addClass(data.statusCss);
					//$('#stopStr').show();
					//$('#startStr').hide();
					//$("#status").removeClass();
					//$("#status").addClass(data.statusCss);
					//alert(serverId);
					load("server_right","/pureportal/systemcomponent/server-info.action?serverId=" + serverId);
				}
			   }
		});
	});
	$("#sp_stop").bind("click", function(){
		$.blockUI({message:$('#loading')});
		$.ajax({
			   type: "POST",
			   url: "/pureportal/system-component/server-main-stop!stop.action",
			   data: {"serverId": serverId},
			   dataType: "json",
			   success: function(data){ 
			    //alert(data.statusCss);
			    $.unblockUI();
			    if($("#status").attr("calss") != data.statusCss){
					$("#status").removeClass();
					$("#status").addClass(data.statusCss);
					tree.getCurrentNode()._get$Ico().removeClass();
					tree.getCurrentNode()._get$Ico().addClass(data.statusCss);
					$('#startStr').show();
					$('#stopStr').hide();
				}
			   }
		});
	})
});
</script>
</html>
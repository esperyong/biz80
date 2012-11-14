<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>system-component</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
</head>
<body>
<form id="addserverform" name="addserverform" method="post" >
<s:hidden id="parentId" value="%{#request.parentId}"/>
<s:hidden id="parentAgentId" value="%{#request.parentAgentId}"/>
<fieldset class="blue-border-nblock">
      <legend> 添加${resourceTypeName}</legend>
      <ul class="fieldlist-n">
        <li> <span class="field-middle">名称</span><span>：</span><s:textfield cssClass="validate[required[名称],length[0,30,名称],noSpecialStr[名称],ajax[addServerName]]" id="name" key="name" value=""/> <span class="red">*</span></li>
        <li> 
        	<span class="field-middle">类型</span><span>：</span><span>${resourceTypeName}</span><s:hidden id="resourceTypeId" value="%{#request.resourceTypeId}"/>
        </li>
        <li> <span class="field-middle">Agent</span><span>：</span><s:textfield id="agentName" key="agentName" readonly="true"/> <span><s:hidden id="agentId"/></span>
			<span class="gray-btn-l" id="sp_browse"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
			<span class="red">*</span>        		
        </li>
        <li> <span class="field-middle">安装位置</span><span>：</span><span>
          <s:textfield cssClass="validate[required[安装位置]]" id="location"/> 
          </span> <span class="red">*</span> 
        </li>
        <li class="line"> </li>
        <li><span class="ico ico-tips"/>发现成功后请重新启动该组件，以使其正常绑定Agent所在机器的域名或者IP地址。</li>
      </ul>
</fieldset>
      <span class="black-btn-l right" id="sp_create_apply"><span class="btn-r"><span class="btn-m"><a>发现</a></span></span></span>
</form>
</body>
<script type="text/javascript">
var toast = new Toast({position:"CT"});
var info  = new information ({text:"添加失败。"});
var resourceTypeId = $("#resourceTypeId").val();
//alert(resourceTypeId);
$.validationEngineLanguage.allRules.addServerName = {
		  file:"${ctx}/system-component/serverNamejsonValidate.action?resourceTypeId="+resourceTypeId,
		  alertTextLoad:"正在验证，请稍后",
		  alertText:"<span class='red'>*</span> @@已存在。"
}
$("#addserverform").validationEngine();
var form = $("#addserverform");
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
var popwind =  new PopWindow({
	width  : 350,
	height : 90,
	title  : '提示',
	shieldEvent : true,
	html   : '123',
	botButs:[{_id:'confirm_button',_listener:function(){popwind.hide()},_text:'确认'}],
	topButs:[{_id:'win-close',_class:'pop-quit',_listener:function(){popwind.hide()},_title:'关闭'}]
	});
$(document).ready(
		function() {
			$("#sp_create_apply").bind(
					"click",
					function() {
						addValidateCss();
						if($.validate(form)){
						var name = $("#name").val();
						var resourceTypeId = $("#resourceTypeId").val();
						var location = $("#location").val();
						var agentId = $("#agentId").val();
						var parentId = $("#parentId").val();
						var param = "name=" + name + "&resourceTypeId=" + resourceTypeId + "&location="
								+ location + "&agentId=" + agentId;
						if (parentId != null) {
							param = param + "&parentId=" + parentId;
						}
						// alert(param);
						$.blockUI({message:$('#loading')});
						
						$.ajax( {
							type : "POST",
							url : "/pureportal/system-component/server-create-apply!apply.action",
							data : param,
							dataType : "json",
							success : function(data) {
								//alert(data.failReason);
								$.unblockUI();
								
								if(data.identifier == "false"){
									$(".formError").remove();
									if(data.failReason=="License not available"){
										info.setContentText("无DMS的License，请联络摩卡软件获取购买相关License的信息。");
										info.show();
									}else if(data.failReason=="over.license"){
										info.setContentText("产品监控的DMS数量已超过限额，请联络摩卡软件获取购买支持更多数量License的信息。");
										info.show();
									}else{
										popwind.setContentHtml('<div class="promp-win-content"><span class="promp-win-ico promp-win-ico-alert"><p style="margin-top:10px;">发现失败，可能的原因如下：</p><p>1.所选的Agent不正确。</p><p>2.安装位置不正确。</p></span><div id="subtipDiv" style="text-align: center; width: 200px; margin: 0px auto; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><span  id="subTip" ></span></div></div>');
										popwind.show();
									}
								}else{
									$(".formError").remove();
									toast.addMessage("添加成功。");
									load("div_syscomp_right","/pureportal/systemcomponent/server-main.action");
								}
							},
					           error:function(e){
								  //alert(e.responseText);
					              $.unblockUI();
					              $(".formError").remove();
					              //if(e.identifier == "true"){
					              	load("div_syscomp_right","/pureportal/systemcomponent/server-main.action");
					              	toast.addMessage("添加成功。");
					              //}
					           }
						});
						}
					});
			$("#sp_browse").bind("click", function() {
				removeValidateCss();
				var parentAgentId = $("#parentAgentId").val();
				//alert(parentAgentId);
				var url = "server-create-getagent!findgent.action?parentAgentId=" + parentAgentId;
				openViewPage(url, "选择Agent");
			});

			var panel;
			function openViewPage(url, title) {
				if(panel) {
					panel.close("close");
				}
					panel = new winPanel( {
					title : title,
					url : url,
					width : 300,
					x : 550,
					y : 140,
					isFloat:true,
					isautoclose: true,
					tools : [ {
						text : "确定",
						click : function() {
							var node = agentTree.getRadioCheckedNode();
							if(node!=null){
								var agentId = node.getValue("agentId");
								var agentName = node.getValue("agentName");
							
								$("#agentId").val(agentId);
								$("#agentName").val(agentName);
							}
							panel.close("close");
						}
					}],
					listeners : {
						closeAfter : function() {
							panel = null;
						},
						loadAfter : function() {
						}
					}
				},{
				      winpanel_DomStruFn:"pop_winpanel_DomStruFn"
			    });
					
			}
			;

		});

function addValidateCss(){
	$("#agentName").addClass("validate[required[Agent]]");
}
function removeValidateCss(){
	$(".formError").remove();
	$("#agentName").removeClass("validate[required[Agent]]");
}
</script>
</html>

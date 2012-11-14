<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<title>转发</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="转发">
 <page:param name="width">550px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1">关闭</page:param>

 <page:param name="bottomBtn_index_1">1</page:param>
 <page:param name="bottomBtn_id_1">send_button</page:param>
 <page:param name="bottomBtn_text_1">发送</page:param>

 <page:param name="bottomBtn_index_2">2</page:param>
 <page:param name="bottomBtn_id_2">close_button</page:param>
 <page:param name="bottomBtn_text_2">关闭</page:param>

 <page:param name="content">
 <form name="emailForm" id="emailForm" method="post">

 <div class="whitebg" style="width:535px;">
 	<div class="fold-top" style="background-color: #F2F2F2">
  	<input type="checkbox" name="selectEmail" id="selectEmail" checked/><span class="title">邮件</span>
  	</div>
  	<div class="fold-content">
  	<table width="100%" border="0" cellspacing="2">
  		<tr>
  			<td width="13%">Email地址</td>
  			<td width="3%">：</td>
  			<td width="84%" nowrap="nowrap"><s:textfield name="receiveBody" id="receiveBody" maxlength="" size="78"/><span class="red">* <span class="ico ico-what" title="可输入多个Email地址作为接收方，Email地址之间用“;”分隔。"></span></span></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;邮件标题</td>
			<td>：</td>
			<td><s:textfield name="emailTitle" id="emailTitle" size="78"/><span class="red">*</span></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;邮件正文</td>
			<td>：</td>
			<td><textarea id="econtent" name="econtent" cols="80" rows="10"><s:property value="emailContent"/></textarea><span class="red">*</span></td>
		</tr>
	</table>
	</div>
</div>
 <div class="whitebg" style="width:535px;">
 	<div class="fold-top" style="background-color: #F2F2F2">
  	<input type="checkbox" name="selectSMS" id="selectSMS"/><span class="title">短信</span>
  	</div>
  	<div class="fold-content">
  	<table width="100%" border="0" cellspacing="2">
  		<tr>
  			<td width="13%">&nbsp;&nbsp;手机号</td>
  			<td width="3%">：</td>
  			<td width="84%" nowrap="nowrap"><s:textfield name="smsNumber" id="smsNumber" maxlength="" size="78" disabled="true"/><span class="red">* <span class="ico ico-what" title="可输入多个手机号作为接收方，手机号之间用“;”分隔。"></span></span></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;短信内容</td>
			<td>：</td>
			<td><textarea id="scontent" name="scontent" cols="80" rows="10" disabled="disabled"><s:property value="smsContent"/></textarea><span class="red">*</span></td>
		</tr>
	</table>
	</div>
</div>
</form>
 </page:param>
</page:applyDecorator>
<script>
    function validateEmail(tag){
        var self = $(tag);
        var emailAddress = self.val();
        var emailAddresses = emailAddress.split(";");
        for(var i = 0; i < emailAddresses.length; i++){
            var result = emailAddresses[i].match(/^[a-zA-Z0-9_\.\-]+\@([a-zA-Z0-9\-]+\.)+[a-zA-Z0-9]{2,4}$/);
            if(result == null) return true; 
        }
        return false;
    }
    
	path = '${ctx}';
	$(function(){
    
    $.validationEngineLanguage.allRules.emails = {
        "nname":"validateEmail",
        "alertText":"<font color='red'>*</font> 无效的邮件地址，请重新填写"
    }
    
	$("#emailForm").validationEngine();
		settings = {
			promptPosition:"centerRight",
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false,
	   		failure : function() {}
		}
		$.validate = function(form){
	     	$.validationEngine.onSubmitValid = false;
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
		$("#send_button").click(function(){
			
			var data = function(){};
			if($("input[name='selectEmail']").attr("checked") == true){
            
                $("input[name='receiveBody']").removeAttr("disabled");
                $("input[name='receiveBody']").addClass("validate[required[Email地址],funcCall[emails],length[0,200]]");
                $("input[name='emailTitle']").removeAttr("disabled");
                $("input[name='emailTitle']").addClass("validate[required[邮件标题],length[0,200]]");
                $("#econtent").attr("disabled",false);
                $("#econtent").addClass("validate[required[邮件正文],length[0,1000]]");
                
				data.receiveBody = $("#receiveBody").val();
				data.emailTitle = $("#emailTitle").val();
				data.emailContent = $("#econtent").val();
			}
			if($("input[name='selectSMS']").attr("checked") == true){
            
                $("input[name='smsNumber']").removeAttr("disabled");
                $("input[name='smsNumber']").addClass("validate[required[手机号],length[0,200]]");
                //alert($("input[name='scontent']").attr("disabled"));
                $("#scontent").attr("disabled",false);
                $("#scontent").addClass("validate[required[短信内容],length[0,1000]]");
                
				data.smsNumber = $("#smsNumber").val();
				data.smsContent = $("#scontent").val();
			}
            
            if(!$.validate($("#emailForm"))) {return;}//验证
            
			if($("input[name='selectEmail']").attr("checked") == false && $("input[name='selectSMS']").attr("checked") == false){
                var _information = new information({text:"请至少选择一项。"});
                _information.show();
				//alert("请至少选择一项。");
				return false;
			}
            
            var _information = new information({text:"告警信息已通过邮件/短信发送给您，若长时间没有接收到，请再次点击发送。"});
            _information.show();
			$.ajax({
				type:"POST",
				url:path + "/notification/sendEmailAndSMS.action",
				data:data,
				success:function(data){
				/*if($("input[name='selectEmail']").attr("checked") == true){
                    var _information = new information({text:data.mailSendAlert});
                    _information.show();
				}
				if($("input[name='selectSMS']").attr("checked") == true){
                    var _information = new information({text:data.smsSendAlert});
                    _information.show();
				}
				if(data.mailSendState=="true" && data.smsSendState=="true"){
					window.close();
				}*/
				},
	              error:function(e){
	              	//alert("发送失败。");
	              	//alert(e.responseText);
	              }
			});
		});
		$('#close_button').click(function(){
			window.close();
		})
		$("input[name='selectSMS']").click(function(){
			if($("input[name='selectSMS']").attr("checked") == true){
				$("input[name='smsNumber']").removeAttr("disabled");
				$("input[name='smsNumber']").addClass("validate[required[手机号],length[0,200]]");
				//alert($("input[name='scontent']").attr("disabled"));
				$("#scontent").attr("disabled",false);
				$("#scontent").addClass("validate[required[短信内容],length[0,1000]]");
			}else{
				$("input[name='smsNumber']").attr({"disabled":"disabled"});
				$("input[name='smsNumber']").removeClass("validate[required[手机号],length[0,200]]");
				$("#scontent").attr("disabled",true);
				$("#scontent").removeClass("validate[required[短信内容],length[0,1000]]");
			}
		})
		$("input[name='selectEmail']").click(function(){
			if($("input[name='selectEmail']").attr("checked") == true){
				$("input[name='receiveBody']").removeAttr("disabled");
				$("input[name='receiveBody']").addClass("validate[required[Email地址],funcCall[emails],length[0,200]]");
				$("input[name='emailTitle']").removeAttr("disabled");
				$("input[name='emailTitle']").addClass("validate[required[邮件标题],length[0,200]]");
				$("#econtent").attr("disabled",false);
				$("#econtent").addClass("validate[required[邮件正文],length[0,1000]]");
			}else{
				$("input[name='receiveBody']").attr({"disabled":"disabled"});
				$("input[name='receiveBody']").removeClass("validate[required[Email地址],funcCall[emails],length[0,200]]");
				$("input[name='emailTitle']").attr({"disabled":"disabled"});
				$("input[name='emailTitle']").removeClass("validate[required[邮件标题],length[0,200]]");
				$("#econtent").attr("disabled",true);
				$("#econtent").removeClass("validate[required[邮件正文],length[0,1000]]");
			}
		})
	});
	function doSubmit(formObj, actionUrl) {
		formObj.attr("action", actionUrl);
		formObj.submit();
	}
</script>
</body>
</html>
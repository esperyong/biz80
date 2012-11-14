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
<title>转发短信</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="转发短信">
 <page:param name="width">520px;</page:param>
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
 <form name="smsForm" id="smsForm" method="post">

 <div class="whitebg" style="width:505px;">
 	<div class="fold-top" style="background-color: #F2F2F2">
  	<span class="ico ico-note"></span><span class="title">可输入多个手机号作为接收方，手机号之间用“;”分隔。</span>
  	</div>
  	<div class="fold-content">
  	<table width="100%" border="0" cellspacing="2">
  		<tr>
  			<td width="20%">&nbsp;&nbsp;手机号：</td>
  			<td width="80%"><s:textfield cssClass="validate[required,length[0,100]]"  name="smsNumber" id="smsNumber" maxlength="" size="48"/><span class="red">*</span></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;短信内容：</td>
			<td><textarea class="validate[required,length[0,1000]]" id="content" name="content" cols="70" rows="6"><s:property value="smsContent"/></textarea><span class="red">*</span></td>
		</tr>
	</table>
	</div>
</div>
</form>
 </page:param>
</page:applyDecorator>
<script>
	path = '${ctx}';
	$(function(){
	$("#smsForm").validationEngine();
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
		$("#send_button").click(function(){
			if(!$.validate($("#smsForm"))) {return;}
			var data = function(){};
			data.smsNumber = $("#smsNumber").val();
			data.smsContent = $("#content").val();
			$.ajax({
				type:"POST",
				url:path + "/notification/SendSMS.action",
				data:data,
				success:function(data){
					alert(data.sendAlert);
					if(data.sendState=="true"){
						window.close();
					}
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
	});
</script>
</body>
</html>
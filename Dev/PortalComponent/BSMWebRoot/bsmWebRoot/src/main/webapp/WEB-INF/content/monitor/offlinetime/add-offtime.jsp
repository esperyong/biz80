<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>${title}</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script> 
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
<script type="text/javascript" src="${ctx}/js/monitor/noAccessTime.js"> </script>
<script type="text/javascript">
var path = "${ctx}";
var isEdit;
</script>
</head>
<body>
<input type="checkbox" id="isNonAccessTimes" checked style="display:none"/>
<page:applyDecorator name="popwindow"  title="${title}">
  <page:param name="width">600px</page:param>
  <page:param name="height">345px;</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  <page:param name="bottomBtn_index_1">1</page:param>
  <page:param name="bottomBtn_id_1">sp_ok</page:param>
  <page:param name="bottomBtn_text_1">确定</page:param>
  <page:param name="bottomBtn_index_2">2</page:param>
  <page:param name="bottomBtn_id_2">sp_cancel</page:param>
  <page:param name="bottomBtn_text_2">取消</page:param>
  <page:param name="content">
<input type="checkbox" checked=checked style="display:none;" id='isNonAccessTimes'/>
	<form id="performance" name="performance" method="post" >
	<input type="hidden" name="offlineTimeId" id="offlineTimeId" value="${offlineTimeId}"/>
	  <div class="pop-content ">
			<div class="content-padding">
				<div> <span> 时间段显示名称：</span> <input class="validate[required[时间段显示名称],length[0,50,时间段显示名称],noSpecialStr[时间段显示名称],ajax[offlineTimeName]]" type="text" id="offlineTimeName" name="offlineTimeName" value="${offlineTimeName}"/><span class="red">*</span></div>
				<div id="panel_disc_info">
					<ul class="fieldlist">
						<s:action name="nonAccessTime" namespace="/monitor" executeResult="true" ignoreContextParams="false" flush="false">
						<s:param name="offlineTimeId"><s:property value='offlineTimeId'/></s:param>
						</s:action>
					</ul>
				</div>
			</div>
	  </div>  
	</form>
  </page:param>
</page:applyDecorator>
<script type="text/javascript">
function getOfflinename(){
	return $("#offlineTimeName").val()
}
$(document).ready(function() {
	$formObj = $("#performance");	
	$.validationEngineLanguage.allRules.offlineTimeName = {
			  "file":"${ctx}/monitor/offlinetimejsonValidate.action?offlineTimeId="+$("#offlineTimeId").val(),
			  "alertTextLoad":"正在验证，请稍后",
			  "alertText":"* @@已存在。"
	}
	$("#performance").validationEngine({promptPosition:"centerRight"});
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
	$("#sp_cancel").bind("click", function() {
		window.close();
	});
	$("#sp_ok").bind("click", function() {
		if(!$.validate($("#performance"))) {return;}
		var ajaxParam = $('#performance').serialize();
		//alert(data);
		$.ajax({
			type:'post',
			url:'offlinetime!addOffTime.action',
			data:ajaxParam,
			success:function(data){
				if("false" != data.returnFlag){
					opener.document.location.href = "${ctx}/monitor/offlinetime.action";
					window.close();
				}
			}
		})
		//var formObj = document.getElementById("performance");
		//formObj.action = "offlinetime!addOffTime.action";
		//formObj.submit();
	});
	
	$("#closeId").bind("click", function() {
		window.close();
	});

});
</script>
</body>
</html>
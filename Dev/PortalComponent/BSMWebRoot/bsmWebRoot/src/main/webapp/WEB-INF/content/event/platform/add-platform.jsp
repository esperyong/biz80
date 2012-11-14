<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>添加平台</title>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
</style>
</head>
<body>
<page:applyDecorator name="popwindow"  title="添加平台">
    <page:param name="width">440px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    <page:param name="topBtn_title_1">关闭</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">ok_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
    <page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
	<s:form id="platformset">
	<s:hidden name="orderType"/>
	<s:hidden name="orderBy"/>
	<s:hidden id="userDomainIdStr" name="platForm.userDomainIdStr"/>
	<UL class="fieldlist-n">
		<li>
			<span class="field-max">平台名称</span><SPAN>：</SPAN><s:textfield name="platForm.platFormName" size="35" cssClass="validate[required,noSpecialStr,length[0,30],ajax[duplicatePlatFormName]]"/><span class="red">*</span>
		</li>
		<li>
			<span class="field-max">关键字</span><SPAN>：</SPAN><s:textfield name="platForm.keyWord" size="35" cssClass="validate[required,noSpecialStr,length[0,30],ajax[duplicateKeyWord]]"/><span class="red">*</span>
		</li>
		<li>
			<span class="field-max">所属<s:property value="@com.mocha.bsm.event.common.RangeName@rangeName()"/></span><SPAN>：</SPAN><s:select id="userDomainIds" list="#{}" name="platForm.userDomainIds" multiple="true" cssClass="validate[funcCall[userDomainSelect]]" cssStyle="width:210px; height:120px"/><span class="red">*</span><span class="ico ico-find"></span>
		</li>
	</UL>
	</s:form>
	</page:param>
</page:applyDecorator>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>

<script type="text/javascript">
var panel = null;
var rangeName = '<%=com.mocha.bsm.event.common.RangeName.rangeName() %>';
$(document).ready(function(){
	$("#platformset").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	    //,failure : function() { callFailFunction()  } 
	});

	$.validationEngineLanguage.allRules.duplicatePlatFormName = {
		  "file":"${ctx}/event/duplicateValidate!validatePlatFormName.action",
		  "alertTextLoad":"* 正在验证，请等待",
		  "alertText":"* 有重复的平台名称"
	}
	$.validationEngineLanguage.allRules.duplicateKeyWord = {
		  "file":"${ctx}/event/duplicateValidate!validateKeyWord.action",
		  "alertTextLoad":"* 正在验证，请等待",
		  "alertText":"* 有重复的关键字"
	}
	$.validationEngineLanguage.allRules.userDomainSelect = {
		  "nname":"validateUserDomain",
		  "alertText":"* 该项为必填项"
	}
	
	$("#topBtn1").click(function() {
		window.close();
  	});
	$("#cancel_button").click(function() {
		window.close();
  	});
	$("#ok_button").click(function() {
		submitForm();
  	});
  	
  	$(".ico-find").click(function() {
		var domainStr = totalDomain();
		var url = "${ctx}/event/userDomainTree!domainTree.action?domainStr=" + domainStr;
  	  	openViewPage(panel,url,"所属" + rangeName);
  	});
});

function openViewPage(panel,url,title) {
	panel = new winPanel(
	{title:title,
	url:url,
	width:300,
	cls:"pop-div",
	tools:[{text:"确定",	click:function(){appendDomainSelect();panel.close("close");}},{text:"取消",click:function(){panel.close("close");}}],
	listeners:{closeAfter:function(){panel = null;}}},{winpanel_DomStruFn:"pop_winpanel_DomStruFn"}); 
}

function appendDomainSelect(){
	var $userDomainIds = $("#userDomainIds");
	$userDomainIds.html("");
	var $checkboxs = $(":checkbox:checked");
	$checkboxs.each(function(index,entity){
		var key = $(entity).val();
		var value = $(entity).next().text();
		var $option = $("<option></option>");
		$option.attr("value",key);
		$option.text(value);
		$userDomainIds.append($option);
	});
}

function validateUserDomain(){
	if($("#userDomainIds").children().length == 0) {
		return true;
	}
	return false;
}

function totalDomain(){
	var domainStr = "";
	$("#userDomainIds").children().each(
		function(i){
			domainStr += this.value + ",";
		}
	);
	if(domainStr == ""){
		domainStr = domainStr.substring(0, domainStr.length - 1);
	}
	return domainStr;
}

function submitForm() {
	if(!$.validate( $("#platformset") )) return;
	$.blockUI({message:$('#loading')});
	var domainStr = totalDomain();
	$("#userDomainIdStr").attr("value",domainStr);
	var ajaxParam = $("#platformset").serialize();
	$.ajax({
		type: "POST",
		dataType:'html',
		url: "${ctx}/event/platFormSet!createPlatForm.action",
		data: ajaxParam,
		success: function(data, textStatus){
			try{
			opener.rewrite("platForms",data);
			}catch(e){}
			window.close();
		},
		fail: function(data, textStatus) {
			alert('fail');
		}
	});
}

settings = {
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	    //failure : function() { callFailFunction()  } 
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
</script>
</body>
</html>
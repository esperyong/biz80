<!-- WEB-INF\content\location\relation\importDevices-selectType.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self"/>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>导入设备位置信息</title>
<link rel="stylesheet" href="${ctxCss}/common.css"
	type="text/css" />
	<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	
	$.validationEngineLanguage.allRules.keyTest = {
			  "alertText":"<font color='red'>*</font> 请选择域",
			  "nname":"checkKey"
	}	
	
		$("form").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"change",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		$("#next").click(function(){
			$("form").submit();
		});
		$("#closeId").click(function(){
			window.close();
		});
	});
	
	

	
	function checkKey(){
		var value=$('#domainId').val();
		if(value==""){
		return true;
		}
		return false;

	}
	
	
</script>
</head>
<body> 
<page:applyDecorator name="popwindow"  title="导入">
	
	<page:param name="width">560px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">next</page:param>
	<page:param name="bottomBtn_text_1">下一步</page:param>
	<page:param name="content">
<form name="uploadTypeForm" action="${ctx}/location/relation/importDevices!uploadFile.action"
	 method="post" enctype="multipart/form-data">
<div id="title0Div" class="panel-titlebg"><span></span><span>1.选择导入的设备类型</span></div>
<div id="oneDiv">
	<ul class="panel-singleli">
		<li>
		<span class="field">域：
		<s:select name="domainId" id="domainId" list="domains" listKey="ID" listValue="name"
			  headerKey="" headerValue="请选择" cssClass="validate[funcCall[keyTest]]"></s:select></span>
		<span class="red">*</span></li>
		<li>	
	
		<input name="resType" type="radio" value="<%=EquipmentTypeEnum.othernetworkdevice %>" checked="checked"/>
		<span>网络设备</span>
		</li>
		<li>		
		<input name="resType" type="radio" value="<%=EquipmentTypeEnum.otherserver %>"/>
		<span>服务器/PC</span>
		</li>
		
	</ul>
</div>	
</form>
</page:param>
</page:applyDecorator>
</body>
</html>


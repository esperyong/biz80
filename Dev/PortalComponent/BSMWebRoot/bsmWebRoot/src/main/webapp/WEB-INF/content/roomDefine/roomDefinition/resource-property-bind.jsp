<!-- 机房-机房定义-3d组件绑定设施页面 resource-property-bind.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>设置属性</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
</head>

<body>
<page:applyDecorator name="popwindow" title="属性">

	<page:param name="width">500px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>

	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">下一步</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>

	<page:param name="content">
		<form id="formID" action="${ctx}/roomDefine/ResourceProperty.action"
			name="ResourcePropertyForm" method="post">
		<div>
		<ul class="fieldlist-n">
				<li><span class="field">机房设施类型</span> <span>：<SELECT id="chooseDev"
					name="chooseDev" class="validate[required]">
					<option value="" selected="selected">请选择</option>
					<s:iterator value="resourceMap" id="map">
						<option value="<s:property value="#map.value.catalog.id" />#<s:property value="#map.key" />#<s:property value="#map.value.desc" />"><s:property
							value="#map.value.name" /></option>
							
					</s:iterator>
				</SELECT>
				</span>
				<span class="red" style="position:relative;top:3px">*</span>
				</li>
				<li><span class="field">名称</span> <span>：<input type="text"
					class="validate[required,noSpecialStr,length[0,30 ]" name="name"
					id="name" size="40" value=""></input></span>
				<span class="red" style="position:relative;top:3px">*</span>
				</li>
				<li><span class="field" style="position:relative;top:-15px">备注</span> <span><span style="position:relative;top:-15px">：</span><textarea name="notes"
					id="notes" cols="42" rows="3" class="validate[length[0,200]]"></textarea></span></li>
		</ul>
		</div>
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		<input type="hidden" name="capacityId" id="capacityId" value="<s:property value='capacityId' />" />
		<input type="hidden" name="resourceId" id="resourceId" value="<s:property value='capacityId' />" />
		<input type="hidden" name="componentId" id="componentId" value="<s:property value='componentId' />" />
		<input type="hidden" name="commitType" id="commitType" value="unbind" />
	</form>
	</page:param>
</page:applyDecorator>
</body>
</html>
<script type="text/javascript">
var cur;
$(document).ready(function() {
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	});
	window.resizeTo(530,200);
});
$("#chooseDev").change(function() {
	var selTxt =  $('#chooseDev option:selected').text();
	var selVal = $('#chooseDev').val();
    if(selTxt == '请选择') {
    	$("#name").val('');
    	$("#capacityId").val('');
    	$("#resourceId").val('');
    	$("#notes").val('');
    } else{
    	var props = selVal.split("#");
    	$("#name").val('');
    	$("#capacityId").val(props[0]);
    	$("#resourceId").val(props[1]);
    	$("#notes").val('');
    }
});

$("#closeId").click(function (){
	$("#removeSession").load("${ctx}/roomDefine/ResourceProperty!clearSession.action");
	window.close();
})

$("#submit").click(function (){
	$("#formID").submit();
	//window.resizeTo(850,335);
})

$("#cancel").click(function(){
	$("#removeSession").load("${ctx}/roomDefine/ResourceProperty!clearSession.action");
	window.close();
})
</script>
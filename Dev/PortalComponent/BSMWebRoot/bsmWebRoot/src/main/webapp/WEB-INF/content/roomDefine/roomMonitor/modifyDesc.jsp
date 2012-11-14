<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>编辑备注</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"
	type="text/javascript"></script>
<script>
if("<s:property value='saveFlag'/>" == "true") {
	if("<s:property value='resourceId'/>" == ""){
		if(opener.document.getElementById("ToolStripComponent")){
			opener.document.getElementById("ToolStripComponent").refreshBasicInforData();
		}
	}else {
		opener.loadResourceData("<s:property value='resourceId'/>");
	}
	window.close();
}
</script>
</head>
<page:applyDecorator name="popwindow" title="编辑备注">

	<page:param name="width">300px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>

	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>

	<page:param name="content">
		<form id="descForm" action="${ctx}/roomDefine/Desc!modifyDesc.action"
			name="descForm" method="post">
		<div>
		<ul class="fieldlist-n">
			<li><span class="field">备注:</span> <textarea name="desc"
				id="desc" cols="42" rows="3" class="validate[length[0,300]]"><s:property value='desc' /></textarea></li>
		</ul>
		</div>
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		<input type="hidden" name="resourceId" id="resourceId" value="<s:property value='resourceId' />" />
	</form>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	$("#descForm").submit();
})

$("#cancel").click(function(){
	window.close();
})
</script>





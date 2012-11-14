<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="分配工作组">
    <page:param name="width">260px;</page:param>
	<page:param name="height">44px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">ok_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
    <page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
	<div><ul class="fieldlist-n">
	  <li><span class="field-middle">工作组：</span>
	    <label>
	      <s:select id="workGroupId" list="workGroups" name="pageQueryVO.workGroupId" listKey="key" listValue="value" />
	    </label><span class="red">*</span>
	  </li>
	</ul>
	</div>
	</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$("#topBtn1").click(function() {
		window.close();
  	});
	$("#ok_button").click(function() {
		window.returnValue = $("#workGroupId").val();
		window.close();
  	});
	$("#cancel_button").click(function() {
		window.returnValue = "";
		window.close();
  	});
});
</script>
</html>
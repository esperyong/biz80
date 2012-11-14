<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>提示</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#topBtn1").click(function() {
		window.close();
  	});
	$("#no_button").click(function() {
		window.returnValue = false;
		window.close();
  	});
	$("#yes_button").click(function() {
		window.returnValue = true;
		window.close();
  	});
});
</script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
</style>
</head>
<body>
<page:applyDecorator name="popwindow"  title="提示">

    <page:param name="width">350px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">yes_button</page:param>
	<page:param name="bottomBtn_text_1">是</page:param>
	
    <page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">no_button</page:param>
	<page:param name="bottomBtn_text_2">否</page:param>
	
	<page:param name="content">
	<div class="promp-win-content">
		<span class="promp-win-ico promp-win-ico-question"><span class="txt">最多能导出最近1000条记录，是否继续？</span></span>
	</div>
	</page:param>
</page:applyDecorator>
</body>
</html>
<!-- \WEB-INF\content\location\relation\operationFail.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>新建</title>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.select.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
</head>

<body >
<page:applyDecorator name="popwindow"  title="操作失败">
	
	<page:param name="width">400px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>

	<page:param name="content">
		<s:hidden name="equipment.domain" id="domain"/>
		<s:hidden name="equipment.id" id="equipment_id"/>
		<ul class="fieldlist-n">
		<s:iterator value="%{operationFlag.entrySet()}" status="flag">
			<li><s:property value="%{getText('i18n.'+key)}"/></li>
		</s:iterator>
		</ul>
	</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		
		$("#closeId").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			window.close();
		});
	});
</script>
</html>
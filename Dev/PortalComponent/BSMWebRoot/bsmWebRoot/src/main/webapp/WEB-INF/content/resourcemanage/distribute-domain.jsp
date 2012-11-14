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
<%
java.lang.String rangeName = com.mocha.bsm.resourcemanage.common.RangeName.rangeName();
java.lang.String title = "分配" + rangeName;
%>
<body>
<page:applyDecorator name="popwindow"  title="<%=title %>">
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
	 <div>
	    <ul class="fieldlist-n">
	      <li><span class="field-middle" style="float:left;height:21px;line-height:21px;width:140px">目的<%=rangeName %>：</span>
	        <span><label>
	          <s:select id="distDomainId" list="domains" name="pageQueryVO.domainId" listKey="key" listValue="value" cssStyle="width:65px;" />
	        </label></span>
	        <span class="red">*</span> </li>
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
		window.returnValue = $("#distDomainId").val();
		window.close();
  	});
	$("#cancel_button").click(function() {
		window.returnValue = "";
		window.close();
  	});
});
</script>
</html>
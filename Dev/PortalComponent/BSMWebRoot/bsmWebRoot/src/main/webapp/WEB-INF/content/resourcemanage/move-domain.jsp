<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
</head>
<%
java.lang.String rangeName = com.mocha.bsm.resourcemanage.common.RangeName.rangeName();
java.lang.String title = "迁移" + rangeName;
%>
<body>
<page:applyDecorator name="popwindow"  title="<%=title %>">
    <page:param name="width">400px;</page:param>
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
	<div class="fold-blue">
	  <div>
	    <ul class="fieldlist-n">
	      <li><span class="field-middle" style="float:left;height:21px;line-height:21px;width:140px">目的<%=rangeName %>：</span>
	        <span><label>
	          <s:select id="distDomainId" list="domains" name="pageQueryVO.domainId" listKey="key" listValue="value" cssStyle="width:200px;"/>
	        </label></span>
	        <span class="red">*</span> </li>
	    </ul>
	  </div>
	  <div>
	<div class="blue-bg-notice"><span class="ico ico-tips"></span><span class="vertical-middle bold">提示</span> </div>
	<div><ul class="fieldlist-n">
	  <li><span class="mr-title-ico"></span>资源所属<%=rangeName %>改变，原<%=rangeName %>中的人员对该资源的权限将清除。
	  </li>
	  <li><span class="mr-title-ico"></span>若已在原<%=rangeName %>的监控策略、资源组、报告、告警视图中需要手工从这些视图中移出。
	  </li>
	</ul></div>
	</div>
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
	SimpleBox.renderAll();
});
</script>
</html>
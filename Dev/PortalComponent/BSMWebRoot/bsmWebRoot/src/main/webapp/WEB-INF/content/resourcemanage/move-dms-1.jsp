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
<page:applyDecorator name="popwindow"  title="DMS资源迁移">
    <page:param name="width">400px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">ok_button</page:param>
	<page:param name="bottomBtn_text_1">开始迁移</page:param>

	<page:param name="content">
		<div class="fold-blue">
		   <div class="fold-top">
				<span class="fold-top-title">1.选择迁移的目的DMS</span>
			</div>
		<div>
		<div class="resources-search"><span class="sub-panel-tips">1. 迁移时会把资源及其监控设置一起迁移到目的DMS。<br/> 2. 迁移时资源所在的源DMS和迁移的目的DMS将自动重启。</span> </div>
		<div><ul class="fieldlist-n">
		  <li><span class="field-middle">目的DMS：</span>
		    <label>
		    	<s:select id="distDmsId" list="dmss" name="pageQueryVO.dms" listKey="key" listValue="value" />
		    </label><span class="red">*</span>
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
		window.returnValue = $("#distDmsId").val();
		window.close();
  	});
});
</script>
</html>
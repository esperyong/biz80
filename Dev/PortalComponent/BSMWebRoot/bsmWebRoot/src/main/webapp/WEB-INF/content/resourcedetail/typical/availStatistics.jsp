<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <%@ include file="/WEB-INF/common/meta.jsp"%>
  <link rel="stylesheet" type="text/css" href="${ctx}/css/master.css" />
  <link rel="stylesheet" type="text/css" href="${ctx}/css/public.css" />
  <link href="${ctx}/css/common.css" rel="stylesheet" type="text/css"/>
  <link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
  <link rel="stylesheet" type="text/css" href="${ctxCss}/business-grid.css" />
  <script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
  <title><s:text name="detail.info.usability" /></title>
</head>
<body>
<div class="loading" id="loading" style="display:none;">
  <div class="loading-l">
    <div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.loading.msg" /></span></div>
   </div>
  </div>
</div>

<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.info.usability" /></page:param>
  <page:param name="width">600px;</page:param>
  <page:param name="height">600px;</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">win_close</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
  
  <page:param name="content">
	  <div id="availDiv">
		  <s:action name="availstatistics" namespace="/detail" executeResult="true" flush="false">
		    <s:param name="instanceId">${instanceId}</s:param>
		  </s:action>
	  </div>
  </page:param>

</page:applyDecorator>
<script type="text/javascript">
$(function(){

  $('#win_close').click(function(){
    window.close();
  });
});
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/loading.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%
	String instanceId = request.getParameter("instanceId");
	String resourceId = request.getParameter("resourceId");
%>
<title>加入监控</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/resource-monitor.js" ></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js" ></script>

<script type="text/javascript">
var instanceId = "<%=instanceId%>";
var resourceId = "<%=resourceId%>";
var ctx = "${ctx}";
var defaultProfileFlag = '<s:property value="@com.mocha.bsm.resourcediscovery.util.Constants@DEFAULT_PROFILE_MARK_ID"/>';
var isSubmit = false;
$(document).ready(function() {
	
	//SimpleBox.renderAll();
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:'profileId', maxHeight:50}]);
	
	$("#closeId").bind("click", function() {
		window.close();
	});
	$("#loading_text").html('<s:text name="page.loading.msg" />');
})
</script>
</head>
<body class="pop-window">
<form id="form1" name="form1" method="post">
<input type="hidden" name="isEnable" id="isEnable" value="true">
<page:applyDecorator name="popwindow"  title="加入监控">
  
  <page:param name="width">400px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">sp_ok</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">sp_cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
  <page:param name="content">

	  <div class="pop-content ">
			<div class="content-padding">
				<div class="h1">
					<span class="field" style="padding-top:5px; float: left;">选择监控策略：</span>
					<s:select list="profileList" listKey="id" listValue="name" id="profileId" name="profileId" offsetWidth="170"></s:select>
				</div>
				<div style="height:50px;">&nbsp;</div>
			</div>
	  </div>
	
  </page:param>
</page:applyDecorator>
</form>
</body>
</html>
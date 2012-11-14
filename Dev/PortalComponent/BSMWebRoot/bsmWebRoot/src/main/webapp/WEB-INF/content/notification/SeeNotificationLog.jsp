<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<title>查看告警日志</title>
<script>
path = '${ctx}';
</script>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
	<script src="${ctx}/js/component/cfncc.js"></script>
	<script src="${ctx}/js/component/gridPanel/grid.js"></script>
	<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
	<script src="${ctx}/js/component/gridPanel/page.js"></script>
	<script src="${ctx}/js/jquery.blockUI.js"></script>
	<script src="${ctx}/js/component/toast/Toast.js"></script>
	<script src="${ctx}/js/component/panel/panel.js"></script>
</head>
<script type="text/javascript">
$(function() {
	$('#close_button').click(function(){
		window.close();
	})
})
</script>
<body>
<page:applyDecorator name="popwindow"  title="告警日志">
 <page:param name="width">1000px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1">关闭</page:param>

 <page:param name="bottomBtn_index_1">1</page:param>
 <page:param name="bottomBtn_id_1">close_button</page:param>
 <page:param name="bottomBtn_text_1">关闭</page:param>

 <page:param name="content">
  <div><s:action name="notificationlist"  namespace="/notification"  executeResult="true" ignoreContextParams="true" flush="false">
        <s:param name="eventDataId" value="eventDataId"/>
        <s:param name="orderBy"></s:param>
		<s:param name="orderType"></s:param>
		<s:param name="currentPage"></s:param>
        <s:param name="pageHeight">600</s:param>
        </s:action>
  </div>
</page:param>
</page:applyDecorator>
</body>
</html>

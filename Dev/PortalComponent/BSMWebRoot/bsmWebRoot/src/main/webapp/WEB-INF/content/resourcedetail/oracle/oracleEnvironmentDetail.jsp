<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>  
<%@ include file="/WEB-INF/common/meta.jsp" %>  
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
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
	<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
	<script type="text/javascript">
	</script>
</head>
<body>

<page:applyDecorator name="popwindow">
 <page:param name="title"><s:text name="detail.database.userenv" /></page:param>
 <page:param name="width">640px;</page:param>
 <page:param name="height">290px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">close_button</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
 
 <page:param name="content">
 
<div style="width:80%; margin-left: 2px; margin-top: 2px;">
	<textarea cols="120" rows="19" readonly><s:property value='text'/></textarea>
</div>

</page:param>
</page:applyDecorator>

</body>
</html>
<script language="javascript">
	$(function(){
		$('#close_button').click(function(){
			window.close();
		});
	});
</script>
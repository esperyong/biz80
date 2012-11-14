<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>第三方集成</title>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/tabPanel/tab.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
#platFormTable{
	background:black;
}
</style>
</head>
<body>
<page:applyDecorator name="popwindow"  title="第三方集成">
    <page:param name="width">700px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    <page:param name="topBtn_title_1">关闭</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">ok_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
    <page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
    <page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">app_button</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>
	
	<page:param name="content">
		<page:applyDecorator name="tabPanel">
		<page:param name="id">platFormTable</page:param>
		<page:param name="width">685px</page:param>
		<page:param name="tabBarWidth"></page:param>
		<page:param name="cls">tab-grounp</page:param>
		<page:param name="current">1</page:param>
		<page:param name="tabHander">[{text:"平台管理",id:"platformset"}]</page:param>
		<page:param name="content_1">
			<div id="platForms">
			<s:action name="platFormSet!platFormSetList" namespace="/event" executeResult="true" ignoreContextParams="true" />
			</div>
		</page:param>
		</page:applyDecorator>
	</page:param>
</page:applyDecorator>
</body>
</html>
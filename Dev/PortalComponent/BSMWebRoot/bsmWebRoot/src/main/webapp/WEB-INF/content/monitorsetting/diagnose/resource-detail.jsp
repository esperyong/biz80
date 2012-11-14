<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/manage.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/jquery-ui/jquery.ui.treeview.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctxJs}/monitorsetting/monitorsetting.js"></script>
<script type="text/javascript">
$(function(){
	BSM.Monitorsetting.Diagnose.initResourceDetail();
	$("#closeId").click(function(){
		window.close();
	});
});
</script>
</head>
<body>
<page:applyDecorator name="popwindow" title="诊断报告">
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	<page:param name="content">
		<div class="h2">IP地址：${ip}</div>
		<fieldset class="blue-border-nblock">
			<legend>SNMP 诊断结果</legend>
			<page:applyDecorator name="indexgrid">  
			   <page:param name="id">snmpGridPanel</page:param>
			   <page:param name="height">100%</page:param>
			   <page:param name="tableCls">grid-gray</page:param>
			   <page:param name="gridhead">[{colId:"mibName", text:"MIB-Name"},{colId:"oid",text:"OID"},{colId:"mibNode",text:"MIB-Node"},{colId:"value",text:"Value"}]</page:param>
			   <page:param name="gridcontent">${snmpResult}</page:param>
			</page:applyDecorator>
		</fieldset>
		<fieldset class="blue-border-nblock">
			<legend>MRAM诊断结果</legend>
			<page:applyDecorator name="indexgrid">  
			   <page:param name="id">mramGridPanel</page:param>
			   <page:param name="height">100%</page:param>
			   <page:param name="tableCls">grid-gray</page:param>
			   <page:param name="gridhead">[{colId:"pluginName", text:"插件名称"},{colId:"version",text:"版本"},{colId:"value",text:"值"}]</page:param>
			   <page:param name="gridcontent">${mramResult}</page:param>
			</page:applyDecorator>
		</fieldset>
		<fieldset class="blue-border-nblock">
			<legend>WMI诊断结果</legend>
			<page:applyDecorator name="indexgrid">  
			   <page:param name="id">wmiGridPanel</page:param>
			   <page:param name="height">100%</page:param>
			   <page:param name="tableCls">grid-gray</page:param>
			   <page:param name="gridhead">[{colId:"nameSpace", text:"Namespace"},{colId:"className",text:"Class"},{colId:"value",text:"Value"}]</page:param>
			   <page:param name="gridcontent">${wmiResult}</page:param>
			</page:applyDecorator>
		</fieldset>
	</page:param>
</page:applyDecorator>
</body>
</html>
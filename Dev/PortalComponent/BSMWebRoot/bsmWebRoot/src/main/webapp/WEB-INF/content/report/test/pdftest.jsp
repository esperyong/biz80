<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<meta name="decorator" content="headfoot" />
<page:applyDecorator name="headfoot">
	<page:param name="head">
		<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
		<link href="${ctxCss}/master.css"  rel="stylesheet" type="text/css"  />
		<link href="${ctxCss}/jquery-ui/treeview.css" type="text/css" rel="stylesheet"/>
		<link href="${ctxCss}/jquery-ui/jquery.ui.treeview.css" rel="stylesheet"type="text/css">
		<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
		<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>		
		<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
		<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
		<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js" ></script>
		<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>		
        <script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
        <script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
        <script type="text/javascript" src="${ctxJs}/report/statistic/statisticMetric.js"></script>
        <script type="text/javascript" src="${ctxJs}/report/statistic/statisticUtil.js"></script>		
	</page:param>	
	<page:param name="body"> 
	<form id="exportparams">
		<s:textfield type="text"  name="reportID"  value="" size="50" id="reportID" />
		<s:textfield type="text"  name="exportFileName"  value="" size="50" id="exportFileName" />
		<s:select name="reportType" list="#{'Performance':'性能','Malfunction':'故障','Event':'事件','Alarm':'告警'}"></s:select>
		<s:textfield type="text"  name="exportFileType"  value="" size="50" id="exportFileType" />
    </form>
    <span>生成</span><input type="button" onclick="createReport()">
	<span>下载</span><input type="button" onclick="exportReport()">
	
	
	</page:param>
</page:applyDecorator>

<script type="text/javascript">

function createReport(){
	$("#exportparams").attr("action", "${ctx}/report/statistic/testManager!generateReport.action");
    $("#exportparams").submit();
}
function exportReport() {
    $("#exportparams").attr("action", "${ctx}/report/statistic/testManager!getDownLoadFile.action");
    $("#exportparams").submit();
}

</script>
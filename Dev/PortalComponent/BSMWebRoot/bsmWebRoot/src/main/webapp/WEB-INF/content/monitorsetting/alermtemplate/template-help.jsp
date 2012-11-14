<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.bsm.action.monitorsetting.alermtemplate.TemplateConstant"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
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
</head>
<body  class="pop-window">
<form name="templateformname" id="templateformname" method="post">
<page:applyDecorator name="popwindow" title="模板">
	<page:param name="width">640px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="content">
		<input type="hidden" id="alermMethod" name="alermMethod" value="${templateVO.alermMethod }">
		<input type="hidden" id="moduleId" name="moduleId" value="${templateVO.moduleId }">
		<input type="hidden" id="eventClass" name="eventClass" value="${templateVO.eventClass }">
		<input type="hidden" id="id" name="id" value="${templateVO.id }">
			<ul class="fieldlist-n">
			<table class="black-grid black-grid-blackb ">	
			<tr style="background: f7;f7f7;">
				<th>变量</th>
				<th>说明</th>
				</tr>
			<s:iterator id="list" value="tabList" status="i">
				<s:if test="#i.index%2==0"><tr class="black-grid-graybg"></s:if>
				<s:else><tr></s:else>
				<td><s:property value="#list.templateName" /></td>
				<td><s:property value="#list.templateDesc" /></td>
				</tr>
			</s:iterator>
			</table>
			注：告警模板中所有带$符号中的变量不可修改，但可删除不用。$符号外信息可以编辑。
			</ul>
		
	</page:param>
</page:applyDecorator>
</form>
<script type="text/javascript">
		$("#closeId").click(function (){
			window.close();
		})
</script>

</body>

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
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctxJs}/monitorsetting/monitorsetting.js"></script>
<script type="text/javascript" src="${ctxJs}/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js" ></script>
</head>
<body>
<div class="separated10"></div>
<div class="main">
	<div class="main-left f-absolute" style="width:210px;left: 0px;">
	<s:iterator id="pagelist" value="pageChildList">
	<input id="classid" type="hidden" value="class_/monitorsetting/alermtemplate/index.action?type=EMAIL">
		<page:applyDecorator name="monitorsettingLeftPanel">
			<page:param name="title"><s:property value="#pagelist.pageName" /></page:param>
			<page:param name="content">
				<ul>
					<s:iterator id="pagedlist" value="#pagelist.ChildList">
						<li><div class="ico ico-policy-child"></div>
						<a id="leftid" name="<s:property value="#pagedlist.path" />" href="javascript:void(0);" >
						
						<s:if test="#pagedlist.pageId=='page-ADMIN0000000031'">
						<span id="class_<s:property value="#pagedlist.path" />" class="bold"><s:property value="#pagedlist.pageName" /></span>
						</s:if>
						<s:else>
						<span id="class_<s:property value="#pagedlist.path" />" class=""><s:property value="#pagedlist.pageName" /></span>
						</s:else>
						
						</a></li>
					</s:iterator>
				</ul>
			</page:param>
		</page:applyDecorator> 
	</s:iterator>
	</div>
	<div class="main-right" id="globalsettingmainright" style="margin-left: 220px;">
		<s:action name="index" namespace="/monitorsetting/alermtemplate" executeResult="true"></s:action>
	</div>
</div>
</body>
</html>
<script language="javascript">
var ctx = "${ctx}";
$(function(){
	BSM.Monitorsetting.initMonitorsetting();
	BSM.Monitorsetting.Template.initIndex();
});

</script>

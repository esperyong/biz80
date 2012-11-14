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
	<script src="${ctx}/js/component/comm/winopen.js"></script>
	<script src="${ctx}/js/component/popwindow/popwin.js"></script>
	<script type="text/javascript">
		var path = "${ctx}";
		var autority = "${authority}"; 
	</script>
</head>
<body>
<form name="wireListForm" id="wireListForm" method="post">
<input type="hidden" name="forPageVO.orderColumn" value="${forPageVO.orderColumn}" id="orderColumn"/>
<input type="hidden" name="forPageVO.orderType" value="${forPageVO.orderType}" id="orderType"/>
<input type="hidden" name="forPageVO.currentPage" value="${forPageVO.currentPage}" id="currentPage"/>
<input type="hidden" name="instanceId" value="${instanceId}" id="instanceId"/>
<input type="hidden" name="authority" value="${authority}" id="authority"/>
<page:applyDecorator name="popwindow"  title="已使用的Action列表">
 <page:param name="width">800px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1">关闭</page:param>
 <page:param name="content">
 <div class="whitebg" style="width:785px;">
<div class="right">
	<s:if test="authority == 'true'">
		<span class="right r-ico r-ico-delete" title="删除"></span> <span class="right ico ico-add" title="添加"></span></div>
	</s:if>
	<div id="child_cirgrid">
		<s:action name="actionListChild"  namespace="/wireless/actionForPage"  executeResult="true" ignoreContextParams="true" flush="false">
			<s:param name="instanceId" value="#instanceId"></s:param>
		</s:action>
	 </div>
 </div>
 </page:param>
</page:applyDecorator>
</form>
<script type="text/javascript" src="${ctx}/js/wireless/wirelessList.js"></script>
</body>
</html>
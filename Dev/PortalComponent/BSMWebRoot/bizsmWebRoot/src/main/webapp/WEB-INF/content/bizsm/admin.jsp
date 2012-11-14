<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:liuyong
	description:业务服务后台管理页面
	uri:{domainContextPath}/admin/console
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务后台管理页面</title>

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/pullBox/j-dynamic-pullbox.js"></script>

<script language="javascript">

	$(function() {

	});
	

</script>
</head>
<body>
	<s:if test="result != null">
		This user is too old.
	</s:if>
	<form action="${ctx}/admin/shell">
		<input type="hidden" name="command" value="init_service_state_normal"/>
		<input type="submit" name="SubBtn" value="初始化业务服务状态"/>
	</form>
</body>
</html>
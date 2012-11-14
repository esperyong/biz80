<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务状态统计栏
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-status-bar
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ToolService</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/service.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/toolBar/j-dynamic-statusbar.js"></script>

<script language="javascript">
	$(function() {
		var jStatusbar = new JDynamicStatusbar({id: "jStatusbar-bizService", label: "业务服务"});
		var statusMap = {};
		statusMap["red"] = 10;
		statusMap["yellow"] = 20;
		statusMap["green"] = 30;
		statusMap["gray"] = 50;
		jStatusbar.setAllValues(statusMap);

		jStatusbar.appendToContainer("body");

	});
</script>
</head>
<body>

</body>
</html>

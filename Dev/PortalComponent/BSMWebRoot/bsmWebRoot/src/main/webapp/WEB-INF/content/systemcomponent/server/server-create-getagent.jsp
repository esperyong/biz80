<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>选择Agent</title>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
</head>
<body>
<div style="height: 200px;overflow: auto">
<span class="txt-white">选择Agent</span>
<span class="txt-white">
${agentTree}
</span>
</div>
<script type="text/javascript">
var agentTree = new Tree({id:"agentTree"});
</script>
</body>
</html>

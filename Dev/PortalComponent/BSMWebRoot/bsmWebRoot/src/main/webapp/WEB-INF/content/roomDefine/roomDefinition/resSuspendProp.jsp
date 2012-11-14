<!-- 机房-机房监控-显示3D悬浮属性页 resSuspendProp.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />

</head>

<body>
<s:form  namespace="/roomDefine">
	<div style="width:100% height:100%" id="prop">
	<li><span class="field">名称:</span> <input type="text"
		class="validate[custom[noSpecialStr],length[0,30 ]" name="name"
		id="name" siz="40" value="${resource.name}"></input></li>
	<li><span class="field">类型:</span> <input type="text"
		class="validate[custom[noSpecialStr],length[0,30 ]" name="type"
		id="type" siz="40" value=""></input></li>
	<li><span class="field">状态:</span> <input type="text"
		class="validate[custom[noSpecialStr],length[0,30 ]" name="state"
		id="state" siz="40" value=""></input></li>
	<li><span class="field">备注:</span> <input type="text"
		class="validate[custom[noSpecialStr],length[0,30 ]" name="notes"
		id="notes" siz="40" value="${resource.desc}"></input></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	<li><span class="field">:</span></li>
	</div>
</s:form>
</body>
</html>
<script type="text/javascript">

</script>
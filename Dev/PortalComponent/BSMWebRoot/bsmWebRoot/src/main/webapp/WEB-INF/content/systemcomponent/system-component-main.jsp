<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.bsm.system.SystemContext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<title>System Component</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/manage.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/jquery-ui/treeview.css" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js" ></script>
<script type="text/javascript" src="${ctx}/js/systemcomponent/system-component.js"></script>
</head>
<body>
<div class="separated10"></div>
<div class="main">
	<div class="main-left f-absolute" style="width: 210px;left: 0px;">
	
		<div class="panel" style="width:99%; margin-bottom: 10px;" >
			<div class="panel-top-l">
				<div class="panel-top-r">
					<div class="panel-top-m">
						<span class="pop-top-title">系统架构</span>
					</div>
				</div>
			</div>
		<div class="panel-m clear" style="width: 100%;">
			<div class="panel-m-content">
				<ul>
					<li><div class="ico ico-policy-child"></div><a href="javascript:void(0);" id="a_agent">Agent</a></li>
					<li><div class="ico ico-policy-child"></div><a href="javascript:void(0);" id="a_server">系统服务</a></li>
				</ul>
			</div>
		</div>
		<div class="panel-bottom-l"><div class="panel-bottom-r"><div class="panel-bottom-m"></div></div></div>
		</div>
		<% if (!SystemContext.isStandAlone()) { %>		
		<div class="panel" style="width:99%; margin-bottom: 10px;">
			<div class="panel-top-l">
				<div class="panel-top-r">
					<div class="panel-top-m">
						<span class="pop-top-title">资源发现与DMS</span>
					</div>
				</div>
			</div>
		<div class="panel-m" style="width: 100%;">
			<div class="panel-m-content">
				<ul>
					<li><div class="ico ico-policy-child"></div><a href="javascript:void(0);" id="leftdmsdomain">资源发现与DMS</a></li>
				</ul>
			</div>
		</div>
		<div class="panel-bottom-l"><div class="panel-bottom-r"><div class="panel-bottom-m"></div></div></div>
		</div>
		<%} %>
	</div>
	<div class="main-right" style="margin-left: 220px;" id="div_syscomp_right">
	
	</div>
</div>

</body>
</html>
<script language="javascript">
	var ctx = "${ctx}";
</script>
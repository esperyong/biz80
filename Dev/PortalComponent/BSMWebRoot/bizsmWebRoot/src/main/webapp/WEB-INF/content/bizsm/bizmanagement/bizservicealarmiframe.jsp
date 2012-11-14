<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:directive.page import="com.mocha.bsm.event.type.Module"/>
<%
String device = (String)request.getParameter("serviceId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务告警
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-affect
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title></title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />

<link href="/pureportal/css/master.css" rel="stylesheet" type="text/css"/>
<link href="/pureportal/css/UIComponent.css" rel="stylesheet" type="text/css"/>


<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.timeentry.min.js"></script>
<script type="text/javascript" src="/pureportal/js/profile/userDefineProfile/noAccessTime.js"> </script>

	<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.timeentry.min.js"></script>
	<script src="/pureportal/js/component/cfncc.js"></script>
	<script src="/pureportal/js/component/gridPanel/grid.js"></script>
	<script src="/pureportal/js/component/gridPanel/indexgrid.js"></script>
	<script src="/pureportal/js/component/gridPanel/page.js"></script>
	<script src="/pureportal/js/jquery.blockUI.js"></script>
	<script src="/pureportal/js/component/toast/Toast.js"></script>
	<script src="/pureportal/js/component/panel/panel.js"></script>
	<script type="text/javascript" src="/pureportal/js/component/menu/menu.js"></script>

<script language="javascript">
	function fristload(){

		var device=parent.device;
		var notionState=parent.notionState;
		var sendTime=parent.sendTime;
		var radio=parent.radio;
		var notStartTime=parent.notStartTime;
		var notEndTime=parent.notEndTime;
		var boxHeight=parent.boxHeight;

		$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"20"},function(){});

	}

</script>
</head>
<body onload="fristload()">
<div id="bizsrvaffect" style="position:absolute;top:0px;left:0px;width:100%;height:100%;"></div>

</body>
</html>
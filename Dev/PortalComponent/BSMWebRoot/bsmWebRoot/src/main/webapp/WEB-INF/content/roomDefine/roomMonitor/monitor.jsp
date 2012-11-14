<!-- 机房-机房监控-首页 monitor.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
<title>Mocha BSM</title>

</head>
<body>
<page:applyDecorator name="headfoot">
<page:param name="body">
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/room.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/flash/history/history.css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
	<div style="height: 90%; width: 98%; ">
	<!-- 页签 -->
	<div class="room-menu">
	<div class="title">
	
	<span id="roomStatus"><s:if test="status==1"><span class="lamp lamp-red"></span></s:if>
	<s:else><span class="lamp lamp-green"></span></s:else>
	</span>
	<span class="name"><s:property value='roomName' /></span></div>
	<div class="menu">
	<ul>
		<li class="first"></li>
		<li class="normal01" id="roomLayoutId" style="cursor:pointer"><span id="roomLayoutChooseId" class="room-tabico room-tabico-on"></span>机房布局</li>
		<li class="normal" id="metricId" style="cursor:pointer"><span id="metricChooseId" class="room-tabico room-tabico-no"></span>监控分析</li>
		<li class="normal" id="deviceOverviewId" style="cursor:pointer"><span id="deviceOverviewChooseId" class="room-tabico room-tabico-no"></span>设备一览</li>
		<s:if test="layout=='true'">
		<li class="normal" id="focusOverviewId" style="cursor:pointer"><span id="focusOverviewChooseId" class="room-tabico room-tabico-no"></span>网络拓扑</li>
		</s:if>
		<li class="normal" id="alarmOverviewId" style="cursor:pointer"><span id="alarmOverviewChooseId" class="room-tabico room-tabico-no"></span>告警管理</li>
		<s:if test="isVideo=='true'">
		<li class="normal" id="roomVideoId" style="cursor:pointer"><span id="roomVideoChooseId" class="room-tabico room-tabico-no"></span>机房视频</li>
		</s:if>
		<li class="jump" id="jump"><a href="${ctx}/roomDefine/MonitorVisit.action"><span class="jump-img"></span></a></li>
	</ul>
	</div>
	</div>

	<div class="clear"  id="dynamicJspId" ></div>
	
	</div>
</page:param>
</page:applyDecorator>
</html>

<script type="text/javascript">
var theBolck = $.blockUI; 
var theUnBolck = $.unblockUI;
$(document).ready(function() {
	$("#roomLayoutId").click(layoutFun);
	$("#metricId").click(metricFun);
	$("#deviceOverviewId").click(deviceOverviewFun);
	$("#focusOverviewId").click(focusOverviewFun);
	$("#alarmOverviewId").click(alarmOverviewFun);
	$("#roomVideoId").click(roomVideoFun);
});

function reomveTagClass(){
	$("#roomLayoutChooseId").removeClass();
	$("#metricChooseId").removeClass();
	$("#deviceOverviewChooseId").removeClass();
	$("#focusOverviewChooseId").removeClass();
	$("#alarmOverviewChooseId").removeClass();
	$("#roomVideoChooseId").removeClass();
}
function unBolck(){
	theUnBolck();
}
/**
 * 机房布局.
 */
function layoutFun() {
	reomveTagClass();
	$("#roomLayoutChooseId").toggleClass("room-tabico room-tabico-on");
	$("#metricChooseId").toggleClass("room-tabico room-tabico-no");
	$("#deviceOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#focusOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#alarmOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#roomVideoChooseId").toggleClass("room-tabico room-tabico-no");
	
	ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/MonitorVisit!showRoom.action");
}
/**
 * 指标分析.
 */
function metricFun() {
	reomveTagClass();
	$("#roomLayoutChooseId").toggleClass("room-tabico room-tabico-no");
	$("#metricChooseId").toggleClass("room-tabico room-tabico-on");
	$("#deviceOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#focusOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#alarmOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#roomVideoChooseId").toggleClass("room-tabico room-tabico-no");
	theBolck({message:$('#loading')});
	ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/MonitorAnalyzeVisit.action");
}
/**
 * 设备一览
 */
function deviceOverviewFun() {
	
	reomveTagClass();
	$("#roomLayoutChooseId").toggleClass("room-tabico room-tabico-no");
	$("#metricChooseId").toggleClass("room-tabico room-tabico-no");
	$("#deviceOverviewChooseId").toggleClass("room-tabico room-tabico-on");
	$("#focusOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#alarmOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#roomVideoChooseId").toggleClass("room-tabico room-tabico-no");
	theBolck({message:$('#loading')});
	ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/DeviceOverviewVisit.action");
}
/**
 * 网络拓扑
 */
function focusOverviewFun() {
	reomveTagClass();
	$("#roomLayoutChooseId").toggleClass("room-tabico room-tabico-no");
	$("#metricChooseId").toggleClass("room-tabico room-tabico-no");
	$("#deviceOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#focusOverviewChooseId").toggleClass("room-tabico room-tabico-on");
	$("#alarmOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#roomVideoChooseId").toggleClass("room-tabico room-tabico-no");
	ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/NetfocusOverview.action");
}
/**
 * 告警管理
 */
function alarmOverviewFun() {
	
	reomveTagClass();
	$("#roomLayoutChooseId").toggleClass("room-tabico room-tabico-no");
	$("#metricChooseId").toggleClass("room-tabico room-tabico-no");
	$("#deviceOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#focusOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#alarmOverviewChooseId").toggleClass("room-tabico room-tabico-on");
	$("#roomVideoChooseId").toggleClass("room-tabico room-tabico-no");
	
	theBolck({message:$('#loading')});
	
	ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/AlarmOverview.action");
	

}

function alarmOverviewFunFlash() {
	reomveTagClass();
	$("#roomLayoutChooseId").toggleClass("room-tabico room-tabico-no");
	$("#metricChooseId").toggleClass("room-tabico room-tabico-no");
	$("#deviceOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#focusOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#alarmOverviewChooseId").toggleClass("room-tabico room-tabico-on");
	$("#roomVideoChooseId").toggleClass("room-tabico room-tabico-no");
	ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/AlarmOverview.action");
}
/**
 * 机房视频
 */
function roomVideoFun() {
	reomveTagClass();
	$("#roomLayoutChooseId").toggleClass("room-tabico room-tabico-no");
	$("#metricChooseId").toggleClass("room-tabico room-tabico-no");
	$("#deviceOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#focusOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#alarmOverviewChooseId").toggleClass("room-tabico room-tabico-no");
	$("#roomVideoChooseId").toggleClass("room-tabico room-tabico-on");
	 ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/RoomVideoVisit.action");
}


/**
 * 加载页面 .
 */
function ajaxloadDivFun(roomId,url) {
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"roomId="+roomId+"&topOffset=33&isSelf=true", 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			$("#dynamicJspId").find("*").unbind();
			$("#dynamicJspId").html("");
			$("#dynamicJspId").append(data);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}
layoutFun();

function roomStatus(status){
	if (status=="1"){
		$("#roomStatus").html("<span class='lamp lamp-red'></span>");
	}else{
		$("#roomStatus").html("<span class='lamp lamp-green'></span>");
	}
}
</script>

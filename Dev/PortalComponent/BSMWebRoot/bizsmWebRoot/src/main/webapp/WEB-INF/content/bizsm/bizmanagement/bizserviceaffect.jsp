<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<jsp:directive.page import="com.mocha.bsm.event.type.Module"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务影响
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-affect
 -->
<%
	String fromStr = request.getParameter("from")==null?"":request.getParameter("from");
%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务影响</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="/pureportal/css/master.css" rel="stylesheet" type="text/css"/>
<link href="/pureportal/css/UIComponent.css" rel="stylesheet" type="text/css"/>

<style type="text/css">
	html,body{height:100%;width:100%}
</style>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.timeentry.min.js"></script>
<script type="text/javascript" src="/pureportal/js/profile/userDefineProfile/noAccessTime.js"> </script>
<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>


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

<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>
<script language="javascript">

	var path = "/pureportal";

	var realWidth = 0, realHeight = 0;

	$(function(){

		/*
		$(window).resize(function(event){
			event.preventDefault();
			event.stopPropagation();

			return false;
		});
		*/

		realWidth = document.body.clientWidth;
		realHeight = document.body.clientHeight;

		$('#bizsrvaffect').css("width", realWidth-50);
		$('#flashContent').css("height", realHeight);


		init();
	});

	function init(){

		var swfVersionStr = "10.0.0";
		var xiSwfUrlStr = "playerProductInstall.swf";
		var flashvars = {};
		//flashvars["uri"] = "./testAssets/FullData.xml";
		flashvars["webRootPath"] = "${ctx}/";

		var params = {};
		params.quality = "high";
		params.bgcolor = "#ffffff";
		params.allowscriptaccess = "always";
		params.wmode = 'transparent';
		params.allowfullscreen = "true";
		params.enablejs= "true";


		var attributes = {};
		attributes.id = "Biz3dCurve";
		attributes.name = "Biz3dCurve";
		attributes.align = "left";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/BizInfluence.swf", "flashContent",
			realWidth-38, 300,
			swfVersionStr, xiSwfUrlStr,
			flashvars, params, attributes);
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");

		initFlashContentObj("BizInfluence");


	}

	if(window.HP){
		 HP.addActivate(function(){
			alert("invoke addActivate");
		 });
		 HP.addSleep(function(){
			alert("invoke addSleep");
		 });
		 HP.addDestory(function(){
			alert("invoke addDestory");
		 });
	}

	function display(device){
		document.getElementById("device").value = device;
		var device=$("#device").attr("value");
		var notionState=document.getElementById("state").value;
		var sendTime="RECENT_1_HOUR";
		var radio="1";
		var notStartTime=""
		var notEndTime="";

		var realHeight = document.body.clientHeight;

		//按比例显示告警信息
		var fromStr = '<%=fromStr%>';
		if(fromStr == "home"){
			$('#searchCondition').css("top","295px");
			$('#bizsrvaffect').css("top","330px");

			if(realHeight*1 > 700){
				var boxHeight = Math.round(realHeight*0.1)+100;
				$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"8"},function(){});
			}else{
				var boxHeight = Math.round(realHeight*0.1);
				$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"4"},function(){});
			}
		}
		else{
			$('#searchCondition').css("top","305px");
			$('#bizsrvaffect').css("top","330px");

			if(realHeight*1 > 600){
				var boxHeight = Math.round(realHeight*0.2)+100;
				$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"10"},function(){});
			}else{
				var boxHeight = Math.round(realHeight*0.2);

				$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"6"},function(){});
			}
		}
	}

</script>
</head>
<body style="text-align:left;margin:0;">
<script type="text/javascript">
	//init();
</script>
<div id="flashContent" style="position:absolute;top:0px;left:0px;z-index:1;">
</div>
<form id="queryForm">
<div id="searchCondition" style="overflow:hidden;width:1000px;position:absolute;top:305px;left:5px;right:0px;z-index:1;">
<ul>
<li>
	<span class="field" style="padding-left:20px;color:white" >告警状态：</span>
	<select id="state" name="state" style="position:relative;left:-20px">
		<option value="false">未确认</option>
		<option value="true">已确认</option>
		<option value="">全部</option>
	</select>
	<span  class="field" style="color: white">告警时间：</span>
      <input type="radio" value="1" name="radio" checked="checked" id="alarmTime" onclick="radioSelected();"></input>
	  <select id="sendTime" name="sendTime" style="position:relative;left:-1px">
		<option value="RECENT_1_HOUR">最近1小时</option>
		<option value="RECENT_3_HOURS">最近3小时</option>
		<option value="RECENT_6_HOURS">最近6小时</option>
		<option value="RECENT_12_HOURS">最近12小时</option>
		<option value="RECENT_1_DAY">最近1天</option>
		<option value="RECENT_7_DAY">最近7天</option>
	</select>
      <input type="radio" value="2" name="radio"  id="alarmTime"  onclick="radioSelected();"></input>
      <span style="color: white">从</span> <input type="text" name="notStartTime" id="notStartTime" maxlength="19" size="22" readonly="readonly" />
      <span style="color: white">到</span> <input type="text" name="notEndTime" id="notEndTime" maxlength="19" size="22" readonly="readonly"/>
  	<span class="ico" title="搜索" onclick="serchDislay();"></span>
</li>
<li></li>
</ul>
</div>
<input type="hidden" id="notificationObjId" name="notificationObjId" value="service" />
<input type="hidden" id="device" name="device" value="" />
<div id="bizsrvaffect" style="position:absolute;top:330px;left:5px;right:0px;z-index:1">
</div>
</form>
<script>
function radioSelected(){
	var radio=$("input[name='radio']:checked").val();

	if(radio==1){

		document.getElementById("notStartTime").disabled=true;
		document.getElementById("notEndTime").disabled=true;
		queryForm.sendTime.disabled=false;

		$('input[id="notStartTime"],input[id="notEndTime"]').removeClass("Wdate");
		//$('input[id="notStartTime"],input[id="notEndTime"]').addClass("WdateGray");
		//$('#state').disable();
		//document.getElementById("notEndTime").style.backgroundColor= "gray";
	}else if(radio==2){

		queryForm.sendTime.disabled=true;
		//$('#state').enable();
		document.getElementById("notStartTime").disabled=false;
		document.getElementById("notEndTime").disabled=false;

		$('input[id="notStartTime"],input[id="notEndTime"]').addClass("Wdate");
		//$('input[id="notStartTime"],input[id="notEndTime"]').removeClass("WdateGray");
	}
}
function serchDislay(){
//业务服务ID
var device=$("#device").attr("value");
//alert("device="+device);
var notionState=document.getElementById("state").value;
//告警状态
//var notionState=$('#state option:selected').value();
//alert("notionState="+notionState);
//告警时间
var sendTime=document.getElementById("sendTime").value;
//var sendTime=$('#state option:selected').value();
//alert("sendTime="+sendTime);
//开始时间
var notStartTime=""
notStartTime=document.getElementById("notStartTime").value;
//var notStartTime=$("#notStartTime").attr("value");
//alert("notStartTime="+notStartTime);
//结束时间
var notEndTime="";
notEndTime=document.getElementById("notEndTime").value;
//var notEndTime=$("#notEndTime").attr("value");
//alert("notEndTime="+notEndTime);
//时间选择按钮
var radio=$("input[name='radio']:checked").val();
//alert("radio="+radio);

//按比例显示告警信息
var realHeight = document.body.clientHeight;

var fromStr = '<%=fromStr%>';
	if(fromStr == "home"){
		if(realHeight*1 > 700){
			var boxHeight = Math.round(realHeight*0.1)+100;
			$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"8"},function(){});
		}else{
			var boxHeight = Math.round(realHeight*0.1);
			$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"4"},function(){});
		}
	}
	else{
		$('#searchCondition').css("top","305px");
		$('#bizsrvaffect').css("top","330px");

		if(realHeight*1 > 600){
			var boxHeight = Math.round(realHeight*0.2)+100;
			$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"10"},function(){});
		}else{
			var boxHeight = Math.round(realHeight*0.2);

			$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"6"},function(){});
		}
	}

}
function getDate(s){
 var now;
 if (s != 0) {
  now = new Date(s);
 } else {
  now = new Date();
 }
 var year = now.getFullYear();
 var month = now.getMonth() + 1;
 var day = now.getDate();
 var hour = now.getHours();
 var minute = now.getMinutes();
 var second = now.getSeconds();
 var nowdate = year + "/" + month + "/" + day + " " + hour + ":" + minute
   + ":" + second;
 return nowdate;

}


//初始化日历组件样式
$wdate = true;
var $dateTxt = $('input[id="notStartTime"],input[id="notEndTime"]');
//$dateTxt.addClass("WdateGray");//WdateGray
$dateTxt.css("cursor", "hand");
$dateTxt.css("border", "0px solid #FF0000");
$dateTxt.css("border-bottom", "1px solid #CCC");
$dateTxt.attr("readOnly", true);

$dateTxt.bind("focus", function(event){
	WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
});
$dateTxt.bind("click", function(event){
	var $this = $(this);
	//$this.focus();//{isShowWeek:true}
	WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
});

$('#startDate_img,#endDate_img').css("cursor", "hand").click(function(){
	var $this = $(this);

	var inputSrcID = "";
	if($this.attr("id") == "startDate_img"){
		inputSrcID = "notStartTime";
	}else if($this.attr("id") == "endDate_img"){
		inputSrcID = "notEndTime";
	}
	WdatePicker({el:inputSrcID});
});

document.getElementById("notStartTime").disabled=true;
document.getElementById("notEndTime").disabled=true;
queryForm.sendTime.disabled=false;
</script>
 </body>
</html>
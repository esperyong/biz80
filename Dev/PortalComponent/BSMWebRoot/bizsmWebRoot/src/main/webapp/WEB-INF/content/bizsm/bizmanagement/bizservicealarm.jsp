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

	var path = "/pureportal";
	var realHeight;

	var device;
	var notionState;
	var sendTime;
	var radio;
	var notStartTime;
	var notEndTime;
	var boxHeight;

	function init(){
		realHeight = parent.document.body.clientHeight;
		document.getElementById("device").value = "<%=device%>";
		$.blockUI({message:$('#loading')});

		device=$("#device").attr("value");
		notionState=document.getElementById("state").value;
		sendTime="RECENT_1_HOUR";
		radio="1";
		notStartTime=""
		notEndTime="";
		boxHeight = Math.round(realHeight*0.62);

		$('#contentArea_ifr').attr("src", "${ctx}/bizsm/bizservice/ui/bizservice-alarm-iframe");

		$.unblockUI();// 屏蔽loading
	}

	$(function() {
		//初始化日历组件样式
		$wdate = true;
		var $dateTxt = $('input[id="notStartTime"],input[id="notEndTime"]');
		$dateTxt.addClass("WdateGray");//WdateGray
		$dateTxt.css("cursor", "hand");
		$dateTxt.css("border", "0px solid #FF0000");
		$dateTxt.css("border-bottom", "1px solid #CCC");
		$dateTxt.attr("readOnly", true);

		$dateTxt.bind("focus", function(event){
			WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});//{isShowWeek:true}
		});
		$dateTxt.bind("click", function(event){
			var $this = $(this);
			//$this.focus();//{isShowWeek:true}
			WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
		});

	});

	//function display(){		//$("#bizsrvaffect").load("/pureportal/notification/historyNotificationlist.action",{device:device,notionState:notionState,sendTime:sendTime,notStartTime:notStartTime,notEndTime:notEndTime,radio:radio,pageHeight:boxHeight,pageSize:"20"},function(){});
		//$('#contentArea_ifr').attr("src", "${ctx}/bizsm/bizservice/ui/bizservice-alarm-iframe");
		//<div id="bizsrvaffect" style="position:absolute;top:0px;left:0px;width:100%;height:100%;"></div>
		//$.unblockUI();// 屏蔽loading
	//}

	function setValue(device,notionState,sendTime,radio,notStartTime,notEndTime,boxHeight){
		device=device;
		notionState=notionState;
		sendTime=sendTime;
		radio=radio;
		notStartTime=notStartTime;
		notEndTime=notEndTime;
		boxHeight = boxHeight;
	}



</script>
</head>
<body onload="init()">
<form id="queryForm">
<div id="searchCondition" style="overflow:hidden;width:1000px;position:absolute;top:0px;left:5px;right:0px;z-index:1;">
<ul>
<li>
	<span class="field" style="padding-left:20px;color:white" >告警状态：</span>
	<select id="state" name="state" style="position:relative;left:-20px">
		<option value="false">未确认</option>
		<option value="true">已确认</option>
		<option value="">全部</option>
	</select>
	<span  class="title" style="color: white">告警时间：</span>
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
      <span style="color: white">从</span> <input type="text" name="notStartTime" id="notStartTime" maxlength="19" size="21" readonly="readonly" />
      <span style="color: white">到</span> <input type="text" name="notEndTime" id="notEndTime" maxlength="19" size="21" readonly="readonly"/>
  	<span class="ico" title="查询" onclick="serchDislay();"></span>
</li>
<li></li>
</ul>
</div>
<input type="hidden" id="notificationObjId" name="notificationObjId" value="service" />
<input type="hidden" id="device" name="device" value="" />
<iframe id="contentArea_ifr" frameborder="NO" border="0" scrolling="NO" noresize framespacing="0" style="position:absolute;top:32px;left:5px;width:96%; height:100%">

</iframe>

</form>
<div class="loading" id="loading" style="display:none;">
		<div class="loading-l">
			<div class="loading-r">
				<div class="loading-m">
					<span class="loading-img">载入中，请稍候...</span>
				</div>
			</div>
		</div>
	</div>
<script>
function radioSelected(){
	var radio=$("input[name='radio']:checked").val();

	if(radio==1){

		document.getElementById("notStartTime").disabled=true;
		document.getElementById("notEndTime").disabled=true;
		queryForm.sendTime.disabled=false;
		//$('#state').disable();

	}else if(radio==2){

		queryForm.sendTime.disabled=true;
		//$('#state').enable();
		document.getElementById("notStartTime").disabled=false;
		document.getElementById("notEndTime").disabled=false;
	}
}
function serchDislay(){
//业务服务ID
device=$("#device").attr("value");
//alert("device="+device);
notionState=document.getElementById("state").value;
//告警状态
//var notionState=$('#state option:selected').value();
//alert("notionState="+notionState);
//告警时间
sendTime=document.getElementById("sendTime").value;
//var sendTime=$('#state option:selected').value();
//alert("sendTime="+sendTime);
//开始时间
notStartTime=""
notStartTime=document.getElementById("notStartTime").value;
//var notStartTime=$("#notStartTime").attr("value");
//alert("notStartTime="+notStartTime);
//结束时间
notEndTime="";
notEndTime=document.getElementById("notEndTime").value;
//var notEndTime=$("#notEndTime").attr("value");
//alert("notEndTime="+notEndTime);
//时间选择按钮
radio=$("input[name='radio']:checked").val();
//alert("radio="+radio);

//显示告警信息框的高度
boxHeight = Math.round(realHeight*0.62);

contentArea_ifr.fristload();
}

	document.getElementById("notStartTime").disabled=true;
	document.getElementById("notEndTime").disabled=true;
	queryForm.sendTime.disabled=false;
</script>
 </body>
</html>
<!-- 机房-机房监控-告警管理alarmOverview.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>告警管理</title>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>

</head>
<form id="queryForm">
<div style="overflow:hidden;width:1000px;">
<ul>
<li style="height:2px"></li>
<li >
	<span  class="field" style="padding-left:20px;color: white">告警对象:</span>
	<input type="text" name="nameoripvalue" id="nameoripvalue" size="20"/>
	<span class="field" style="padding-left:20px;color:white" >告警状态:</span>
	<select id="notionState" name="notionState" style="position:relative;left:-20px">
		<option value="false">未确认</option>
		<option value="true">已确认</option>
		<option value="">全部</option>
	</select>
	<span  class="title" style="color: white">告警时间：</span>
      <input type="radio" value="1" name="radio" checked="checked"></input>
      <s:select id="sendTime" name="sendTime" list="sendTimelist" listKey="key" listValue="value"/>
      <input type="radio" value="2" name="radio"></input>
      <span style="color: white">从</span> <input type="text" name="notStartTime" id="notStartTime" maxlength="19" size="19" readonly="readonly" value="${notStartTime}"/>
      <span style="color: white">到</span> <input type="text" name="notEndTime" id="notEndTime" maxlength="19" size="19" readonly="readonly"  value="${notEndTime}"/>
  	<span class="ico" title="搜索" ></span>
</li>
<li></li>
</ul>
</div>
<div class="clear"  id="alarmJspId"></div>
<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
<input type="hidden" name="device" id="device" value="<s:property value='device' />" />
</form>
<script type="text/javascript">
var path = "${ctx}";

/**
 * 加载页面 .
 */
function ajaxalarmDivFun(roomId,nameoripvalue,radio,sendTime,notStartTime,notEndTime,notionState) {
	var device = $("#device").val();
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"device="+device+"&nameoripvalue="+nameoripvalue+"&radio="+radio+"&sendTime="+sendTime+"&notStartTime="+notStartTime+"&notEndTime="+notEndTime+"&confirm="+notionState, 
		url: "${ctx}/roomDefine/AlarmOverview!alarmList.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			$("#alarmJspId").find("*").unbind();
			$("#alarmJspId").html("");
			$("#alarmJspId").append(data);
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
$("document").ready(function() {
	$(".ico").click(function (){
		var roomId = $("#roomId").val();
		var nameoripvalue = $("#nameoripvalue").val();
		var radio = $("input[@name=radio]:checked").val();
		var sendTime = $("#sendTime").val();
		var notStartTime = $("#notStartTime").val();
		var notEndTime = $("#notEndTime").val();
		var notionState=$("#notionState").val();
		ajaxalarmDivFun(roomId,nameoripvalue,radio,sendTime,notStartTime,notEndTime,notionState);
	}); 
	if (parent.unBolck){
		window.parent.unBolck();
	}
	var $startTime = $("input[name='notStartTime']");
	var $endTime = $("input[name='notEndTime']");
	$startTime.click(function(){
		var pos = getElementPos('notStartTime');
		WdatePicker({
	   		startDate:getDate(),
	   		dateFmt:'yyyy/MM/dd HH:mm:ss',
	   		el:'notStartTime',
	   		position:{left:pos.x,top:pos.y}
	   	});
	});
	$endTime.click(function(){
		var pos = getElementPos('notEndTime');
		WdatePicker({
	   		startDate:getDate(),
	   		dateFmt:'yyyy/MM/dd HH:mm:ss',
	   		el:'notEndTime',
	   		$dpPath:'dddd',
	   		position:{left:pos.x,top:pos.y}
	   	});
	});
});

function getDate(){
	 var now = new Date();
	 var year = now.getFullYear();
	 var month=now.getMonth()+1;
	 var day=now.getDate();
	    var hour=now.getHours();
	    var minute=now.getMinutes();
	    var second=now.getSeconds();
	    var nowdate=year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
	    return nowdate;
	}

function getElementPos(elementId) {
	var ua = navigator.userAgent.toLowerCase();
	var isOpera = (ua.indexOf('opera') != -1);
	var isIE = (ua.indexOf('msie') != -1 && !isOpera); // not opera spoof
	var el = document.getElementById(elementId);
	if(el.parentNode === null || el.style.display == 'none') {
	   return false;
	}      
	var parent = null;
	var pos = [];     
	var box;     
	if(el.getBoundingClientRect) { //IE
	   box = el.getBoundingClientRect();
	   var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
	   var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
	   return {x:box.left + scrollLeft, y:box.top + scrollTop};
	} else if (document.getBoxObjectFor) { // gecko
	   box = document.getBoxObjectFor(el); 
	   var borderLeft = (el.style.borderLeftWidth)?parseInt(el.style.borderLeftWidth):0; 
	   var borderTop = (el.style.borderTopWidth)?parseInt(el.style.borderTopWidth):0; 
	   pos = [box.x - borderLeft, box.y - borderTop];
	} else { // safari & opera
	   pos = [el.offsetLeft, el.offsetTop]; 
	   parent = el.offsetParent;     
	   if (parent != el) { 
	    while (parent) { 
	     pos[0] += parent.offsetLeft; 
	     pos[1] += parent.offsetTop; 
	     parent = parent.offsetParent;
	    } 
	   }   
	   if (ua.indexOf('opera') != -1 || ( ua.indexOf('safari') != -1 && el.style.position == 'absolute' )) { 
	    pos[0] -= document.body.offsetLeft;
	    pos[1] -= document.body.offsetTop;         
	   }    
	}              
	if (el.parentNode) { 
	   parent = el.parentNode;
	} else {
	   parent = null;
	}
	while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML') { // account for any scrolled ancestors
	   pos[0] -= parent.scrollLeft;
	   pos[1] -= parent.scrollTop;
	   if (parent.parentNode) {
	    parent = parent.parentNode;
	   } else {
	    parent = null;
	   }
	}
	return {x:pos[0], y:pos[1]};
}
ajaxalarmDivFun("<s:property value='roomId'/>", "","1","RECENT_1_DAY","","","false");
</script>
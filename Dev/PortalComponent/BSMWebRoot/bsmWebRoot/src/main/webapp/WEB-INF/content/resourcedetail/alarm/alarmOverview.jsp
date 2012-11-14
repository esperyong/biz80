<!-- 机房-机房监控-告警管理alarmOverview.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="detail.alarm.wintitle" /></title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
<style>
	.titleLi span{
		color: #000000;
	}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
</head>
<form id="queryForm">

<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.alarm.search" /></page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">win-close</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
 
  <page:param name="content">
 
<div style="width:80%; margin: 10px 0 0 0;">
	<ul>
		<li class="titleLi">
			<span class="field"><s:text name="detail.alarm.status" /></span>
			<select name="notionState" id="notionState">
				<option value=""><s:text name="i18n.all" /></option>
				<option value="true"><s:text name="detail.alarm.confirm" /></option>
				<option value="false"><s:text name="detail.alarm.noconfirm" /></option>
			</select>
			<span class="title"><s:text name="detail.alarm.alarmtime" />
		      <input type="radio" value="1" name="radio" checked="checked"></input>
		      <s:select id="sendTime" name="sendTime" list="sendTimelist" listKey="key" listValue="value"/>
		      <input type="radio" value="2" name="radio"></input>
          <s:text name="i18n.from" /><input type="text" name="notStartTime" id="notStartTime" maxlength="19" size="19" readonly="readonly" value="${notStartTime}"/>
          <s:text name="i18n.to" /><input type="text" name="notEndTime" id="notEndTime" maxlength="19" size="19" readonly="readonly"  value="${notEndTime}"/>
		              </span>
		  	<span class="ico" title="<s:text name="i18n.search" />" ></span>
		</li>
	</ul>
</div>

<input type="hidden" name="resInstanceId" id="resInstanceId" value="${resInstanceId}" />
<input type="hidden" name="device" id="device" value="${resInstanceId}"/>

<div class="clear" id="alarmJspId"></div>
</page:param>
</page:applyDecorator>
</form>
<script type="text/javascript">
var toast = new Toast({position:"CT"});
var path = "${ctx}";
function selectState(state) {
	$("#notionState").val(state);
}
/**
 * 加载页面 .
 */
function ajaxalarmDivFun(resInstanceId,notionState,radio,sendTime,notStartTime,notEndTime,notificationObjId1) {
	//alert(notificationObjId1);
	var str = "";
	if( notificationObjId1 != null && notificationObjId1 != "" && notificationObjId1 != "null" ){
		str = "&notificationObjId1=" + notificationObjId1;
	}
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"device="+resInstanceId+"&notionState="+notionState+"&radio="+radio+"&sendTime="+sendTime+"&notStartTime="+notStartTime+"&notEndTime="+notEndTime+str, 
		url: "${ctx}/detail/insalarmoverlist.action",
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
			alert("eeeerror");
		}
		});
}
$("document").ready(function() {
	$(".ico").click(function (){
		var resInstanceId = $("#resInstanceId").val();
		var notionState = $("#notionState").val();
		var radio = $("input[@name=radio]:checked").val();
		var sendTime = $("#sendTime").val();
		var notStartTime = $("#notStartTime").val();
		var notEndTime = $("#notEndTime").val();
		var notificationObjId1 = "${notificationObjId1}";

		if(radio == "2"){
			if(notStartTime.length <= 0){
				toast.addMessage("<s:text name="detail.alarm.starttime" />");
				return false;
			}
			if(notEndTime.length <=0){
				toast.addMessage("<s:text name="detail.alarm.endtime" />");
				return false;
			}
			if(notStartTime > notEndTime){
				toast.addMessage("<s:text name="detail.alarm.stgtet" />");
				return false;
			}
		}
		
		ajaxalarmDivFun(resInstanceId,notionState,radio,sendTime,notStartTime,notEndTime,notificationObjId1);
	}); 

	$('#close_button').click(function(){
		window.close();
	})
	
	$('#win-close').click(function(){
			window.close();
		})
	

	var $startTime = $("input[name='notStartTime']");
	var $endTime = $("input[name='notEndTime']");
	$startTime.click(function(){
		var pos = getElementPos('notStartTime');
		//alert('x:'+pos.x+' y:'+pos.y)
		WdatePicker({
	   		startDate:getDate(),
	   		dateFmt:'yyyy/MM/dd HH:mm:ss',
	   		el:'notStartTime',
	   		position:{left:pos.x,top:pos.y}
	   	});
	});
	$endTime.click(function(){
		var pos = getElementPos('notEndTime');
		//alert('x:'+pos.x+' y:'+pos.y)
		WdatePicker({
	   		startDate:getDate(),
	   		dateFmt:'yyyy/MM/dd HH:mm:ss',
	   		el:'notEndTime',
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
selectState("${notionState}");
ajaxalarmDivFun("${resInstanceId}", "${notionState}","1","RECENT_1_HOUR","","","${notificationObjId1}");
</script>
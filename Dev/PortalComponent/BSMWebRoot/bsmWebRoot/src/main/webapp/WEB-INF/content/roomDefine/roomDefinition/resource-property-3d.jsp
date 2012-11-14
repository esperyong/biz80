<!-- 机房-机房定义-3d组件属性页面 resource-property-3d.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>设置属性</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 

<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/flash/history/history.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/accordionPanel/j-dynamic-accordion.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/pullBox/j-dynamic-pullbox-1.1.js"></script>
<script  type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<%
	String roomId = request.getParameter("roomId");
	String componentId = request.getParameter("componentId");
	String capacityId = "";
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	String inUse = "";
	String isMonitorSet = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
		if(vs.findValue("inUse") != null && !"".equals(vs.findValue("inUse"))){
			inUse = (String)vs.findValue("inUse");
		}
		if(vs.findValue("isMonitorSet") != null && !"".equals(vs.findValue("isMonitorSet"))){
			isMonitorSet = (String)vs.findValue("isMonitorSet");
		}
		if(vs.findValue("capacityId") != null && !"".equals(vs.findValue("capacityId"))){
			capacityId = (String)vs.findValue("capacityId");
		}
	}
%>
<script>
var toast;
toast = new Toast({position:"CT"});
if("<%=inUse%>" == "true"){
	//alert("名称已经存在,请重新设置");
	var _information1 = new information({text:"名称已经存在,请重新设置"});
	_information1.show();
	_information1.setConfirm_listener(function(){
		window.close();
	});
	//window.close();
}else{
	if (window.opener){
		if("<%=saveFlag%>" == "true") {
			window.opener.saveFlash();
		
			var locaUrl = window.location.href;
			if("<%=isMonitorSet%>" != "true"){
				if(locaUrl.indexOf("ResourceProperty") != -1) {
					window.close();
				} else {
					if(window.opener.location){
						window.opener.location.href=window.opener.location;
						window.close();
					}
				}
			}
		}
	}else{
		location.href=location;
		window.close();
	}
	
	//alert(window.opener.location);
	//window.opener.location.href="${ctx}/roomDefine/IndexVisit.action";
	

}

</script>
</head>

<body>
<page:applyDecorator name="popwindow" title="属性">

	<page:param name="width">820px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>

	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>

	<page:param name="content">
		<form id="formID" action="${ctx}/roomDefine/ResourceProperty.action"
			name="ResourcePropertyForm" method="post">
		<div class="ui-layout-center">
		<div id="no"></div>

		<div id="normal" class="clear" style="display: none">
		</div>

		<div id="jigui" style="display: none">
		<ul class="button-module">
			<li class="focus" id="normalInfo"><span></span><a
				href="javascript:void(0)">常规信息</a></li>
			<li id="deviceManager"><span></span><a href="javascript:void(0)">设备列表</a></li>
			<li id="statusSet"><span></span><a href="javascript:void(0)">状态定义</a></li>
		</ul>
		<div id="contenter" class="clear"/>
		</div>
		</div>
		<s:if test="resource!=null">
			<s:if test="isJigui=='true'">
				<script type="text/javascript">
				$("#jigui").show("slow");
				$("#no").hide("slow");
				$("#normal").hide("slow");
				$("#normalInfo").addClass("focus");
				$("#deviceManager").removeClass("focus");
				$("#statusSet").removeClass("focus");
				$("#contenter").load("${ctx}/roomDefine/ResMetricVisit.action?roomId=<%=roomId%>&resourceId=<%=componentId%>");
				</script>
			</s:if>
			<s:else>
				<script type="text/javascript">
				$("#jigui").hide("slow");
				$("#no").hide("slow");
				$("#normal").show("slow");
				$("#normal").addClass("focus");
				$("#normal").load("${ctx}/roomDefine/ResMetricVisit.action?roomId=<%=roomId%>&resourceId=<%=componentId%>");
				</script>
			</s:else>
		</s:if> 
		
		<input type="hidden" name="capacityId" id="capacityId" value="<s:property value='capacityId' />" />
		<input type="hidden" name="componentId" id="componentId" value="<s:property value='componentId' />" />
		<input type="hidden" name="isJigui" id="isJigui" value="1" />
		<input type="hidden" name="commitType" id="commitType" value="normalInfo" />
		
		<div id="removeSession" style="display: none"/>
		<div id="commitTab" style="display: none"/>
	</form>
	</page:param>
</page:applyDecorator>
</body>
</html>
<script type="text/javascript">
$(document).ready(function() {
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	});
	window.resizeTo(850,335);

});
var thisClick = "true";
$("#normalInfo").click(roomLayoutIdFunClk);
$("#deviceManager").click(deviceManagerFunClk);
$("#statusSet").click(monitorSetFunClk);
function roomLayoutIdFunClk(){
	$("#normalInfo").addClass("focus");
	$("#deviceManager").removeClass("focus");
	$("#statusSet").removeClass("focus");
	$('#commitType').val("normalInfo");
	$("#contenter").html("");

	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"roomId="+"<%=roomId%>"+"&resourceId="+"<%=componentId%>", 
		url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			$("#contenter").find("*").unbind();
			$("#contenter").html("");
			$("#contenter").append(data);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
	
	//$("#contenter").load("${ctx}/roomDefine/ResMetricVisit.action?roomId=<%=roomId%>&resourceId=<%=componentId%>");
	
}
function deviceManagerFunClk(){
	if($("#name")){
		if($("#name").val()==''){
			var _information = new information({text:"机柜号不允许为空"});
			  _information.show();
						
			//alert("请填写名称");
		}else{
			$.blockUI({message:$('#loading')});
			saveBasicInfo("deviceManager");
			$("#normalInfo").removeClass("focus");
			$("#deviceManager").addClass("focus");
			$("#statusSet").removeClass("focus");
			$('#commitType').val("deviceManager");
			//$("#contenter").load("${ctx}/roomDefine/DeviceListVisit.action?roomId=<%=roomId%>&isJigui=<%='1'%>&capacityId=<%=capacityId%>&resourceId=<%=componentId%>");
		}
	}else{
		$.blockUI({message:$('#loading')});
		saveBasicInfo("deviceManager");
		$("#normalInfo").removeClass("focus");
		$("#deviceManager").addClass("focus");
		$("#statusSet").removeClass("focus");
		$('#commitType').val("deviceManager");
	}
}
function monitorSetFunClk(){
	if($("#name")){
		if($("#name").val()==''){
			alert("请填写名称");
		}else{
		$.blockUI({message:$('#loading')});
		saveBasicInfo("statusSet");
		$("#normalInfo").removeClass("focus");
		$("#deviceManager").removeClass("focus");
		$("#statusSet").addClass("focus");
		$('#commitType').val("statusSet");
		//$("#contenter").load("${ctx}/roomDefine/ResStatusVisit.action?roomId=<%=roomId%>&capacityId=<%=capacityId%>&resourceId=<%=componentId%>&isMonitorSet=false");
		}
	}else{
		$.blockUI({message:$('#loading')});
		saveBasicInfo("statusSet");
		$("#normalInfo").removeClass("focus");
		$("#deviceManager").removeClass("focus");
		$("#statusSet").addClass("focus");
		$('#commitType').val("statusSet");
	}
	
}

function refreshManagerFun(){
	$("#normalInfo").removeClass("focus");
	$("#deviceManager").addClass("focus");
	$("#statusSet").removeClass("focus");
	$('#commitType').val("deviceManager");
	$("#contenter").load("${ctx}/roomDefine/DeviceListVisit.action?roomId=<%=roomId%>&isJigui=<%='1'%>&capacityId=<%=capacityId%>&resourceId="+$("#componentId").val());
}

function saveBasicInfo(type){

	var url = "${ctx}/roomDefine/ResourceProperty!savePropertyData.action";
	$.ajax({
		url:url,
		data:$("#formID").serialize(),
		dataType:"html",
		type:"POST",
		success:function(data,state){
			if (type=="deviceManager"){
		
				openDevice(data);
				//$("#contenter").load("${ctx}/roomDefine/DeviceListVisit.action?roomId=<%=roomId%>&isJigui=<%='1'%>&capacityId=<%=capacityId%>&resourceId="+data);
			}else if(type=="statusSet"){
				openStrutsSet(data);
				//$("#contenter").load("${ctx}/roomDefine/ResStatusVisit.action?roomId=<%=roomId%>&capacityId=<%=capacityId%>&resourceId="+data+"&isMonitorSet=false");
			}

			$("#componentId").val(data);
		}
		
	});
}

function openDevice(data){
	
	var thisRoom = "<%=roomId%>";
	var thisCapacity = "<%=capacityId%>";
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"roomId="+thisRoom+"&isJigui=1&capacityId="+thisCapacity+"&resourceId="+data, 
		url: "${ctx}/roomDefine/DeviceListVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			$("#contenter").find("*").unbind();
			$("#contenter").html("");
			$("#contenter").append(data);
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

function openStrutsSet(data){

	var thisCap = "<%=capacityId%>";
	var thisRoom = "<%=roomId%>";
	
	$.ajax({
	type: "post",
	dataType:'html', //接受数据格式 
	cache:false,
	data:"roomId="+thisRoom+"&capacityId="+thisCap+"&resourceId="+data+"&isMonitorSet=false", 
	url: "${ctx}/roomDefine/ResStatusVisit.action",
	beforeSend: function(XMLHttpRequest){
	//ShowLoading();
	},
	success: function(data, textStatus){
		$("#contenter").find("*").unbind();
		$("#contenter").html("");
		$("#contenter").append(data);
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

$("#closeId").click(function (){
	$("#removeSession").load("${ctx}/roomDefine/ResourceProperty!clearSession.action?roomId=<%=roomId%>&capacityId=<%=capacityId%>&resourceId=<%=componentId%>");
	window.close();
})

$("#submit").click(function (){
	$("#formID").submit();
/*
		 settings = {
		   promptPosition:"topRight", 
		   inlineValidation: true,
		   scroll:false,
		   success:false
		 }
		
		 if(!$.validate($('#formID'),settings)) {return;}
		
		  var data =$('#formID').serialize();
		  //alert(data);
		 $.ajax({
		  type:'POST',
		  url: "${ctx}/roomDefine/ResourceProperty.action",
		  data:data,
		  success:function(){
		   try{
		    window.location.href = window.location.href; 
		    window.close();
		   }catch(e){
		   }
		  },
		    error:function(msg) {
		   alert( msg.responseText);
		    }
		 })
*/		
})

$("#cancel").click(function(){
	$("#removeSession").load("${ctx}/roomDefine/ResourceProperty!clearSession.action?roomId=<%=roomId%>&capacityId=<%=capacityId%>&resourceId=<%=componentId%>");
	window.close();
})


function window.onbeforeunload()
{
if(event.clientX>document.body.clientWidth&&event.clientY<0||event.altKey||event.ctrlKey)
{
	$("#removeSession").load("${ctx}/roomDefine/ResourceProperty!clearSession.action?roomId=<%=roomId%>&capacityId=<%=capacityId%>&resourceId=<%=componentId%>");
}
}

</script>
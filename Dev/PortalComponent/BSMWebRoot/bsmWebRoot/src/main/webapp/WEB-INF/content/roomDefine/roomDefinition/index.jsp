<!-- 机房-机房定义-首页 index.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>Mocha BSM</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" ></link>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String roomId = "";
	String saveFlag = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("roomId") != null){
			roomId = (String)vs.findValue("roomId");
		}
		if(vs.findValue("saveFlag") != null){
			saveFlag = (String)vs.findValue("saveFlag");
		}
	}
%>
</head>

<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<page:applyDecorator name="headfoot"> 
<page:param name="body">




<style type="text/css">
	.li_title{
		 width:160px;
		 white-space:nowrap;
		 text-overflow:ellipsis;
		 overflow: hidden;
	}
			
</style>
<div id="totalDivId" >

	<div class="ui-layout-west" id="layoutwestId">
	   <div id="leftAllId" style="height:100%;overflow:hidden" >
		<div class="left-panel-open" id="leftId" >
			<div class="left-panel-l" id="leftpanelId" style="cursor:default">
				<div class="left-panel-r">
					<div class="left-panel-m" style="position:relative">
						<span class="left-panel-title" style="left:-50px;">机房定义</span>
					</div>	
				</div>
			</div>
			<div class="left-panel-content" style="height:100%;" >
					<div class="fold" ><div class="fold-top"><span style="position:relative;left:30px" class="ico ico-jifangdy"></span><span style="position:relative;left:30px"><b>机房定义</b></span></div></div>
					<div class="add-button1" style="height:75%;width:98%">
						<span class="r-ico ico-delete" id="del-button1" title="删除机房" width="10" height="10" border="0"></span>
						<span class="r-ico ico-add" id="add-button1" title="新建机房" width="10" height="10" border="0"></span>
						<span class="ico-21 ico-21-guide right" style="top:-5px;position:relative" id="help-button1" title="导航" width="10" heigth="10" border="0"></span>
					</div>
					<s:if test="roomData==null || roomData.size()==0">
						<div class="add-button2" style="height:80%"><span>请点击 <img src="${ctx}/images/add-button1.gif" width="10" height="10" border="0"> 按钮新建一个机房</span></div>
					</s:if>
					<s:else>
						<div class="add-button2b" style="height:75%;width:95%;overflow-y:auto;overflow-x:hidden">
						<ul style="padding-left:10px" >
						<s:iterator value="roomData"  status="rd" id="map">	
					
						<s:if test="roomId!=null && #map.key==roomId">
							<li style="height:20px" class="li_title">
								<img src="${ctx}/images/ico/ico-px.gif" />
								<span  name="spanFontName" onclick="doit(this,'<s:property value="value.viewType"/>')" title="<s:property value="value.name"/>" id="<s:property value='key'/>" value="<s:property value='key'/>" style="cursor: pointer;font-weight:bold" >
								<!-- 
								 <s:if test="value.name.length()>16">
								 	<s:property value="value.name.substring(0,16)"/>...
								 	</s:if>
								 	<s:else>
								 		<s:property value="value.name"/>
								 	</s:else>
								 	-->
								 	<s:property value="value.name"/>
								 </span>
								  
								 <span onclick="setRoom(this,'<s:property value="value.viewType"/>')" value="<s:property value='key'/>" >
								 </span>
							 </li>
						</s:if>
						<s:else>
							 <li style="height:20px" class="li_title">
							 	<img src="${ctx}/images/ico/ico-px.gif" />
							 	<span name="spanFontName" title="<s:property value="value.name"/>" onclick="doit(this,'<s:property value="value.viewType"/>')" id="<s:property value='key'/>" value="<s:property value='key'/>" style="cursor: pointer" >
							 	<!-- 
								 <s:if test="value.name.length()>16">
								 <s:property value="value.name.substring(0,16)"/>...
								 </s:if>
								 <s:else>
								 <s:property value="value.name"/>
								 </s:else>
								  -->
								  	<s:property value="value.name"/>
								 </span>
								 <span onclick="setRoom(this,'<s:property value="value.viewType"/>')" value="<s:property value='key'/>" >
								 </span>
							 </li>
						</s:else>
						</s:iterator>
						</ul>
						</div>
					</s:else>
					<s:if test="userType==1">
					<div class="add-button3" style="z-index:3000;width:100%;height:25px;position:absolute;bottom:0px">机房监控管理</div>
					</s:if>
			</div>
		  </div>	
		</div>
	</div>
	
	<div id="divCenter" class="ui-layout-center" style="overflow-y:hidden; overflow-x:hidden" >
		<div id="no" style='font-size:45px;font-weight:700;width:300px;height:300px; margin:230px auto;'>未创建机房</div>
		<div id="have" style="display:none"  >
			<div class="button-module" style="height:100%" >
			    <ul class="button-module">
			        <li class="focus" id="roomLayoutId" style="overflow-x:hidden;"><span></span><a href="javascript:void(0)">机房布局</a></li>
			        <li id="deviceManager"><span></span><a href="javascript:void(0)">设备管理</a></li>
			        <li id="monitorSet"><span></span><a href="javascript:void(0)">监控设置</a></li>
			        
			    </ul>
			  <div class="clear"  id="dynamicJspId" style="height:93%" ></div>
			</div>
			
		</div>
	</div>
	
</div>
<s:form theme="simple" id="formDeleteRoomID" action="DeleteRoomInfo" name="DeleteRoomInfoForm" method="post" namespace="/roomDefine">
<input type="hidden" id="roomIndexId" name="roomId" value="" />
<input type="hidden" id="roomType" name="roomType" value="" />
</s:form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
 </page:param>
</page:applyDecorator>
</body>
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
</html>
<script type="text/javascript">
var isSave = null;
var menu =null;
var pageLoading = $.blockUI;
$(function(){
	// this layout could be created with NO OPTIONS - but showing some here just as a sample...
	// myLayout = $('body').layout(); -- syntax with No Options

	myLayout = $('#totalDivId').layout({

	//	enable showOverflow on west-pane so popups will overlap north pane
		west__showOverflowOnHover: false
	//	reference only - these options are NOT required because are already the 'default'
	,	closable:				true	// pane can open & close
	,	resizable:				true	// when open, pane can be resized 
	,	slidable:				true	// when closed, pane can 'slide' open over other panes - closes on mouse-out

	//	some resizing/toggling settings
	,	north__slidable:		false	// OVERRIDE the pane-default of 'slidable=true'
	,	north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
	,   north__closable:        false
	,	north__spacing_closed:	0		// big resizer-bar when open (zero height)
	,   north__spacing_open:0
	,	south__resizable:		false	// OVERRIDE the pane-default of 'resizable=true'
			// no resizer-bar when open (zero height)
	,	south__spacing_closed:	8		// big resizer-bar when open (zero height)
	,   south__spacing_open:8
	,   south__togglerLength_open:10
	,   south__togglerLength_closed:10
	//	some pane-size settings
	,   west__size:				235
	,	west__minSize:			100
	,   west__spacing_open:8
	,   west__spacing_closed:8
	,   west__togglerLength_open:36
	,   west__togglerLength_closed:36
	,	east__size:				300
	,	east__minSize:			200
	,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
	});
	
});
var toast;
$(document).ready(function() {
	//$("#leftAllId").width(1000);
	$("#leftAllId").css("marginTop","12px");
	//$("#leftAllId").css("marginRight","12px");
	$("#leftAllId").css("marginBottom","0px");
	$("#leftAllId").css("marginLeft","12px");
	$("#leftAllId").css("marginRight","12px");
	$("#leftAllId").css("overflow","hidden");
	$("#layoutwestId").css("overflow","hidden");
	
	//$("#have").height($("#divCenter").height());
	browserinfo();
	if (navigator.Actual_Version != "8.0"){
		$(".left-panel-content").css("height","90%");
	}else{
		$(".left-panel-content").css("height","100%");
	}

	$(".add-button1").height(20);
	$("#add-button1").click(function(){
		openWindowFun();
	});
	$("#del-button1").click(function(){
		delRoom($("#roomIndexId").val());
	});
	$("#help-button1").click(function(){
		openHelpFun();
	});
	
	$("#layoutwestId")[0].style.height="100%";
	$("#leftId").width(211).css("height","100%");
//	$(".add-button2b").height(500);
	//$(".add-button3").height(30);
	
	$("#roomLayoutId").click(roomLayoutIdFunClk);
	$("#deviceManager").click(deviceManagerFunClk);
	$("#monitorSet").click(monitorSetFunClk);
	
	$(".add-button3").click(function(){
		window.open("${ctx}/roomDefine/DevTypeManagerVisit.action","_blank","width=960,height=620,scrollbars=yes");
	});
	
	toast = new Toast({position:"CT"}); 
	menu = new MenuContext({
        x: 20,
        y: 100,
        width: 150,
        listeners: {
            click: function(id) {
                //alert(id)
            }
        }
    });
});
function openWindowFun(){
	//alert("aa");
	var winOpenObj = {};
	var src = "${ctx}/roomDefine/CreateGeneralInfoVisit.action";
	var name = "createGeneral";
	
	var height = '175';
	
	winOpenObj.width = '550';
	winOpenObj.height = height;
	winOpenObj.name = name;
	winOpenObj.url = src;
	winOpenObj.scrollable = false;
	winOpenObj.resizeable = false;
	winOpen(winOpenObj); 
}

function openHelpFun(){
	window.open("${ctx}/roomDefine/NavigationHelpInfoVisit.action","_blank","width=900,height=470")
}
function roomLayoutIdFunClk(){
	isSave=null;
	$("#roomLayoutId").addClass("focus");
	$("#deviceManager").removeClass("focus");
	$("#monitorSet").removeClass("focus");
	var roomId = $('#roomIndexId').val();
	if(roomId!=null && roomId != ""){
		isExistRoom($('#roomIndexId').val());
		ajaxIndexFun(roomId,"0","${ctx}/roomDefine/Show3DRoomVisit.action");
		document.getElementById("divCenter").style.overflowY= "hidden";
	}
	
}
function deviceManagerFunClk(){
	isExistRoom($('#roomIndexId').val());
	var roomType = $('#roomType').val();
	
	if(roomType.indexOf("2D")!= -1){
		isSave = isSaveState(isSave);
		if(isSave === null){
			var _confirm = new confirm_box({text:"页面已修改，是否保存？"});
			_confirm.setConfirm_listener(function(){
				var tmpObj={};
				document.getElementById("MachineRoomGraph").excuteFunction("savedata",tmpObj);
				deviceManagerFunClkAfter();
				isSave = true;
				_confirm.hide();
			});
			_confirm.setCancle_listener(function(){
				deviceManagerFunClkAfter();
				isSave = false;
				_confirm.hide();
			});
			_confirm.show();
		}else{
			deviceManagerFunClkAfter();
		}
	}else{
		deviceManagerFunClkAfter();
	}
	
	//$("#iframeId").attr("src","${ctx}/roomDefine/DeviceListVisit.action?roomId="+roomId);
}
function deviceManagerFunClkAfter(){
	pageLoading({message:$('#loading')});
	$("#roomLayoutId").removeClass("focus");
	$("#deviceManager").addClass("focus");
	$("#monitorSet").removeClass("focus");
	var roomId = $('#roomIndexId').val();
	ajaxIndexFun(roomId,"0","${ctx}/roomDefine/DeviceListVisit.action");
	document.getElementById("divCenter").style.overflowY="auto";
}
function monitorSetFunClk(){
	isExistRoom($('#roomIndexId').val());
	var roomType = $('#roomType').val();
	if(roomType.indexOf("2D")!= -1){
		isSave = isSaveState(isSave);
		if(isSave === null){
			var _confirm = new confirm_box({text:"页面已修改，是否保存？"});
			_confirm.setConfirm_listener(function(){
				var tmpObj={};
				document.getElementById("MachineRoomGraph").excuteFunction("savedata",tmpObj);
				monitorSetFunClkAfter();
				isSave = true;
				_confirm.hide();
			});
			_confirm.setCancle_listener(function(){
				monitorSetFunClkAfter();
				isSave = false;
				_confirm.hide();
			});
			_confirm.show();
		}else{
			monitorSetFunClkAfter();
		}
	}else{
		monitorSetFunClkAfter();
	}
}
function monitorSetFunClkAfter(){
	
	pageLoading({message:$('#loading')});
	$("#roomLayoutId").removeClass("focus");
	$("#deviceManager").removeClass("focus");
	$("#monitorSet").addClass("focus");
	var roomId = $('#roomIndexId').val();
	ajaxIndexFun(roomId,"0","${ctx}/roomDefine/MonitorSetVisit.action");
	document.getElementById("divCenter").style.overflowY= "hidden";
}
function ajaxIndexFun(roomId,isJigui,url) {
	//alert("ajaxIndexFun:roomId:::"+roomId);
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"roomId="+roomId+"&isJigui="+isJigui, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#dynamicJspId")[0]);
			$("#dynamicJspId").find("*").unbind();
			$("#dynamicJspId").html("");
			//alert(data);
			$("#dynamicJspId").append(data);
			//alert(data);
		//var listJson = $parseJSON(data.devValues);
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
var cur;
function doit(obj,type) {
	isExistRoom(obj.value);
    if(cur == obj) return false;
    if(cur!=null) cur.style.fontWeight = "normal";
    var spanArr = $("span[name='spanFontName']");
    for(i=0;i<spanArr.length;i++) {
    	spanArr[i].style.fontWeight="normal";
    }
    obj.style.fontWeight = "bold";
    cur = obj;
    $("#have").show();
    $("#no").hide();
    $("#roomIndexId").val(obj.value);
    $("#roomType").val(type);
    roomLayoutIdFunClk();
}

function delRoom(roomId) {
	if(!roomId){
		var inform = new information({text:"没有要删除的机房。"});
		inform.show();
	}else{
		var roomType = $('#roomType').val();
		if(roomType.indexOf("2D")!= -1){
			isExistRoom(roomId);
			var _confirm = new confirm_box({text:"是否确认执行此操作？"});
			 _confirm.setContentText("是否确认执行此操作？");
			 _confirm.setConfirm_listener(function(){
				 delRoomExcuse(roomId)
					_confirm.hide();
			 });
			 _confirm.show();
		}else{
			/* 
			var winOpenObj = {};
	    	winOpenObj.height = '140';
	    	winOpenObj.width = '350';
	    	winOpenObj.name = window;
	    	winOpenObj.url = "${ctx}/roomDefine/Show3DConfrimVisit.action?roomId="+roomId;
	    	winOpenObj.scrollable = false;
	    	winOpenObj.resizeable = false;
	    	modalinOpen(winOpenObj);
	    	*/
			var centerX = (screen.width-350)/2
			var centerY = (screen.height-140)/2
			window.open("${ctx}/roomDefine/Show3DConfrimVisit.action?roomId="+roomId,"_blank","width=350,height=140,top="+centerY+",left="+centerX);
		}
		
	}
}

function delRoomExcuse(roomId){
	$("#roomIndexId").val(roomId);
	$('#formDeleteRoomID').submit();
}

$(document).ready(function() {	
	if("<%=roomId%>" != null && "<%=roomId%>" != ""){
		if("<%=saveFlag%>" == "true") {
			$("#roomIndexId").val("<%=roomId%>");
			$("#have").show();
		    $("#no").hide();
			monitorSetFunClk();
		}else{
			$("#"+"<%=roomId%>").click();
		}
		
	}else{
		try{
			var firstVal = $($("#leftAllId span[name='spanFontName']")[0]).val();
			$("#"+firstVal).click();
		}catch(e){
		}
	}
	
});
function setRoom(obj,type){
	$("#roomIndexId").val(obj.value);
	$("#roomType").val(type);
}
function isExistRoom(roomId){
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:"roomId="+roomId, 
		url: "${ctx}/roomDefine/RoomisExist.action",
		success: function(data, textStatus){
			if(data.result!="success"){
				var inform = new information({text:"机房已不存在。"});
				inform.setConfirm_listener(function(){
					inform.hide();
					location.reload();
				});
				inform.show();
				
			}
		}
	});
}

function browserinfo(){   
	var Browser_Name=navigator.appName;   
	var Browser_Version=parseFloat(navigator.appVersion);   
	var Browser_Agent=navigator.userAgent;   
	var Actual_Version,Actual_Name;
	var is_IE=(Browser_Name=="Microsoft Internet Explorer");//判读是否为ie浏览器   10.        
	var is_NN=(Browser_Name=="Netscape");//判断是否为netscape浏览器   
	var is_op=(Browser_Name=="Opera");//判断是否为Opera浏览器  
    if(is_NN){   //upper 5.0 need to be process,lower 5.0 return directly  
		if(Browser_Version>=5.0){   
			if(Browser_Agent.indexOf("Netscape")!=-1){   
				var Split_Sign=Browser_Agent.lastIndexOf("/");   
				var Version=Browser_Agent.lastIndexOf(" ");  
				var Bname=Browser_Agent.substring(0,Split_Sign);   
				var Split_sign2=Bname.lastIndexOf(" ");   
				Actual_Version=Browser_Agent.substring(Split_Sign+1,Browser_Agent.length);
				Actual_Name=Bname.substring(Split_sign2+1,Bname.length);
			}
			if(Browser_Agent.indexOf("Firefox")!=-1){
				var Split_Sign=Browser_Agent.lastIndexOf("/");
				var Version=Browser_Agent.lastIndexOf(" ");
				Actual_Version=Browser_Agent.substring(Split_Sign+1,Browser_Agent.length);
				Actual_Name=Browser_Agent.substring(Version+1,Split_Sign);
			}
			if(Browser_Agent.indexOf("Safari")!=-1){
				if(Browser_Agent.indexOf("Chrome")!=-1){
					var Split_Sign=Browser_Agent.lastIndexOf(" ");
					var Version=Browser_Agent.substring(0,Split_Sign);
					var Split_Sign2=Version.lastIndexOf("/");
					var Bname=Version.lastIndexOf(" ");
					Actual_Version=Version.substring(Split_Sign2+1,Version.length);
					Actual_Name=Version.substring(Bname+1,Split_Sign2);
				}else{
					var Split_Sign=Browser_Agent.lastIndexOf("/");
					var Version=Browser_Agent.substring(0,Split_Sign);
					var Split_Sign2=Version.lastIndexOf("/");
					var Bname=Browser_Agent.lastIndexOf(" ");
					Actual_Version=Browser_Agent.substring(Split_Sign2+1,Bname);
					Actual_Name=Browser_Agent.substring(Bname+1,Split_Sign);
				} 
			}
		}else{
			Actual_Version=Browser_Version;
			Actual_Name=Browser_Name;
		}
	}else if(is_IE){
		var Version_Start=Browser_Agent.indexOf("MSIE");
		var Version_End=Browser_Agent.indexOf(";",Version_Start);
		Actual_Version=Browser_Agent.substring(Version_Start+5,Version_End)
		Actual_Name=Browser_Name;
		if(Browser_Agent.indexOf("Maxthon")!=-1||Browser_Agent.indexOf("MAXTHON")!=-1){
			var mv=Browser_Agent.lastIndexOf(" ");
			var mv1=Browser_Agent.substring(mv,Browser_Agent.length-1);
			mv1="遨游版本:"+mv1;
			Actual_Name+="(Maxthon)";
			Actual_Version+=mv1;
		}
	}else if(Browser_Agent.indexOf("Opera")!=-1){
		Actual_Name="Opera";
		var tempstart=Browser_Agent.indexOf("Opera");
		var tempend=Browser_Agent.length;
		Actual_Version=Browser_Version;
	}else{
		Actual_Name="Unknown Navigator";
		Actual_Version="Unknown Version";
	}
	navigator.Actual_Name=Actual_Name;
	navigator.Actual_Version=Actual_Version;
	this.Name=Actual_Name;
	this.Version=Actual_Version;
} 
</script>
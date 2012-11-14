<!-- 机房-机房定义-显示2DFlash show2DRoom.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/footer.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css" media="screen">
html,body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
	text-align: center;
	background-color: #ffffff;
}

#flashContent {
	display: none;
}
</style>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/room.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/flash/history/history.css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>

	<div id="<s:property value='roomId'/>" style="height: 100%; width: 100%">

	<!-- flash-->
	<div id="flash0_<s:property value='roomId'/>" style="position:absolute;top:<s:property value='topOffset'/>px;left:0px;z-index:50">
	<div id="suspendInfo">
	<p>To view this page ensure that Adobe Flash Player version 10.0.0
	or greater is installed.</p>
	<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				//alert(pageHost);
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script> <script type="text/javascript">
			//加载悬浮flash
			<!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/ToolStripComponent.swf";
            //alert(xiSwfUrlStr);
            var flashvars = {};
            var params = {};
            params.wmode = "transparent";
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
            params.allowfullscreen = "true";
            flashvars.isBrowse="true";
            flashvars.background= "./pic/jf.png";
            flashvars.graphbackground="./pic/bg.jpg";
            flashvars.roomId="<s:property value='roomId'/>";
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
            var attributes = {};
            attributes.id = "ToolStripComponent_<s:property value='roomId'/>";
            attributes.name = "ToolStripComponent";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/ToolStripComponent.swf", "suspendInfo", 
                "640", "25", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
	</script></div>
	</div>
	
	
	<div id="flash1_<s:property value='roomId'/>" style="width:100%;height:100%">
	<div id="flashContent">
	<p>To view this page ensure that Adobe Flash Player version 10.0.0
	or greater is installed.</p>
	<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				//alert(pageHost);
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script> <script type="text/javascript">
			//加载机房flash
            <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/playerProductInstall.swf";
            //alert(xiSwfUrlStr);
            var flashvars = {};
            var params = {};
            params.wmode = "transparent";
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
            params.allowfullscreen = "true";
            flashvars.isBrowse="true";
            flashvars.isHomePage="false";
            flashvars.background= "./pic/jf.png";

            flashvars.roomid="<s:property value='roomId'/>";
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
            var attributes = {};
            attributes.id = "MachineRoomGraph_<s:property value='roomId'/>";
            attributes.name = "MachineRoomGraph";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/MachineRoomGraph.swf", "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script></div>
	</div>
	
	
	<div id="flash2_<s:property value='roomId'/>" style="position:absolute;bottom:0px;left:0px;overflow:hidden">
	<div id="suspendContent">
	<p>To view this page ensure that Adobe Flash Player version 10.0.0
	or greater is installed.</p>
	<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				//alert(pageHost);
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script> <script type="text/javascript">
			//加载悬浮flash
			<!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/DisplayBoardTool.swf";
            //alert(xiSwfUrlStr);
            var flashvars = {};
            var params = {};
            params.wmode = "transparent";
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
            params.allowfullscreen = "true";
            flashvars.isBrowse="true";
            flashvars.background= "./pic/jf.png";
            flashvars.roomid="<s:property value='roomId'/>";
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
            var attributes = {};
            attributes.id = "DisplayBoardTool_<s:property value='roomId'/>";
            attributes.name = "DisplayBoardTool";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/DisplayBoardTool.swf", "suspendContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
	</script></div>
	</div>
	<div id="removeMsg_<s:property value='roomId'/>" style="display: none" >
	</div>
	</div>
	<script type="text/javascript"> 

	var suspendLoaded=false;
	var flashinterval = null;
    //实时获取组件数据
    function loadResourceData(objectId) {
        if(suspendLoaded){
        	document.getElementById("flash2_<s:property value='roomId'/>").style.height="215";
        	$.ajax({
        		type: "post",
        		dataType:'String', //接受数据格式 
        		cache:false,
        		data:"action=getResInfo&roomId=<s:property value='roomId'/>&resourceId="+objectId, 
        		url: "<%=request.getScheme() + "://" + request.getServerName()
            		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet",
        		beforeSend: function(XMLHttpRequest){
        		//ShowLoading();
        		},
        		success: function(data, textStatus){
        			flashinterval = setInterval(function(){ 
	            										if(document.getElementById("DisplayBoardTool_<s:property value='roomId'/>").setData){
	            											document.getElementById("DisplayBoardTool_<s:property value='roomId'/>").setData(data,objectId);
	            											clearInterval(flashinterval);
	                    								}
            										},50);
        		},
        		complete: function(XMLHttpRequest, textStatus){
        		//HideLoading();
        		},
        		error: function(){
        		//请求出错处理
        			//alert("error");
        		}
        		});
        }
    }  

    //悬浮flash加载完成时调用
    function suspendSwfLoaded(){
        suspendLoaded = true;
        document.getElementById("flash2_<s:property value='roomId'/>").style.height="0";
    }

    //悬浮flash关闭时调用
    function suspendSwfClosed(){
    	document.getElementById("flash2_<s:property value='roomId'/>").style.height="0";
    }

  	//弹出基础信息时调用
    function suspendInfoOpen(){
        if( $("#ToolStripComponent_<s:property value='roomId'/>").height()!=180){
            
        	$("#ToolStripComponent_<s:property value='roomId'/>").height(180);
        	$("#ToolStripComponent_<s:property value='roomId'/>").focus();
        	$("#flash0_<s:property value='roomId'/>").height(180);
        	
        }
    }
    //关闭基础信息时调用
    function suspendInfoClosed(){
        $("#ToolStripComponent_<s:property value='roomId'/>").height(25);
        $("#flash0_<s:property value='roomId'/>").height(25);
    }

    // 删除留言时调用
    var delWordID;
    function deleteLeaveWord(delID){
        
    	delWordID = delID;
    	var _confirm = new confirm_box({text:"是否确认执行此操作？"});
		 _confirm.setContentText("是否确认执行此操作？");
		 _confirm.setConfirm_listener(function(){
			 document.getElementById("ToolStripComponent_<s:property value='roomId'/>").deleteLeaveWord(delWordID);
				_confirm.hide();
		 });
		 _confirm.show();
    }

    //编辑机房备注调用
    function editRoomDesc(desc){
    	window.open("${ctx}/roomDefine/Desc.action?roomId=<s:property value='roomId'/>&desc="+desc,"_blank","height=135,width=300");
    }
    //编辑组件备注调用
    function editResDesc(resourceId,desc){
    	window.open("${ctx}/roomDefine/Desc.action?roomId=<s:property value='roomId'/>&resourceId="+resourceId+"&desc="+desc,"_blank","height=135,width=300");
    	loadResourceData(resourceId);
    }
    //添加留言调用
    function addMsg(){
    	window.open("${ctx}/roomDefine/Msg.action?roomId=<s:property value='roomId'/>","_blank","height=165,width=300");
    }
    // 显示留言
    function showMsg(msgId){
    	window.open("${ctx}/roomDefine/ShowMsgVisit.action?id="+msgId,null,"height=190,width=350");
    }
    
    //详细信息页面调用
    function resourceDetail(resId){
        var url = "${ctx}/detail/resourcedetail.action?instanceId=" + resId;
        winOpen({url:url,width:980,height:600,scrollable:false,name:'resdetail_'+resId});
    }

    // 状态信息页面
    function resourceState(resId){
    	 var url = "${ctx}/monitor/resourceStateDetail.action?instanceId=" + resId;
         winOpen({url:url,width:630,height:538,scrollable:false,name:'resdetail_'+resId});
    }
    // 定位节点
    function locatoionNode(UID){
    	var locationNodeObj={};
    	locationNodeObj.id = UID;
    	document.getElementById("MachineRoomGraph_<s:property value='roomId'/>").excuteFunction("nodelocation",locationNodeObj);
    }
    
    //告警管理
    function alarmOverviewFun() {
    	parent.ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/AlarmOverview.action");
    }
    //首页
    if(window.HP){
    HP.addActivate(function(){
    	document.getElementById("flash0_<s:property value='roomId'/>").style.height="25";
    	var theObj = new Object();
    	theObj.value="true";
    	document.getElementById("MachineRoomGraph_<s:property value='roomId'/>").excuteFunction("timerswitch",theObj);
    	document.getElementById("MachineRoomGraph_<s:property value='roomId'/>").excuteFunction("setnodeclick",theObj);
    });

    HP.addSleep(function(){
    	document.getElementById("flash0_<s:property value='roomId'/>").style.height="0";
    	document.getElementById("flash2_<s:property value='roomId'/>").style.height="0";
    	var theObj = new Object();
    	theObj.value="false";
    	document.getElementById("MachineRoomGraph_<s:property value='roomId'/>").excuteFunction("timerswitch",theObj);
    	document.getElementById("MachineRoomGraph_<s:property value='roomId'/>").excuteFunction("setnodeclick",theObj);
    });
    HP.addDestory({});
    }

    function init(){
        if("<s:property value='nodeId'/>" != null && "<s:property value='nodeId'/>"!=""){
        	locatoionNode("<s:property value='nodeId'/>");
        }
    }
</script>





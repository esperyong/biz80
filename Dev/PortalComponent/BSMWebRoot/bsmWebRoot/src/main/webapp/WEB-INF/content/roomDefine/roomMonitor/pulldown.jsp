<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/footer.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/room.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/flash/history/history.css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
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
<body style="background-color:transparent">
	<!-- flash-->
	<div id="suspendInfo" style="background-color:#000000">
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
            params.quality = "high";
            params.bgcolor = "#000000";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
            params.allowfullscreen = "true";
            flashvars.isBrowse="true";
            flashvars.roomId="<s:property value='roomId'/>";
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
        	flashvars.msgActionPath="<%=request.getScheme() + "://" + request.getServerName()
             	+ ":" + request.getServerPort()%>${ctx}/roomDefine/Msg!delMsg.action";
            var attributes = {};
            attributes.id = "ToolStripComponent_<s:property value='roomId'/>";
            attributes.name = "ToolStripComponent";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/ToolStripComponent.swf", "suspendInfo", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
	</script></div>
	<div id="removeMsg_<s:property value='roomId'/>" style="display: none" />
</body>
	

	<script type="text/javascript"> 
  	//弹出基础信息时调用
    function suspendInfoOpen(){
        if( $("#ToolStripComponent_<s:property value='roomId'/>").height()<180){
            parent.pulldownHeight(180);
        	$("#ToolStripComponent_<s:property value='roomId'/>").height(180);
        }
    }
    //关闭基础信息时调用
    function suspendInfoClosed(){
    	parent.pulldownHeight(25);
        $("#ToolStripComponent_<s:property value='roomId'/>").height(25);
    }

    //编辑机房备注调用
    function editRoomDesc(desc){
    	window.open("${ctx}/roomDefine/Desc.action?roomId=<s:property value='roomId'/>&desc="+desc);
    }

    //添加留言调用
    function addMsg(){
    	window.open("${ctx}/roomDefine/Msg.action?roomId=<s:property value='roomId'/>","_blank","height=165,width=300");
    }
    // 删除留言时调用
    function deleteLeaveWord(delID){
		document.getElementById("ToolStripComponent_<s:property value='roomId'/>").deleteLeaveWord(delID);
    }
    // 显示留言
    function showMsg(msgId){
    	window.open("${ctx}/roomDefine/ShowMsgVisit.action?id="+msgId,null,"height=190,width=350");
    }
    //告警管理
    function alarmOverviewFun() {
    	parent.parent.ajaxloadDivFun("<s:property value='roomId'/>","${ctx}/roomDefine/AlarmOverview.action");
    }
</script>






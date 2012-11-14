<!-- 机房-机房定义-显示Unity3D图形 monitorUnify3DRoom.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>显示Unity3D图形</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/room.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
</head>
<body style="background-color:transparent"> 
<div class="content">
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
            params.quality = "high";
            params.bgcolor = "#00000";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
            params.allowfullscreen = "true";
            flashvars.isBrowse="true";
            flashvars.roomid="<s:property value='roomId'/>";
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
            var attributes = {};
            attributes.id = "DisplayBoardTool_<s:property value='roomId'/>";
            attributes.name = "DisplayBoardTool";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/DisplayBoardTool.swf", "suspendContent", 
                "1024", "225", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "position:absolute;top:290px;left:0px;display:block;text-align:left");
	</script></div>
	
</div>
</body>

<script type="text/javascript"> 
	var suspendLoaded=false;
	 //实时获取组件数据
    function loadResourceData(objectId) {
        if(suspendLoaded){
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
    }

    //悬浮flash关闭时调用
    function suspendSwfClosed(){
    	parent.suspendPropClosed();
    }

    //编辑组件备注调用
    function editResDesc(resourceId,desc){
    	window.open("${ctx}/roomDefine/Desc.action?roomId=<s:property value='roomId'/>&resourceId="+resourceId+"&desc="+desc,"_blank","height=135,width=300");
    	loadResourceData(resourceId);
    }

    //详细信息页面调用
    function resourceDetail(resId){
        var url = "${ctx}/detail/resourcedetail.action?instanceId=" + resId;
        winOpen({url:url,width:980,height:600,scrollable:false,name:'resdetail_'+resId});
    }
</script>

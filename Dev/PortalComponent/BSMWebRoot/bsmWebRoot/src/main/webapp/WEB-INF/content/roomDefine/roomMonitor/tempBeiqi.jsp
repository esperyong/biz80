<!-- 机房-机房监控-首页背鳍  monitor.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>Mocha BSM</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/flash/history/history.css" />
<script type="text/javascript" src="${ctx}/flash/history/history.js"></script>

<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
</head>

<page:applyDecorator name="headfoot"> 
<form METHOD="POST" name="go" >
		<div id="flashContent" style="width:100%">
<p>To view this page ensure that Adobe Flash Player version 10.0.0
or greater is installed.</p>
<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				//alert(pageHost);
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script>
<script type="text/javascript">
            <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/RotatingWallDisplay.swf";
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
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
            var attributes = {};
            attributes.id = "RotatingWallDisplay";
            attributes.name = "RotatingWallDisplay";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/RotatingWallDisplay.swf", "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script>			
</div>
</form>
</page:applyDecorator>
<script type="text/javascript">
function showRuntimeRoom(roomId,status){
      document.go.action="${ctx}/roomDefine/MonitorVisit!monitor.action?roomId="+roomId+"&status="+status+"&isSelf=true";
	  document.go.submit();
}
</script>
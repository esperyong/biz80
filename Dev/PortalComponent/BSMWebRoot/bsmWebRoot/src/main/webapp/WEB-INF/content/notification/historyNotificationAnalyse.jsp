<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<script>
path = '${ctx}';
</script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script src="${ctx}/flash/location/flash/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/historyanalysis.js"></script>
</head>
<script type="text/javascript">
$(function() {
	$('#close_button').click(function(){
		window.close();
	})
})
</script>
<body>
<page:applyDecorator name="popwindow"  title="${instanceName}告警分析">
 <page:param name="width"></page:param>
 <page:param name="height">565px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1">关闭</page:param>



 <page:param name="content">
  <script type="text/javascript">
            <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. -->
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/playerProductInstall.swf";
            //alert(xiSwfUrlStr);
            var flashvars = {};
            var params = {};
            params.wmode = "transparent";
            params.quality = "high";
            //params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.flashvars = "imageUrl=${ctx}/images/flash/flashAlertViewModeImage/";
            var attributes = {};
            attributes.id = "historyAnalysis";
            attributes.name = "historyAnalysis";
            attributes.align = "middle";

            swfobject.embedSWF(
                "${ctx}/flash/notification/HistoryAlarmsAnalysis.swf", "flashContent",
                document.documentElement.clientWidth-18, document.documentElement.clientHeight-60,
                swfVersionStr, xiSwfUrlStr,
                flashvars, params, attributes);
   <!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
   swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script>


<div id="flashContent" style="z-index: 112;">
<p>To view this page ensure that Adobe Flash Player version 10.0.0
or greater is installed.</p>
<script type="text/javascript">
	var parentInstanceId = '<s:property value="parentInstanceId"/>';
	var userId = '<s:property value="userId"/>';
	var viewId = '<s:property value="viewId"/>';
	refreshFlashHistory(userId,viewId,parentInstanceId);
    var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://");
    //alert(pageHost);
    document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='"
        + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
	
	
</script></div>
</page:param>
</page:applyDecorator>
</body>
</html>
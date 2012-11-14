<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<script src="${ctx}/flash/location/flash/swfobject.js"></script>
<div style="background-color: #d8d8d8;overflow:hidden;">
<ul>
<li class="left">
<s:text name="notification.platformview.notifytime" />
<s:select id="timePeriod" list="timePeriods" listKey="optionValue" listValue="optionDisplay" value="crtTimePeriod"></s:select>
</li>
<li class="right">
<span class="black-btn-l right" id="export" style="margin-right: 30px;"><span class="btn-r"><span class="btn-m"><a>导出</a></span></span></span>
<span class="black-btn-l right" id="batchOperate"><span class="btn-r"><span class="btn-m"><a>批量操作</a></span></span></span>
<span class="black-btn-l right" id="browseMode" ><span class="btn-r"><span class="btn-m"><a>浏览模式</a></span></span></span>
<span class="black-btn-l" id="clearSearch"><span class="btn-r"><span class="btn-m"><a>清空搜索条件</a></span></span></span>
</li>
</ul>
</div>
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

            var attributes = {};
            attributes.id = "AlertList";
            attributes.name = "AlertList";
            attributes.align = "middle";

            swfobject.embedSWF(
                "${ctx}/flash/notification/AlertList.swf", "flashContent",
                "100%", "91%",
                swfVersionStr, xiSwfUrlStr,
                flashvars, params, attributes);
   <!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
   swfobject.createCSS("#flashContent", "display:block;text-align:left;");
   
   //window.screen.availHeight - 260
   
</script>


<div id="flashContent" style="z-index: 112;">
<p>To view this page ensure that Adobe Flash Player version 10.0.0
or greater is installed.</p>
<script type="text/javascript">
    var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://");
    //alert(pageHost);
    document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='"
        + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
</script></div>

<script type="text/javascript">
function setBodyHeight(){
    var pageObj = document.getElementById("flashContent");
    var pHeight = pageObj.offsetHeight;
}
</script>


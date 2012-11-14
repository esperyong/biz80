<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head> 
		<%@ include file="/WEB-INF/common/meta.jsp"%>
		<base target="_self">
		<title></title>
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
}

#flashContent { /////////	display: none;
}
</style>
		<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet"
			type="text/css" media="screen" title="no title" charset="utf-8" />
		<script src="${ctxJs}/jquery.validationEngine-cn.js"
			type="text/javascript"></script>
		<script src="${ctxJs}/jquery.validationEngine.js"
			type="text/javascript"></script>

<!--
		<script type="text/javascript"
			src="${ctx}/flash/location/flash/history/history.js"></script>
		<script type="text/javascript"
			src="${ctx}/flash/location/flash/swfobject.js"></script>
-->
		<script type="text/javascript"
			src="${ctx}/flash/history/history.js"></script>
		<script type="text/javascript"
			src="${ctx}/flash/swfobject.js"></script>
		<script type="text/javascript">
            <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/location/flash/playerProductInstall.swf";
            //alert(xiSwfUrlStr);
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            var attributes = {};
            attributes.id = "Location";
            attributes.name = "Location";
            attributes.align = "middle";
            
            flashvars.url="${ctx}/location/define/defineflash!mapXML.action?locationId=${location.locationId}";
            flashvars.imageurl="${ctx}/flash/location/flash/location/image/assets/toolbox/";
            flashvars.dataurl="${ctx}/location/define/defineflash!saveLocationData.action?locationId=${location.locationId}";
            //alert(flashvars.url);
            //flashvars.saveurl="${ctx}/location/define/defineflash!saveLocationFlashXML.action?locationId=${location.locationId}";
            //alert('${ctx}');
            swfobject.embedSWF(
                "${ctx}/flash/location/flash/Location.swf", "flashContent", 
                "800", "800", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
			
	function doIt(){
			//alert(2);
			var flashobj=	document.getElementById("Location");
			//alert(flashobj);
			flashobj.excuteCMD("save",null);
			// 刷新物理位置数
			window.setTimeout(loadLocations, 500);
			}
			
			//alert('${location.locationId}');
        </script>
	</head>
	<body>
		<!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
			 JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
			 when JavaScript is disabled.
		-->
		<div style="float:left;width: 100%">
			<ul class="panel-button" >
				<li style="float:left">
					<span></span><a id="important_0" onClick="doIt();"
						style="cursor: pointer">应用</a>
				<input type="hidden" name="locationId.locationId" value="${location.locationId}" id="location.locationId"/>
				</li>
			</ul>
		</div>
		<div id="flashContent" style="position:absolute;z-index:10">
			<p>
				To view this page ensure that Adobe Flash Player version 10.0.0 or
				greater is installed.
			</p>
			<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				//alert(pageHost);
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script>
		</div>

		<noscript>
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
				width="800" height="800" id="Location">
				<param name="WMODE" value="transparent"/>
				<param name="movie" value="Location.swf" />
				<param name="quality" value="high" />
				<param name="allowScriptAccess" value="sameDomain" />
				<param name="allowFullScreen" value="true" />
				<!--[if !IE]>-->
				<object type="application/x-shockwave-flash" data="Location.swf"
					width="800" height="800">
					<param name="quality" value="high" />
					<param name="WMODE" value="transparent"/>
					<param name="allowScriptAccess" value="sameDomain" />
					<param name="allowFullScreen" value="true" />
					<!--<![endif]-->
					<!--[if gte IE 6]>-->
					<p>
						Either scripts and active content are not permitted to run or
						Adobe Flash Player version 10.0.0 or greater is not installed.
					</p>
					<!--<![endif]-->
					<a href="http://www.adobe.com/go/getflashplayer"> <img
							src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"
							alt="Get Adobe Flash Player" /> </a>
					<!--[if !IE]>-->
				</object>
				<!--<![endif]-->
			</object>
		</noscript>
	</body>
</html>

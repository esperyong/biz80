<!-- WEB-INF\content\location\define\flash-define.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head> 
		<%@ include file="/WEB-INF/common/meta.jsp"%>
		<%@ include file="/WEB-INF/common/loading.jsp" %>
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
		<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
		<script src="${ctx}/js/component/cfncc.js"></script>	
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
            params.wmode = "transparent";
            params.allowfullscreen = "true";            
            params.isBrowse = "true";
			
            var attributes = {};
            attributes.id = "Location";
            attributes.name = "Location";
            attributes.align = "middle";
            
            flashvars.url="${ctx}/location/define/defineflash!mapXML.action?locationId=${location.locationId}";
            flashvars.imageurl="${ctx}/flash/location/flash/location/image/assets/toolbox/";
            flashvars.dataurl="${ctx}/location/define/defineflash!saveLocationData.action?locationId=${location.locationId}";
            flashvars.roomurl="${ctx}/location/define/room!allRoom.action";
            flashvars.roomLicense = "${roomLicense}";
            //alert(flashvars.url);
            //flashvars.saveurl="${ctx}/location/define/defineflash!saveLocationFlashXML.action?locationId=${location.locationId}";
            //alert('${ctx}');
            swfobject.embedSWF(
                "${ctx}/flash/location/flash/Location.swf", "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
			
	
			
	function doEnd(locationId){
			toast.addMessage("保存区域结构成功，并将区域结构生成为导航。");
			// 刷新物理位置数
			window.setTimeout(loadLocationNewDomain(loadLocationNewDomain,locationId), 500);
			//loadHandles(locationId);
	}		
			
	function doAlert(info){
		var _information = new information({text:info}); 
		_information.show();
	}			
	
	function doDel(locationId,LocationName){
	var flashobj=	document.getElementById("Location");
	var _confirm = new confirm_box({text:"是否确认执行此操作？"});
		_confirm.setContentText("删除‘"+LocationName+"’将删除节点本身及其子区域，是否确认删除？");
 		_confirm.setConfirm_listener(function(){
  		$.ajax({
			url:		ctx + "/location/define/location!delteLocation.action",
			data:		"location.locationId=" + locationId,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				flashobj.excuteCMD("delNode",locationId);
				_confirm.hide();
			}
		});
 			});
 	_confirm.show();

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
		
<div  id="flashContent_f" style="height:700px; width:100%">
		<div id="flashContent" style="position:absolute;z-index:2">
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

<script>
var toast=null;
$(document).ready(function () {
		toast = new Toast({position:"CT"});
		});
		
//右键弹出属性框
function creatFloor() {
  	//window.showModalDialog("${ctx}/location/define/floor.action", null, "help=no;status=no;scroll=no;center=yes")
  	window.open("${ctx}/location/define/floor.action");
}
//存储属性给flash
function saveProperty(object) {
	
    var flashobj=	document.getElementById("Location"); 
    //alert(object.flashType);
    //alert(object.flashType);
	flashobj.excuteCMD("attribute",object);	
}
//保存按钮需要保存
function ableBtn(btnname, status){
$("#location_flashchangeflag").val(1);
}
function doIt(){
			$("#location_flashchangeflag").val(0);
			//alert(2);
			var flashobj=	document.getElementById("Location");
			//alert(flashobj);
			flashobj.excuteCMD("save",null);
}

function startLoading(){
$.blockUI({message:$('#loading')});
}

function endLoading(){
$.unblockUI();
}

</script>
<script>
//右键菜单
var RightClick = {
		/**
		 *  Constructor
		 */ 
		init: function () {
		//alert('RightClick .init');
			this.FlashObjectID = "Location";
			this.FlashContainerID = "flashContent_f";
			this.Cache = this.FlashObjectID;
			if(window.addEventListener){
				 window.addEventListener("mousedown", this.onGeckoMouse(), true);
			} else {
			document.getElementById(this.FlashContainerID).onmouseup = function() { document.getElementById(RightClick.FlashContainerID).releaseCapture(); }
			document.oncontextmenu = function(){ if(window.event.srcElement.id == RightClick.FlashObjectID) { return false; } else { RightClick.Cache = "nan"; }}
			document.getElementById(this.FlashContainerID).onmousedown = RightClick.onIEMouse;

			}
		},
		/**
		 * GECKO / WEBKIT event overkill
		 * @param {Object} eventObject
		 */
		killEvents: function(eventObject) {
			if(eventObject) {
				if (eventObject.stopPropagation) eventObject.stopPropagation();
				if (eventObject.preventDefault) eventObject.preventDefault();
				if (eventObject.preventCapture) eventObject.preventCapture();
		   		if (eventObject.preventBubble) eventObject.preventBubble();
			}
		},
		/**
		 * GECKO / WEBKIT call right click
		 * @param {Object} ev
		 */
		onGeckoMouse: function(ev) {
		alert(1);
		  	return function(ev) {
		    if (ev.button != 0) {
				RightClick.killEvents(ev);
				if(ev.target.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
		    		RightClick.call();
				}
				RightClick.Cache = ev.target.id;
			}
		  }
		},
		/**
		 * IE call right click
		 * @param {Object} ev
		 */
		onIEMouse: function() {
		//alert('onIEMouse');
		  	if (event.button > 1) {
				if(window.event.srcElement.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
					RightClick.call(); 
				}
				document.getElementById(RightClick.FlashContainerID).setCapture();
				if(window.event.srcElement.id)
				RightClick.Cache = window.event.srcElement.id;
			}
		},
		/**
		 * Main call to Flash External Interface
		 */
		call: function() {
			//alert('call');
			//document.getElementById(this.FlashObjectID).rightClick()=excuteCMD("rightClick",null);
			document.getElementById(this.FlashObjectID).excuteCMD("rightClick","");
		}
	}
RightClick.init();



</script>
	</body>
</html>

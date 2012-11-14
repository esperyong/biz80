<!-- WEB-INF\content\location\view\browse-content.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.DesignImageTypeEnum"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<link href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/portal02.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" />
<link href="${ctx}/flash/history/history.css" />
<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />

<body style="height: 100%" onhashchange="">
<div class="physical-location" style="height: 100%">
  <div class="phy-top-l">
    <div class="phy-top-r">
      <div class="phy-top-m"></div>
    </div>
  </div>
  <div class="phy-mid-l">
    <div class="phy-mid-r">
      <div class="phy-mid-m" style="height:750px;">
	  <!--左边菜单开始，关闭样式：class="phy-menu-close"-->
        <div class="phy-menu-open" id="phy-menu" style="width:0px;height: 100%">
            <div class="phy-menu-btn" id="displayState"></div>
            <!-- 
            <div class="phy-menu-layers" id="locationsState" style="overflow:auto;margin:4px;height: 100%"></div>
             -->
        </div>
        <iframe id="locationsState" name="suspendFrame" src="${ctx}/location/define/location!locationsState.action" scrolling="no" 
                frameborder="0" marginheight="0" marginwidth="0" style="width:200px;height:100%;top:0px; left:0px;position: absolute;overflow: hidden;filter:alpha(opacity=70);z-index:1000;display:block;background-color:#565656;"></iframe>
		<!--    左边菜单结   束-->
		
		<!--右边菜单开始，关闭样式：class="phy-rightmenu-close"-->
		<div class="phy-rightmenu-open" id="phy-rightmenu">
          <ul class="line">
            <li class="btn"  id="phy-rightmenu-btn"></li>
            <li style="padding-bottom: 6px; padding-left: 60px; padding-right: 0px; font-family: Arial, Helvetica, sans-serif; float: left; color: #ffcc33; font-size: 14px; font-weight: 700; padding-top: 6px;">关联的内容</li>
          </ul>
          <div id="relationContent"></div>
        </div>	
		<!--    右边菜单结   束-->
		<!-- 普通物理位置 2D falsh 开始-->
		<div id="locationContainer_t" style="height: 100%">
		<div id="locationContent" style="z-index: 112;height: 100%; display: none">
			<p>To view this page ensure that Adobe Flash Player version 10.0.0
			or greater is installed.</p>
			<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script>
		</div>
		</div>
		<!-- 普通物理位置 2D falsh 结束-->	
		<!-- 楼层 3D Unity 开始-->
		<div id="unityPlayerDIV" style="display:none">
			<div id="content_3d" style="float:left;overflow:hidden;overflow-x:hidden;">
				<div id="unityPlayer_3d">
					<div class="missing">
					<a href="http://unity3d.com/webplayer/"	title="Unity Web Player. Install now!">
						<img alt="Unity Web Player. Install now!"
							src="http://webplayer.unity3d.com/installation/getunity.png" width="193" height="63" />
					</a>
					</div>
				</div>
			</div>
			<div id="contentShow" style="float: left;width: 180px;background-color:#000;border-style:solid;border-color:#cccccc;border-width:1px">
<pre style="font-size:15px;color:#fff;">

<b style="font-size:16px;">    支持3D展现</b>

  物理位置使用3D图片来
  展现楼层。用户在新建
  楼层时，将3D文件打包
  上传，即可展现3D楼层。 

<b style="font-size:16px;">  体现整体组织结构或</b>
<b style="font-size:16px;">  地域分布</b>

  可按公司整体的组织结
  构或地域分布，在物理
  位置中进行定义，一目
  了然，查看公司整体分
  布。 

<b style="font-size:16px;">  和机房的关联</b> 

  在从整体定义了物理位
  置之后，针对单个的物
  理位置，例如某个房间
  、某个 机房，可关联
  具体的设备，并且当设
  备异常时，从物理位置
  的整体视图中能够清晰
  的定位到故障设备所在
  。当故障解决后，可在
  物理位置中快速验证。
</pre>
			</div>
		</div>
		<!-- 楼层 3D Unity 结束-->
		<!-- 机房 开始-->
		<div id="roomContainer" style="height: 600px;display: none">
		<iframe id="roomid" name="suspendFrame" src="" scrolling="no"
					frameborder="0" marginheight="0" marginwidth="0" width="76%" height="100%" allowtransparency="true" style="background-color:transparent"></iframe>
		</div>
		<!-- 机房  结束-->
      </div>
    </div>
  </div>
  <div class="phy-bottom-l">
    <div class="phy-bottom-r">
      <div class="phy-bottom-m"></div>
    </div>
  </div>
</div>
</body>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script src="${ctxJs}/jquery.validationEngine.js"></script>
<script src="${ctx}/flash/history/history.js"></script>
<script src="${ctx}/flash/swfobject.js"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctx}/js/component/comm/winopen.js"></script>
<script src="${ctxJs}/component/treeView/tree.js"></script>
<script src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
<script src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
<script src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
<script src="${ctxJs}/component/plugins/jquery.ui.accordion.js"></script>
<script src="${ctxJs}/component/accordionPanel/j-dynamic-accordion.js"></script>
<script src="${ctxJs}/component/tabPanel/j-dynamic-tab.js"></script>
<script src="${ctxJs}/component/pullBox/j-dynamic-pullbox-1.1.js"></script>
<script src="${ctxJs}/component/panel/panel.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctxJs}/location/define/locations.js"></script>
<script type="text/javascript" src="${ctx}/js/room/UnityObject.js"></script>
<script type="text/javascript" src="${ctx}/flash/location/unity3d/CaptureScreen.js"></script>
<script type="text/javascript">
var locationId="${location.locationId}";
var current_location = {};
var unityUrl="<%=request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort()%>${ctx}";
var filePath;

function mapwidth(){
return $(".phy-mid-l").width()-220;
}

document.getElementById("contentShow").style.height=($(".phy-mid-l").height()-50)+"px";
function showDIV1(){
	document.getElementById("content_3d").style.width=mapwidth()+"px";
	document.getElementById("contentShow").style.display="none";
}
function disDIV1(){
	document.getElementById("content_3d").style.width=(mapwidth()-180)+"px";
	document.getElementById("contentShow").style.display="block";
}

//加载3D模型
function loadUnity(path){
	if (typeof unityObject != "undefined") {
		showDIV1();
		filePath=path;	
		var params = {disableContextMenu: true,
						backgroundcolor: "000000",
						bordercolor: "000000",
					  textcolor: "FFFFFF",
					  logoimage: "${ctx}/flash/logo.png"};
		//var WebPlayer_url=unityUrl+"/flash/location/unity3d/WebPlayer.unity3d";
		var WebPlayer_url=unityUrl+"/flash" + filePath;
		unityObject.embedUnity("unityPlayer_3d", WebPlayer_url,
				$(".phy-mid-l").width()-220,
				$(".phy-mid-l").height()-100,
				params);
		disDIV1();
		setto=setTimeout("showDIV1()",15000);
	}
}
// 得到3D模型对象
function GetUnity() {
	if (typeof unityObject != "undefined") {
		return unityObject.getObjectById("unityPlayer_3d");
	}
	return null;
}

            
function loaded(text){
	//alert("test loaded ok: " + text);
}

//设置模型类别，可选值：MachineRoom、Floor，这个值决定了刷新数据的类
function configUnity(){
        //楼层
        GetUnity().SendMessage("root", "setModelName", "Floor");
         //设置模型状态： runtime/design/browse，三种模式可选
        GetUnity().SendMessage("root", "ChangeState", "runtime");
}  
          
//unity 将模型加载完成之后调用init方法
 function init(){
 		//var floor_url=unityUrl+"/flash" + filePath;
		//加载模型楼层
		//LoadModel(floor_url);
		LoadInternalModel();
}  

//非通知Unity加载模型方式
 function LoadInternalModel()
 {
     GetUnity().SendMessage("root", "LoadInternalModel", "");
 }
     

//通知Unity加载模型
function LoadModel(url){
         GetUnity().SendMessage("root", "LoadModel", url);
}
            //model
            var ModelName;
            
            //模型加载完成，为了能够让浏览器客户端能够对模型进行一些视角的调整，增加这个方法
            function customizeModel(modelName)
            {
                ModelName = modelName;
                //alert(modelName + ": wait ...");
                
                GetUnity().SendMessage(modelName, "Zoom", 10);
                GetUnity().SendMessage(modelName, "RotateLeft", 0);
                GetUnity().SendMessage(modelName, "RotateDown", 0);
                
            }
function LoadModelCompleted(){                                
                //root.SetRefreshUrl(string url, int 刷新时间间隔秒数);
         GetUnity().SendMessage("root", "SetRefreshInterval", 20);
}
            
//单击模型
function clickModel(type,locationId){
	var o={type:"<%=DesignImageTypeEnum.room.getKey() %>",clickLocationId:locationId};
    onDoubleClick(o);
}
            
//Unity向页面请求状态数据
function loadData() {
			//alert(locationId);
        	$.ajax({
        		type: "post",
        		dataType:'json', //接受数据格式 
        		cache:false,
        		data:"locationId="+locationId, 
        		url: unityUrl+"/location/design/locationmap3d!get3DComponentXML.action",
        		success: function(data, textStatus){
        			//alert(data.xml3d);
        			GetUnity().SendMessage("root", "Refresh", data.xml3d);   
        		},
        		error: function(){
        		//请求出错处理
        			//alert("error");
        		}
        		});
        }        
            
//在3d模型中选定一个对象后，显示名称
function setSelectedModel3d(name){
	selectedModel3d.innerHTML = name;
}
            
</script>
<script type="text/javascript">        
//截图完成，把图片回传给截图程序
function completeGetPng(){
                window.external.unity3dCaptureComplete(pngstr);
            }
            
//unity3d的绝对位置坐标
function unity3dLocation(){
			//return "0,200";
            var aaa= getElementPos("unityPlayer_3d");
            return aaa.x+","+aaa.y;
}            
</script>
<script>
function getElementPos(elementId) {
 var ua = navigator.userAgent.toLowerCase();
 var isOpera = (ua.indexOf('opera') != -1);
 var isIE = (ua.indexOf('msie') != -1 && !isOpera); // not opera spoof
 var el = document.getElementById(elementId);
 if(el.parentNode === null || el.style.display == 'none') {
    return false;
 }      
 var parent = null;
 var pos = [];     
 var box;     
 if(el.getBoundingClientRect) { //IE
    box = el.getBoundingClientRect();
    var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
    var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
    return {x:box.left + scrollLeft, y:box.top + scrollTop};
 } else if (document.getBoxObjectFor) { // gecko
    box = document.getBoxObjectFor(el); 
    var borderLeft = (el.style.borderLeftWidth)?parseInt(el.style.borderLeftWidth):0; 
    var borderTop = (el.style.borderTopWidth)?parseInt(el.style.borderTopWidth):0; 
    pos = [box.x - borderLeft, box.y - borderTop];
 } else { // safari & opera
    pos = [el.offsetLeft, el.offsetTop]; 
    parent = el.offsetParent;     
    if (parent != el) { 
     while (parent) { 
      pos[0] += parent.offsetLeft; 
      pos[1] += parent.offsetTop; 
      parent = parent.offsetParent;
     } 
    }   
    if (ua.indexOf('opera') != -1 || ( ua.indexOf('safari') != -1 && el.style.position == 'absolute' )) { 
     pos[0] -= document.body.offsetLeft;
     pos[1] -= document.body.offsetTop;         
    }    
 }              
 if (el.parentNode) { 
    parent = el.parentNode;
 } else {
    parent = null;
 }
 while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML') { // account for any scrolled ancestors
    pos[0] -= parent.scrollLeft;
    pos[1] -= parent.scrollTop;
    if (parent.parentNode) {
     parent = parent.parentNode;
    } else {
     parent = null;
    }
 }
 return {x:pos[0], y:pos[1]};
 }

</script>
<script type="text/javascript">
$(document).ready(function() {
	var $leftMenu = $("#phy-menu"); 
	var $rightMenu = $("#phy-rightmenu"); 
	var objIframe=document.getElementById("locationsState");
	$("#displayState").click(function(){
		
		if($leftMenu.attr("class")=="phy-menu-open"){
			$leftMenu.addClass("phy-menu-close")
			objIframe.style.display="none";
		} else {
			$leftMenu.removeClass("phy-menu-close")
			objIframe.style.display="block";
		}
	});

	$("#phy-rightmenu-btn").click(function(){
		if($rightMenu.attr("class")=="phy-rightmenu-open"){
			$rightMenu.addClass("phy-rightmenu-close")
		} else {
			$rightMenu.removeClass("phy-rightmenu-close")
		}
	});

	// 加载物理位置状态页面
	//loadDomainState(function(){
	//			loadFlash();
	//			loadRelContent();
	//		  },locationId
	//);
	
	//首页
    if(window.HP){
	    HP.addActivate(function(){
	    	// alert("激活");
	    });
	
	    HP.addSleep(function(){
	    	// alert("失效");
	    });
	    HP.addDestory({});
    }
	
});
// 加载Flash
function loadFlash(){
	// For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection.
	var swfVersionStr = "10.0.0";
	// To use express install, set to playerProductInstall.swf, otherwise the empty string.
	var xiSwfUrlStr = "${ctx}/flash/location/draw2dflash/playerProductInstall.swf";
	var flashvars = {isBrowse:"false", modle:"view", locationId:locationId,
			url:"${ctx}/location/design/locationmapdesign!mapXML.action?locationId="+locationId,
			saveurl:"${ctx}/location/design/locationmapdesign!saveLocationMapFlashXML.action?locationId="+locationId,
			imageurl:"${ctx}/flash/location/flash/location/image/assets/toolbox/",
			dataurl:"${ctx}/location/design/locationmapdesign!dataViewXML.action?locationId="+locationId,//业务数据的url
			datasaveurl:"${ctx}/location/design/locationmapdesign!saveLocationMapComponentFlashData.action?locationId="+locationId
			};
	var params = {bgcolor:"#ffffff", wmode:"transparent", quality:"high", allowscriptaccess:"sameDomain", allowfullscreen:"true", isBrowse:"true"};
	var attributes = {id:"LocationMap", name:"LocationMap", align:"middle"};
	swfobject.embedSWF(
		    "${ctx}/flash/location/draw2dflash/LocationEditer.swf", "locationContent", 
		    $(".phy-mid-l").width()-20,
		    $(".phy-mid-l").height(), 
		     swfVersionStr, xiSwfUrlStr, 
		     flashvars, params, attributes);
	// JavaScript enabled so display the locationContent div in case it is not replaced with a swf object.
	swfobject.createCSS("#locationContent", "display:block;text-align:left;");
}

function showD(){
var w = $("#roomid").attr("width");
var roomwidth = $(".phy-mid-l").width()-$("#locationsState").width()-220;
if(w == roomwidth){
$("#roomid").attr("width",roomwidth-1);
}else{
$("#roomid").attr("width",roomwidth);
}

}
//加载机房定义
function loadRoom(){
var roomwidth = $(".phy-mid-l").width()-$("#locationsState").width()-220;
	$("#roomid").attr("width",roomwidth);
	var ctx="${ctx}";
	$("#roomid").attr("src",ctx+"/roomDefine/MonitorVisit!showRoom.action?roomId="+current_location.locationId);
	if(current_location.flashType == "2D"){
		$("#roomid").attr("width","100%");
		}else{
			setTimeout("showD()",2000);
			}
	/*
	$.ajax({
		cache:false,
		dataType:'html', //接受数据格式 
		data:"roomId="+current_location.locationId, 
		url: "${ctx}/roomDefine/MonitorVisit!showRoom.action",
		success: function(data, textStatus){
			//prompt("",data);
			$("#roomContainer").html(data);
			$("#roomContainer").find("div[id^=flash0_]").html("");
			$("#roomContainer").find("iframe[id^=menuFrame_]").hide();
		}});
		*/
}
// 重新物理位置的内容
function refreshModel(){

	if(current_location.type=="<%=com.mocha.bsm.location.enums.LocationTypeEnum.LOCATION_ROOM.getKey()%>"){
		$("#locationContainer_t").hide();
		//$("#unityPlayerDIV").hide();
		$("#unityPlayerDIV").hide();
		loadRoom();
		$("#roomContainer").show();
	} else if(current_location.flashType && current_location.flashType=="<%=com.mocha.bsm.location.enums.LocationMapTypeEnum.MAP3D.getKey()%>"){
		$("#locationContainer_t").hide();
		$("#roomContainer").hide();
		$("#unityPlayerDIV").show();
		loadUnity(current_location.filePath);
	} else {
		$("#unityPlayerDIV").hide();
		$("#roomContainer").hide();
		$("#locationContainer_t").show();
		try{
			document.getElementById("LocationMap").excuteCMD("refresh",
				{locationId:locationId,
				url:"${ctx}/location/design/locationmapdesign!mapXML.action?locationId="+locationId,
				saveurl:"${ctx}/location/design/locationmapdesign!saveLocationMapFlashXML.action?locationId="+locationId,
				dataurl:"${ctx}/location/design/locationmapdesign!dataViewXML.action?locationId="+locationId,//业务数据的url
				datasaveurl:"${ctx}/location/design/locationmapdesign!saveLocationMapComponentFlashData.action?locationId="+locationId
				});
			}catch(e){}
	}
}

function startLoading(){
	$.blockUI({message:$('#loading')});
	}

	function endLoading(){
	$.unblockUI();
	}
// 双击中转页面
function onDoubleClick(object){
	
	if("<%=DesignImageTypeEnum.builder.getKey() %>"==object.type 
			|| "<%=DesignImageTypeEnum.floor.getKey() %>"==object.type 
			|| "<%=DesignImageTypeEnum.room.getKey() %>"==object.type 
			|| "<%=DesignImageTypeEnum.office.getKey() %>"==object.type
			|| "<%=DesignImageTypeEnum.logo.getKey() %>"==object.type
			|| object.type.indexOf("<%=DesignImageTypeEnum.label.getKey() %>")>=0){
		if(object.clickLocationId!=""){
			
			loadLocationContent(object.clickLocationId);
		}
	} else if("<%=DesignImageTypeEnum.desk.getKey() %>"==object.type){
		if(object.clickResId!=""){
			winOpen({url:'${ctx}/detail/resourcedetail.action?instanceId=' + object.clickResId,width:980,height:600,scrollable:false,name:object.clickResId}); 
		}else if(object.clickURL!=""){
			winOpen({url:object.clickURL,width:980,height:600,scrollable:false,name:object.clickResId});
		}
	} else if("Rectangle"==object.type
			||"RoundedRectangle"==object.type
			||"Ellipse"==object.type){
		if(object.clickType=='locationPage'&&object.clickLocationId!=""){
			loadLocationContent(object.clickLocationId); 
		}else if(object.clickType=='resPage'&&object.clickResId!=""){
			winOpen({url:'${ctx}/detail/resourcedetail.action?instanceId=' + object.clickResId,width:980,height:600,scrollable:false,name:object.clickResId}); 
		}else if(object.clickType=='urlPage'&&object.clickURL!=""){
			winOpen({url:object.clickURL,width:980,height:600,scrollable:false,name:object.clickResId});
		}
	}
}
// 加载物理位置下的内容
function loadLocationContent(vLocationId){
	var contentfrm = window.frames['locationsState'];
	locationId=vLocationId;
	$.ajax({
		url: 		"${ctx}/location/define/location!getLocationById.action",
		data:		"location.locationId="+locationId,
		dataType: 	"json",
		cache:		false,
		success: function(data, textStatus){
			current_location=data.location;
			contentfrm.setCurrentNode(locationId);
			// 刷新模型
		  	refreshModel();
		  	// 加载关联内容
		  	loadRelContent();
		}
  });
}
function linkInfo(linkId){
	winOpen({url:'/netfocus/modules/link/linkdetail2.jsp?instanceid=' + linkId,width:980,height:600,scrollable:false,name:linkId});
}
</script>
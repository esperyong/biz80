<!-- WEB-INF\content\location\design\design-main-2d.jsp -->
<!--显示／控制2DFlash -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.DesignImageTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctxCss}/footer.css" rel="stylesheet" type="text/css" />
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
<!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
			 JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
			 when JavaScript is disabled.
		-->
<!--TEST-->
<div id="button_location" style="float:left;width: 100%">
		<input type="hidden" name="locationId.locationId" value="${location.locationId}" id="location.locationId"/>
</div>		
		
		
<!-- FLASHCONTENT-->		
<div id="flashContent_t">		
<div id="flashContent" style="z-index: 112;height: 360;" >
<p>To view this page ensure that Adobe Flash Player version 10.0.0
or greater is installed.</p>
<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				//alert(pageHost);
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script>
</div>
</div>
<!-- 工具栏 -->
<page:applyDecorator name="tools">
	<page:param name="width">440</page:param>
	<page:param name="available">true</page:param>
	<page:param name="isExpend">true</page:param>
	<page:param name="btns">
    [[
      {id:"zoom-in",oncls:"zoom-in",offcls:"zoom-in",disablecls:"zoom-in-off",available:"on",title:"放大"},
      {id:"zoom-out",oncls:"zoom-out",offcls:"zoom-out",disablecls:"zoom-out-off",available:"on",title:"缩小"}],
     [{id:"repeal",oncls:"repeal",offcls:"repeal",disablecls:"repeal-off",available:"false",title:"撤销"},
      {id:"resume",oncls:"resume",offcls:"resume",disablecls:"resume-off",available:"false",title:"恢复"}], 
     [{id:"natural-size",offcls:"natural-size",disablecls:"natural-size-off",available:"off",title:"正常大小"},
      {id:"fit-window",offcls:"fit-window",disablecls:"fit-window-off",available:"off",title:"适合窗口"}],
     [{id:"textarea",offcls:"textarea",disablecls:"textarea-off",available:"off",title:"文本框"},
     {id:"font-border",oncls:"font-border",offcls:"font-border",disablecls:"font-border-off",available:"off",title:"隐藏/显示边框"},
     {id:"font-size",oncls:"font-size",offcls:"font-size",disablecls:"font-size-off",available:"off",title:"字体大小"},     
     {id:"font-bold",oncls:"font-bold",offcls:"font-bold-off",disablecls:"font-bold-off",available:"false",title:"字体加粗"},
      {id:"font-color",oncls:"font-color",offcls:"font-color",disablecls:"font-color-off",available:"off",title:"文字颜色"},],
     [{id:"node-color",oncls:"node-color",offcls:"node-color",disablecls:"node-color-off",available:"off",title:"填充颜色"}],
     [{id:"save",oncls:"save",offcls:"save",disablecls:"save-off",available:"false",title:"保存"},
      {id:"delete",oncls:"delete",offcls:"delete",disablecls:"delete-off",available:"on",title:"删除"}]]
    </page:param>
     <!--
     {id:"mouse",oncls:"mouse",offcls:"mouse-off",disablecls:"mouse-off",available:"on",title:"选择"}, 
     ,
      {id:"font-border",offcls:"font-border",disablecls:"font-border",available:"off",title:"显示/隐藏文本框"}
     {id:"font-bold",oncls:"font-bold-off",offcls:"font-weight-off",disablecls:"font-weight-off",available:"off",title:"文字粗细"}, 
     -->
</page:applyDecorator>

<!-- 工具箱  -->
<div id="rightRoot"
	style="position: absolute; top: 0px; right: 0px; z-index: 100; height: 100%; width: 40%"></div>
<page:applyDecorator name="colorPanel">  
</page:applyDecorator>
<page:applyDecorator name="fontsizepanel">  
     <page:param name="fontsizekind">8,9,10,12,14,16,18,20,22,26,32</page:param>
     </page:applyDecorator> 
<script type="text/javascript">

var chooseFlag="false";
var currID="";
var theObj={};
function doIt(){

		$("#location_flashchangeflag").val(0);
			//alert(2);
		var flashobj=	document.getElementById("LocationMap");	
		flashobj.excuteCMD("save",null);
			
	}

//工具栏
$(function(){

	Footools.init({listeners:{click:function(id){
	
		//保存
		if('save' == id){
		
		$("#location_flashchangeflag").val(0);
		var flashobj=	document.getElementById("LocationMap");	
		flashobj.excuteCMD("save",null);
		}
		//删除 
		else if('delete' == id){
			document.getElementById("LocationMap").excuteCMD("del",null);
		}
		//文本框
		else if('textarea' == id){
			document.getElementById("LocationMap").excuteCMD("text",null);
		}
		//文本框是否显示边框
		else if('font-border' == id){
			document.getElementById("LocationMap").excuteCMD("fontborder",null);
		}
		//填充颜色
		else if('node-color' == id){
			ColorPanel.init({color:"#ffffff",isClose:true,x:100,y:100,clickAfter:function(color){
			var tmpObj={};
			tmpObj.color=color;
			color="0x"+color;
			//alert(color);
			document.getElementById("LocationMap").excuteCMD("fillColor",color);
			}}); 
			ColorPanel.show();

			
		}
		//边框颜色
		else if('border-color' == id){
		ColorPanel.init({color:"#ffffff",isClose:true,x:100,y:100,clickAfter:function(color){
			var tmpObj={};
			tmpObj.color=color;
			color="0x"+color;
				document.getElementById("LocationMap").excuteCMD("bordercolor",color);
			}}); 
			ColorPanel.show();
		}
		//文字大小
		else if('font-size' == id){
		
		  var pos = getElementPos(id);
		  //alert(pos);
		  
		  FontSizePanel.init({size:13,isClose:false,x:pos.x-280,y:pos.y-240,clickAfter:function(size){
				var tmpObj={};
				tmpObj.fontsize=size;
				//parent.document.getElementById("LocationMap").excuteCMD("fontSize",size);
				document.getElementById("LocationMap").excuteCMD("fontSize",size);
				}}
			); 
			FontSizePanel.show(); 
				
				
			//var tmpObj={};
			//tmpObj.fontsize=20;
			//parent.document.getElementById("LocationMap").excuteCMD("fontsize",14);
		}
		//文字颜色
		else if('font-color' == id){
		ColorPanel.init({color:"#ffffff",isClose:true,x:100,y:100,clickAfter:function(color){
			var cc='0x'+color;
			document.getElementById("LocationMap").excuteCMD("textColor",cc);
			}}); 
			ColorPanel.show();
			
		}
		//文字粗细
		else if('font-weight' == id){
			var tmpObj={};
			tmpObj.bold=true;
			parent.document.getElementById("LocationMap").excuteCMD("bold",tmpObj);
		}
		//缩小
		else if('zoom-in' == id){
			var flashobj=	document.getElementById("LocationMap");	
			flashobj.excuteCMD("zoomout",null);
		}
		//放大
		else if('zoom-out' == id){
			var flashobj=	document.getElementById("LocationMap");	
			flashobj.excuteCMD("zoomin",null);
		}
		//自适应
		  else if('fit-window' == id){
		   var flashobj= document.getElementById("LocationMap"); 
		   flashobj.excuteCMD("fitWindow",null);
		  }
		  //原始大小
		  else if('natural-size' == id){
		   var flashobj= document.getElementById("LocationMap"); 
		   flashobj.excuteCMD("normalSize",null);
		  } 
		//撤销
		else if('repeal' == id){			
		   var flashobj= document.getElementById("LocationMap"); 
		   flashobj.excuteCMD("undo",null);
		}
		//恢复
		else if('resume' == id){			
		   var flashobj= document.getElementById("LocationMap"); 
		   flashobj.excuteCMD("redo",null);
		}
	}
}
});
});

//工具栏撤销恢复按钮状态设置
function ableBtn(btnname, status){

	if(status == 'true'){
	//设置常量为需要保存
	$("#location_flashchangeflag").val(1);
		if(btnname=='save'){
			Footools.btnOn('save');
		}else if(btnname=='undo'){		
			Footools.btnOn('repeal');		
		}else if(btnname=='redo'){
			Footools.btnOn('resume');		
		}
	}else{
		if(btnname=='save'){
			Footools.btnDisable('save');
		}else if(btnname=='undo'){		
			Footools.btnDisable('repeal');		
		}else if(btnname=='redo'){
			Footools.btnDisable('resume');		
		}
		//Footools.btnDisable('repeal');
	}
}

</script>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>


<script src="${ctxJs}/jquery.validationEngine-cn.js"
	type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/flash/history/history.css" />
<script type="text/javascript" src="${ctx}/flash/history/history.js"></script>

<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript"
	src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript"
	src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript"
	src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript"
	src="${ctxJs}/component/plugins/jquery.ui.accordion.js"></script>

<script type="text/javascript"
	src="${ctxJs}/component/accordionPanel/j-dynamic-accordion.js"></script>
<script type="text/javascript"
	src="${ctxJs}/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript"
	src="${ctxJs}/component/pullBox/j-dynamic-pullbox-1.1.js"></script>

<script type="text/javascript">
           <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/location/draw2dflash/playerProductInstall.swf";
            //alert(xiSwfUrlStr);
            var flashvars = {};
            var params = {};
            params.bgcolor = "#ffffff";
            
            params.wmode = "transparent";
            
            params.quality = "high";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
           
            
            var attributes = {};
            attributes.id = "LocationMap";
            attributes.name = "LocationMap";
            attributes.align = "middle";
            
            
            flashvars.isBrowse="false";
            flashvars.modle="design";
            flashvars.locationId="${location.locationId}";
             //获取展现数据
             //纯ui
            flashvars.url="${ctx}/location/design/locationmapdesign!mapXML.action?locationId=${location.locationId}";
            flashvars.saveurl="${ctx}/location/design/locationmapdesign!saveLocationMapFlashXML.action?locationId=${location.locationId}";
            flashvars.imageurl="${ctx}/flash/location/flash/location/image/assets/toolbox/";
            //业务数据的url
            flashvars.dataurl="${ctx}/location/design/locationmapdesign!dataXML.action?locationId=${location.locationId}";
            //alert(flashvars.dataurl);
            flashvars.datasaveurl="${ctx}/location/design/locationmapdesign!saveLocationMapComponentFlashData.action?locationId=${location.locationId}";
            flashvars.autobutton="${autobutton}";
            swfobject.embedSWF(
                "${ctx}/flash/location/draw2dflash/LocationEditer.swf", "flashContent", 
                "100%", "85%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script>


<script language="javascript">
	var accordionPanelBox = null;
	var slabId = "";
	// 重新加载PageSlab
	function reloadPageSlab(){
		accordionPanelBox.expanseSlab(slabId);
	}
	//绘图箱
	$(function() {
				$('body #rightRoot').empty();
				//创建折叠组建对象(slid:设置折叠动作是否带有滑动动画效果,panelBlockStyle:设置折叠样式风格，目前只支持blackbox和tree两种风格)
				accordionPanelBox = new JDynamicAccordionPanel({id:"bizServiceDefinedAccordion3", slid:true, panelBlockStyle:"blackbox"});
				
				//添加折叠页（折叠页content部分引用的是一个具体url）
				//第一个参数：json对象(slabID:slab页id,label:slab页label,contentHeight:slab页content部分的高度值)
				//第二个参数：字符串(折叠页content部分引入的具体url路径)
				//第三个参数：json对象(需要添加的用户参数信息，这个参数信息会在点击折叠页的回调函数中传递到具体的用户回调函数中)
				//第四个参数：函数对象引用(点击折叠页的时候会调用这个回调函数并将该折叠页对应的参数信息及用户参数信息传递到具体的用户回调函数中)
				accordionPanelBox.addPageSlab({slabID:"slab-1",label:"插入图片",contentHeight:"350px"},
						"${ctx}/location/design/designImage!showImages.action?"+
						"types=<%=DesignImageTypeEnum.map.getKey() %>"+
						"&types=<%=DesignImageTypeEnum.builder.getKey() %>"+
						"&types=<%=DesignImageTypeEnum.floor.getKey() %>"+
						"&types=<%=DesignImageTypeEnum.room.getKey() %>"+
						"&types=<%=DesignImageTypeEnum.office.getKey() %>"+
						"&types=<%=DesignImageTypeEnum.desk.getKey() %>"+
						"&types=<%=DesignImageTypeEnum.logo.getKey() %>", null, null);
				accordionPanelBox.addPageSlab({slabID:"slab-2",label:"插入形状",contentHeight:"350px"}, 
						"${ctx}/location/design/designImage!showImages.action?"+
						"&types=<%=DesignImageTypeEnum.basic.getKey() %>"+
						"&types=<%=DesignImageTypeEnum.label.getKey() %>", null, null);
				accordionPanelBox.addPageSlab({slabID:"slab-3",label:"插入背景",contentHeight:"350px"}, 
						"${ctx}/location/design/designImage!showImages.action?"+
						"&types=<%=DesignImageTypeEnum.back.getKey() %>", null, null);
				//accordionPanelBox.addInnerComponetSlab({slabID:"slab-3",label:"背景",contentHeight:"350px"}, tabPanelTemp3.getComponetHandle(), null, null);
				slabId  = "slab-1"
				//设置折叠组建,处于展开状态的折叠页
				accordionPanelBox.expanseSlab(slabId);
				accordionPanelBox.click(function(slabDataMap){
					slabId=slabDataMap.slabID;
				});

				//创建推拉box组件(animated:推拉速度("slow", "normal", "fast", or number))
				var jpullPanelObj = new JDynamicPullPanel({id:"jPull-1", label:"绘图", contentWidth:"200px",contentHeight:"530px", animated:"slow"});
				jpullPanelObj.addTitleToolBtn({btnID:"btn-1", title:"图片管理", icoClassName:"set-panel-title-icomanagement"}, null, function(dataMap){
					window.open("${ctx}/location/design/designImage!imageEdit.action","open_image_2","width=369,height=463");
				});
				//添加推拉组件内部引入的组件
				jpullPanelObj.addInnerComponet(accordionPanelBox.getComponetHandle());
				//将推拉组件添加到id=rightRoot的div中
				jpullPanelObj.appendToContainer('body div[id="rightRoot"]');
	});
	

</script>
<script language="javascript">

//右键菜单
var RightClick = {
		/**
		 *  Constructor
		 */ 
		init: function () {
			this.FlashObjectID = "LocationMap";
			this.FlashContainerID = "flashContent_t";
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

<script>
//右键弹出属性框
function showProperty(object) {
/*	alert("locationId:\n"+"${location.locationId}");
	alert("imageId:\n"+object.imageId);
	alert("type:\n"+object.type);
	alert("componentId:\n"+object.componentId);
	alert("componentName:\n"+object.componentName);
	alert("isDoubleClick:\n"+object.isDoubleClick);
	alert("position:\n"+object.position);
	alert("workLabel:\n"+object.workLabel);
	alert("wallNumber:\n"+object.wallNumber);
	alert("upPort:\n"+object.upPort);
	alert("clickLocationId:\n"+object.clickLocationId);
	alert("statusType:\n"+object.statusType);
	alert("isRelationRes:\n"+object.isRelationRes);
	alert("relationResId:\n"+object.relationResId);
	alert("statusMetricType:\n"+object.statusMetricType);
	alert("metricId:\n"+object.metricId);
	alert("clickType:\n"+object.clickType);
	alert("clickResId:\n"+object.clickResId);
	alert("clickURL:\n"+object.clickURL);
	alert("isRelationLink:\n"+object.isRelationLink);
	alert("fromResId:\n"+object.fromResId);
	alert("fromInterfaceId:\n"+object.fromInterfaceId);
	alert("toResId:\n"+object.toResId);
	alert("toInterfaceId:\n"+object.toInterfaceId);
	alert("linkType:\n"+object.linkType);
	alert("linkRemark:\n"+object.linkRemark);
	alert("linkUpflow:\n"+object.linkUpflow);
	alert("linkDownflow:\n"+object.linkDownflow);
	alert("linkDirection:\n"+object.linkDirection);
*/
	var params="component.locationId=${location.locationId}";
    if(object.imageId)    		params+="&component.imageId="+object.imageId;
    if(object.type)				params+="&component.type="+object.type;
    if(object.componentId)    	params+="&component.componentId="+object.componentId;
    if(object.componentName)   	params+="&component.componentName="+encodeURI(object.componentName);
    if(object.isDoubleClick)   	params+="&component.isDoubleClick="+object.isDoubleClick;
    if(object.position)	    	params+="&component.position="+object.position;
    if(object.workLabel)	    params+="&component.workLabel="+object.workLabel;
    if(object.wallNumber)	    params+="&component.wallNumber="+object.wallNumber;
    if(object.upPort)	    	params+="&component.upPort="+object.upPort;
    if(object.clickLocationId) 	params+="&component.clickLocationId="+object.clickLocationId;
    if(object.statusType)	   	params+="&component.statusType="+object.statusType;
    if(object.isRelationRes)  	params+="&component.isRelationRes="+object.isRelationRes;
    if(object.relationResId)	params+="&component.relationResId="+object.relationResId;
    if(object.statusMetricType)	params+="&component.statusMetricType="+object.statusMetricType;
    if(object.metricId)			params+="&component.metricId="+object.metricId;
    if(object.clickType)	    params+="&component.clickType="+object.clickType;
    if(object.clickResId)   	params+="&component.clickResId="+object.clickResId;
    if(object.clickURL) 		params+="&component.clickURL="+object.clickURL;
    if(object.isRelationLink) 	params+="&component.isRelationLink="+object.isRelationLink;
    if(object.fromResId)		params+="&component.fromResId="+object.fromResId;
    if(object.fromInterfaceId)	params+="&component.fromInterfaceId="+object.fromInterfaceId;
    if(object.toResId)			params+="&component.toResId="+object.toResId;
    if(object.toInterfaceId)	params+="&component.toInterfaceId="+object.toInterfaceId;
    if(object.linkType)			params+="&component.linkType="+object.linkType;
    if(object.linkRemark)		params+="&component.linkRemark="+object.linkRemark;
    if(object.linkUpflow)		params+="&component.linkUpflow="+object.linkUpflow;
    if(object.linkDownflow)		params+="&component.linkDownflow="+object.linkDownflow;
    if(object.linkDirection)	params+="&component.linkDirection="+object.linkDirection;
    	
  	window.open("${ctx}/location/design/nodeAttribute.action?" + params);
}
//存储属性给flash
function saveProperty(object) {
    var flashobj=	document.getElementById("LocationMap");
    flashobj.excuteCMD("attribute",object);
	/*flashobj.excuteCMD("attribute",{
		locationId:"locationId",
		imageId:"imageId",
		type:"type",
		componentId:"componentId",
		componentName:"componentName",
		isDoubleClick:"isDoubleClick",
		position:"position",
		workLabel:"workLabel",
		wallNumber:"wallNumber",
		upPort:"upPort",
		clickLocationId:"clickLocationId",
		statusType:"statusType",
		isRelationRes:"isRelationRes",
		relationResId:"relationResId",
		statusMetricType:"statusMetricType",
		metricId:"metricId",
		clickType:"clickType",
		clickResId:"clickResId",
		clickURL:"clickURL",
		isRelationLink:"isRelationLink",
		fromResId:"fromResId",
		fromInterfaceId:"fromInterfaceId",
		toResId:"toResId",
		toInterfaceId:"toInterfaceId",
		linkType:"linkType",
		linkRemark:"linkRemark",
		linkUpflow:"linkUpflow",
		linkDownflow:"linkDownflow",
		linkDirection:"linkDirection"
	});*/	
}
// 双击中转页面
function onDoubleClick(childLocationId){
	loadHandles(childLocationId);
	window.setTimeout(function(){$("#paintLocation").click();}, 800);
}

$("#rightRoot").click(function(){
	//alert("rightRoot");
	var flashobj=document.getElementById("LocationMap");
	if (chooseFlag != "true"){
		
		//$("#"+currID).removeClass("on");
		//currID = "";
		var theObj={};
		//alert("cancelCMD");
		flashobj.excuteCMD("cancelCMD",theObj);
	}
	chooseFlag = "false";
})	

function removeFlashElement(){
	var flashobj=document.getElementById("LocationMap");
	flashobj.excuteCMD("cancelCMD",null);
}

function addFlashElement(obj){
		//var str = obj.componentId;
		//if (currID != str){
		//$("#"+str).addClass("on");
		//currID=str;
		//}	
	var flashobj=document.getElementById("LocationMap");
	var params = {
			type:obj.type,
			imageUrl:"${ctx}/location/design/designImage!getImage.action?flashRead=true&designImage.id=",
			imageId:obj.id,
			displayName:obj.name
	};
	if("<%=DesignImageTypeEnum.builder.getKey() %>"==obj.type 
			|| "<%=DesignImageTypeEnum.floor.getKey() %>"==obj.type 
			|| "<%=DesignImageTypeEnum.room.getKey() %>"==obj.type 
			|| "<%=DesignImageTypeEnum.office.getKey() %>"==obj.type
			|| "<%=DesignImageTypeEnum.desk.getKey() %>"==obj.type
			|| "<%=DesignImageTypeEnum.logo.getKey() %>"==obj.type){
		// 添加物理位置元素
		flashobj.excuteCMD("creator",params);
	} else if("<%=DesignImageTypeEnum.basic.getKey() %>"==obj.type){
		// 基本类型
		params.type=obj.childType;
		flashobj.excuteCMD("graphics",params);
	} else if("<%=DesignImageTypeEnum.label.getKey() %>"==obj.type){
		params.type=obj.childType;
		// 标注
		flashobj.excuteCMD("comment",params);
	} else if("<%=DesignImageTypeEnum.map.getKey() %>"==obj.type ){
		// 地图
		flashobj.excuteCMD("image",params);
	} else if("<%=DesignImageTypeEnum.back.getKey() %>"==obj.type ){
		// 背景
		flashobj.excuteCMD("background",params);
	}
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
	
function autolayoutdesk(){
	var flashobj=document.getElementById("LocationMap");
	var deskurl="${ctx}/location/design/autolayout!deskAutoLayout.action?locationId=${location.locationId}";
	flashobj.excuteCMD("autolayout",deskurl);
}

function startLoading(){
$.blockUI({message:$('#loading')});
}

function endLoading(){
$.unblockUI();
}

</script>
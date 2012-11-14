<!-- 机房-机房定义-显示2DFlash show2DRoom.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
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
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet"
	type="text/css" media="screen" title="no title" charset="utf-8" />

<link rel="stylesheet" type="text/css" href="${ctx}/flash/history/history.css" />
<!-- huaf:解决BSM8000001553 当切换到监控设置的告警定义再点机房布局右侧绘图栏不见了。-->
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion.js"></script>
<!-- end -->
<!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
			 JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
			 when JavaScript is disabled.
		-->
<div style="height: 100%; width: 100%">
<div id="flashContent" style="z-index: 112;">
<p>To view this page ensure that Adobe Flash Player version 10.0.0
or greater is installed.</p>
<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				//alert(pageHost);
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script></div>
<div id="bottomTool" style="position:absolute;bottom:0px;left:0px">
<!-- 工具栏 -->
<page:applyDecorator name="tools">
	<page:param name="width">465</page:param>
	
	<page:param name="available">true</page:param>
	<page:param name="isExpend">true</page:param>
	<page:param name="btns">
    [[{id:"drag",oncls:"mouse",offcls:"mouse",disablecls:"mouse",available:"on",title:"拖拽"},
      {id:"zoom-in",oncls:"zoom-in",offcls:"zoom-in",disablecls:"zoom-in-off",available:"on",title:"放大"},
      {id:"zoom-out",oncls:"zoom-out",offcls:"zoom-out",disablecls:"zoom-out-off",available:"on",title:"缩小"}],
     [{id:"repeal",oncls:"repeal",offcls:"repeal",disablecls:"repeal-off",available:"false",title:"撤销"},
      {id:"resume",oncls:"resume",offcls:"resume",disablecls:"resume-off",available:"false",title:"恢复"}], 
     [{id:"natural-size",oncls:"natural-size",offcls:"natural-size",disablecls:"natural-size-off",available:"on",title:"正常大小"},
      {id:"fit-window",oncls:"fit-window",offcls:"fit-window",disablecls:"fit-window-off",available:"on",title:"适合窗口"}],
     [{id:"textarea",offcls:"textarea",disablecls:"textarea-off",available:"on",title:"文本框"},
     {id:"font-border",oncls:"font-border",offcls:"font-border-off",disablecls:"font-border-off",available:"false",title:"隐藏/显示边框"},
     {id:"font-size",oncls:"font-size",offcls:"font-size",disablecls:"font-size-off",available:"false",title:"字体大小"},
     {id:"font-bold",oncls:"font-bold",offcls:"font-bold-on",disablecls:"font-bold-off",available:"false",title:"字体加粗"},
      {id:"font-color",oncls:"font-color",offcls:"font-color",disablecls:"font-color-off",available:"false",title:"文字颜色"},],
     [{id:"node-color",oncls:"node-color",offcls:"node-color",disablecls:"node-color-off",available:"false",title:"填充颜色"}],
     [{id:"save",oncls:"save",offcls:"save",disablecls:"save-off",available:"false",title:"保存"},
      {id:"delete",oncls:"delete",offcls:"delete",disablecls:"delete-off",available:"false",title:"删除"}]]
    </page:param>
     <!--
     {id:"mouse",oncls:"mouse",offcls:"mouse-off",disablecls:"mouse-off",available:"on",title:"选择"}, 
     ,
      {id:"font-border",offcls:"font-border",disablecls:"font-border",available:"off",title:"显示/隐藏文本框"}
     {id:"font-bold",oncls:"font-bold-off",offcls:"font-weight-off",disablecls:"font-weight-off",available:"off",title:"文字粗细"}, 
     -->
</page:applyDecorator>
</div>
<!-- 工具箱  -->
<div id="rightRoot"
	style="position: absolute; top: 30px; right: 0px; z-index: 100; height: 82%;width: 40%"></div>
<page:applyDecorator name="colorPanel">  
     </page:applyDecorator>
<page:applyDecorator name="fontsizepanel">  
     <page:param name="fontsizekind">8,9,10,12,14,16,18,20,22,26,32</page:param>
     </page:applyDecorator> 
<div id="removeProp" style="display: none" />
</div>
<script type="text/javascript">
var currentDraw;
//工具栏
$(function(){
	Footools.init({listeners:{click:function(id){
		
		isExistRoom($('#roomIndexId').val());
		//保存
		if('save' == id){
			var tmpObj={};
			document.getElementById("MachineRoomGraph").excuteFunction("savedata",tmpObj);
			Footools.btnDisable('save');
		}
		//删除 
		else if('delete' == id){
			var tmpObj={};
			document.getElementById("MachineRoomGraph").excuteFunction("deletenode",tmpObj);
		}
		//拖拽
		if('drag' == id){
			var tmpObj={};
			tmpObj.value="true" //true全局拖动false取消全局拖动
			document.getElementById("MachineRoomGraph").excuteFunction("drag",tmpObj);
		}
		//文本框
		else if('textarea' == id){
			var tmpObj={};
			tmpObj.type = 'text';
			parent.document.getElementById("MachineRoomGraph").excuteFunction("createbasicgraph",tmpObj);
		}
		//填充颜色
		else if('node-color' == id){
			var tmpObj={};
			var pos = getElementPos(id);
			ColorPanel.init({color:"#ffffff",isClose:true,x:pos.x-220,y:pos.y-290,clickAfter:function(color){
				tmpObj.color="0x"+color;
				parent.document.getElementById("MachineRoomGraph").excuteFunction("fillcolor",tmpObj);}}); 
			ColorPanel.show();
		}
		//边框颜色
		else if('border-color' == id){
			var tmpObj={};
			var pos = getElementPos(id);
			ColorPanel.init({color:"#ffffff",isClose:true,x:pos.x-280,y:pos.y-290,clickAfter:function(color){
				tmpObj.color="0x"+color;
				parent.document.getElementById("MachineRoomGraph").excuteFunction("bordercolor",tmpObj);}}); 
			ColorPanel.show();
			
		}
		//隐藏显示文本框边框
		else if('font-border' == id){
			var tmpObj={};
			tmpObj.value="false"
			parent.document.getElementById("MachineRoomGraph").excuteFunction("boldvisible",tmpObj);
		}
		//文字大小
		else if('font-size' == id){
			var pos = getElementPos(id);
			FontSizePanel.init({size:13,isClose:false,x:pos.x-280,y:pos.y-240,clickAfter:function(size){
				var tmpObj={};
				tmpObj.fontsize=size;
				parent.document.getElementById("MachineRoomGraph").excuteFunction("fontsize",tmpObj);}}
			); 
			FontSizePanel.show(); 
			
		}
		//文字加粗
		else if('font-bold' == id){
			var tmpObj={};
			if(Footools.isBtnOn(id)){
				tmpObj.bold=true;
				Footools.btnOff('font-bold');
			}else{
				tmpObj.bold=false;
				Footools.btnOn('font-bold');
			}
			parent.document.getElementById("MachineRoomGraph").excuteFunction("bold",tmpObj);
		}
		//文字颜色
		else if('font-color' == id){
			var tmpObj={};
			var pos = getElementPos(id);
			ColorPanel.init({color:"#ffffff",isClose:true,x:pos.x-280,y:pos.y-290,clickAfter:function(color){
				tmpObj.color="0x"+color;
				parent.document.getElementById("MachineRoomGraph").excuteFunction("fontcolor",tmpObj);}}); 
			ColorPanel.show();
		}
		//缩小
		else if('zoom-in' == id){
			var tmpObj={};
			tmpObj.value=0.1;
			parent.document.getElementById("MachineRoomGraph").excuteFunction("magnify",tmpObj);
		}
		//放大
		else if('zoom-out' == id){
			var tmpObj={};
			tmpObj.value=0.1;
			parent.document.getElementById("MachineRoomGraph").excuteFunction("reduce",tmpObj);
		}
		//正常大小
		else if('natural-size' == id){
			var tmpObj={};
			parent.document.getElementById("MachineRoomGraph").excuteFunction("normalsize",tmpObj);
		}
		//适合窗口
		else if('fit-window' == id){
			var tmpObj={};
			parent.document.getElementById("MachineRoomGraph").excuteFunction("fitwindow",tmpObj);
		}
		//撤销
		else if('repeal' == id){
			Footools.btnOff('save');
			document.getElementById("MachineRoomGraph").excuteFunction("undo",null);
		}
		//恢复
		else if('resume' == id){
			Footools.btnOff('save');
			 document.getElementById("MachineRoomGraph").excuteFunction("redo",null);
			 
		}
	}


}
	
});
});

//工具栏撤销恢复按钮状态设置
function revokedRecovery(revoke, recover){
	if(revoke == 'true'){
		Footools.btnOn('repeal');
	}else{
		Footools.btnDisable('repeal');
	}
	if(recover == 'true'){
		Footools.btnOn('resume');
	}else{
		Footools.btnDisable('resume');
	}
}
//工具栏组件相关按钮状态设置
function revokedComponent(components){
	for(var i = 0; i < components.length; i++) {
		if(document.getElementById(components[i].key)){
			if(components[i].status=='true'){
				if(components[i].key=='font-bold'){
					if(components[i].value=='true'){
						Footools.btnOff(components[i].key);
					}else{
						Footools.btnOn(components[i].key);
					}
				}else{
					Footools.btnOn(components[i].key);
				}
			}else{
				Footools.btnDisable(components[i].key);
			}
		}
    }
}
//放大缩小按钮是否可以使用
function graphScale(magnifyFlag,reduceFlag){
	
	if (magnifyFlag == 'true'){
		Footools.btnOn('zoom-in');
	}else{
		Footools.btnDisable('zoom-in');
	}

	if (reduceFlag == 'true'){
		Footools.btnOn('zoom-out');
	}else{
		Footools.btnDisable('zoom-out');
	}
}
function saveBtnFlag(isFlag){
	if (isFlag == 'true'){
		Footools.btnOn('save');
	}else{
		Footools.btnDisable('save');
	}
}
//
</script>

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
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
            params.allowfullscreen = "true";
            flashvars.isBrowse="false";
            flashvars.isHomePage="false";
            flashvars.background= "./pic/jf.png";
            flashvars.graphbackground="./pic/bg.jpg";
            flashvars.roomid="<s:property value='roomId'/>";
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
            var attributes = {};
            attributes.id = "MachineRoomGraph";
            attributes.name = "MachineRoomGraph";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/MachineRoomGraph.swf", "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script>

<script language="javascript">
function plotCurrentClick(param){
	currentDraw = param["view"];
}
				//绘图箱
				$('body #rightRoot').html("");
				//创建折叠组建对象(slid:设置折叠动作是否带有滑动动画效果,panelBlockStyle:设置折叠样式风格，目前只支持blackbox和tree两种风格)
				var accordionPanelBox = new JDynamicAccordionPanel({id:"bizServiceDefinedAccordion3", slid:true, panelBlockStyle:"blackbox"});
				
				//添加折叠页（折叠页content部分引用的是一个具体url）
				//第一个参数：json对象(slabID:slab页id,label:slab页label,contentHeight:slab页content部分的高度值)
				//第二个参数：字符串(折叠页content部分引入的具体url路径)
				//第三个参数：json对象(需要添加的用户参数信息，这个参数信息会在点击折叠页的回调函数中传递到具体的用户回调函数中)
				//第四个参数：函数对象引用(点击折叠页的时候会调用这个回调函数并将该折叠页对应的参数信息及用户参数信息传递到具体的用户回调函数中)
				accordionPanelBox.addPageSlab({slabID:"slab-1",label:"组件",contentHeight:"300"}, "${ctx}/roomDefine/ArtOpt!getImg.action",{"view":"slab-1"},plotCurrentClick);
				accordionPanelBox.addPageSlab({slabID:"slab-2",label:"形状",contentHeight:"300"}, "${ctx}/roomDefine/ArtOpt!getShape.action",{"view":"slab-2"},plotCurrentClick);
				accordionPanelBox.addPageSlab({slabID:"slab-3",label:"背景",contentHeight:"300"}, "${ctx}/roomDefine/ArtOpt!getBackground.action",{"view":"slab-3"},plotCurrentClick);
				//accordionPanelBox.addInnerComponetSlab({slabID:"slab-3",label:"背景",contentHeight:"350px"}, tabPanelTemp3.getComponetHandle(), null, null);
				$('#rightRoot').css("width", "285px");
				$('#rightRoot').css("right", "0px");
				//创建推拉box组件(animated:推拉速度("slow", "normal", "fast", or number))
			    var jpullPanelObj = new JDynamicPullPanel({id:"jPull-1", label:"绘图", contentWidth:"270px", contentHeight:"388px", animated:"slow"});
			    jpullPanelObj.addTitleToolBtn({btnID:"btn-1", title:"图片管理", icoClassName:"set-panel-title-icomanagement"}, null, function(dataMap){
			        //alert(dataMap["btnID"]);
			        window.open("${ctx}/roomDefine/ImageManagerVisit.action","_blank","width=700,height=570");
			    });			
				//添加推拉组件内部引入的组件
				jpullPanelObj.addInnerComponet(accordionPanelBox.getComponetHandle());
				//将推拉组件添加到id=rightRoot的div中
				jpullPanelObj.appendToContainer('body div[id="rightRoot"]');

				/*
				var jpullPanelObj = new JDynamicPullPanel({id:"jPull-1",label:"绘图",contentWidth:"270px",contentHeight:"420px"});
				jpullPanelObj.addInnerComponet(accordionPanelBox.ComponetHandle());
				jpullPanelObj.appendToContainer("body #rightRoot");
				*/
				//设置折叠组建,处于展开状态的折叠页
				accordionPanelBox.expanseSlab("slab-1");


				
</script>

<script language="javascript">


//右键菜单
var RightClick = {
		/**
		 *  Constructor
		 */ 
		init: function () {
			this.FlashObjectID = "MachineRoomGraph";
			this.FlashContainerID = "dynamicJspId";
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
			document.getElementById(this.FlashObjectID).rightClick();
		}
	}
RightClick.init();
</script>

<script>
//右键弹出属性框
function showProperty(objectId,type) {
	var winOpenObj = {};
	var src = "${ctx}/roomDefine/ResourcePropertyVisit.action?roomId=<s:property value='roomId'/>&componentId="+objectId+"&type="+type;
	var height = '335';
	winOpenObj.width = '850';
	winOpenObj.height = height;
	winOpenObj.url = src;
	winOpenObj.scrollable = true;
	winOpenObj.resizeable = false;
	winOpen(winOpenObj); 
	//window.open("${ctx}/roomDefine/ResourcePropertyVisit.action?roomId=<s:property value='roomId'/>&componentId="+objectId+"&type="+type);
}
//清除属性
function removeProperty(objectId) {
	$("#removeProp").load("${ctx}/roomDefine/ResourcePropertyVisit!remove.action?roomId=<s:property value='roomId'/>&componentId="+objectId);
}

//右键弹出编辑文本
function showText(objectId,type) {
	window.open("${ctx}/roomDefine/FlashTxt.action?roomId=<s:property value='roomId'/>&componentId="+objectId+"&type="+type,"_blank","width=400,height=250");
}

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
//右键弹出替换图片
function replacePicFun(typeId) {
	window.open("${ctx}/roomDefine/ReplacePictureVisit.action?typeId="+typeId,"_blank","width=700,height=505");
}
function subPic(picurl) {
	var theObj = new Object();
	theObj.pic=picurl;
    document.getElementById("MachineRoomGraph").excuteFunction("resplacepic",theObj);
    saveFlash();
}

function saveFlash(){
	var tmpObj={};
	document.getElementById("MachineRoomGraph").excuteFunction("savedata",tmpObj);
	Footools.btnDisable('save');
}
function isSaveState(isSave){
	if(Footools.isBtnOn("save")){
		isSave = null;
	}else{
		isSave = true;
	}
	return isSave;
}
function refreshDraw(){
	accordionPanelBox.expanseSlab(currentDraw);
	
}


function browserinfo(){   
	var Browser_Name=navigator.appName;   
	var Browser_Version=parseFloat(navigator.appVersion);   
	var Browser_Agent=navigator.userAgent;   
	var Actual_Version,Actual_Name;
	var is_IE=(Browser_Name=="Microsoft Internet Explorer");//判读是否为ie浏览器   10.        
	var is_NN=(Browser_Name=="Netscape");//判断是否为netscape浏览器   
	var is_op=(Browser_Name=="Opera");//判断是否为Opera浏览器  
    if(is_NN){   //upper 5.0 need to be process,lower 5.0 return directly  
		if(Browser_Version>=5.0){   
			if(Browser_Agent.indexOf("Netscape")!=-1){   
				var Split_Sign=Browser_Agent.lastIndexOf("/");   
				var Version=Browser_Agent.lastIndexOf(" ");  
				var Bname=Browser_Agent.substring(0,Split_Sign);   
				var Split_sign2=Bname.lastIndexOf(" ");   
				Actual_Version=Browser_Agent.substring(Split_Sign+1,Browser_Agent.length);
				Actual_Name=Bname.substring(Split_sign2+1,Bname.length);
			}
			if(Browser_Agent.indexOf("Firefox")!=-1){
				var Split_Sign=Browser_Agent.lastIndexOf("/");
				var Version=Browser_Agent.lastIndexOf(" ");
				Actual_Version=Browser_Agent.substring(Split_Sign+1,Browser_Agent.length);
				Actual_Name=Browser_Agent.substring(Version+1,Split_Sign);
			}
			if(Browser_Agent.indexOf("Safari")!=-1){
				if(Browser_Agent.indexOf("Chrome")!=-1){
					var Split_Sign=Browser_Agent.lastIndexOf(" ");
					var Version=Browser_Agent.substring(0,Split_Sign);
					var Split_Sign2=Version.lastIndexOf("/");
					var Bname=Version.lastIndexOf(" ");
					Actual_Version=Version.substring(Split_Sign2+1,Version.length);
					Actual_Name=Version.substring(Bname+1,Split_Sign2);
				}else{
					var Split_Sign=Browser_Agent.lastIndexOf("/");
					var Version=Browser_Agent.substring(0,Split_Sign);
					var Split_Sign2=Version.lastIndexOf("/");
					var Bname=Browser_Agent.lastIndexOf(" ");
					Actual_Version=Browser_Agent.substring(Split_Sign2+1,Bname);
					Actual_Name=Browser_Agent.substring(Bname+1,Split_Sign);
				} 
			}
		}else{
			Actual_Version=Browser_Version;
			Actual_Name=Browser_Name;
		}
	}else if(is_IE){
		var Version_Start=Browser_Agent.indexOf("MSIE");
		var Version_End=Browser_Agent.indexOf(";",Version_Start);
		Actual_Version=Browser_Agent.substring(Version_Start+5,Version_End)
		Actual_Name=Browser_Name;
		if(Browser_Agent.indexOf("Maxthon")!=-1||Browser_Agent.indexOf("MAXTHON")!=-1){
			var mv=Browser_Agent.lastIndexOf(" ");
			var mv1=Browser_Agent.substring(mv,Browser_Agent.length-1);
			mv1="遨游版本:"+mv1;
			Actual_Name+="(Maxthon)";
			Actual_Version+=mv1;
		}
	}else if(Browser_Agent.indexOf("Opera")!=-1){
		Actual_Name="Opera";
		var tempstart=Browser_Agent.indexOf("Opera");
		var tempend=Browser_Agent.length;
		Actual_Version=Browser_Version;
	}else{
		Actual_Name="Unknown Navigator";
		Actual_Version="Unknown Version";
	}
	navigator.Actual_Name=Actual_Name;
	navigator.Actual_Version=Actual_Version;
	this.Name=Actual_Name;
	this.Version=Actual_Version;
} 

   
$(document).ready(function(){
	browserinfo();

	if (navigator.Actual_Version != "8.0"){
		$("#bottomTool").css("bottom","-10px");
	}else{
		$("#bottomTool").css("bottom","0px");
	}
	
});



</script>
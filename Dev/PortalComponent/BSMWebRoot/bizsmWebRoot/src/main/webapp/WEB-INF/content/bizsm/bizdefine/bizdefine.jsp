<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务定义首页
	uri:{domainContextPath}/bizsm/bizservice/ui/biz-define
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String serviceId = request.getParameter("serviceId");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>服务定义首页</title>
<link rel="Shortcut icon" type="image/x-icon" href="${ctx}/imac.ico">
<link rel="icon" href="${ctx}/imac.ico" type="image/x-icon" />



<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/footer.css" rel="stylesheet" type="text/css" />


<link href="${ctx}/css/jquery-ui/jquery.ui.toolbar.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/jquery.ui.toolmenu.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />


<style type="text/css" media="screen">
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:left;
		   background-color: #ffffff; }
	#flashContent { display:none; }
	select{
		height:auto;
	}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion-1.2.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script type="text/javascript" src="${ctx}/js/component/menu/j-dynamic-toolmenu-1.1.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/pullBox/j-dynamic-pullbox-1.1.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toolBar/j-dynamic-horizontal-toolbar.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>


<script language="javascript">
	var confirmConfig = {width: 300,height: 80};

	var currentServiceRunState = parent.parent.leftFrame.serviceRunStateGlobal;
	var borderVisibled_global = "hidden";//点击插入边框工具按钮，是否添加文本框边框
	var isMouseDrag = false; //点击拖拽工具按钮，是否直线拖拽
	var fontWeightStyle_global = "bold"; //全局工具条字体加粗样式(bold/normal)


	var realWidth = 0, realHeight = 0;

	var accordionPanelBox = null;

	$(function() {

			realWidth = document.body.clientWidth;
			realHeight = document.body.clientHeight;

			$('#rightRoot').css({right:"0px"});
			Footools.init({listeners:{click:function(id){
									  }
									  , afterClick:function(id){
											//Footools.btnDisable(id);
											if(id == "btn-full-screen"){
												//alert(dataMap["title"]);
												//这里调用flash正常尺寸
												setTopoActaulSize();
											}else if(id == "btn-abbreviative"){
												//自适应窗口
												setTopoJustSize();
											}else if(id == "btn-mouse"){
												//这里调用flash拖拽
												move(isMouseDrag);
												isMouseDrag = !isMouseDrag;
											}else if(id == "btn-zoom-out"){
												//这里调用flash放大
												zoomOut();
											}else if(id == "btn-zoom-in"){
												//这里调用flash缩小
												zoomIn();
											}else if(id == "btn-repeal"){
												//这里调用flash撤销
												undo();
											}else if(id == "btn-resume"){
												//这里调用flash恢复
												redo();
											}else if(id == "btn-textarea"){
												//这里调用flash插入文本默认值：Sample Text
												var type = "text";
												var text = "请使用右键菜单编辑显示文本";
												createCustomShape(type, text);
											}else if(id == "btn-hidetextareaborder"){
												//这里调用flash插入设置文本是否有边框
												if(borderVisibled_global == "show"){
													setBorderVisible("hidden");
												}else if(borderVisibled_global == "hidden"){
													setBorderVisible("show");
												}
												//borderVisibled_global = !borderVisibled_global;
											}else if(id == "btn-refresh"){
												//alert(dataMap["title"]);
												//call flash 判断是否需要保存当前拓扑
												var confirmTopoFlag = callSaveTopoFlag();
												if(confirmTopoFlag){
													var _confirm = top.confirm_box(confirmConfig);
													_confirm.setContentText("是否保存当前拓扑？"); //提示框
													_confirm.show();
													_confirm.setConfirm_listener(function() {
														_confirm.hide();
														//call flash 保存拓扑
														saveTopo("${ctx}");
													});
													_confirm.setCancle_listener(function(){
														_confirm.hide();
														refreshTopo();
													});
												}else{
													refreshTopo();
												}
											}else if(id == "btn-delete"){
												deleteSelectedCmps();
											}else if(id == "btn-save"){
												// call flash.
												saveTopo("${ctx}");
											}else if('btn-font-bold' == id){
												//这里调用flash修改字体加粗样式
											//alert(fontWeightStyle_global);
											   setFontWeight(fontWeightStyle_global);
											}else if('btn-font-size' == id){
											   var pos = getElementPos(id);
											   FontSizePanel.init({size:13,isClose:false,x:pos.x,y:pos.y-173,clickAfter:function(size){
													//这里调用flash修改字体大小的代码
													setFontSize(size);
													//修改缺陷BSM8000000189 - 设置字号
													$('#btn-font-size a').text(size);
											   }});
											   FontSizePanel.show();
											}else if('btn-font-color' == id){
											   var tmpObj={};
											   var pos = getElementPos(id);
											   ColorPanel.init({color:"#ffffff",isClose:true,x:pos.x,y:pos.y-225,clickAfter:function(color){
													//调用flash方法设置组件颜色
													setFontColor(color);
											   }});
											   ColorPanel.show();
											}else if('btn-node-color' == id){
											   var tmpObj={};
											   var pos = getElementPos(id);
											   ColorPanel.init({color:"#ffffff",isClose:true,x:pos.x,y:pos.y-225,clickAfter:function(color){
													//调用flash方法设置组件颜色
													setFill(color);
											   }});
											   ColorPanel.show();
											}else if('btn-line-color' == id){
											   var tmpObj={};
											   var pos = getElementPos(id);
											   ColorPanel.init({color:"#ffffff",isClose:true,x:pos.x,y:pos.y-225,clickAfter:function(color){
													//调用flash方法设置组件颜色
													setLineColor(color);
											   }});
											   ColorPanel.show();
											}else if('btn-line-weight' == id){
												 var pos = getElementPos(id);
												LinesizePanel.init({size:"0.75",isClose:true,x:pos.x,y:pos.y-153,clickAfter:function(num){
													//调用flash方法设置组件size
													setLineSize(num);
												}});
												LinesizePanel.show();

											}else if('btn-line-style' == id){
												 var pos = getElementPos(id);
												LineStylePanel.init({style:"style1",isClose:true,x:pos.x,y:pos.y-119,clickAfter:function(styleType){
													var styleStr = "solid";
													if(styleType == "style1"){
														styleStr = "solid";
													}else if(styleType == "style2"){
														styleStr = "dotted";
													}else if(styleType == "style3"){
														styleStr = "l_dashed";
													}else if(styleType == "style4"){
														styleStr = "s_dashed";
													}
													//调用flash方法设置组件样式
													setLineStyle(styleStr);
												}});
												LineStylePanel.show();
											}else if('btn-arrow-style' == id){
												var pos = getElementPos(id);
												ArrowStylePanel.init({style:"style1",isClose:true,x:pos.x,y:pos.y-119,clickAfter:function(styleType){
													var styleStr = "none";
													if(styleType == "style1"){
														styleStr = "none";
													}else if(styleType == "style2"){
														styleStr = "dest";
													}else if(styleType == "style3"){
														styleStr = "source";
													}else if(styleType == "style4"){
														styleStr = "double";
													}
													//调用flash方法设置组件样式
													setLineArrow(styleStr);
												}});
												ArrowStylePanel.show();
											}

									  }
							}
			  });

			Footools.setWidth(screen.availWidth);
			Footools.expend();

			/**
			*读取右边业务服务属性窗口
			*param String serviceID 当前展开的业务服务ID
			*
			*/
			$.readRightPullBox = function(serviceID, runState){
				$('body #rightRoot').empty();

				if(serviceID != null && serviceID != ""){
					accordionPanelBox = new JDynamicAccordionPanel({id:"bizServiceDefinedAccordion3", slid:true, panelBlockStyle:"blackbox"});
					accordionPanelBox.addPageSlab({slabID:"slab-1",label:"业务服务",contentHeight:"280px"}, null, "${ctx}/bizservice/?canAdoptByServiceId="+serviceID, null, null);
					accordionPanelBox.addPageSlab({slabID:"slab-2",label:"资源",contentHeight:"280px"}, null, "${ctx}/bizsm/bizservice/ui/bizdefine-resourcetreeview?serviceId="+serviceID, null, null);
					accordionPanelBox.addPageSlab({slabID:"slab-3",label:"业务单位",contentHeight:"280px"}, null, "${ctx}/bizuser/?serviceId="+serviceID, null, null);
					accordionPanelBox.addPageSlab({slabID:"slab-4",label:"自定义元素",contentHeight:"280px"}, null, "${ctx}/bizsm/bizservice/ui/custom-graph-element?serviceId="+serviceID, null, null);
					accordionPanelBox.addSlabTitleToolBtn("slab-4",{btnID:"img-btn-1", title:"图标管理", icoClassName:"set-panel-title-icomanagement"}, null, function(dataMap){
						openImgWindow();
					});
					accordionPanelBox.click(function(tabDataMap){
						//call flash (取消当前tab页中选中的内容)
						unChoose();
					});
					if(runState == "true"){
						accordionPanelBox.setContentDisabled(true);
					}else{
						accordionPanelBox.setContentDisabled(false);
					}

					//$('#rightRoot').css("width", "340px");
					//$('#rightRoot').css("left", (top.document.body.offsetWidth-645));
					//$('#rightRoot').css("backgroundColor", "gray");

					var jpullPanelObj = new JDynamicPullPanel({id:"jPull-1", label:"绘图", contentWidth:"270px",contentHeight:"400px", animated:200});
					jpullPanelObj.addInnerComponet(accordionPanelBox.getComponetHandle());
					jpullPanelObj.appendToContainer('body #rightRoot');

					accordionPanelBox.expanseSlab("slab-1");

				}
				//判断是否第一次打开服务定义页面
				if(parent.parent.leftFrame.firstLoadPage_global){
					//触发服务列表框click事件, 展开服务列表框
					parent.parent.leftFrame.f_clickLeftBar();
					parent.parent.leftFrame.firstLoadPage_global = false;
				}

			}



	});

	/**
	* 展开右面哪个slab
	* @param slabID
	*/
	function f_expanseSlab(slabID){
		accordionPanelBox.expanseSlab(slabID);
	}

	/**
	* 展开某个业务服务
	* @param String bizServiceId (业务服务ID)
	*
	*/
	function f_expanseBizService(bizServiceId){
		parent.parent.leftFrame.f_expanseBizServAccorSlab(bizServiceId);;
	}
	function f_updateBizServiceList(){
		//top.leftFrame.f_updateLeftPanel();
		parent.parent.leftFrame.f_updateLeftPanel();
	}
	function f_loadBizDefineTopo(){
		//call flash
		chooseTopo("biztopo/.xml?bizServiceId=<%=serviceId%>");
	}
	function f_readRightPullBox(serivceId){
		/*
		if(currentServiceRunState == "true"){
			$('#rightRoot *').each(function(){
				this.disabled = true;
			});
		}else{
			$('#rightRoot').get(0).disabled = false;
		}
		*/
		//创建右侧绘图框
		$.readRightPullBox(serivceId, currentServiceRunState);
		//屏蔽左边服务列表的loading div
		parent.parent.leftFrame.f_unLoadingServiceList();
	}
	/**
	*加载flash文件
	*
	*/
	function f_loadFlash(){
		 <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. -->
		var swfVersionStr = "10.0.0";
		<!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
		var xiSwfUrlStr = "${ctx}/flash/bizsm/playerProductInstall.swf";
		var flashvars = {};
		//flashvars["uri"] = "./testAssets/FullData.xml"
		flashvars["webRootPath"] = "${ctx}/";

		var params = {};
		params.quality = "high";
		params.bgcolor = "#ffffff";
		params.allowscriptaccess = "always";
		params.wmode = 'transparent';
		params.allowfullscreen = "true";
		params.enablejs= "true";


		var attributes = {};
		attributes.id = "BizEditor";
		attributes.name = "BizEditor";
		attributes.align = "middle";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/BizEditor.swf", "flashContent",
			"98%", realHeight-40,
			swfVersionStr, xiSwfUrlStr,
			flashvars, params, attributes);
		<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");

	}
	/*
	* 页面初始化
	*
	*/
	function f_init(){
		f_loadFlash();
		initFlashContentObj("BizEditor");
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

	function f_setToolEnable(toolBoxEnable){

		var delEnabled = toolBoxEnable.deleteSelectedCmps;
		if(delEnabled == false){
			Footools.btnDisable("btn-delete");
		}else{
			Footools.btnOff("btn-delete");
		}
		var refreshEnabled = toolBoxEnable.refreshTopo;
		if(refreshEnabled == false){
			Footools.btnDisable("btn-refresh");
		}else{
			Footools.btnOff("btn-refresh");
		}

		var saveEnabled = toolBoxEnable.saveTopo;
		if(saveEnabled == false){
			Footools.btnDisable("btn-save");
		}else{
			Footools.btnOff("btn-save");
		}
		var actaulSizeEnabled = toolBoxEnable.setTopoActaulSize;//实际大小
		if(actaulSizeEnabled == false){btnID = "";
			Footools.btnDisable("btn-full-screen");
		}else{
			Footools.btnOff("btn-full-screen");
		}
		var topoJustSizeEnabled = toolBoxEnable.setTopoJustSize;//自适应大小
		if(topoJustSizeEnabled == false){
			Footools.btnDisable("btn-abbreviativ");
		}else{
			Footools.btnOff("btn-abbreviativ");
		}
		var fontSizeEnabled = toolBoxEnable.setFontSize;
		if(fontSizeEnabled == false){
			Footools.btnDisable("btn-font-size");
		}else{
			Footools.btnOff("btn-font-size");
		}
		var fontColorEnabled = toolBoxEnable.setFontColor;
		if(fontColorEnabled == false){
			Footools.btnDisable("btn-font-color");
		}else{
			Footools.btnOff("btn-font-color");
		}
		var fontWeightStyle = toolBoxEnable.setFontWeight;//字体是否加粗
		if(fontWeightStyle == "null"){
			Footools.btnDisable("btn-font-bold"); //字体加粗样工具按钮不可用
		}else{
			Footools.btnOff("btn-font-bold");
			fontWeightStyle_global = fontWeightStyle; //设置字体加粗样式(bold/normal)
		}

		var borderVisibleEnabled = toolBoxEnable.setBorderVisible;//显示边框
		if(borderVisibleEnabled == "null"){
			Footools.btnDisable("btn-hidetextareaborder");
		}else{
			borderVisibled_global = borderVisibleEnabled;
			Footools.btnOff("btn-hidetextareaborder");
		}


		var lineColorEnabled = toolBoxEnable.setLineColor;
		if(lineColorEnabled == false){
			Footools.btnDisable("btn-line-color");
		}else{
			Footools.btnOff("btn-line-color");
		}
		var lineSizeColorEnabled = toolBoxEnable.setLineSize;
		if(lineSizeColorEnabled == false){
			Footools.btnDisable("btn-line-weight");
		}else{
			Footools.btnOff("btn-line-weight");
		}
		var lineStyleEnabled = toolBoxEnable.setLineStyle;
		if(lineStyleEnabled == false){
			Footools.btnDisable("btn-line-style");
			Footools.btnDisable("btn-arrow-style");
		}else{
			Footools.btnOff("btn-line-style");
			Footools.btnOff("btn-arrow-style");
		}
		var createCustomShapeEnabled = toolBoxEnable.createCustomShape;//插入文本
		if(createCustomShapeEnabled == false){
			Footools.btnDisable("btn-textarea");
		}else{
			Footools.btnOff("btn-textarea");
		}
		var redoEnabled = toolBoxEnable.redo;//恢复
		if(redoEnabled == false){
			Footools.btnDisable("btn-resume");
		}else{
			Footools.btnOff("btn-resume");
		}
		var undoEnabled = toolBoxEnable.undo;//撤销
		if(undoEnabled == false){
			Footools.btnDisable("btn-repeal");
		}else{
			Footools.btnOff("btn-repeal");
		}
		var fillEnabled = toolBoxEnable.setFill;//填充自定义图像
		if(fillEnabled == false){
			Footools.btnDisable("btn-node-color");
		}else{
			Footools.btnOff("btn-node-color");
		}

		var zoomInEnabled = toolBoxEnable.zoomIn; //放大
		if(zoomInEnabled == false){
			Footools.btnDisable("btn-zoom-in");
		}else{
			Footools.btnOff("btn-zoom-in");
		}
		var zoomOutEnabled = toolBoxEnable.zoomOut; //缩小
		if(zoomOutEnabled == false){
			Footools.btnDisable("btn-zoom-out");
		}else{
			Footools.btnOff("btn-zoom-out");
		}

		var fontSizeTemp = toolBoxEnable.fontSize;
		if(fontSizeTemp != null){
			FontSizePanel.setFontNumber(fontSizeTemp);
		}

	}

	function openImgWindow(){
		if(currentServiceRunState == "false"){
			var returnValue = showModalPopup("${ctx}/bizsm/bizservice/ui/edit-img", 'Edit img', "320px", '500px');
			/*if(returnValue){
				if(returnValue == "success"){
					window.location.reload();
				}
			}*/
			parent.parent.window.location.reload();
		}
	}
</script>
</head>
<body onload="f_init()" style="overflow-x:hidden;overflow-y:hidden">

	<div id="flashContent" style="position:absolute;top:0px;left:0px;z-index:-101;height:100%;width:100%"></div>

	<div id="rightRoot" style="position:absolute;top:0px;right:0;width:350px;z-index:101;"></div>

	<div id="toolbar" style="position:absolute;left:0px;bottom:0;height:40px;width:100px;z-index:101">
		<page:applyDecorator name="tools">
		   <page:param name="width">620</page:param>
		   <page:param name="available">false</page:param>
		   <page:param name="isExpend">true</page:param>
		   <page:param name="btns">[[
				   {id:"btn-full-screen",oncls:"full-screen",offcls:"full-screen",disablecls:"full-screen",available:"on",title:"正常尺寸"}
				   , {id:"btn-abbreviative",oncls:"abbreviative",offcls:"abbreviative",disablecls:"abbreviative",available:"on",title:"适合窗口"}

				   , {id:"btn-mouse",oncls:"foot-click",offcls:"foot-click",disablecls:"foot-click-off",available:"on",title:"拖拽"}
				   , {id:"btn-zoom-out",oncls:"zoom-in",offcls:"zoom-in",disablecls:"zoom-in-off",available:"on",title:"放大"}
				   , {id:"btn-zoom-in",oncls:"zoom-out",offcls:"zoom-out",disablecls:"zoom-out-off",available:"on",title:"缩小"}

				   , {id:"btn-repeal",oncls:"repeal",offcls:"repeal",disablecls:"repeal-off",available:"on",title:"撤销"}
				   , {id:"btn-resume",oncls:"resume",offcls:"resume",disablecls:"resume-off",available:"on",title:"恢复撤销"}
				   , {id:"btn-textarea",oncls:"textarea-on",offcls:"textarea",disablecls:"textarea-off",available:"on",title:"插入文本框"}
				   , {id:"btn-hidetextareaborder",oncls:"font-border",offcls:"font-border",disablecls:"font-border-off",available:"on",title:"隐藏边框"}
				   , {id:"btn-font-size",oncls:"font-size",offcls:"font-size",disablecls:"font-size-off",available:"on",title:"字体大小"}
				   , {id:"btn-font-bold",oncls:"font-bold",offcls:"font-bold",disablecls:"font-bold-off",available:"on",title:"文字加粗"}
				   , {id:"btn-font-color",oncls:"font-color",offcls:"font-color",disablecls:"font-color-off",available:"on",title:"字体颜色"}
				   , {id:"btn-node-color",oncls:"node-color",offcls:"node-color",disablecls:"node-color-off",available:"on",title:"填充颜色"}
				   , {id:"btn-line-color",oncls:"line-color",offcls:"line-color",disablecls:"line-color-off",available:"on",title:"线条颜色"}
				   , {id:"btn-line-weight",oncls:"line-weight",offcls:"line-weight",disablecls:"line-weight-off",available:"on",title:"线条粗细"}
				   , {id:"btn-line-style",oncls:"line-style",offcls:"line-style",disablecls:"line-style-off",available:"on",title:"线条样式"}
				   , {id:"btn-arrow-style",oncls:"foot-arrow",offcls:"foot-arrow",disablecls:"foot-arrow-off",available:"on",title:"箭头样式"}
				   , {id:"btn-refresh",oncls:"update",offcls:"update",disablecls:"update",available:"on",title:"刷新"}
				   , {id:"btn-delete", oncls:"delete", offcls:"delete",disablecls:"delete-off",available:"on",title:"删除"}
				   , {id:"btn-save", oncls:"save", offcls:"save",disablecls:"save-off",available:"on",title:"保存"}]]
			</page:param>
		</page:applyDecorator>
	</div>
	<page:applyDecorator name="fontsizepanel">
		<page:param name="fontsizekind">8,9,10,12,14,16,18,20,22,26,32</page:param>
    </page:applyDecorator>

	<page:applyDecorator name="colorPanel"></page:applyDecorator>


    <page:applyDecorator name="linestylePanel">
		<page:param name="headother"><p></p></page:param>
		<page:param name="footother"><h3></h3></page:param>
    </page:applyDecorator>
	<page:applyDecorator name="linesizePanel">
		<page:param name="headother"><p></p></page:param>
		<page:param name="footother"><h3></h3></page:param>
    </page:applyDecorator>
	<page:applyDecorator name="arrowstylePanel">
		<page:param name="headother"><p></p></page:param>
		<page:param name="footother"><h3></h3></page:param>
    </page:applyDecorator>

</body>
</html>

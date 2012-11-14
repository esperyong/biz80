<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务定义首页
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefinemain
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>服务定义首页</title>



<link rel="Shortcut icon" type="image/x-icon" href="${ctx}/apple.ico">
<link rel="icon" href="${ctx}/apple.ico" type="image/x-icon" />



<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/footer.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/jquery-ui/jquery.ui.toolbar.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/jquery.ui.toolmenu.css" rel="stylesheet" type="text/css" />

<style type="text/css" media="screen"> 
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:center; 
		   background-color: #ffffff; }   
	#flashContent { display:none; }
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion-1.1.js"></script>

<script type="text/javascript" src="${ctx}/js/component/menu/j-dynamic-toolmenu-1.1.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/pullBox/j-dynamic-pullbox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toolBar/j-dynamic-horizontal-toolbar.js"></script>


<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>


<script language="javascript">

	var currentServiceID_global = "";
	var currentServiceRunState = "false";
	$(function() {
			

			$("#standardAccordionHull #standardAccordionHullTitle").css("width", "280px");

			$("#standardAccordionHull #standardAccordionHullBottom").css("width", "280px");

			$("#standardAccordionHull #jAccordionRoot").css("height", "420px");

			//padding-top:5px;padding-left:20px;position:absolute;top:10px;left:0px;z-index:10;
			//$("#standardAccordionHull").css("padding-top", "5px");
			//$("#standardAccordionHull").css("padding-left", "5px");
			
			/*
			//工具条组件
			var bizServiceDefineHToolbar = new JDynamicHorizontalToolbar({id:'bizServiceDefineHToolbar'});
			bizServiceDefineHToolbar.addItem({itemID:"item-refresh", title:"刷新", className:"btnrs"}, {}, function(dataMap){
				//alert(dataMap["title"]);
				refreshTopo();
			});
			bizServiceDefineHToolbar.addItem({itemID:"item-del", title:"删除", className:"btnDel"}, {}, function(dataMap){
				deleteSelectedCmps();
			});
			bizServiceDefineHToolbar.addItem({itemID:"item-save", title:"保存", className:"btnSave"}, {}, function(dataMap){
				// call flash.
				saveTopo("${ctx}");
			});
			
			bizServiceDefineHToolbar.appendToContainer('body div[id="toolbar"]');
			*/

			Footools.init({listeners:{click:function(id){
										if(id == "btn-refresh"){
											//alert(dataMap["title"]);
											refreshTopo();
										}else if(id == "btn-delete"){
											deleteSelectedCmps();
										}else if(id == "btn-save"){
											// call flash.
											saveTopo("${ctx}");
										}

									  }
									  , afterClick:function(id){
											//Footools.btnDisable(id);
									  }
							}
			  });
			//document.body.clientWidth);
			Footools.setWidth(1220);
			Footools.expend();


			/**
			*更新左边当前展开的业务服务
			*
			*/
			$.updateLeftBizService = function(){

				$('#standardAccordionHull #jAccordionRoot').empty();
				
				var bizAccordionPanel1 = new JDynamicAccordionPanel({id:"bizServiceDefinedAccordion1", slid:true, panelBlockStyle:"tree", autoHeight:true, fillSpace:true, globalContentHeight:"220px"});
				
				//执行AJAX请求,获取当前所有定义的业务服务列表.
				$.get('${ctx}/bizservice/.xml',{},function(data){
					//获取当前所有定义的业务服务列表
					var $serviceNodes = $(data).find('BizServices>BizService');//.not('[reference]');
					$serviceNodes.each(function(i){
						var $thisService = $(this);

						var idStr = $thisService.find('>bizId').text();
						var contentPagePath = "${ctx}/bizsm/bizservice/ui/bizdefine-biztreeview?uri="+$thisService.find('>uri').text()+".xml";
						var runStateStr = $thisService.find('>monitered').text();//"false";

						//添加业务服务折叠页签
						var slabMap = {};
						slabMap["slabID"] = idStr;
						slabMap["label"] = $thisService.find('>name').text();
						//slabMap["contentHeight"] = "260px";
						
						var icoArray = new Array();
						if(runStateStr == "true"){
							icoArray.push("state state-use");
						}else{
							icoArray.push("state state-unuse");
						}
						bizAccordionPanel1.addPageSlab(slabMap, icoArray, contentPagePath, {runState:runStateStr}, null);
						
						var menuObj = new JDynamicToolMenu({id:"biztoolmenu-"+i, menuItemWidth:"130", btnImagePath:"${ctx}/images/ico/btn-right.gif"});
						menuObj.addMenuItem({menuID:"bizpopmenunode-1", label:"删除", icoClassName:"delete"}, null, function(dataMap){f_deleteBizService("${ctx}/bizservice/"+idStr)});

						if(runStateStr == "true"){
							menuObj.addMenuItem({menuID:"bizpopmenunode-2", label:"停用", icoClassName:"verboten"}, null, function(dataMap){
								f_setBizServiceRunState(idStr, "false");
							});
						}else{
							menuObj.addMenuItem({menuID:"bizpopmenunode-2", label:"启用", icoClassName:"verboten"}, null, function(dataMap){
								f_setBizServiceRunState(idStr, "true");
							});
						}
						
						bizAccordionPanel1.addSlabTool(idStr, menuObj.getComponetHandle(), 3);

					});
						
					bizAccordionPanel1.appendToContainer($('#standardAccordionHull #jAccordionRoot'));
					//展开当前处于展开状态的折叠页签.
					bizAccordionPanel1.expanseSlab(currentServiceID_global);
				
					bizAccordionPanel1.click(function(slabDataMap){
						//call flash (切换当前业务服务topo)
						chooseTopo("biztopo/.xml?bizServiceId="+slabDataMap.slabID);
						//设置当前处于展开的业务服务ID
						currentServiceID_global = slabDataMap.slabID;
						//设置当前业务服务运行状态
						currentServiceRunState = bizAccordionPanel1.getUserData(slabDataMap.slabID, "runState");
					});
				});
				
			}
			
			/**
			*读取左边业务服务列表
			*param String expanseSlabID 需要展开的折叠页签ID
			*
			*/
			$.readLeftBizService = function(expanseSlabID){
				$('#standardAccordionHull #jAccordionRoot').empty();
				
				var bizAccordionPanel2 = new JDynamicAccordionPanel({id:"bizServiceDefinedAccordion2", slid:true, panelBlockStyle:"tree", autoHeight:true, fillSpace:true, globalContentHeight:"220px"});
				//执行AJAX请求,获取当前所有定义的业务服务列表.
				$.get('${ctx}/bizservice/.xml',{},function(data){
					var $serviceNodes = $(data).find('BizServices>BizService');//.not('[reference]');
					if($serviceNodes.size() == 0){
						//call flash  (切换当前业务服务topo)
						chooseTopo("");
					}else{
						var currentBizID = "";
						$serviceNodes.each(function(i){
							var $thisService = $(this);

							var idStr = $thisService.find('>bizId').text();
							var contentPagePath = "${ctx}/bizsm/bizservice/ui/bizdefine-biztreeview?uri="+$thisService.find('>uri').text()+".xml";

							var runStateStr = $thisService.find('>monitered').text();

							var slabMap = {};
							slabMap["slabID"] = idStr;
							slabMap["label"] = $thisService.find('>name').text();
							//slabMap["contentHeight"] = "260px";
							
							var icoArray = new Array();
							if(runStateStr == "true"){
								icoArray.push("state state-use");
							}else{
								icoArray.push("state state-unuse");
							}
							bizAccordionPanel2.addPageSlab(slabMap, icoArray, contentPagePath, {runState:runStateStr}, null);

							var menuObj = new JDynamicToolMenu({id:"biztoolmenu-"+i, menuItemWidth:"130", btnImagePath:"${ctx}/images/ico/btn-right.gif"});
							menuObj.addMenuItem({menuID:"bizpopmenunode-1", label:"删除",  icoClassName:"delete"}, null, function(dataMap){f_deleteBizService("${ctx}/bizservice/"+idStr)});
							
							if(runStateStr == "true"){
								menuObj.addMenuItem({menuID:"bizpopmenunode-2", label:"停用",  icoClassName:"verboten"}, null, function(dataMap){
									f_setBizServiceRunState(idStr, "false");
								});
							}else{
								menuObj.addMenuItem({menuID:"bizpopmenunode-2", label:"启用",  icoClassName:"verboten"}, null, function(dataMap){
									f_setBizServiceRunState(idStr, "true");
								});
							}
							
							bizAccordionPanel2.addSlabTool(idStr, menuObj.getComponetHandle(), 3);

							if(i == 0){
								currentBizID = idStr;
							}
							//alert("nodeName:"+this.nodeName);
							//alert(this.firstChild.nodeValue);
							//alert("nodeType:"+this.nodeType);
							//temp["name"] = this.firstChild.nodeValue;//this.getAttribute("name");
							//temp["id"] = this.getAttribute("id");
							//temp["url"] = "${ctx}/"+this.getAttribute("url")+"?bizID="+temp["id"];
						});
						
						bizAccordionPanel2.appendToContainer($('#standardAccordionHull #jAccordionRoot'));

						bizAccordionPanel2.click(function(slabDataMap){
							//call flash (切换当前业务服务topo)
							chooseTopo("biztopo/.xml?bizServiceId="+slabDataMap.slabID);
							//设置当前处于展开的业务服务ID
							currentServiceID_global = slabDataMap.slabID;
							//设置当前业务服务运行状态
							currentServiceRunState = bizAccordionPanel2.getUserData(slabDataMap.slabID, "runState");
						});
						
						if(expanseSlabID == "first"){
							expanseSlabID = currentBizID;
						}
						//展开处于展开状态的折叠页签,展开时会触发slab的click事件.
						bizAccordionPanel2.expanseSlab(expanseSlabID);
					}
					//设置当前处于展开的业务服务ID
					currentServiceID_global = expanseSlabID;
					//设置当前业务服务运行状态
					//currentServiceRunState = startState;
					
				});
			}
			
			/**
			*读取右边业务服务属性窗口
			*param String serviceID 当前展开的业务服务ID
			*
			*/
			$.readRightPullBox = function(serviceID, runState){
				$('body #rightRoot').empty();
				
				if(serviceID != null && serviceID != ""){
					var tabPanelTemp = new JDynamicTabPanel({id:"jTabsOne"});
					tabPanelTemp.addPageTab({tabID:"tab-1",label:"常规信息",height:"400px"}, "${ctx}/bizsm/bizservice/ui/bizservicemanager!getGeneralInfo?serviceId="+serviceID, null, function(dataMap){
						// alert(dataMap["tabID"]);
					});
					tabPanelTemp.addPageTab({tabID:"tab-2",label:"业务服务",height:"300px"}, "${ctx}/bizservice/?canAdoptByServiceId="+serviceID, null, null);
					tabPanelTemp.addPageTab({tabID:"tab-3",label:"资源",height:"430px"}, "${ctx}/bizsm/bizservice/ui/bizdefine-resourcetreeview", null, null);
					tabPanelTemp.addPageTab({tabID:"tab-4",label:"业务单位",height:"200px"}, "${ctx}/bizuser/", null, null);
					tabPanelTemp.addPageTab({tabID:"tab-5",label:"自定义元素",height:"200px"}, "", null, null);
		
					tabPanelTemp.click(function(tabDataMap){
						//call flash (取消当前tab页中选中的内容)
						unChoose();
					});
					//展开指定的tab页
					tabPanelTemp.expanseTab("tab-1");

					var tabPanelTemp3 = new JDynamicTabPanel({id:"jTabsTwo", animated:""});
					tabPanelTemp3.addPageTab({tabID:"tab-1",label:"tab1",height:"200px"}, "", null, null);
					tabPanelTemp3.addPageTab({tabID:"tab-2",label:"tab2",height:"300px"}, "", null, null);
					tabPanelTemp3.addPageTab({tabID:"tab-3",label:"tab3",height:"200px"}, "", null, null);
					tabPanelTemp3.expanseTab("tab-3");

					var accordionPanelBox = new JDynamicAccordionPanel({id:"bizServiceDefinedAccordion3", slid:true, panelBlockStyle:"blackbox"});
					accordionPanelBox.addInnerComponetSlab({slabID:"slab-1",label:"服务定义",contentHeight:"470px"}, null, tabPanelTemp.getComponetHandle(), null, null);
					accordionPanelBox.addPageSlab({slabID:"slab-2",label:"状态定义",contentHeight:"400px"}, null, "${ctx}/bizsm/bizservice/ui/bizstatusmanager!getStatusDefinePage?serviceId="+serviceID, null, null);
					accordionPanelBox.addInnerComponetSlab({slabID:"slab-3",label:"警告定义",contentHeight:"450px"}, null, tabPanelTemp3.getComponetHandle(), null, null);

					if(runState == "true"){
						accordionPanelBox.setContentDisabled(true);
						tabPanelTemp.setContentDisabled(true);
						tabPanelTemp3.setContentDisabled(true);
					}else{
						accordionPanelBox.setContentDisabled(false);
						tabPanelTemp.setContentDisabled(false);
						tabPanelTemp3.setContentDisabled(false);
					}
					
					$('#rightRoot').css("width", "435px");
					$('#rightRoot').css("left", (document.body.offsetWidth-435));
					//$('#rightRoot').css("backgroundColor", "gray");

					var jpullPanelObj = new JDynamicPullPanel({id:"jPull-1", label:"业务服务定义属性设置", contentWidth:"400px", animated:"slow"});
					jpullPanelObj.addInnerComponet(accordionPanelBox.getComponetHandle());
					jpullPanelObj.appendToContainer('body #rightRoot');
					
					accordionPanelBox.expanseSlab("slab-1");
					
					//设置工具条,删除按钮是否可用
					if(runState == "true"){
						//$("#toolbar").setbtEnable("del", false);
						//bizServiceDefineHToolbar.setItemDisabled("item-del", true);
						//Footools.btnDisable("btn-delete");
					}else{
						//$("#toolbar").setbtEnable("del", true);
						//bizServiceDefineHToolbar.setItemDisabled("item-del", false);
						//Footools.btnOff("btn-delete");
					}
					
				}
				
			}

			/**
			*注册添加业务服务按钮触发事件.
			*
			*/
			$("#standardAccordionHull>#standardAccordionHullTitle #addBiz-h").bind("click", function(){
				//var child = window.open('${ctx}/bizsm/bizservice/ui/addnewbizservice', 'Add Biz', 'width=400, height=230,top=230,left=400,toolbar=no, menubar=no, scroll=no, resizable=no,location=no, status=no');
				//child.focus();
				  var returnValue = showModalPopup("${ctx}/bizsm/bizservice/ui/addnewbizservice", 'Add Biz', "230px", '400px');
				  if(returnValue){
					  $.get('${ctx}/'+returnValue+".xml", {},function(data){
						var $thisService= $(data).find('BizService');
						var idStr = $thisService.find('>bizId').text();
						$.readLeftBizService(idStr);
					});
				  }
			});
			
		  //为左边导航添加推拉效果
			$('#pageBorderLocal').toggle(function(event){
				var $thisLocal = $(this);
				$('#pageBorderPanel').animate({
					left:0
				},500, function(){
					$thisLocal.removeClass("bar-left");
					$thisLocal.addClass("bar-right");
				});

				$('#standardAccordionHull').animate({
					width:0,
					opacity:1
				},500);
				
				
			}, function(event){
				var $thisLocal = $(this);
				$('#standardAccordionHull').animate({
					width:275,
					opacity:1
				},500);

				$('#pageBorderPanel').animate({
					left:280
				},500, function(){
					$thisLocal.removeClass("bar-right");
					$thisLocal.addClass("bar-left");
				});
				
			});
			
	});

	function f_deleteBizService(uri){
	
		if(!confirm("是否确定删除此业务服务？")){
				return;
		}
		$.ajax({
			 type: 'DELETE',
			 url: uri,
			 contentType: "application/x-www-form-urlencoded",
			 data: 'xhr=1&',
			 processData: false,
			 beforeSend: function(request){
			  httpClient = request;
			 },
			 cache:false,
			 error: function (request) {
				var errorMessage = request.responseText;
				var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
				 $errorObj.each(function(i){
				  var fieldId = $(this).find('FieldId').text();
				  var field = document.getElementById(fieldId);
				  var errorInfo = $(this).find('ErrorInfo').text();
				  alert(errorInfo);
				  field.focus();
			  });
			 },
			 success: function(msg){
				f_readLeftPanel();
			 }         
		}); 
		
	}
	
	function f_setBizServiceRunState(serviceID, runState){
		var paramData = "<BizService><monitered>"+runState+"</monitered></BizService>";
		var httpClient;
		$.ajax({
			  type: 'PUT',
			  url: "${ctx}/bizservice/"+serviceID+".xml",
			  contentType: "application/xml",
			  data: paramData,
			  processData: false,
			  beforeSend: function(request){
				  httpClient = request;
			  },
			  cache:false,
			  error: function (request) {
					var errorMessage = request.responseXML;
					var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
					$errorObj.each(function(i){
						var fieldId = $(this).find('FieldId').text();
						var field = document.getElementById(fieldId);
						var errorInfo = $(this).find('ErrorInfo').text();
						alert(errorInfo);
						field.focus();
					});
			  },
			  success: function(msg){
				  f_readLeftPanel();
			  }			  		  
		});	
	}

	function f_updateLeftPanel(){
		$.updateLeftBizService();
	}
	function f_readLeftPanel(){
		$.readLeftBizService("first");
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
		$.readRightPullBox(serivceId, currentServiceRunState);
	}

	function showModalPopup(URL,name,height,width) {
		var properties = "resizable=no;center=yes;help=no;status=no;scroll=no;dialogHeight = " + height;
		properties = properties + ";dialogWidth=" + width;
		var leftprop, topprop, screenX, screenY, cursorX, cursorY, padAmt;
		screenY = document.body.offsetHeight;
		screenX = window.screen.availWidth;

		leftvar = (screenX - width) / 2;
		rightvar = (screenY - height) / 2;
		leftprop = leftvar;
		topprop = rightvar;

		properties = properties + ", dialogLeft = " + leftprop;
		properties = properties + ", dialogTop = " + topprop;

		return window.showModalDialog(URL,name,properties);
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
			"100%", "100%", 
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

</script>
</head>
<body onload="f_init()">
	<div id='standardAccordionHull' style="position:absolute;top:5px;left:0px;width:275px;z-index:101">
		<div id='standardAccordionHullTitle' class='left-panel-open'>
			<div class='left-panel-l'>
				<div class='left-panel-r ui-dialog-titlebar'>
					<div id='accordionDragHandle' class='left-panel-m'>
						<span class='left-panel-title'>业务服务定义</span>
					</div>
				</div>
			</div>
			<div class='left-panel-content'>
				<table width="100%">
					<tr>
						<td width="100%" style="text-align:right;">
							<a id="addBiz-h" href="#"><img src="${ctx}/images/add-button1.gif" title="添加业务服务"/></a>
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<hr/>
						</td>
					</tr>
				</table>
				<div id='jAccordionRoot'></div>
			</div>
			<div id='standardAccordionHullBottom' class='left-panel-close'>
				<div class='left-panel-l'>
					<div class='left-panel-r'>
						<div class='left-panel-m'><span class='left-panel-title'></span></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="pageBorderPanel" class="bar" style="position:absolute;top:5px;left:280px;height:579px;z-index:101">
	  <p id="pageBorderLocal" class="bar-left"></p> 
	</div>

	<div id="flashContent" style="position:absolute;top:0px;left:0px;z-index:-101;height:100%;width:100%"></div>

	<div id="rightRoot" style="position:absolute;top:0px;z-index:102;"></div>

	<div id="toolbar" style="position:absolute;top:530px;left:0px;z-index:101;width:100px">
		<page:applyDecorator name="tools">  
		   <page:param name="width">500</page:param>
		   <page:param name="available">false</page:param>
		   <page:param name="isExpend">true</page:param>
		   <page:param name="btns">[[
				   {id:"btn-full-screen",oncls:"full-screen",offcls:"full-screen",disablecls:"full-screen",available:"on",title:"全拼"}
				   , {id:"btn-abbreviative",oncls:"abbreviative",offcls:"abbreviative",disablecls:"abbreviative",available:"on",title:"缩小"}
				   , {id:"btn-repeal",oncls:"repeal",offcls:"repeal",disablecls:"repeal-off",available:"on",title:"撤销"}
				   , {id:"btn-resume",oncls:"resume",offcls:"resume",disablecls:"resume-off",available:"on",title:"恢复撤销"}
				   , {id:"btn-textarea",oncls:"textarea-on",offcls:"textarea",disablecls:"textarea-off",available:"on",title:"Textarea"}
				   , {id:"btn-font-size",oncls:"font-size",offcls:"font-size",disablecls:"font-size-off",available:"on",title:"Font Size"}
				   , {id:"btn-font-color",oncls:"font-color",offcls:"font-color",disablecls:"font-color-off",available:"on",title:"Font Color"}
				   , {id:"btn-node-color",oncls:"node-color",offcls:"node-color",disablecls:"node-color-off",available:"on",title:"Node Color"}
				   , {id:"btn-bg-color",oncls:"bg-color",offcls:"bg-color",disablecls:"bg-color-off",available:"on",title:"Background Color"}
				   , {id:"btn-line-color",oncls:"line-color",offcls:"line-color",disablecls:"line-color-off",available:"on",title:"Line Color"}
				   , {id:"btn-line-weight",oncls:"line-weight",offcls:"line-weight",disablecls:"line-weight-off",available:"on",title:"Node Color"}
				   , {id:"btn-line-style",oncls:"line-style",offcls:"line-style",disablecls:"line-style-off",available:"on",title:"Background Color"}
				   , {id:"btn-single",oncls:"single",offcls:"single",disablecls:"single-off",available:"on",title:"Line Color"}
				   , {id:"btn-refresh",oncls:"update",offcls:"update",disablecls:"update",available:"on",title:"刷新"}
				   , {id:"btn-delete", oncls:"delete", offcls:"delete",disablecls:"delete-off",available:"on",title:"删除"}
				   , {id:"btn-save", oncls:"save", offcls:"save",disablecls:"save-off",available:"on",title:"保存"}]]
			</page:param>
		</page:applyDecorator>
	</div>

</body>
</html>
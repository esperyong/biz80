<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ page import="com.mocha.bsm.bizsm.core.util.LicenseUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务列表
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-list
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	int operateCount = LicenseUtil.getBizServiceOperateCount();
	if(operateCount < 0) operateCount = 0;

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>业务服务列表</title>



<link rel="Shortcut icon" type="image/x-icon" href="${ctx}/imac.ico">
<link rel="icon" href="${ctx}/imac.ico" type="image/x-icon" />



<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/footer.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/service.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />


<link href="${ctx}/css/jquery-ui/jquery.ui.treeview.css"  rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/jquery.ui.toolmenu.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />


<style type="text/css" media="screen">
	html, body	{ height:100%; }
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion-1.1.js"></script>

<script type="text/javascript" src="${ctx}/js/component/menu/j-dynamic-toolmenu-1.1.js"></script>

<script src="${ctx}/js/component/treeView/j-dynamic-treeview-1.2.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>


<script language="javascript">
	var confirmConfig = {width: 300,height: 80};

	var serviceIDGlobal = ""; //当前处于选中状态的业务服务ID
	var serviceNodeIDGlobal = ""; //当前处于选中状态的NodeID
	var serviceRunStateGlobal = "false"; //当前业务服务运行状态(启用/禁用)

	/*
		如果点击左侧服务树上面的删除，启用/禁用按钮；如果拓扑有变化，弹出提示是否保存当前拓扑；
		此时再次切换服务时，bizdefinetop页面中的$('#topBtnPanel>ul>li').click 不再弹出保存提示。
		保存拓扑后flash会回调刷新树js函数；此时，如果点击确定保存当前拓扑，则不再执行重复的刷新左侧树操作（因为删除，启用/禁用操作会重新加载树）。
	*/
	var requiredUpdateLeftGlobal = true; //是否需要刷新左边树
	var requiredTipSaveGlobal = true; //是否需要提示保存当前拓扑

	var bizServiceTreeView = null; //业务服务树形组件对象


	var bizServiceOperateCount = "<%=operateCount%>"; //当前license操作数


	var $loadingDivLeft_global = null;//左边服务列表页面loading 对象
	var $loadingDivRight_global = null;//右边页面loading 对象

	var firstLoadPage_global = true; //标识页面是否第一次打开

	$(function() {
			$("#standardAccordionHull #standardAccordionHullTitle").css("width", "230px");

			//为左边导航添加推拉效果
			$('#pageBorderLocal').toggle(function(event){
					var $thisLocal = $(this);

					$('#standardAccordionHull').hide();

					$('#pageBorderPanel').animate({
						left:0
					},0, function(){
						parent.f_hideLeftFrame();
						$thisLocal.removeClass("bar-left");
						$thisLocal.addClass("bar-right");
					});
			}, function(event){
					var $thisLocal = $(this);

					$('#standardAccordionHull').show();

					$('#pageBorderPanel').animate({
						left:230
					},0, function(){
						parent.f_showLeftFrame();
						$thisLocal.removeClass("bar-right");
						$thisLocal.addClass("bar-left");
					});
			});

			/**
			*注册添加业务服务按钮触发事件.
			*
			*/
			$("#standardAccordionHull>#standardAccordionHullTitle #addBiz-h").bind("click", function(){
				//var child = window.open('${ctx}/bizsm/bizservice/ui/addnewbizservice', 'Add Biz', 'width=400, height=230,top=230,left=400,toolbar=no, menubar=no, scroll=no, resizable=no,location=no, status=no');
				//child.focus();
				  var returnValue = showModalPopup("${ctx}/bizsm/bizservice/ui/addnewbizservice", 'Add Biz', "220px", '520px');
				  if(returnValue){
					  $.get('${ctx}/'+returnValue+".xml", {},function(data){
						var $thisService= $(data).find('BizService');
						var idStr = $thisService.find('>bizId').text();
						f_readLeftPanel(idStr);
					});
				  }
			});

			/**
			*注册导航服务按钮触发事件.
			*
			*/
			$("#standardAccordionHull>#standardAccordionHullTitle #daohang").bind("click", function(){
				//showModalPopup("${ctx}/pages/bizservicedefine1.jsp", 'Add Biz', "560px", '1000px');
				window.open("${ctx}/pages/navigation/bizservicedefine1.jsp","导航窗口","width=950,height=560");
			});

			f_readLeftPanel("");

	});


	/**
	*读取左边业务服务列表
	*param String selectedNodeID 需要展开的树节点ID
	*
	*/
	function f_readLeftPanel(selectedNodeID){

		//初始化全局变量
		//设置当前处于展开的业务服务ID
		serviceIDGlobal = "";
		//设置当前处于展开的NodeID
		serviceNodeIDGlobal = "";
		serviceRunStateGlobal = "false"; //当前业务服务运行状态(启用/禁用)

		var expanseNodeID = selectedNodeID;
		if(selectedNodeID == null || selectedNodeID == ""){
			expanseNodeID = "first";
		}

		$('#standardAccordionHull #jAccordionRoot').empty();

		//执行AJAX请求,获取当前所有定义的业务服务列表.
		//bizservice/.xml
		$.get('${ctx}/bizservice/snapshot.xml',{},function(data){

			var $serviceNodes = $(data).find('BizServices:first>BizService');//.not('[reference]');
			if($serviceNodes.size() == 0){
				var $noBizServiceArea = $('<div class="new-machineroom" style="width:200px"><div class="add-button2"><span>请点击 <a href="#"><img src="${ctx}/images/add-button1.gif" width="10" height="10" border="0"></a> 按钮新建一个服务</span></div><div class="clear"></div></div>');

				$('#standardAccordionHull #jAccordionRoot').append($noBizServiceArea);
				//call flash  (切换当前业务服务topo)
				//chooseTopo("");
				//如果未定义任务业务服务时,右面显示区域显示默认提示信息
				parent.rightFrame.f_disabledDefaultContent(true);
				//调用f_unLoadingServiceList取消屏蔽效果。
				f_unLoadingServiceList();
			}else{

				if(firstLoadPage_global){
					//第一次打开时,收回左边的服务列表框
					$('#pageBorderLocal').click();
				}

				//业务服务树节点上，所有弹出菜单对象集合。
				var menuObjBizArray = new Array();
				//显示右面展示区
				parent.rightFrame.f_disabledDefaultContent(false);

				var currentBizID = "";
				bizServiceTreeView = new JDynamicTreeview({id:"bizServiceTree", lineStyle:"treeview-black", animated:300, collapsed:true, unique: false});
				$serviceNodes.each(function(i){
					var $thisService = $(this);

					var bizServiceID = $thisService.find('>bizId').text();
					var runStateStr = $thisService.find('>monitered').text();
					if(runStateStr == null || runStateStr == ""){
						runStateStr = false;
					}

					if(i == 0){
						currentBizID = bizServiceID;
					}

					var bizServiceNodeMap = {};
					bizServiceNodeMap["nodeID"] = bizServiceID;
					bizServiceNodeMap["label"] = $thisService.find('>name').text();
					bizServiceNodeMap["parentNodeID"] = "";
					bizServiceNodeMap["isDataNode"] = "false";
					var preElArrayBiz = new Array();
					preElArrayBiz.push('<span class="ico ico-policy" style="display:inline"/>');

					if(runStateStr == "true"){
						preElArrayBiz.push('<span class="state state-use" style="display:inline"/>');
					}else{
						preElArrayBiz.push('<span class="state state-unuse" style="display:inline"/>');
					}

					var menuObjBiz = new JDynamicToolMenu({id:"biztoolmenu-1", menuItemWidth:"110", btnClassName:"ico ico-t-right"});

					//将弹出菜单对象，存入集合
					menuObjBizArray.push(menuObjBiz);

					menuObjBiz.addMenuItem({menuID:"bizpopmenunode-1", label:"删除", icoClassName:"delete"}, null, function(dataMap){
						var confirmTopoFlag = false;
						//call flash 判断是否需要保存当前拓扑
						if(parent.rightFrame.contentArea_ifr.callSaveTopoFlag != null && parent.rightFrame.contentArea_ifr.callSaveTopoFlag != ""){
							confirmTopoFlag = parent.rightFrame.contentArea_ifr.callSaveTopoFlag();
						}
						if(confirmTopoFlag){
							var _confirm = top.confirm_box(confirmConfig);
							_confirm.setContentText("是否保存当前拓扑？"); //提示框
							_confirm.show();
							_confirm.setConfirm_listener(function() {
								_confirm.hide();
								//因为下面的删除操作会重新加载左边的服务树，所以保存拓扑的时候不能再刷新左边树了。
								requiredUpdateLeftGlobal = false;
								//call flash 保存拓扑
								parent.rightFrame.contentArea_ifr.saveTopo("${ctx}");

								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//删除服务
								f_deleteBizService("${ctx}/bizservice/"+bizServiceID);
							});
							_confirm.setCancle_listener(function(){
								_confirm.hide();

								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//删除服务
								f_deleteBizService("${ctx}/bizservice/"+bizServiceID);
							});
							_confirm.setClose_listener(function(){
								_confirm.hide();

								//设置不再需要提示保存
								requiredTipSaveGlobal = true;

							});
						}else{
							//设置不再需要提示保存
							requiredTipSaveGlobal = false;
							//删除服务
							f_deleteBizService("${ctx}/bizservice/"+bizServiceID);
						}
					});

					if(runStateStr == "true"){
						menuObjBiz.addMenuItem({menuID:"bizpopmenunode-2", label:"禁用", icoClassName:"verboten"}, null, function(dataMap){
							var confirmTopoFlag = false;
							//call flash 判断是否需要保存当前拓扑
							if(parent.rightFrame.contentArea_ifr.callSaveTopoFlag != null && parent.rightFrame.contentArea_ifr.callSaveTopoFlag != ""){
								confirmTopoFlag = parent.rightFrame.contentArea_ifr.callSaveTopoFlag();
							}
							if(confirmTopoFlag){
								var _confirm = top.confirm_box(confirmConfig);
								_confirm.setContentText("是否保存当前拓扑？"); //提示框
								_confirm.show();
								_confirm.setConfirm_listener(function() {
									_confirm.hide();
									//因为下面的设置状态操作会重新加载左边的服务树，所以保存拓扑的时候不能再刷新左边树了。
									requiredUpdateLeftGlobal = false;
									//call flash 保存拓扑
									parent.rightFrame.contentArea_ifr.saveTopo("${ctx}");

									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//禁用服务
									f_setBizServiceRunState(bizServiceID, "false");
								});
								_confirm.setCancle_listener(function(){
									_confirm.hide();
									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//禁用服务
									f_setBizServiceRunState(bizServiceID, "false");
								});
								_confirm.setClose_listener(function(){
									_confirm.hide();

									//设置不再需要提示保存
									requiredTipSaveGlobal = true;

								});
							}else{
								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//禁用服务
								f_setBizServiceRunState(bizServiceID, "false");
							}
						});
					}else{
						menuObjBiz.addMenuItem({menuID:"bizpopmenunode-2", label:"启用",  icoClassName:"apply"}, null, function(dataMap){
							var confirmTopoFlag = false;
							//call flash 判断是否需要保存当前拓扑
							if(parent.rightFrame.contentArea_ifr.callSaveTopoFlag != null && parent.rightFrame.contentArea_ifr.callSaveTopoFlag != ""){
								confirmTopoFlag = parent.rightFrame.contentArea_ifr.callSaveTopoFlag();
							}
							if(confirmTopoFlag){
								var _confirm = top.confirm_box(confirmConfig);
								_confirm.setContentText("是否保存当前拓扑？"); //提示框
								_confirm.show();
								_confirm.setConfirm_listener(function() {
									_confirm.hide();
									//因为下面的设置状态操作会重新加载左边的服务树，所以保存拓扑的时候不能再刷新左边树了。
									requiredUpdateLeftGlobal = false;
									//call flash 保存拓扑
									parent.rightFrame.contentArea_ifr.saveTopo("${ctx}");

									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//启用服务
									f_setBizServiceRunState(bizServiceID, "true");
								});
								_confirm.setCancle_listener(function(){
									_confirm.hide();
									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//启用服务
									f_setBizServiceRunState(bizServiceID, "true");
								});
								_confirm.setClose_listener(function(){
									_confirm.hide();

									//设置不再需要提示保存
									requiredTipSaveGlobal = true;

								});
							}else{
								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//启用服务
								f_setBizServiceRunState(bizServiceID, "true");
							}
						});
					}
					var lastElArrayBiz = new Array();
					lastElArrayBiz.push(menuObjBiz.getComponetHandle());
					//添加业务服务列表节点
					bizServiceTreeView.addTreeNode(bizServiceNodeMap, true, {bizID:bizServiceID,runState:runStateStr}, preElArrayBiz, lastElArrayBiz, function(dataMap){
						try{
							var theServiceIDTemp = dataMap["bizID"];
							var theServiceNodeIDTemp = dataMap["nodeID"];

							if(theServiceNodeIDTemp != serviceNodeIDGlobal){
								//展开处于展开状态的树节点,展开时会触发树节点的click事件.
								bizServiceTreeView.expanseNode(theServiceNodeIDTemp, true, true, null);
							}

							//设置当前业务服务运行状态
							serviceRunStateGlobal = bizServiceTreeView.getUserData(theServiceNodeIDTemp, "runState");
							//设置当前处于展开的业务服务ID
							serviceIDGlobal = theServiceIDTemp;
							//设置当前处于展开的NodeID
							serviceNodeIDGlobal = theServiceNodeIDTemp;

							//切换业务服务定义项目
							parent.rightFrame.f_bizServiceDefine("bizdefine", theServiceIDTemp);

							//切换左侧服务拓扑时,屏蔽服务列表树;右侧flash加载完成后会调用f_unLoadingServiceList取消屏蔽效果。
							if($loadingDivLeft_global != null && $loadingDivLeft_global.size() > 0){
								$loadingDivLeft_global.show();//显示左侧服务列表页面loading对象
								$loadingDivRight_global.show();//显示右侧页面loading对象
							}else{
								//创建左侧服务列表页面loading对象
								$loadingDivLeft_global = $("<div>").attr("id","middleElementLeft_bgDiv").css(
																											{
																												position:"absolute",
																												left:"0px",
																												top:"0px",
																												width:"238px", //$(window).width()+"px",
																												height:Math.max($("body").height(),$(window).height())+"px",
																												filter:"Alpha(Opacity=40)",
																												opacity:"0.4",
																												backgroundColor:"#AAAAAA",
																												zIndex:"1001",
																												margin:"0px",
																												padding:"0px"
																											}
																										);
								$loadingDivLeft_global.appendTo('body');
								//创建右侧页面loading对象
								$loadingDivRight_global = $("<div>").attr("id","middleElementRight_bgDiv").css(
																											{
																												position:"absolute",
																												left:"0px",
																												top:"0px",
																												width:$(parent.rightFrame.window).width()+"px",
																												height:Math.max($(parent.rightFrame.document.body).height(),$(parent.rightFrame.window).height())+"px",
																												filter:"Alpha(Opacity=40)",
																												opacity:"0.4",
																												backgroundColor:"#AAAAAA",
																												zIndex:"1001",
																												margin:"0px",
																												padding:"0px"
																											}
																										);
								$loadingDivRight_global.appendTo(parent.rightFrame.document.body);
							}
						}catch(e){
							//alert("服务加载中，请稍候。");
						}

					});

					//添加子业务服务列表节点
					var childBizSerRootNodeMap = {};
					var childBizRootID = "childBizService&&"+bizServiceID;
					childBizSerRootNodeMap["nodeID"] = childBizRootID;
					childBizSerRootNodeMap["label"] = "业务服务";
					childBizSerRootNodeMap["parentNodeID"] = bizServiceID;
					childBizSerRootNodeMap["isDataNode"] = "false";
					var preElArrayChildBiz = new Array();
					//preElArrayChildBiz.push('<img src="${ctx}/images/bizservice-default/default-bizservice-icon.png" align="bottom" width="15" height="14" border="0"/>');
					preElArrayChildBiz.push('<span class="ico ico-yingy" style="display:inline"/>');
					bizServiceTreeView.addTreeNode(childBizSerRootNodeMap, false, null, preElArrayChildBiz, null, null);

					var $subBizNodes = $thisService.find('>childBizServices>BizService');
					$subBizNodes.each(function(j){
						var $childService = $(this);
						var subBizIDTemp = $childService.find('>bizId').text();
						var childBizSerNodeMap = {};
						childBizSerNodeMap["nodeID"] = subBizIDTemp+"&&"+childBizRootID;
						childBizSerNodeMap["label"] = $childService.find('>name').text();
						childBizSerNodeMap["parentNodeID"] = childBizRootID;
						childBizSerNodeMap["isDataNode"] = "true";
						//添加子业务服务列表节点
						bizServiceTreeView.addTreeNode(childBizSerNodeMap, false, {bizID:subBizIDTemp}, null, null, null);
					});

					//添加资源列表节点
					var resourceRootNodeMap = {};
					var resourceRootID = "resource&&"+bizServiceID;
					resourceRootNodeMap["nodeID"] = resourceRootID;
					resourceRootNodeMap["label"] = "资源";
					resourceRootNodeMap["parentNodeID"] = bizServiceID;
					resourceRootNodeMap["isDataNode"] = "false";
					var preElArrayResource = new Array();
					preElArrayResource.push('<span class="tree-panel-ico tree-panel-ico-network"/>');
					bizServiceTreeView.addTreeNode(resourceRootNodeMap, false, null, preElArrayResource, null, null);

					var $resNodes = $thisService.find('>MonitableResources>MonitableResource');
					$resNodes.each(function(j){
						var $resource = $(this);
						var resourceIDTemp = $resource.find('>resourceInstanceId').text();
						var resourceNodeMap = {};
						resourceNodeMap["nodeID"] = resourceIDTemp+"&&"+resourceRootID;
						resourceNodeMap["label"] = $resource.find('>resourceName').text();
						resourceNodeMap["parentNodeID"] = resourceRootID;
						resourceNodeMap["isDataNode"] = "true";
						//添加资源列表节点
						bizServiceTreeView.addTreeNode(resourceNodeMap, false, {resourceID:resourceIDTemp}, null, null, null);
					});

					//添加业务单位列表节点
					var bizUserRootNodeMap = {};
					var bizUserRootID = "bizUser&&"+bizServiceID;
					bizUserRootNodeMap["nodeID"] = bizUserRootID;
					bizUserRootNodeMap["label"] = "业务单位";
					bizUserRootNodeMap["parentNodeID"] = bizServiceID;
					bizUserRootNodeMap["isDataNode"] = "false";
					var preElArrayBizUser = new Array();
					//preElArrayBizUser.push('<img src="${ctx}/images/bizservice-default/default-bizuser-icon.png" align="bottom" width="16" height="15" border="0"/>');
					preElArrayBizUser.push('<span class="ico ico-person" style="display:inline"/>');
					bizServiceTreeView.addTreeNode(bizUserRootNodeMap, false, null, preElArrayBizUser, null, null);

					var $bizUserNodes = $thisService.find('>bizUsers>BizUser');
					$bizUserNodes.each(function(j){
						var $bizUser = $(this);
						var bizUserIDTemp = $bizUser.find('>id').text();
						var bizUserNodeMap = {};
						bizUserNodeMap["nodeID"] = bizUserIDTemp+"&&"+bizUserRootID;
						bizUserNodeMap["label"] = $bizUser.find('>name').text();
						bizUserNodeMap["parentNodeID"] = bizUserRootID;
						bizUserNodeMap["isDataNode"] = "true";
						//添加业务单位列表节点
						bizServiceTreeView.addTreeNode(bizUserNodeMap, false, {bizUserID:bizUserIDTemp}, null, null, null);
					});
				});

				if(expanseNodeID == "first"){
					expanseNodeID = currentBizID;
				}

				//点击所有树节点时，关闭掉弹出的菜单
				bizServiceTreeView.allNodeClick(function(){
					for(var menuCnt=0; menuCnt<menuObjBizArray.length; menuCnt++){
						menuObjBizArray[menuCnt].close();
					}
				});
				bizServiceTreeView.allExpanseNode(function(){
					for(var menuCnt=0; menuCnt<menuObjBizArray.length; menuCnt++){
						menuObjBizArray[menuCnt].close();
					}
				});

				//触发树节点的click事件.
				bizServiceTreeView.nodeClick(expanseNodeID);

				$('#jAccordionRoot').append(bizServiceTreeView.getComponetHandle());
				var scrollWidthTemp = $('#jAccordionRoot').get(0).scrollWidth;
				//alert($('#jAccordionRoot').get(0).scrollWidth);
				//alert($('#jAccordionRoot').width());
				//alert($('#jAccordionRoot').get(0).scrollLeft)
				bizServiceTreeView.setAvailWidth(scrollWidthTemp+25);
			}
			//设置当前处于展开的NodeID
			serviceNodeIDGlobal = expanseNodeID;
		});
	}

	/**
	* 更新左边当前展开的业务服务
	*
	*/
	function f_updateLeftPanel(){

		//判断是否执行需要刷新左边树
		if(requiredUpdateLeftGlobal == false){
			requiredUpdateLeftGlobal = true;
			return;
		}
		$('#standardAccordionHull #jAccordionRoot').empty();

		//业务服务树节点上，所有弹出菜单对象集合。
		var menuObjBizArray = new Array();

		bizServiceTreeView = new JDynamicTreeview({id:"bizServiceTree", lineStyle:"treeview-black", animated:300, collapsed:true, unique: false});

		//执行AJAX请求,获取当前所有定义的业务服务列表.
		$.get('${ctx}/bizservice/snapshot.xml',{},function(data){
			var $serviceNodes = $(data).find('BizServices:first>BizService');//.not('[reference]');
			if($serviceNodes.size() == 0){
				var $noBizServiceArea = $('<div class="new-machineroom" style="width:200px"><div class="add-button2"><span>请点击 <a href="#"><img src="${ctx}/images/add-button1.gif" width="10" height="10" border="0"></a> 按钮新建一个服务</span></div><div class="clear"></div></div>');

				$('#standardAccordionHull #jAccordionRoot').append($noBizServiceArea);
				//call flash  (切换当前业务服务topo)
				//chooseTopo("");
				//如果未定义任务业务服务时,右面显示区域显示默认提示信息
				parent.rightFrame.f_disabledDefaultContent(true);
				//调用f_unLoadingServiceList取消屏蔽效果。
				f_unLoadingServiceList();
			}else{

				if(firstLoadPage_global){
					//第一次打开时,收回左边的服务列表框
					$('#pageBorderLocal').click();
				}

				$serviceNodes.each(function(i){
					var $thisService = $(this);

					var bizServiceID = $thisService.find('>bizId').text();
					var runStateStr = $thisService.find('>monitered').text();
					if(runStateStr == null || runStateStr == ""){
						runStateStr = false;
					}

					var bizServiceNodeMap = {};
					bizServiceNodeMap["nodeID"] = bizServiceID;
					bizServiceNodeMap["label"] = $thisService.find('>name').text();
					bizServiceNodeMap["parentNodeID"] = "";
					bizServiceNodeMap["isDataNode"] = "false";
					var preElArrayBiz = new Array();
					preElArrayBiz.push('<span class="ico ico-policy" style="display:inline"/>');

					if(runStateStr == "true"){
						preElArrayBiz.push('<span class="state state-use" style="display:inline"/>');
					}else{
						preElArrayBiz.push('<span class="state state-unuse" style="display:inline"/>');
					}

					var menuObjBiz = new JDynamicToolMenu({id:"biztoolmenu-1", menuItemWidth:"110", btnClassName:"ico ico-t-right"});
					//将弹出菜单对象，存入集合
					menuObjBizArray.push(menuObjBiz);

					menuObjBiz.addMenuItem({menuID:"bizpopmenunode-1", label:"删除", icoClassName:"delete"}, null, function(dataMap){
						var confirmTopoFlag = false;
						//call flash 判断是否需要保存当前拓扑
						if(parent.rightFrame.contentArea_ifr.callSaveTopoFlag != null && parent.rightFrame.contentArea_ifr.callSaveTopoFlag != ""){
							confirmTopoFlag = parent.rightFrame.contentArea_ifr.callSaveTopoFlag();
						}
						if(confirmTopoFlag){
							var _confirm = top.confirm_box(confirmConfig);
							_confirm.setContentText("是否保存当前拓扑？"); //提示框
							_confirm.show();
							_confirm.setConfirm_listener(function() {
								_confirm.hide();
								//因为下面的删除操作会重新加载左边的服务树，所以保存拓扑的时候不能再刷新左边树了。
								requiredUpdateLeftGlobal = false;
								//call flash 保存拓扑
								parent.rightFrame.contentArea_ifr.saveTopo("${ctx}");

								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//删除服务
								f_deleteBizService("${ctx}/bizservice/"+bizServiceID);
							});
							_confirm.setCancle_listener(function(){
								_confirm.hide();

								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//删除服务
								f_deleteBizService("${ctx}/bizservice/"+bizServiceID);
							});
							_confirm.setClose_listener(function(){
								_confirm.hide();

								//设置不再需要提示保存
								requiredTipSaveGlobal = true;

							});
						}else{
							//设置不再需要提示保存
							requiredTipSaveGlobal = false;
							//删除服务
							f_deleteBizService("${ctx}/bizservice/"+bizServiceID);
						}
					});

					if(runStateStr == "true"){
						menuObjBiz.addMenuItem({menuID:"bizpopmenunode-2", label:"禁用", icoClassName:"verboten"}, null, function(dataMap){
							var confirmTopoFlag = false;
							//call flash 判断是否需要保存当前拓扑
							if(parent.rightFrame.contentArea_ifr.callSaveTopoFlag != null && parent.rightFrame.contentArea_ifr.callSaveTopoFlag != ""){
								confirmTopoFlag = parent.rightFrame.contentArea_ifr.callSaveTopoFlag();
							}
							if(confirmTopoFlag){
								var _confirm = top.confirm_box(confirmConfig);
								_confirm.setContentText("是否保存当前拓扑？"); //提示框
								_confirm.show();
								_confirm.setConfirm_listener(function() {
									_confirm.hide();
									//因为下面的设置状态操作会重新加载左边的服务树，所以保存拓扑的时候不能再刷新左边树了。
									requiredUpdateLeftGlobal = false;
									//call flash 保存拓扑
									parent.rightFrame.contentArea_ifr.saveTopo("${ctx}");

									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//禁用服务
									f_setBizServiceRunState(bizServiceID, "false");
								});
								_confirm.setCancle_listener(function(){
									_confirm.hide();

									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//禁用服务
									f_setBizServiceRunState(bizServiceID, "false");
								});
								_confirm.setClose_listener(function(){
									_confirm.hide();

									//设置不再需要提示保存
									requiredTipSaveGlobal = true;

								});
							}else{
								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//禁用服务
								f_setBizServiceRunState(bizServiceID, "false");
							}
						});
					}else{
						menuObjBiz.addMenuItem({menuID:"bizpopmenunode-2", label:"启用",  icoClassName:"apply"}, null, function(dataMap){
							var confirmTopoFlag = false;
							//call flash 判断是否需要保存当前拓扑
							if(parent.rightFrame.contentArea_ifr.callSaveTopoFlag != null && parent.rightFrame.contentArea_ifr.callSaveTopoFlag != ""){
								confirmTopoFlag = parent.rightFrame.contentArea_ifr.callSaveTopoFlag();
							}
							if(confirmTopoFlag){
								var _confirm = top.confirm_box(confirmConfig);
								_confirm.setContentText("是否保存当前拓扑？"); //提示框
								_confirm.show();
								_confirm.setConfirm_listener(function() {
									_confirm.hide();
									//因为下面的设置状态操作会重新加载左边的服务树，所以保存拓扑的时候不能再刷新左边树了。
									requiredUpdateLeftGlobal = false;
									//call flash 保存拓扑
									parent.rightFrame.contentArea_ifr.saveTopo("${ctx}");

									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//启用服务
									f_setBizServiceRunState(bizServiceID, "true");
								});
								_confirm.setCancle_listener(function(){
									_confirm.hide();

									//设置不再需要提示保存
									requiredTipSaveGlobal = false;
									//启用服务
									f_setBizServiceRunState(bizServiceID, "true");
								});
								_confirm.setClose_listener(function(){
									_confirm.hide();

									//设置不再需要提示保存
									requiredTipSaveGlobal = true;

								});
							}else{
								//设置不再需要提示保存
								requiredTipSaveGlobal = false;
								//启用服务
								f_setBizServiceRunState(bizServiceID, "true");
							}
						});
					}

					var lastElArrayBiz = new Array();
					lastElArrayBiz.push(menuObjBiz.getComponetHandle());
					//添加业务服务列表节点
					bizServiceTreeView.addTreeNode(bizServiceNodeMap, true, {bizID:bizServiceID,runState:runStateStr}, preElArrayBiz, lastElArrayBiz, function(dataMap){
						try{
							var theServiceIDTemp = dataMap["bizID"];
							var theServiceNodeIDTemp = dataMap["nodeID"];

							if(theServiceNodeIDTemp != serviceNodeIDGlobal){
								//展开处于展开状态的树节点,展开时会触发树节点的click事件.
								bizServiceTreeView.expanseNode(theServiceNodeIDTemp, true, true, null);
							}

							//设置当前业务服务运行状态
							serviceRunStateGlobal = bizServiceTreeView.getUserData(theServiceNodeIDTemp, "runState");
							//设置当前处于展开的业务服务ID
							serviceIDGlobal = theServiceIDTemp;
							//设置当前处于展开的NodeID
							serviceNodeIDGlobal = theServiceNodeIDTemp;

							//切换业务服务定义项目
							parent.rightFrame.f_bizServiceDefine("bizdefine", theServiceIDTemp);

							//切换左侧服务拓扑时,屏蔽服务列表树;右侧flash加载完成后会调用f_unLoadingServiceList取消屏蔽效果。
							if($loadingDivLeft_global != null && $loadingDivLeft_global.size() > 0){
								$loadingDivLeft_global.show();//显示左侧服务列表页面loading对象
								$loadingDivRight_global.show();//显示右侧页面loading对象
							}else{
								//创建左侧服务列表页面loading对象
								$loadingDivLeft_global = $("<div>").attr("id","middleElementLeft_bgDiv").css(
																											{
																												position:"absolute",
																												left:"0px",
																												top:"0px",
																												width:"238px", //$(window).width()+"px",
																												height:Math.max($("body").height(),$(window).height())+"px",
																												filter:"Alpha(Opacity=40)",
																												opacity:"0.4",
																												backgroundColor:"#AAAAAA",
																												zIndex:"1001",
																												margin:"0px",
																												padding:"0px"
																											}
																										);
								$loadingDivLeft_global.appendTo('body');
								//创建右侧页面loading对象
								$loadingDivRight_global = $("<div>").attr("id","middleElementRight_bgDiv").css(
																											{
																												position:"absolute",
																												left:"0px",
																												top:"0px",
																												width:$(parent.rightFrame.window).width()+"px",
																												height:Math.max($(parent.rightFrame.document.body).height(),$(parent.rightFrame.window).height())+"px",
																												filter:"Alpha(Opacity=40)",
																												opacity:"0.4",
																												backgroundColor:"#AAAAAA",
																												zIndex:"1001",
																												margin:"0px",
																												padding:"0px"
																											}
																										);
								$loadingDivRight_global.appendTo(parent.rightFrame.document.body);
							}
						}catch(e){
							//alert("服务加载中，请稍候。");
						}
					});

					//添加子业务服务列表节点
					var childBizSerRootNodeMap = {};
					var childBizRootID = "childBizService&&"+bizServiceID;
					childBizSerRootNodeMap["nodeID"] = childBizRootID;
					childBizSerRootNodeMap["label"] = "业务服务";
					childBizSerRootNodeMap["parentNodeID"] = bizServiceID;
					childBizSerRootNodeMap["isDataNode"] = "false";
					var preElArrayChildBiz = new Array();
					preElArrayChildBiz.push('<span class="ico ico-yingy" style="display:inline"/>');
					bizServiceTreeView.addTreeNode(childBizSerRootNodeMap, false, null, preElArrayChildBiz, null, null);

					var $subBizNodes = $thisService.find('>childBizServices>BizService');
					$subBizNodes.each(function(j){
						var $childService = $(this);
						var subBizIDTemp = $childService.find('>bizId').text();
						var childBizSerNodeMap = {};
						childBizSerNodeMap["nodeID"] = subBizIDTemp+"&&"+childBizRootID;
						childBizSerNodeMap["label"] = $childService.find('>name').text();
						childBizSerNodeMap["parentNodeID"] = childBizRootID;
						childBizSerNodeMap["isDataNode"] = "true";
						//添加子业务服务列表节点
						bizServiceTreeView.addTreeNode(childBizSerNodeMap, false, {bizID:subBizIDTemp}, null, null, null);
					});

					//添加资源列表节点
					var resourceRootNodeMap = {};
					var resourceRootID = "resource&&"+bizServiceID;
					resourceRootNodeMap["nodeID"] = resourceRootID;
					resourceRootNodeMap["label"] = "资源";
					resourceRootNodeMap["parentNodeID"] = bizServiceID;
					resourceRootNodeMap["isDataNode"] = "false";
					var preElArrayResource = new Array();
					preElArrayResource.push('<span class="tree-panel-ico tree-panel-ico-network"/>');
					bizServiceTreeView.addTreeNode(resourceRootNodeMap, false, null, preElArrayResource, null, null);

					var $resNodes = $thisService.find('>MonitableResources>MonitableResource');
					$resNodes.each(function(j){
						var $resource = $(this);
						var resourceIDTemp = $resource.find('>resourceInstanceId').text();
						var resourceNodeMap = {};
						resourceNodeMap["nodeID"] = resourceIDTemp+"&&"+resourceRootID;
						resourceNodeMap["label"] = $resource.find('>resourceName').text();
						resourceNodeMap["parentNodeID"] = resourceRootID;
						resourceNodeMap["isDataNode"] = "true";
						//添加资源列表节点
						bizServiceTreeView.addTreeNode(resourceNodeMap, false, {resourceID:resourceIDTemp}, null, null, null);
					});

					//添加业务单位列表节点
					var bizUserRootNodeMap = {};
					var bizUserRootID = "bizUser&&"+bizServiceID;
					bizUserRootNodeMap["nodeID"] = bizUserRootID;
					bizUserRootNodeMap["label"] = "业务单位";
					bizUserRootNodeMap["parentNodeID"] = bizServiceID;
					bizUserRootNodeMap["isDataNode"] = "false";
					var preElArrayBizUser = new Array();
					preElArrayBizUser.push('<span class="ico ico-person" style="display:inline"/>');
					bizServiceTreeView.addTreeNode(bizUserRootNodeMap, false, null, preElArrayBizUser, null, null);

					var $bizUserNodes = $thisService.find('>bizUsers>BizUser');
					$bizUserNodes.each(function(j){
						var $bizUser = $(this);
						var bizUserIDTemp = $bizUser.find('>id').text();
						var bizUserNodeMap = {};
						bizUserNodeMap["nodeID"] = bizUserIDTemp+"&&"+bizUserRootID;
						bizUserNodeMap["label"] = $bizUser.find('>name').text();
						bizUserNodeMap["parentNodeID"] = bizUserRootID;
						bizUserNodeMap["isDataNode"] = "true";
						//添加业务单位列表节点
						bizServiceTreeView.addTreeNode(bizUserNodeMap, false, {bizUserID:bizUserIDTemp}, null, null, null);
					});
				});//foreach 结束

				//点击所有树节点时，关闭掉弹出的菜单
				bizServiceTreeView.allNodeClick(function(){
					for(var menuCnt=0; menuCnt<menuObjBizArray.length; menuCnt++){
						menuObjBizArray[menuCnt].close();
					}
				});
				bizServiceTreeView.allExpanseNode(function(){
					for(var menuCnt=0; menuCnt<menuObjBizArray.length; menuCnt++){
						menuObjBizArray[menuCnt].close();
					}
				});

				//触发树节点的click事件.
				bizServiceTreeView.expanseNode(serviceNodeIDGlobal, true, true, null);

				$('#jAccordionRoot').append(bizServiceTreeView.getComponetHandle());
				var scrollWidthTemp = $('#jAccordionRoot').get(0).scrollWidth;
				bizServiceTreeView.setAvailWidth(scrollWidthTemp+25);

			}//if($serviceNodes.size() == 0) else 结束

		});//ajax 结束
	}

	/**
	* 屏蔽页面服务列表loading div
	*/
	function f_unLoadingServiceList(){
		if($loadingDivLeft_global != null && $loadingDivLeft_global != "undefined"){
			$loadingDivLeft_global.hide();//屏蔽左侧服务列表页面loading
			$loadingDivRight_global.hide();//屏蔽右侧页面loading
		}
	}
	function f_loadingServiceList(){
		if($loadingDivLeft_global != null && $loadingDivLeft_global != "undefined"){
			$loadingDivLeft_global.show();//屏蔽左侧服务列表页面loading
			$loadingDivRight_global.show();//屏蔽右侧页面loading
		}
	}
	/**
	* 删除业务服务
	* param String uri
	*/
	function f_deleteBizService(uri){
		$loadingDivLeft_global.show();
		$loadingDivRight_global.show();

		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("是否确定删除此业务服务？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
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
						var _information  = top.information();
						_information.setContentText(errorInfo);
						_information.show();
						//alert(errorInfo);
						//field.focus();
						f_unLoadingServiceList();
					});
				},
				success: function(msg){
					f_readLeftPanel("");
				}
			});
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
			f_unLoadingServiceList();
		});
		_confirm.setClose_listener(function(){
			_confirm.hide();
			f_unLoadingServiceList();
		});
	}

	/**
	*设置业务服务启用状态
	* param String serviceID
	* param String runState(true/false)
	*/
	function f_setBizServiceRunState(serviceID, runState){
		$loadingDivLeft_global.show();
		$loadingDivRight_global.show();

		if(runState == "true"){
			// && bizServiceRunCount >= bizServiceOperateCount
			//执行AJAX请求,获取当前所有定义的业务服务列表.
			$.get('${ctx}/bizservice/snapshot.xml',{},function(data){
				var bizServiceRunCount = 0;
				var $serviceNodes = $(data).find('BizServices:first>BizService');//.not('[reference]');
				$serviceNodes.each(function(i){
					var $thisService = $(this);

					var runStateStr = $thisService.find('>monitered').text();
					if(runStateStr == null || runStateStr == ""){
						runStateStr = false;
					}
					if(runStateStr == "true"){
						bizServiceRunCount++;
					}
				});
				if(bizServiceRunCount >= bizServiceOperateCount){
					var _information  = top.information();
					_information.setContentText("产品监控的业务服务数量已超过限额，请联络摩卡软件获取购买支持更多数量License的信息。");
					_information.show();
					//alert("产品监控的业务服务数量已超过限额，请联络摩卡软件获取购买支持更多数量License的信息。");
					f_unLoadingServiceList();
					return false;
				}else{
					//执行设置业务服务启用状态
					f_execSetRun(serviceID, runState);
				}
			});
		}else{
			//执行设置业务服务启用状态
			f_execSetRun(serviceID, runState);
		}
	}
	/**
	* 执行设置业务服务启用状态
	* param String serviceID
	* param String runState(true/false)
	*/
	function f_execSetRun(serviceID, runState){
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

						var _information  = top.information();
						_information.setContentText(errorInfo);
						_information.show();
						//alert(errorInfo);
						//field.focus();
						f_unLoadingServiceList();
					});
			  },
			  success: function(msg){
				  f_readLeftPanel(serviceID);//serviceIDGlobal
			  }
		});
	}

	/**
	* 展开某个业务服务树节点
	* @param String bizServiceId (业务服务ID)
	*
	*/
	function f_expanseBizServAccorSlab(bizServiceId){
		bizServiceTreeView.nodeClick(expanseNodeID);
	}
	/**
	* 触发左边服务列表框的click事件
	*
	*/
	function f_clickLeftBar(){
		$('#pageBorderLocal').click();
	}
</script>
</head>
<body>
		<!--左侧推拉框组件-->
		<div id='standardAccordionHull' style="left:0px;min-height:100%;height:100%;">
			<div id='standardAccordionHullTitle' class='left-panel-open' style="min-height:100%;height:100%;">
				<div class='left-panel-l'>
					<div class='left-panel-r ui-dialog-titlebar'>
						<div id='accordionDragHandle' class='left-panel-m'>
							<span class='left-panel-title'>业务服务定义</span>
						</div>
					</div>
				</div>
				<div class='left-panel-content' style="min-height:89%;height:89%;">
					<div class="add-button1" style="width:98%">
						<a id="daohang" href="#"><img src="${ctx}/images/navigation/gou.gif" width="14.5" height="14.5" title="业务服务导航" style="position:absolute;top:3px;right:30px"/></a>
						<a id="addBiz-h" href="#"><img src="${ctx}/images/add-button1.gif" title="添加业务服务"/></a>
					</div>
					<div id='jAccordionRoot' style="margin-top:10px;height:94%;overflow:auto;"></div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--左侧推拉框线-->
		<div id="pageBorderPanel" class="bar" style="position:absolute;top:0px;left:230px;min-height:100%;height:100%;">
		  <p id="pageBorderLocal" class="bar-left"></p>
		</div>
</body>
</html>
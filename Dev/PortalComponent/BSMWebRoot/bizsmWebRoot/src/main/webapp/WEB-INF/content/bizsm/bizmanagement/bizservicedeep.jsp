<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务总揽
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-deep
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.mocha.bsm.bizsm.core.util.LicenseUtil"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />

<%
	String serviceID = request.getParameter("serviceId");

	String showNetfocus = String.valueOf(LicenseUtil.iNetfocus());
	String showRoom = String.valueOf(LicenseUtil.iRoomMon());
%>
<title>业务服务分析</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/jquery-ui/jquery.ui.treeview.css"  rel="stylesheet" type="text/css" />

<style type="text/css" media="screen">
	html,body{height:100%;}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion-1.1.js"></script>


<script src="${ctx}/js/component/treeView/j-dynamic-treeview-1.2.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>

<script language="javascript">

	var serviceNodeIDGlobal = ""; //当前处于选中状态的NodeID
	var serviceRunStateGlobal = "false"; //当前业务服务运行状态(启用/停用)

	var bizServiceTreeView = null; //业务服务树形组件对象

	var currentServiceID_global = "<%=serviceID%>";

	var showNetfocus_js = "<%=showNetfocus%>"; //是否购买了netfocus license
	var showRoom_js = "<%=showRoom%>";//是否购买了机房 license

	$(function() {

		//初始化左边业务服务列表box样式
		$("#standardAccordionHull #standardAccordionHullTitle").css("width", "235px");

		$("#standardAccordionHull #standardAccordionHullBottom").css("width", "235px");

		$("#standardAccordionHull #jAccordionRoot").css("height", "100%");
		$("#standardAccordionHull #jAccordionRoot").css("overflow", "auto");

		$('#topTool_Td').attr("width", "243px");


		//为左边导航添加推拉效果
		$('#pageBorderLocal').toggle(function(event){
				var $thisLocal = $(this);
				$('#pageBorderPanel').animate({
					left:0
				},0, function(){
					$thisLocal.removeClass("bar-left");
					$thisLocal.addClass("bar-right");
				});

				$('#standardAccordionHull').animate({
					width:0,
					opacity:1
				},0);

				$('#topTool_Td').animate({
					width:"8px"
				},0);
		}, function(event){
				var $thisLocal = $(this);

				$('#topTool_Td').animate({
					width:"243px"
				},0);

				$('#standardAccordionHull').animate({
					width:235,
					opacity:1
				},0);

				$('#pageBorderPanel').animate({
					left:235
				},0, function(){
					$thisLocal.removeClass("bar-right");
					$thisLocal.addClass("bar-left");
				});
		});


		//button area
		//$('input[type="button"]').css("cursor", "hand");
		$('#topBtnPanel>ul>li').click(function(){
			var $this = $(this);

			var srcURI = "";
			var btnID = $this.attr("id");
			if(btnID == "viewAll_btn"){
				srcURI = "${ctx}/bizsm/bizservice/ui/bizservice-overall?moduleName=listView";
			}else if(btnID == "aracitecture_btn"){
				srcURI = "${ctx}/bizsm/bizservice/ui/bizservice-manage";
			}else if(btnID == "affect_btn"){
				srcURI = "${ctx}/bizsm/bizservice/ui/bizservice-overall?moduleName=influence";
			}else if(btnID == "analysis_btn"){
				srcURI = "${ctx}/bizsm/bizservice/ui/bizservice-single-analysis";
			}else if(btnID == "bill_btn"){
				srcURI = "${ctx}/bizsm/bizservice/ui/bizservice-affect";
			}else if(btnID == "topo_btn"){
				//srcURI = "/netfocus/modules/3rd/nf_for_service.jsp?serviceId="+currentServiceID_global+"&domainId=-1";
				if(showNetfocus_js == "true"){
					srcURI = "/netfocus/modules/3rd/nf_for_service.jsp?serviceId="+currentServiceID_global+"&domainId=-1";
				}else{
					return false;
				}
			}else if(btnID == "room_btn"){
				if(showRoom_js == "true"){
					srcURI = "${ctx}/bizsm/bizservice/ui/bizmanagement-roomplugin?serviceId="+currentServiceID_global;
				}else{
					return false;
				}
				//srcURI = "${ctx}/bizsm/bizservice/ui/bizmanagement-roomplugin?serviceId="+currentServiceID_global;
				//srcURI = "/pureportal/roomDefine/BizsmAction.action?serviceId="+currentServiceID_global;
			}else if(btnID == "warnAlert_btn"){
				srcURI = "${ctx}/bizsm/bizservice/ui/bizservice-alarm?serviceId="+currentServiceID_global;
			}

			$('#topBtnPanel>ul>li.focus').removeClass("focus");
			$(this).addClass("focus");

			$('#contentArea_ifr').attr("src", srcURI);
		});


		//返回按钮 click
		$('#back_btn').css("cursor", "hand").click(function(){
			//window.location.href = "${ctx}/bizsm/bizservice/ui/bizservice-overview";
			var toolbarObj = parent.document.all.leftFrame.contentWindow.vToolbar;
			toolbarObj.pressItem("item5");
		});


		f_readLeftPanel(currentServiceID_global);
	});

	/**
	*读取左边业务服务列表
	*param String selectedNodeID 需要展开的树节点ID
	*
	*/
	function f_readLeftPanel(selectedNodeID){

		//初始化全局变量
		//设置当前处于展开的NodeID
		serviceNodeIDGlobal = "";
		serviceRunStateGlobal = "false"; //当前业务服务运行状态(启用/停用)

		var expanseNodeID = selectedNodeID;
		if(selectedNodeID == null || selectedNodeID == ""){
			expanseNodeID = "first";
		}

		$('#standardAccordionHull #jAccordionRoot').empty();

		//执行AJAX请求,获取当前所有定义的业务服务列表. //bizservice/.xml
		$.get('${ctx}/bizservice/.xml',{},function(data){

			var $serviceNodes = $(data).find('BizServices:first>BizService');//.not('[reference]');
			if($serviceNodes.size() == 0){
			}else{
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

					//var monitoredStateStr = $thisService.find('>monitoredState').text();
					//alert("get1");
					var monitoredStateStr = f_readServiceState(bizServiceID);
					//alert("get2");

					var preElArrayBiz = new Array();
					preElArrayBiz.push('<span class="ico ico-policy" style="display:inline"/>');
					if(runStateStr == "true"){
						if(monitoredStateStr == "SERIOUS"){
							preElArrayBiz.push('<span class="lamp lamp-red" style="display:inline"/>');
						}else if(monitoredStateStr == "WARNING"){
							preElArrayBiz.push('<span class="lamp lamp-yellow" style="display:inline"/>');
						}else if(monitoredStateStr == "NORMAL"){
							preElArrayBiz.push('<span class="lamp lamp-green" style="display:inline"/>');
						}else if(monitoredStateStr == "UNKNOWN"){
							preElArrayBiz.push('<span class="lamp lamp-gray" style="display:inline"/>');
						}
					}else{
						preElArrayBiz.push('<span class="state state-unuse" style="display:inline"/>');
					}

					//添加业务服务列表节点
					bizServiceTreeView.addTreeNode(bizServiceNodeMap, true, {bizID:bizServiceID,runState:runStateStr}, preElArrayBiz, null, function(dataMap){
						var theServiceIDTemp = dataMap["bizID"];
						var theServiceNodeIDTemp = dataMap["nodeID"];

						if(theServiceNodeIDTemp != serviceNodeIDGlobal){
							//展开处于展开状态的树节点,展开时会触发树节点的click事件.
							bizServiceTreeView.expanseNode(theServiceNodeIDTemp, true, true, null);
						}

						//设置当前业务服务运行状态
						serviceRunStateGlobal = bizServiceTreeView.getUserData(theServiceNodeIDTemp, "runState");
						//设置当前处于展开的NodeID
						serviceNodeIDGlobal = theServiceNodeIDTemp;

						//设置当前处于展开的业务服务ID
						currentServiceID_global = theServiceIDTemp;

						$('#topBtnPanel>ul>li[id="viewAll_btn"]').click();

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
				});

				if(expanseNodeID == "first"){
					expanseNodeID = currentBizID;
				}

				//触发树节点的click事件.
				bizServiceTreeView.nodeClick(expanseNodeID);

				$('#jAccordionRoot').append(bizServiceTreeView.getComponetHandle());

				var scrollWidthTemp = $('#jAccordionRoot').get(0).scrollWidth;
				bizServiceTreeView.setAvailWidth(scrollWidthTemp+25);

			}
			//设置当前处于展开的NodeID
			serviceNodeIDGlobal = expanseNodeID;

			$('#topBtnPanel>ul>li[id="viewAll_btn"]').click();
		});
	}

	/**
	* 读取服务状态值
	* param bizServiceID
	* return bizServiceState
	*/
	function f_readServiceState(bizServiceID){
		var result = "";
		$.ajax({
			  type: 'Get',
			  url: "${ctx}/bizservice/"+bizServiceID+"/bizservicestate/.xml",
			  contentType: "application/xml",
			  data: "",
			  dataType:"xml",
			  processData: false,
			  beforeSend: function(request){
				  httpClient = request;
			  },
			  cache:false,
			  async:false,
			  error: function (request){},
			  success: function(data){
				 //alert(data);
				 result = $(data).find('BizServiceState').text();
			  }
		});
		return result;
	}
</script>
</head>
<body>
<div id='standardAccordionHull' style="position:absolute;top:5px;left:0px;width:275px;z-index:101;min-height:100%;height:100%;">
	<div id='standardAccordionHullTitle' class='left-panel-open' style="min-height:100%;height:100%;">
		<div class='left-panel-l'>
			<a id="back_btn" class="ico-jump" title="返回"></a>
			<div class='left-panel-r ui-dialog-titlebar'>
				<div id='accordionDragHandle' class='left-panel-m'>
					<span class='left-panel-title'>业务服务</span>
				</div>
			</div>
		</div>
		<div class='left-panel-content' style="min-height:80%;height:80%;">
			<div id='jAccordionRoot'></div>
		</div>
		<div id='standardAccordionHullBottom' class='left-panel-close' style="min-height:15%;height:15%;">
			<div class='left-panel-l'>
				<div class='left-panel-r'>
					<div class='left-panel-m'><span class='left-panel-title'></span></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="pageBorderPanel" class="bar" style="position:absolute;top:5px;left:235px;min-height:100%;height:100%;z-index:101;">
  <p id="pageBorderLocal" class="bar-left"></p>
</div>

<table height="100%" border="0">
	<tr>
		<td id="topTool_Td">
			&nbsp;
		</td>
		<td>
			<!--按钮群 -->
			<div id="topBtnPanel" class="business-tab">
				<ul class="business-tab">
					<li id="viewAll_btn" class="focus"><span></span><a href="#">总览</a></li>
					<li id="affect_btn"><span></span><a href="#">影响</a></li>
					<li id="analysis_btn"><span></span><a href="#">分析</a></li>
					<%if(showNetfocus.equals("true")){%>
						<li id="topo_btn"><span></span><a href="#">拓扑</a></li>
					<%}else{%>
						<li id="topo_btn"><span></span><a href="#" disabled title="无拓扑License，请联络摩卡软件获取购买相关License的信息。">拓扑</a></li>
					<%}%>
					<%if(showRoom.equals("true")){%>
						<li id="room_btn"><span></span><a href="#">机房</a></li>
					<%}else{%>
						<li id="room_btn"><span></span><a href="#" disabled title="无机房License，请联络摩卡软件获取购买相关License的信息。">机房</a></li>
					<%}%>
					<li id="warnAlert_btn"><span></span><a href="#">告警</a></li>
				</ul>
			  <div class="clear"></div>
			</div>
		</td>
	</tr>
	<tr height="100%" style="min-height:100%;height:100%;">
		<td width="243px">
		</td>
		<td height="100%">
			<iframe id="contentArea_ifr" frameborder="NO" border="0" scrolling="NO" noresize framespacing="0" style="width:100%; height:88%"></iframe>
		</td>
	</tr>
</table>

</body>
</html>
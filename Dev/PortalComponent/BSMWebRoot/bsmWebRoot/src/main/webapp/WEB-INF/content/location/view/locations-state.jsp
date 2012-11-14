<!-- WEB-INF\content\location\view\locations-state.jsp -->
<html style="height:100%;background:url(${ctx}/images/m-l-bg.png) repeat 0px 0px;">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
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
<link href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/portal02.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" />
<link href="${ctx}/flash/history/history.css" />
<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
</head>
<body  style="height:100%;background:url(${ctx}/images/m-l-bg.png) repeat 0px 0px;">
<div style="color:#FFF">
<s:set name="treeName" value="'LocationTree'"/>
<s:if test="!locations.isEmpty()">
	<s:bean var="nodeStyle" name="com.mocha.bsm.action.location.define.util.LoctionStateStyle"/>
	<s:bean var="treeHelper" name="com.mocha.bsm.action.location.define.util.LocationTreeHelper">
		<s:param name="nodeStyle" value="#nodeStyle"/>
		<s:property value="getTreeHtml(#treeName,locations)" escape="false"/>
	</s:bean>
</s:if>
<s:else>
		<span>没有物理位置</span>
</s:else>
</div>

<script type="text/javascript">
var tree;
$(document).ready(function () {

	// 指定树的事件
	tree = new Tree({id:"${treeName}",currentColor:"#FF0",color:"#FFF",
					listeners:{
						  nodeClick:function(node){
							 
							  window.parent.loadLocationContent(node.getId());
							  
						  }
					}}); 
				
		$(".light-ico.light-ico-red").attr("style","cursor:pointer;");
		$(".light-ico.light-ico-red").click(function(){
			var locationId=this.parentNode.nodeid;
			
			var r_value = window.showModalDialog("${ctx}/location/status/locationStatus!findStatusList.action?LocationStatusKey=red&locationId="+locationId,window,"help=no;status=no;scroll=no;center=yes;dialogWidth="+dwidth+"px;dialogHeight=500px");
			/*
			panel = new winPanel({
		        url:"${ctx}/location/status/locationStatus!findStatusList.action?LocationStatusKey=red&locationId="+locationId,
		        width:830,
		        x:200,
		        y:30,
		        isDrag:false,
				isautoclose:true
			},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
			*/
		})
		
		var root = tree.getRoot();
		var node = root.getFirstChild();
		if(node){
			node.click();
			setCurrentNode(node.getId());
			window.parent.loadFlash();
			window.parent.loadRelContent();
		}
		
		
		
});
// 设置默认选中节点
function setCurrentNode(locationId){
	tree.getNodeById(locationId).setCurrentNode();
}
</script>
</body>
</html>

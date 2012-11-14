<!-- WEB-INF\content\location\define\define.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<input type="hidden" id="location_flashchangeflag" value="0" >
<page:applyDecorator name="headfoot">
 	<page:param name="body">
 	
 	<div id="totalDivId" style="height:670px;" class="main-jk">
		<!-- 位置定义页面 -->
		<div class="ui-layout-west main-jk-left" id="locations" style="height:100%"></div>
		<!-- 位置定义操作页面 -->
		<div id="uiMain" class="ui-layout-center main-jk-left" style="height:100%">
			<!-- 位置定义操作页面 -->
			<div id="handles"></div>   
			<!-- 位置定义操作页面详细页面 -->
			<div id="content"></div>
		</div>
 	</div>
	</page:param>
</page:applyDecorator>
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
<script src="${ctxJs}/jquery.blockUI.js" ></script>
<script src="${ctxJs}/jquery.select.js"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js" type="text/javascript" ></script>
<script src="${ctxJs}/component/treeView/tree.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/cirgrid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/gridPanel/page.js"></script>
<script src="${ctxJs}/component/panel/panel.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/component/menu/menu.js"></script>
<script src="${ctxJs}/location/define/locations.js"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript">
	function mainWidth(){
		var wid=document.getElementById("uiMain").style.width;
		return wid.substring(0,wid.length-2);
	}
	var mc;
	$(document).ready(function () {
		mc = new MenuContext({x:500,y:500,listeners:{click:function(id){alert(id)}}},{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});
		/**
		var myLayout = $('#totalDivId').layout({
			//	enable showOverflow on west-pane so popups will overlap north pane
			west__showOverflowOnHover: true
		//	reference only - these options are NOT required because are already the 'default'
		,	closable:				true	// pane can open & close
		,	resizable:				true	// when open, pane can be resized 
		,	slidable:				true	// when closed, pane can 'slide' open over other panes - closes on mouse-out
		//	some pane-size settings
		,   west__size:				210
		,	west__minSize:			100
		,   west__spacing_open:8
		,   west__spacing_closed:8
		,   west__togglerLength_open:36
		,   west__togglerLength_closed:36
		,	east__size:				300
		,	east__minSize:			200
		,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
		});
		*/
		myLayout = $('#totalDivId').layout({

	//	enable showOverflow on west-pane so popups will overlap north pane
		west__showOverflowOnHover: false
	//	reference only - these options are NOT required because are already the 'default'
	,	closable:				true	// pane can open & close
	,	resizable:				true	// when open, pane can be resized 
	,	slidable:				true	// when closed, pane can 'slide' open over other panes - closes on mouse-out

	//	some resizing/toggling settings
	,	north__slidable:		false	// OVERRIDE the pane-default of 'slidable=true'
	,	north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
	,   north__closable:        false
	,	north__spacing_closed:	0		// big resizer-bar when open (zero height)
	,   north__spacing_open:0
	,	south__resizable:		false	// OVERRIDE the pane-default of 'resizable=true'
			// no resizer-bar when open (zero height)
	,	south__spacing_closed:	8		// big resizer-bar when open (zero height)
	,   south__spacing_open:8
	,   south__togglerLength_open:10
	,   south__togglerLength_closed:10
	//	some pane-size settings
	,   west__size:				215
	,	west__minSize:			100
	,   west__spacing_open:8
	,   west__spacing_closed:8
	,   west__togglerLength_open:36
	,   west__togglerLength_closed:36
	,	east__size:				300
	,	east__minSize:			200
	,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
	});
//alert(Math.floor(screen.availWidth / 2));
		// 加载物理位置页面,之后再加载处理页面
		loadLocations(loadHandles);
	});
</script>

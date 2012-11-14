<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<script type="text/javascript">
	var path = '${ctx}';
	var ctxFlash = "${ctxFlash}";
</script>
<page:applyDecorator name="headfoot">
	<link rel="stylesheet" href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="${ctxCss}/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
	<link rel="stylesheet" href="${ctxCss}/public.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/master.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/jquery-ui/treeview.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/UIComponent.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/tongjifenxi.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/topn.css" type="text/css" />
	

	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>  
	<script type="text/javascript" src="${ctxJs}/report/history/history.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.timeentry.min.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
	<script type="text/javascript" src="${ctxJs}/report/history/tools.js"></script>
	<script type="text/javascript" src="${ctxJs}/AnyChart.js"></script> 
	<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
	
	
	<page:param name="body">
	<div id="totalDivId" style="height:100%">
		<!-- 历史分析资源树页面 -->
		<div id="panel" class="ui-layout-west" style="float:left;width:22%;clear: both;overflow-x:hidden;overflow-y:hidden">
			<div class="left-panel-open" id="leftId">
			   <div class="left-panel-l" id="leftpanelId">
			    <div class="left-panel-r">
			     <div class="left-panel-m">
			      <span class="left-panel-title">历史分析</span>
			     </div> 
			    </div>
			 </div>
			 <div class="left-panel-content" style="height:100%">
			 		<page:applyDecorator name="accordionInerPanel">  
                         <page:param name="id">innerpanel</page:param>
                         <page:param name="width">210px</page:param>
                         <page:param name="height">100%</page:param>
                         <page:param name="currentIndex">0</page:param>
                         <page:param name="panelIndex_0">0</page:param>
                         <page:param name="panelIndex_1">1</page:param>
                         <page:param name="panelIndex_2">2</page:param>
                         <page:param name="panelTitle_0">TOP10分析</page:param>
                         <page:param name="panelIco_0">tree-panel-ico</page:param>
                         <page:param name="panelTitle_1">故障分析</page:param>
                         <page:param name="panelIco_1">tree-panel-ico</page:param>
                         <page:param name="panelTitle_2">对比分析</page:param>
                         <page:param name="panelIco_2">tree-panel-ico</page:param>
                         <page:param name="panelContent_0">
                         	  <div id="TopDiv">
                              		<s:action name="leftTree!getTop10TreeList" namespace="/report/history" executeResult="true" flush="false" ></s:action>
                         	  </div>
                         </page:param>                    
                         <page:param name="panelContent_1">
                         	  <div id="MalfunctionDiv">
                         	  </div>	
                         </page:param>
                         <page:param name="panelContent_2">
                         	  <div id="ComparisonDiv">
                         	  </div>	
                         </page:param> 
                  </page:applyDecorator>
			 </div>
			</div>
      	</div>
      	<!-- 详细内容 -->
      	<div class="ui-layout-center">
	      	<div id="no" style="font-size:45px;font-weight:700;width:300px;margin:150px auto;">未创建视图</div>
			<div id="have" style="display:none" style="height:100%" >
				<div id="content">
			   		<s:action name="historyContentAction!displayContent" namespace="/report/history" executeResult="true" flush="false" >
			   			<s:param name="analysisView.id"><s:property value="analysisView.id" /></s:param>
			   		</s:action>
				</div>
			</div>
		</div>
	</div>
	</page:param>
</page:applyDecorator>

<script type="text/javascript">
$(function(){
	// this layout could be created with NO OPTIONS - but showing some here just as a sample...
	// myLayout = $('body').layout(); -- syntax with No Options

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
	,   west__size:				230
	,	west__minSize:			100
	,   west__spacing_open:8
	,   west__spacing_closed:8
	,   west__togglerLength_open:36
	,   west__togglerLength_closed:36
	,	east__size:				400
	,	east__minSize:			200
	,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
	});
	
});
$(document).ready(function(event) {
	$("#innerpanel").height(document.body.clientHeight-130);
	$("#content").height(document.body.clientHeight-130);
	$("#leftId").width(230);
	new AccordionMenu({id:"innerpanel",listeners:{
		expend:function(index){
			if(index=="0"){
				$("#MalfunctionDiv").html("");
				$("#ComparisonDiv").html("");
				//change("/report/history/leftTree!getTop10TreeList.action","","#TopDiv");
				$.loadPage("TopDiv", path+"/report/history/leftTree!getTop10TreeList.action", "POST", "", function(){
					initTree();
					setFirstNode();
				});
			}
			if(index=="1"){
				$("#TopDiv").html("");
				$("#ComparisonDiv").html("");
				//change("/report/history/leftTree!getTroubleTreeList.action","","#MalfunctionDiv");
				$.loadPage("MalfunctionDiv", path+"/report/history/leftTree!getTroubleTreeList.action", "POST", "", function(){
					initTree();
					setFirstNode();
				});
			}
			if(index=="2"){
				$("#TopDiv").html("");
				$("#MalfunctionDiv").html("");
				//change("/report/history/leftTree!getContrastTreeList.action","","#ComparisonDiv");
				$.loadPage("ComparisonDiv", path+"/report/history/leftTree!getContrastTreeList.action", "POST", "", function(){
					initTree();
					setFirstNode();
				});
			}
		}}
	},{accordionMenu_DomStruFn:"inner_accordionMenu_DomStruFn",accordionMenu_DomCtrlFn:"inner_accordionMenu_DomCtrlFn"});
	initTree();
	contentInit();
	contentDataInit();
});
$(window).resize(function(){
		var conf = $("#innerpanel");
		var cutHeight = conf.cutHeight ? conf.cutHeight:60;
		accordionResize("innerpanel",cutHeight);
	});
 function accordionResize(panelId, otherHeight){
	if(null != panelId){
		//当页面改变大小时 修改左侧panel的整体高度
		var cutHeight = otherHeight ? otherHeight:60;
		var t_panel = $("#"+panelId);
		var height =  document.body.offsetHeight - 15;

		t_panel.height(height-cutHeight);
		var $panels = t_panel.children("div");
		var panelsCount = $panels.length;
		var contentHeight = 41+(panelsCount-1)*30;
		var cHeight = height-90-contentHeight-24;
		for(var i=0; i<panelsCount; i++){
			var $item = $($panels[i]);
			var $content = $item.children("div:last");
			$content.height(cHeight);

		}
	}
}
</script>



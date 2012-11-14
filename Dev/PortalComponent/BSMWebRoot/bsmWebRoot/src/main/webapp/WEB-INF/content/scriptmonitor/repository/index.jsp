<!-- WEB-INF\content\scriptmonitor\repository\index.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<page:applyDecorator name="headfoot">
	<page:param name="head">
	<link rel="stylesheet" href="${ctxCss}/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
	<link rel="stylesheet" href="${ctxCss}/public.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${ctxCss}/master.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/jquery-ui/treeview.css" type="text/css" />
	<link rel="stylesheet" href="${ctxCss}/UIComponent.css" type="text/css" />
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script> 
	<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>	  
	<script type="text/javascript" src="${ctxJs}/scriptmonitor/scriptRepositorys.js"></script>
	<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
	<script type="text/javascript" src="${ctx}/js/scriptmonitor/modolExtension.js"></script>
	<script type="text/javascript" src="${ctx}/js/scriptmonitor/modelWindow.js"></script>
	</page:param>
 	<page:param name="body">
	<div class="loading" id="loading" style="display:none;">
	 <div class="loading-l">
	  <div class="loading-r">
	    <div class="loading-m">
	       <span class="loading-img">正在执行，请稍候...</span> 
	    </div>
	  </div>
	  </div>
	</div>  	
	<!-- 脚本库及分类显示 -->
	  <s:if test="#canEdit == false">
	  	<div id="totalDivId" style="height:100%;overflow:auto;" class="main-jk">
		 <div class="ui-layout-west main-jk-left" id="layoutwestId">
			 <page:applyDecorator name="accordionLeftPanel">
				<page:param name="id">resourceOrProfile</page:param>
				<page:param name="width">100%</page:param>
				<page:param name="height">100%</page:param>
				<page:param name="currentIndex">0</page:param>
				<page:param name="panelIndex_0">0</page:param>
				<page:param name="panelTitle_0">脚本监控</page:param>
				<page:param name="panelContent_0">  
					<page:applyDecorator name="accordionInerPanel">  
			                <page:param name="id">innerpanel</page:param>
			                <page:param name="width">99%</page:param>
			                <page:param name="height">100%</page:param>
			                <page:param name="currentIndex">0</page:param>
			                <page:param name="panelIndex_0">0</page:param>
			                <page:param name="panelTitle_0">脚本监控</page:param>
			                <page:param name="panelIco_0">tree-panel-ico tree-panel-ico-link</page:param>
			                <page:param name="panelContent_0">
			                </page:param>                    
					</page:applyDecorator>
    				</page:param>
		 	</page:applyDecorator>
					  	<div class="clear"></div>
		</div>
		<div class="ui-layout-center main-jk-right" id="content" style="height:auto;"></div>
		</div>
	  </s:if>
	  <s:else>
	  <div id="totalDivId" style="height:100%;overflow:auto;" class="main-jk">
		 <div class="ui-layout-west main-jk-left" id="layoutwestId">
			 <page:applyDecorator name="accordionLeftPanel">
				<page:param name="id">resourceOrProfile</page:param>
				<page:param name="width">100%</page:param>
				<page:param name="height">100%</page:param>
				<page:param name="currentIndex">0</page:param>
				<page:param name="panelIndex_0">0</page:param>
				<page:param name="panelTitle_0">脚本监控</page:param>
				<page:param name="panelContent_0">  
					<page:applyDecorator name="accordionInerPanel">  
			                <page:param name="id">innerpanel</page:param>
			                <page:param name="width">99%</page:param>
			                <page:param name="height">100%</page:param>
			                <page:param name="currentIndex">0</page:param>
			                <s:if test="canEdit">
			                <page:param name="panelIndex_0">0</page:param>
			                <page:param name="panelIndex_1">1</page:param>
			                <page:param name="panelIndex_2">2</page:param>
			                <page:param name="panelTitle_0">脚本库</page:param>
			                <page:param name="panelIco_0">tree-panel-ico tree-panel-ico-group</page:param>
			                <page:param name="panelTitle_1">模型扩展</page:param>
			                <page:param name="panelIco_1">tree-panel-ico</page:param>
			                <page:param name="panelTitle_2">脚本监控</page:param>
			                <page:param name="panelIco_2">tree-panel-ico tree-panel-ico-link</page:param>
			                <page:param name="panelContent_0">
			                	<div class="add-button1"><img id="addImg" src="${ctxImages}/add-button1.gif" style="padding-right:10px;cursor:hand;"  border="0" title="新建脚本库" /></div>
			               		<div id="scriptRepository" style="height:380px;width:180px;">
			                    	<s:action name="scriptRepository!scriptRepostiorys" namespace="/scriptmonitor/repository" executeResult="true" flush="false"></s:action>
			                    </div>
			                </page:param>
			                </s:if>
			                <s:else>
			                	 <page:param name="panelIndex_0">0</page:param>
 								 <page:param name="panelTitle_0">脚本监控</page:param>
			               		 <page:param name="panelIco_0">tree-panel-ico tree-panel-ico-link</page:param>
			               		 <page:param name="panelContent_0">
			                	</page:param>
			                </s:else>
			                <page:param name="panelContent_1">
			                	<div id="models" style="height:100%;width:180px;overflow:auto">
			                	</div>
			                </page:param>
			                <page:param name="panelContent_2">  
			                </page:param>
					</page:applyDecorator>
    				</page:param>
		 	</page:applyDecorator>
				
					  	<div class="clear"></div>
			
		</div>
		<div class="ui-layout-center main-jk-right" id="content" style="height:auto;">
		</div>
		</div>
		</s:else>
		<!-- 详细内容 -->
	  
	</page:param>
</page:applyDecorator>
			<script type="text/javascript">
	var $scriptRepository, $models, $content;
	function clearHTML(){
		$scriptRepository.find("*").unbind();
		$scriptRepository.html("");
		$models.find("*").unbind();
		$models.html("");
		$content.find("*").unbind();
		$content.html("");
	}
	var mc;
	$(document).ready(function () {
		<s:if test="canEdit">
	 	$("#addImg").click(addScriptRepostiory);
	 	</s:if>
		mc = new MenuContext({x:500,y:500,listeners:{click:function(id){alert(id)}}},{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});
		
		$scriptRepository = $("#scriptRepository");
		$models = $("#models");
		$content = $("#content");
		
		new AccordionMenu({
	        id: "innerpanel",
	        listeners: {
	            expend: function(index) {
	            		<s:if test="canEdit">
	            			$.blockUI({message:$('#loading')});
		            		if (index == "0") {
			                	$.loadPage($scriptRepository,
			                			"${ctx}/scriptmonitor/repository/scriptRepository!scriptRepostiorys.action",
			                			null,
			                			"",
			                			null
			                			);
							}
							if (index == "1") {
			                	$.loadPage($models,
			                			"${ctx}/scriptmonitor/repository/modelExtend!showModelTypes.action",
			                			null,
			                			"resourceCategoryIds=device&resourceCategoryIds=application",
			                			null
			                			);
							}
							if (index == "2") {
			                	$.loadPage($content,
			                			"${ctx}/scriptmonitor/repository/scriptPropfile!showProfiles.action",
			                			null,
			                			"",
			                			null
			                			);
							}
							//$.unblockUI();
						</s:if>
						<s:else>
								$.blockUI({message:$('#loading')});
			                	$.loadPage($content,
			                			"${ctx}/scriptmonitor/repository/scriptPropfile!showProfiles.action",
			                			null,
			                			"",
			                			null
			                			);
			                	//$.unblockUI();
						</s:else>
	            }
	        }
	    },{accordionMenu_DomStruFn:"inner_accordionMenu_DomStruFn",accordionMenu_DomCtrlFn:"inner_accordionMenu_DomCtrlFn"});
	    
	    
	    
	    <s:if test="#canEdit == false">
	    $.loadPage($content,"${ctx}/scriptmonitor/repository/scriptPropfile!showProfiles.action",null,"",null);
	    </s:if>
	});
	</script>
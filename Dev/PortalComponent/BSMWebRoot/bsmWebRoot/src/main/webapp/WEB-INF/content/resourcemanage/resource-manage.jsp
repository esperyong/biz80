<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp"%>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/manage.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/tabPanel/tab.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/menu/menu.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
</head>
<body>
<div class="main margin5">
	<div class="main-left f-absolute" style="left: 0px;">
		<page:applyDecorator name="accordionLeftPanel"> 
			<page:param name="id">leftTree</page:param>
			<page:param name="width">200px</page:param>
			<page:param name="height">591px</page:param>
			<page:param name="currentIndex">0</page:param>
			<page:param name="panelIndex_0">0</page:param>
			<page:param name="panelTitle_0">资源管理</page:param>
			<page:param name="panelContent_0">
			<div id="tree" style="height:550px;overflow-y:auto;overflow-x:hidden;">
			${domainTree}
			</div>
			</page:param>
		</page:applyDecorator>
	</div>
	<div class="main-right" style="margin-left: 210px;">
		<div class="manage-content">
			<div class="top-l">
				<div class="top-r">
					<div class="top-m">	</div>
				</div>
			</div>
			<div class="mid">
				<div class="h1"><span class="bold">当前位置：</span><span>资源管理</span></div>
				<div id="resource_main_div" class="content">
					<s:action name="resManage!resMain" namespace="/resourcemanage" executeResult="true" ignoreContextParams="true" flush="false">
						<s:param name="pageQueryVO.domainId" value="pageQueryVO.domainId"/>
					</s:action>
				</div>
			</div>
			<div class="bottom-l">
				<div class="bottom-r">
					<div class="bottom-m"> </div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
var tree = new Tree({id:"domainTree",listeners:{nodeClick:function(node){
	$.blockUI({message:$('#loading')});
	var nodeId = node.getId();
	var paramStr = "";
	var params = nodeId.split(';');
	for(var i = 0; i < params.length; i++){
		var key_value = params[i].split(',');
		if(i == (params.length - 1)){
			paramStr += "pageQueryVO." + key_value[0] + "=" + key_value[1];
		}else{
			paramStr += "pageQueryVO." + key_value[0] + "=" + key_value[1] + "&";
		}
	}
	
	$.loadPage("resource_main_div","${ctx}/resourcemanage/resManage!resMain.action","get",paramStr,function(){$.unblockUI();});
}}});

function treeTrim(){
	$('#domainTree li').css('word-wrap','normal');
	$("#domainTree span[type='text']").each(
		function() {
			var text = $(this).text();
			$(this).empty();
			$(this).append("<span STYLE='width:125px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='" + text + "'>" + text + "</span>");
		}
	);
}

treeTrim();
</script>
</html>
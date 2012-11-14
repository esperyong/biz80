<!-- 机房-机房监控-指标分析 monitorAnalyzeInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>指标分析</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/portal02.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/accordionPanel/j-dynamic-accordion.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>

<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>

</head>
<script type="text/javascript">
if("<s:property value='hasLeafNode'/>" != "true") {
	$("#no").show();
	//document.getElementById("center-area").style.overflow = 'hidden';
}else{
	$("#no").hide();
	//document.getElementById("center-area").style.overflow = 'auto';
}
</script>
<body >
 
<div id="totalDivId" style="height:100%">

	<div class="ui-layout-west" id="layoutwestId">
		<div class="left-panel-open" id="leftId">
			<div class="left-panel-l" id="leftpanelId">
				<div class="left-panel-r">
					<div class="left-panel-m">
						<span class="left-panel-title">指标列表</span>
					</div>	
				</div>
			</div>
			<div class="left-panel-content" style="height:90%;overflow-y:auto">
			<s:property value="catalogTree" escape="false" />	
			</div>
		</div>
	</div>
	
	<div id="center-area" class="ui-layout-center" style="overflow:hidden;height:100%" >
		<div id="no" style='font-size:45px;font-weight:700;width:300px;height:300px; margin:230px auto;'>无监控设施</div>
		<div id="treeNodePageId"  style="overflow-x:hidden;width:100%;height:100%">
			
		</div>
	</div>
	
</div>
<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
<input type="hidden" name="firstNode" id="firstNode" value="<s:property value='firstNode'/>"/>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</body>
</html>
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
	,   west__size:				250
	,	west__minSize:			100
	,   west__spacing_open:8
	,   west__spacing_closed:8
	,   west__togglerLength_open:36
	,   west__togglerLength_closed:36
	,	east__size:				300
	,	east__minSize:			200
	,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
	});
	
});
var toast;
$(document).ready(function() {
	$("#layoutwestId").width(250);
	$("#leftId").width(250);
	$("#layoutwestId")[0].style.height="100%";
	$("#leftId")[0].style.height="100%";
	toast = new Toast({position:"CT"}); 
	if (parent.unBolck){
		window.parent.unBolck();
	}
	var tree = new  Tree({id:"treeId",listeners:{
	    nodeClick:function(node){
		var nodestr = node.getId();
		var arr;
		
		if(nodestr != null && (nodestr.indexOf("#")>0)){
			arr = nodestr.split("#");
			var catalogId = arr[0];
			var resourceId = arr[1];
			var resourceName = arr[2];
			var picColor = arr[3];
			var catalogName = arr[4];
			var resourceDesc = arr[5];
			var roomId = $("#roomId").val();
			ajaxFun(catalogId,resourceId,roomId,resourceName,picColor,catalogName,resourceDesc);
		}
	  }
	}
	});
	var firstLocationId = getFirstLocationId($("#treeId").html());
	firstLocationId = $("#firstNode").val();
	tree.setCurrentNode(firstLocationId);
	if(firstLocationId != null && (firstLocationId.indexOf("#")>0)){
		var arr = firstLocationId.split("#");
		var catalogId = arr[0];
		var resourceId = arr[1];
		var resourceName = arr[2];
		var picColor = arr[3];
		var catalogName = arr[4];
		var resourceDesc = arr[5];
		var roomId = $("#roomId").val();
		ajaxFun(catalogId,resourceId,roomId,resourceName,picColor,catalogName,resourceDesc);
	}
	
	
});
function getFirstLocationId(html){
	var $ls = $(html).find("li[nodeid][class='']");
	return $ls.length>0 ? $ls.get(0).nodeid : null;
}

function ajaxFun(catalogId,resourceId,roomId,resourceName,picColor,catalogName,resourceDesc) {
	//$("#treeNodePageFrame").attr("src","${ctx}/roomDefine/ChangeTreeResPage.action?catalogId="+catalogId+"&resourceId="+resourceId+"&roomId="+roomId+"&resourceName="+resourceName+"&picColor="+picColor+"&catalogName="+catalogName+"&resourceDesc="+resourceDesc)
	
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"catalogId="+catalogId+"&resourceId="+resourceId+"&roomId="+roomId+"&resourceName="+resourceName+"&picColor="+picColor+"&catalogName="+catalogName+"&resourceDesc="+resourceDesc, 
		url: "${ctx}/roomDefine/ChangeTreeResPage.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var roomId = $("#roomId").val();
			
			$("#treeNodePageId").find("*").unbind();
			$("#treeNodePageId").html("");
			$("#treeNodePageId").append(data);
			
			$("#roomId").val(roomId);//unbind后或者append后roomId会为空.
			
			treeTrim();
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
	
}




function treeTrim(){
	  $('#treeId li').css('word-wrap','normal');
	  $("#treeId span[type='text']").each(
	  function() {
	      var text = $(this).text();
	      var width = 85;
	   var patt1 = /^m_/;
	   var nodeid = $(this).parent().attr("nodeid");
	   if(nodeid && patt1.test(nodeid)){
	       width = 85;
	      }
	      $(this).empty();
	      $(this).append("<span STYLE='width:"+width+"px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='" + text + "'>" + text + "</span>");
	     }
	    );
}

</script>
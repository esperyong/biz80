<%--  
 *************************************************************************
 * @source  : pollingCountTab.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.4.20   huaf     关联指标页面
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>关联监控指标</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/tongjifenxi.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>	
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
</head>

<script>
if("<s:property value='saveFlag' />" != null && "<s:property value='saveFlag' />" == "true") {
	parent.window.toast.addMessage("操作成功");
	setTimeout(function(){
		parent.opener.refreshWin();
		parent.window.close();
		},1000);
}else if("<s:property value='saveFlag' />" == "false") {
try{
	parent.window.toast.addMessage("操作失败");
	parent.window.close();
}catch(e){
	alert(e);
}
}
</script>
<body>

<page:applyDecorator name="popwindow" >
<page:param name="title">关联指标</page:param>	
<page:param name="width">500px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">closeId</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>

<page:param name="bottomBtn_index_1">2</page:param>
<page:param name="bottomBtn_id_1">submit</page:param>
<page:param name="bottomBtn_text_1">确定</page:param>

<page:param name="bottomBtn_index_2">3</page:param>
<page:param name="bottomBtn_id_2">cancel</page:param>
<page:param name="bottomBtn_text_2">取消</page:param>

<page:param name="content">
<form id="relationMonitorResourceFormID" action="" name="relationMonitorResourceForm" method="post" >
<div id="relationMonitorResourceAllId">

	<div id="roomsDeviceDivId">
		<ul class="fieldlist">
				<li class="last" id="tableDivId">
				<page:applyDecorator name="indexgrid">  
			     <page:param name="id">devTableId</page:param>
			     <page:param name="width">500px</page:param>
			     <page:param name="height">360px</page:param>
			     <page:param name="linenum">15</page:param>
			     <page:param name="tableCls">grid-gray</page:param>
			     <page:param name="gridhead">[{colId:"metricId",text:""},{colId:"metricName",text:"指标名称"},{colId:"metricDsc",text:"指标描述"}]</page:param>
			     <page:param name="gridcontent"><s:property value="metricInfoStr" escape="false" /></page:param>
			   	</page:applyDecorator>
			   	<div id="pageDevice" >
			      	</div>
			</li>
		</ul>
	</div>
</div>
<input type="hidden" id="roomIdHidden" name="roomId" value="<s:property value='roomId'/>" />
<input type="hidden" id="resourceId" name="resourceId" value="" />
<input type="hidden" id="facilityId" name="facilityId" value="" />
<input type="hidden" name="pollingId" id="pollingId" value="<s:property value='pollingId' />" />
<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="" />
<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="" />
<input type="hidden" id="sortIdFacHidden" name="sortIdFacHidden" value="" />
<input type="hidden" id="sortColIdFacHidden" name="sortColIdFacHidden" value="" />
<input type="hidden" name="pollingIndexId" id="pollingIndexId" value="<s:property value='pollingIndexId' />" />
<input type="hidden" name="checkId" id="checkId" value="<s:property value='checkId' />" />
<input type="hidden" name="metricId" id="metricId" value="<s:property value='metricId' />" />
</form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</page:param>
</page:applyDecorator>
</body>
</html>
<script>
var toast = new Toast({position:"RT"}); 

var devGp = new GridPanel({id:"devTableId",
    width:500,
    columnWidth:{metricId:50,metricName:150,metricDsc:200},
    plugins:[SortPluginIndex,TitleContextMenu],
    sortColumns:[{index:"metricName",defSorttype:"up"}],
    sortLisntenr:function($sort){
   },
contextMenu:function(td){
//alert("=="+td.colId);
   }
   },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
   );
devGp.rend([{index:"metricId",fn:function(td){
		if(td.html!="") {
			if("${metricId}" === td.html){
	    		$radioObj = $('<input type="radio" style="cursor:pointer" name="radioOne" checked value="'+td.html+'"/>');
			}else{
				$radioObj = $('<input type="radio" style="cursor:pointer" name="radioOne" value="'+td.html+'"/>');
			}
	    	$radioObj.bind("click",function(){
	    		$("#metricId").val($(this).val());	    	
	        });
	    	return $radioObj;
	    }else{
			return null;
	    }
      }
   }]);

$("#closeId").click(winClose);
$("#submit").click(function (){
	var radioVal = $("input[name=relationRadio]:checked").val();
	var $metricId = $("#metricId").val();

	if($metricId == ""){
		window.toast.addMessage("请选择一个指标！");
		return;
	}
	var url = "${ctx}/roomDefine/RelationMonitorMetricVisit!saveRelationMetric.action";
	$.ajax({
		url:url,
		data:$("#relationMonitorResourceFormID").serialize(),
		dataType:"html",
		type:"POST",
		success:function(data,state){
			window.returnValue="true";
			self.opener.refreshWin();
			self.window.close();
		}
	});
	//$("#relationMonitorResourceFormID").attr("action",url);
	//$("#relationMonitorResourceFormID").attr("target","submitIframe");
	//$("#relationMonitorResourceFormID").submit();
});
$("#cancel").click(winClose);
function winClose() {
	window.close();
}


</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<title></title>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css"></link>
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
</head>
<body>
<base target="_self">
	<s:form id="extension_form">
		<s:hidden name="instanceId"/>
		<s:hidden name="metricId"/>
		<s:hidden name="moduleId"/>
		<s:hidden name="startTime"/>
		<s:hidden name="endTime"/>
		<s:hidden name="orderBy"/>
		<s:hidden name="orderType"/>
		<s:hidden name="currentPage"/>
		<s:hidden name="pageSize"/>
		<s:hidden name="height"/>
	</s:form>
	<page:applyDecorator name="indexcirgrid"> 
		<page:param name="id">extensionTableId</page:param>
		<page:param name="height">${height}px</page:param>
		<page:param name="linenum">${pageSize}</page:param>
		<page:param name="tableCls">grid-black</page:param>
		<page:param name="gridhead">[{colId:"serverity", text:"级别"},{colId:"occurTime",text:"产生时间"},{colId:"message",text:"事件内容"}]</page:param>
		<page:param name="gridcontent">${extensionEvents}</page:param>
	</page:applyDecorator>
	<div id="pagination" style="width:100%"></div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	var gp = new GridPanel({id:"extensionTableId",
		unit:"%",
		columnWidth:{serverity:10,occurTime:24,message:66},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"serverity"},
		{index:"occurTime",defSorttype:"down"}],
		sortLisntenr:function($sort){
			var orderType = "desc";
			if($sort.sorttype == "up"){
				orderType = "asc";
			}
			$("input[name='orderBy']","#extension_form").attr("value",$sort.colId);
			$("input[name='orderType']","#extension_form").attr("value",orderType);
			var ajaxParam = $("#extension_form").serialize();
	      	  $.ajax({
	      		type: "POST",
	      		dataType:'json',
	      		url: "${ctx}/event/extensionEvent!extensionEventListJson.action",
	      		data: ajaxParam,
	      		success: function(data, textStatus){
	      			gp.loadGridData(data.extensionEvents);
	      		}
	      	  });
		}},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	gp.rend([{index:"serverity",fn:function(td){
		if(td.html == ""){
			return;
		}
		var array = td.html.split(',');
		var $span = $('<span class="event-level"><div class="event-level-topbottom"></div><div class="event-level-mid event-level'+array[0]+'">'+array[1]+'</div><div class="event-level-topbottom"></div></span>');
    	return $span;
	}}]);

	var page = new Pagination({applyId:"pagination",listeners:{
        pageClick:function(page){
		  $("input[name='currentPage']","#extension_form").attr("value",page);
          var ajaxParam = $("#extension_form").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'json',
      		url: "${ctx}/event/extensionEvent!extensionEventListJson.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
      			gp.loadGridData(data.extensionEvents);
      		}
      	  });
        }
      }});
    page.pageing(${totalPage},${currentPage});
});
</script>
</html>
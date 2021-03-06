<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<base target="_self">
	<s:form id="hiddenForm_active">
		<s:hidden name="eventQuery.resourceCategoryId"/>
		<s:hidden name="eventQuery.queryType"/>
		<s:hidden name="eventQuery.queryValue"/>
		<s:hidden name="eventQuery.userDomainID"/>
		<s:hidden name="eventQuery.serverity"/>
		<s:hidden name="eventQuery.dependencySystem"/>
		<s:hidden name="eventQuery.eventType"/>
		<s:hidden name="eventQuery.timeType"/>
		<s:hidden name="eventQuery.timePoint"/>
		<s:hidden name="eventQuery.startTime"/>
		<s:hidden name="eventQuery.endTime"/>
		<s:hidden name="eventQuery.orderBy"/>
		<s:hidden name="eventQuery.orderType"/>
		<s:hidden name="eventQuery.currentPage"/>
	</s:form>
	<page:applyDecorator name="indexcirgrid"> 
		<page:param name="id">tableId</page:param>
		<page:param name="height">500px</page:param>
		<page:param name="lineHeight">25px</page:param>
		<page:param name="tableCls">grid-black</page:param>
		<page:param name="gridhead">[{colId:"serverity", text:"级别"},{colId:"occurTime",text:"产生时间"},{colId:"objectType",text:"事件对象类型"},{colId:"objectName",text:"事件对象"},{colId:"message",text:"事件内容"}]</page:param>
		<page:param name="gridcontent">${events}</page:param>
	</page:applyDecorator>
	<div id="pagination" style="width:100%"></div>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var gp = new GridPanel({id:"tableId",
		unit:"%",
		columnWidth:{serverity:6,occurTime:14,objectType:14,objectName:27,message:39},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"serverity"},
		{index:"occurTime",defSorttype:"down"},
		{index:"objectType"},
		{index:"objectName"}/*,
		{index:"message"}*/],
		sortLisntenr:function($sort){
			var orderType = "desc";
			if($sort.sorttype == "up"){
				orderType = "asc";
			}
			$("input[name='eventQuery.orderBy']","#hiddenForm_active").attr("value",$sort.colId);
			$("input[name='eventQuery.orderType']","#hiddenForm_active").attr("value",orderType);
			var ajaxParam = $("#hiddenForm_active").serialize();
	      	  $.ajax({
	      		type: "POST",
	      		dataType:'json',
	      		url: "${ctx}/event/eventManage!activeEventListJson.action",
	      		data: ajaxParam,
	      		success: function(data, textStatus){
	      			gp.loadGridData(data.events);
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
	}},{index:"objectName",fn:function(td){
		if(td.html == ""){
			return;
		}
		var array = td.html.split(',');
		if(array[0] == "no") {
			$font = $('<font title="' + array[1] + '">'+array[1]+'</font>');
		} else {
			$font = $('<font style="cursor:pointer" title="' + array[1] + '">'+array[1]+'</font>');
			$font.bind("click",function(){
				openResourceDetailInfo(array[0]);
			});
		}
    	return $font;
	}},{index:"message",fn:function(td){
		if(td.html == ""){
			return;
		}
		var array = td.html.split('##');
		$font = $('<font style="cursor:pointer" title="' + array[1] + '">'+array[1]+'</font>');
		$font.bind("click",function(){
			openEventDetailInfo(array[0],array[2]);
		});
    	return $font;
	}}]);

	function openEventDetailInfo(Id,occurTime) {
		var src="${ctx}/event/eventDetailInfo!activeDetailInfo.action?eventDetailInfoVO.eventId="+Id + "&eventDetailInfoVO.occurTimePage=" + occurTime;
		var width=720;
		var height=345;
		window.open(src,'eventDetailInfo','height='+height+',width='+width+',scrollbars=yes');
	}
	
	function openResourceDetailInfo(url) {
		var width=1000;
		var height=650;
		window.open(url,'resourceDetailInfo','height='+height+',width='+width+',scrollbars=yes');
	}

	var page = new Pagination({applyId:"pagination",listeners:{
        pageClick:function(page){
		  $("input[name='eventQuery.currentPage']","#hiddenForm_active").attr("value",page);
          var ajaxParam = $("#hiddenForm_active").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'json',
      		url: "${ctx}/event/eventManage!activeEventListJson.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
      			gp.loadGridData(data.events);
      		}
      	  });
        }
      }});
    page.pageing(${totalPage},${eventQuery.currentPage});
});

$.unblockUI();
</script>
</html>
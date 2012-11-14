<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<s:form id="res-list-query">
	<s:hidden name="pageQueryVO.domainId"/>
	<s:hidden name="pageQueryVO.dms"/>
	<s:hidden name="pageQueryVO.resGroup"/>
	<s:hidden name="pageQueryVO.queryName"/>
	<s:hidden name="pageQueryVO.queryValue"/>
	<s:hidden name="pageQueryVO.workGroupId"/>
	<s:hidden name="pageQueryVO.currentPage"/>
	<s:hidden name="pageQueryVO.orderBy"/>
	<s:hidden name="pageQueryVO.orderType"/>
	<s:hidden name="pageQueryVO.resType"/>
	<s:hidden name="distDomainId" id="distDomainId"/>
	<s:hidden name="distWorkGroupId" id="distWorkGroupId"/>
	<page:applyDecorator name="indexcirgrid"> 
		<page:param name="id">other_table</page:param>
		<page:param name="height">475px</page:param>
		<page:param name="linenum">${pageQueryVO.pageSize}</page:param>
		<page:param name="lineHeight">26px</page:param>
		<page:param name="tableCls">grid-black</page:param>
		<page:param name="gridhead">[{colId:"resInstanceId",text:"<input type='checkbox' name='all_instance' id='all_instance'/>"},{colId:"resInstanceName",text:"名称"},{colId:"domain",text:"所属<s:property value="@com.mocha.bsm.resourcemanage.common.RangeName@rangeName()"/>"}]</page:param>
		<page:param name="gridcontent">${resJson}</page:param>
	</page:applyDecorator>
</s:form>
<div id="pagination" style="width:100%"></div>
<script type="text/javascript">
$(document).ready(function(){
	var gp = new GridPanel({id:"other_table",
		unit:"%",
		columnWidth:{resInstanceId:6,resInstanceName:49,domain:45},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"resInstanceName",defSorttype:"down"}],
		sortLisntenr:function($sort){
			$.blockUI({message:$('#loading')});
			var orderType = "desc";
			if($sort.sorttype == "up"){
				orderType = "asc";
			}
			$("input[name='pageQueryVO.orderBy']","#res-list-query").attr("value",$sort.colId);
			$("input[name='pageQueryVO.orderType']","#res-list-query").attr("value",orderType);
			var ajaxParam = $("#res-list-query").serialize();
	      	  $.ajax({
	      		type: "POST",
	      		dataType:'html',
	      		url: "${ctx}/resourcemanage/resManage!resList.action",
	      		data: ajaxParam,
	      		success: function(data, textStatus){
	      			$resource_list_div = $("#resource-list-div");
	      			$resource_list_div.find("*").unbind();
	      			$resource_list_div.html(data);
	      			$.unblockUI();
	      		}
	      	  });
		}},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	
	gp.rend([{index:"resInstanceId",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $checkbox = $('<input type="checkbox" name="instanceIds" value="'+td.html+'">');
    	return $checkbox;
	}}]);

	var page = new Pagination({applyId:"pagination",listeners:{
        pageClick:function(page){
		  $.blockUI({message:$('#loading')});
		  $("input[name='pageQueryVO.currentPage']","#res-list-query").attr("value",page);
          var ajaxParam = $("#res-list-query").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'html',
      		url: "${ctx}/resourcemanage/resManage!resList.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
      			$resource_list_div = $("#resource-list-div");
      			$resource_list_div.find("*").unbind();
      			$resource_list_div.html(data);
      			$.unblockUI();
      		}
      	  });
        }
      }});
    page.pageing(${pageQueryVO.pageCount},${pageQueryVO.currentPage});

    $("#all_instance").click(function() {
		$("input[name='instanceIds']").attr("checked",$("#all_instance").attr("checked"));
	});

	$("input[name='instanceIds']").click(function() {
		var param = $(this).attr("checked");
		if(param == false) {
			$("#all_instance").attr("checked", false);
		}
	});
});
</script>
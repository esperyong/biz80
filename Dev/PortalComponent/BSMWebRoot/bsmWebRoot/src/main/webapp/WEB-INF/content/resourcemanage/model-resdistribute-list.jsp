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
	<s:hidden name="pageQueryVO.pageSize"/>
	<page:applyDecorator name="indexcirgrid"> 
		<page:param name="id">model_distribute_table</page:param>
		<page:param name="height">100%</page:param>
		<page:param name="linenum">${pageQueryVO.pageSize}</page:param>
		<page:param name="lineHeight">26px</page:param>
		<page:param name="tableCls">grid-black</page:param>
		<page:param name="gridhead">[{colId:"resInstanceId",text:"<input type='checkbox' name='all_instance' id='all_instance'/>"},{colId:"resInstanceName",text:"名称"},{colId:"ipAddress",text:"IP地址"},{colId:"resGroup",text:"资源类型"}]</page:param>
		<page:param name="gridcontent">${resJson}</page:param>
	</page:applyDecorator>
</s:form>
<div id="pagination" style="width:100%"></div>
<script type="text/javascript">
$(document).ready(function(){
	var gp = new GridPanel({id:"model_distribute_table",
		unit:"%",
		columnWidth:{resInstanceId:9,resInstanceName:30,ipAddress:31,resGroup:30},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"resInstanceName",defSorttype:"down"},{index:"ipAddress"}],
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
	      		dataType:'json',
	      		url: "${ctx}/resourcemanage/resManage!resDistributeListJson.action",
	      		data: ajaxParam,
	      		success: function(data, textStatus){
	      			gp.loadGridData(data.resJson);
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
	}},{index:"ipAddress",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $select = "";
		var ipArr = td.html.split(',');
		if(ipArr.length > 1){
			$select = "<select>";
			for(var i = 0; i < ipArr.length; i++){
				$select += "<option>" + ipArr[i] + "</option>";
			}
			$select += "</select>";
		}else{
			$select = td.html;
		}
    	return $select;
	}}]);

	var page = new Pagination({applyId:"pagination",listeners:{
        pageClick:function(page){
		  $.blockUI({message:$('#loading')});
		  $("input[name='pageQueryVO.currentPage']","#res-list-query").attr("value",page);
          var ajaxParam = $("#res-list-query").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'json',
      		url: "${ctx}/resourcemanage/resManage!resDistributeListJson.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
      			gp.loadGridData(data.resJson);
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
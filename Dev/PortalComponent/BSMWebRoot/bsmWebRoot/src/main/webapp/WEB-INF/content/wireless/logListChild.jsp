<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script>
var pageCount = "${forPageVO.pageCount}";
</script>
</head>
<body>
<div style="color:black;" id="dataListDiv">
   <page:applyDecorator name="indexcirgrid">
      <page:param name="id">tableId</page:param>
      <page:param name="height">580px</page:param>
      <page:param name="lineHeight">23px</page:param>
      <page:param name="tableCls">roundedform</page:param>
      <page:param name="gridhead">${forPageVO.titleList}</page:param>
      <page:param name="gridcontent">${forPageVO.dataList}</page:param>
    </page:applyDecorator>
    <div id="page"></div>
</div>
<script>
$(function() {
	$.blockUI({message:$('#loading')});
	$formObj = $("#wireListForm");
	var $searchValue = $('#searchValue');
	if(gp != null) {gp = null};
	gp = new GridPanel({id:"tableId",
		columnWidth:{instanceName:"15",ips:"14",resourceType:"13",actionName:"10",scriptName:"10",commandPath:"14",createTime:"16",success:"8"},
		unit: "%",
		plugins:[SortPluginIndex],
		sortColumns:[{index:"createTime",defSorttype:"down"}],
		sortLisntenr:function($sort){
			  $.blockUI({message:$('#loading')});
              var orderType = "desc";
              if($sort.sorttype == "up"){
                      orderType = "asc";
              }
              $("#orderColumn").val($sort.colId);
              $("#orderType").val(orderType);
              if($searchValue.val() == searchTip) {
      			$searchValue.val("");
      		  }
              var ajaxParam = $formObj.serialize();
	          $.ajax({
	              type: "POST",
	              dataType:'json',
	              url: path+"/wireless/actionResultForPage/actionResultJsonSort.action",
	              data: ajaxParam,
	              success: function(data, textStatus){
	              	if(data.forPageVO.dataList) {
			        	if($searchValue.val()=="") {
							$searchValue.val(searchTip);
						}
		        		gp.loadGridData(data.forPageVO.dataList);
	              	}
	              	$.unblockUI();
	              }
	          });
        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});          
	
	gp.rend([{index:"ips",fn:function(td){
			if(td.html == "") {return;}
	        if(td.html == "-"){
	            return "-";
	        }
	        //var tmp = eval(td.html);
	        //var arr = eval(td.html);
	        var arr = td.html.split(',');
	        var length = arr.length;
	        if(length <= 1 ){
	             return '<span>'+arr[0]+'</span>';
	        }
	        var select = '<select name="ipAddress" style="width:117px" id="ipAddress">';
	        for (var i = 0; i < length; i++) {
	            var option = '<option>' + arr[i] + '</option>'
	            select += option;
	         }
	         select += '</select>';
	         return select;
		}
		},{index:"success",fn:function(td){
			if(td.html == "") {return;}
			if(td.html == 'true') {
				return $('<span class="ico ico-checkmark" style="cursor:none;"></span>');	
			}else {
				return $('<span class="ico ico-delete2" style="cursor:none;"></span>');	
			}
		}
		}]);

	var page = new Pagination({applyId:"page",listeners:{
		pageClick:function(page){
		$.blockUI({message:$('#loading')});
		$("#currentPage").val(page);
		if($searchValue.val() == searchTip) {
  			$searchValue.val("");
  		}
		var ajaxParam = $formObj.serialize();
		$.ajax({
			type: "POST",
			dataType:'json',
			url: path+"/wireless/actionResultForPage/actionResultJsonSort.action",
			data: ajaxParam,
			success: function(data, textStatus){
				if(data.forPageVO.dataList){
					if($searchValue.val()=="") {
						$searchValue.val(searchTip);
					}
					gp.loadGridData(data.forPageVO.dataList);
				}
				$.unblockUI();
			}
		});
	}
	}});
	page.pageing(pageCount,1);
	$.unblockUI();
});
</script>
</body>
</html>
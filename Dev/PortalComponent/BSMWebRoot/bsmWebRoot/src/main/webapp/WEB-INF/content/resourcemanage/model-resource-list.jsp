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
	<s:hidden name="distDmsId" id="distDmsId"/>
	<page:applyDecorator name="indexcirgrid"> 
		<page:param name="id">model_table</page:param>
		<page:param name="height">486px</page:param>
		<page:param name="linenum">${pageQueryVO.pageSize}</page:param>
		<page:param name="lineHeight">27px</page:param>
		<page:param name="tableCls">grid-black</page:param>
		<page:param name="gridhead">
		<%if(com.mocha.bsm.system.SystemContext.isStandAlone()){%>
		[{colId:"resInstanceId",text:"<input type='checkbox' name='all_instance' id='all_instance'/>"},{colId:"resInstanceState", text:""},{colId:"resInstanceName",text:"名称"},{colId:"ipAddress",text:"IP地址"},{colId:"resGroup",text:"资源类型"},{colId:"domain",text:"所属<s:property value="@com.mocha.bsm.resourcemanage.common.RangeName@rangeName()"/>"},{colId:"componentInfo",text:"组件信息"}]
		<%}else{ %>
		[{colId:"resInstanceId",text:"<input type='checkbox' name='all_instance' id='all_instance'/>"},{colId:"resInstanceState", text:""},{colId:"resInstanceName",text:"名称"},{colId:"ipAddress",text:"IP地址"},{colId:"resGroup",text:"资源类型"},{colId:"dms",text:"所属DMS"},{colId:"domain",text:"所属<s:property value="@com.mocha.bsm.resourcemanage.common.RangeName@rangeName()"/>"},{colId:"componentInfo",text:"组件信息"}]
		<%} %>
		</page:param>
		<page:param name="gridcontent">${resJson}</page:param>
	</page:applyDecorator>
</s:form>
<div id="pagination" style="width:100%"></div>
<script type="text/javascript">
var panel;
$(document).ready(function(){
	var columnWidth;
	if(<%=com.mocha.bsm.system.SystemContext.isStandAlone()%>) {
		columnWidth = {resInstanceId:5,resInstanceState:3,resInstanceName:22,ipAddress:22,resGroup:19,domain:19,componentInfo:10};
	} else {
		columnWidth = {resInstanceId:5,resInstanceState:3,resInstanceName:18,ipAddress:18,resGroup:15,dms:16,domain:15,componentInfo:10};
	}
	var gp = new GridPanel({id:"model_table",
		unit:"%",
		columnWidth:columnWidth,
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
	      		url: "${ctx}/resourcemanage/resManage!resListJson.action",
	      		data: ajaxParam,
	      		success: function(data, textStatus){
	      			gp.loadGridData(data.resJson);
	      			bindComponentInfo();
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
	}},{index:"resInstanceState",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $span;
		if("monitor" == td.html){
			$span = $('<span class\="ico ico-play" ></span>');
		}else{
			$span = $('<span class\="ico ico-stop" ></span>');
		}
    	return $span;
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
	}},{index:"componentInfo",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $img = $("<span class='ico ico-file'></span><input type='hidden' value='" + td.html + "'>");
    	return $img;
	}}]);

	var page = new Pagination({applyId:"pagination",listeners:{
        pageClick:function(page){
		  $.blockUI({message:$('#loading')});
		  $("input[name='pageQueryVO.currentPage']","#res-list-query").attr("value",page);
          var ajaxParam = $("#res-list-query").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'json',
      		url: "${ctx}/resourcemanage/resManage!resListJson.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
      			gp.loadGridData(data.resJson);
      			bindComponentInfo();
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

	bindComponentInfo();
});

function bindComponentInfo() {
	$(".ico-file").click(function(){
		var resInstanceId = $(this).next().val();
		openComponentInfo(resInstanceId);
	});
}

var getDistDmsId = function() {
	return $("#distDmsId").val();
}

var getInstanceIds = function() {
	var instanceIds = new Array();
	var $checkboxs = $("[name=instanceIds]:checked");
	$.each($checkboxs,function(index,entity){
		instanceIds.push($(entity).val());
	});
	return instanceIds; 
}

function openComponentInfo(resInstanceId) {
	panel = new winPanel({
			type: "POST",
			url: "${ctx}/resourcemanage/componentInfo.action?resInstanceId=" + resInstanceId,
			width: 320,
			x: 650,
			isautoclose: true,
			y: 130,//event.pageY,
			closeAction: "close"
		},
		{winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"}
	); 
}
</script>
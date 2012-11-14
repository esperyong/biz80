<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp"%>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>分配资源</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/jquery.blockUI.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="分配资源">
    <page:param name="width">500px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">app_button</page:param>
	<page:param name="bottomBtn_text_1">应用</page:param>
	
    <page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">ok_button</page:param>
	<page:param name="bottomBtn_text_2">确定</page:param>
	
    <page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">cancel_button</page:param>
	<page:param name="bottomBtn_text_3">取消</page:param>
	
	<page:param name="content">
	<div class="resources-search"><span class="sub-panel-tips">将当前<s:property value="@com.mocha.bsm.resourcemanage.common.RangeName@rangeName()"/>中的资源分配到工作组，工作组中的用户只能查看组中的资源。</span> </div>
	<div class="search-white-bg">
  	<s:form id="query-form">
	  <div class="select">
	  <s:if test="pageQueryVO.resType == 'model'">
		  <s:select list="%{@com.mocha.bsm.resourcemanage.common.QueryConditionFactory@resGroups()}" name="pageQueryVO.resGroup" listKey="key" listValue="value" headerKey="-1" headerValue="选择资源类型"/></span><span>
		  <s:select list="#{'name':'名称','ip':'IP地址'}" name="pageQueryVO.queryName" listKey="key" listValue="value"/></span><span>
  	  </s:if>
  	  <s:else>
  	  	  <span><s:hidden name="pageQueryVO.queryName" value="name"/>名称：</span>
  	  </s:else>
	  <s:textfield name="pageQueryVO.queryValue"/><span class="ico"></span>
	  </div>
	  <s:hidden name="pageQueryVO.domainId" id="domainId"/>
  	  <s:hidden name="pageQueryVO.workGroupId" id="workGroupId"/>
  	  <s:hidden name="pageQueryVO.resType" id="resType"/>
  	  <s:hidden name="pageQueryVO.pageSize" id="pageSize"/>
  	</s:form>
	</div>
	<div id="resource-list-div">
		<s:action name="resManage!resDistributeList" namespace="/resourcemanage" executeResult="true" ignoreContextParams="true" flush="false">
			<s:param name="pageQueryVO.domainId" value="pageQueryVO.domainId"/>
			<s:param name="pageQueryVO.workGroupId" value="pageQueryVO.workGroupId"/>
			<s:param name="pageQueryVO.resType" value="pageQueryVO.resType"/>
			<s:param name="pageQueryVO.pageSize" value="pageQueryVO.pageSize"/>
		</s:action>
	</div>
	</page:param>
</page:applyDecorator>
</body>
<script>
$(document).ready(function(){
	var toast = new Toast({position:"CT"});
	$(".ico").bind("click", function(){
		search();
	});
	$("#topBtn1").click(function() {
		window.close();
  	});
	$("#cancel_button").click(function() {
		window.close();
  	});
	$("#app_button").click(function() {
		appSubmitForm(toast);
  	});	
	$("#ok_button").click(function() {
		submitForm(toast);
  	});	
});

function search() {
	$.blockUI({message:$('#loading')});
	var ajaxParam = $("#query-form").serialize();
	$.ajax({
		type: "POST",
		dataType:'html',
		url: "${ctx}/resourcemanage/resManage!resDistributeList.action",
		data: ajaxParam,
		success: function(data, textStatus){
			$resource_list_div = $("#resource-list-div");
			$resource_list_div.find("*").unbind();
			$resource_list_div.html(data);
			$.unblockUI();
		}
	});
}

function submitForm(toast) {
	if(!validateDelete(toast)) return;
	var ajaxParam = $("#res-list-query").serialize();
	$.ajax({
		type: "POST",
		dataType:'html',
		url: "${ctx}/resourcemanage/resManage!addInstanceToWorkGroup.action",
		data: ajaxParam,
		success: function(data, textStatus){
			opener.search();
			window.close();
		},
		fail: function(data, textStatus) {
			alert('fail');
		}
	});
}

function appSubmitForm(toast) {
	if(!validateDelete(toast)) return;
	var ajaxParam = $("#res-list-query").serialize();
	$.ajax({
		type: "POST",
		dataType:'html',
		url: "${ctx}/resourcemanage/resManage!addInstanceToWorkGroup.action",
		data: ajaxParam,
		success: function(data, textStatus){
			$resource_list_div = $("#resource-list-div");
  			$resource_list_div.find("*").unbind();
  			$resource_list_div.html(data);
  			opener.search();
		},
		fail: function(data, textStatus) {
			alert('fail');
		}
	});
}

function validateDelete(toast) {
	var $checkarr = $("input[name='instanceIds']:checked");
	if($checkarr.length == 0){
		toast.addMessage("请至少选择一项。");
		return false;
	}
	return true;
}
</script>
</html>
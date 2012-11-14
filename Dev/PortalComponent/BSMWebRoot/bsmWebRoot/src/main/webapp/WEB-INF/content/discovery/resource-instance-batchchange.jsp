<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/loading.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>变更设备类型</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<%
String instanceId = request.getParameter("instanceId");
%>
<script>
var contextPath = "${ctx}";
$(document).ready(function() {
	
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:'parentGroupId', maxHeight:60}]);
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:'groupId', maxHeight:60}]);
	
	$("#sp_discovery").bind("click", function() {
		var groupId = $("#groupId").val();
		startLoading();
		$("#div_disc_result").show();
		$.ajax( {
			type : "post",
			url : "resource-instance-changetypesubmit.action",
			data : "groupId="+groupId+"&instanceId=${instanceId}",
			success : function(data, textStatus) {
				var resultList = data.changeResult;
				$("#change_result_div").html("");
				if(resultList.length != 0){
					for(var i=0;i<resultList.length;i++){
						if(resultList[i].errorMessage != null){
							$("#change_result_div").append("<div class='h3' ><span class='bold'>"+resultList[i].resInstance.name+"：</span><span class='ico ico-false' title='失败'></span></div>");
						}else{
							$("#change_result_div").append("<div class='h3' ><span class='bold'>"+resultList[i].resInstance.name+"：</span><span class='ico ico-right' title='成功'></span></div>");
						}
					}
				}else{
					$("#change_result_div").append("<span class='bold'>变更设备类型结果：变更失败，资源实例不存在</span>");
				}
				
				stopLoading();
				$("#div_disc_result").show();
				$("#btn_ok").show();
			},
			beforeSend : function(XMLHttpRequest) {
				/*alert('beforeSend');*/
			},
			complete : function(XMLHttpRequest, textStatus) {
				/*alert('complete');*/
			},
			error : function() {
				alert("error");
			}
		});
	});
	$("#parentGroupId").bind("change", function() {
		/* AJAX方式取资源的列表 */
		var parentGroupId = $("#parentGroupId").val();
		$.ajax( {
			type : "post",
			url : "resource-instance-grouplist.action",
			data : "parentGroupId=" + parentGroupId,
			success : function(data, textStatus) {
				var groups = data.groupFormList;
				$("#groupId option").remove();  
				for (var i = 0; i < groups.length; i++) {
					var groupId = groups[i].resourceCategoryGroupId;
					var groupName = groups[i].resourceGroupName;
					$("#groupId").append("<option value='" + groupId + "'>" + groupName + "</option>");
				}
				$("#groupId").change();
			},
			beforeSend : function(XMLHttpRequest) {
				/*alert('beforeSend');*/
			},
			complete : function(XMLHttpRequest, textStatus) {
				/*alert('complete');*/
			},
			error : function() {
				alert("error");
			}
		});
	});
	
	$("#btn_cancel").bind("click", function() {
		window.close();
	});	
	$("#closeId").bind("click", function() {
		window.close();
	});
	
	$("#loading_text").html('<s:text name="page.loading.msg" />');
	$("#btn_ok").hide();
	$("#btn_cancel").hide();
});
</script>
<script type="text/javascript" src="${ctx}/js/discovery/resource-discovery.js"></script>
<script>
	$(function(){
		$("#btn_ok").click(function(){
			refreshPage(opener,'${instanceId}',"changetype");
			window.close();
		});
		$("span[class='fold-ico fold-ico-up']").each(function(){
			$(this).css("display","none");
		});
	});
</script>
</head>
<body class="pop-window">
<page:applyDecorator name="popwindow"  title="变更设备类型">
  
  <page:param name="width">500px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
   	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">btn_ok</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">btn_cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
  <page:param name="content">
  
    <page:applyDecorator name="accordionPanel">  
		<page:param name="id">panel_disc_info</page:param>
		<page:param name="title">修改信息</page:param>
		<page:param name="height"></page:param>
		<page:param name="width">95%</page:param>
		<page:param name="cls">fold</page:param>
		<page:param name="display"></page:param>
	  	<page:param name="content">

			<input type="hidden" name="domainId" id="domainId" value="${domainId}"  />
			<input type="hidden" name="resourceId" id="resourceId" value="${resourceId}"  />
			<ul>
				<li class="margin5 padding2"><span style="float: left; padding-top:5px;">&nbsp;选择设备类型：</span><span>${parentGroupSelect }<s:select list="groupList" id="groupId" name="groupId" isSynchro="1" listKey="resourceCategoryGroupId" listValue="resourceGroupName" value="%{groupId}" offsetWidth="150"></s:select></span></li>
				<li>
				  	<ul>
						<li class="margin3 padding2">
							</br>
							<span class="black-btn-l right" id="sp_discovery"><span class="btn-r"><span class="btn-m"><a >变更</a></span></span></span>
				       </li>
				    </ul>
				</li>
			</ul>
		</page:param>		  
	</page:applyDecorator>
  
	<div id="div_disc_result" style="display:none">
	    <page:applyDecorator name="accordionPanel">  
			<page:param name="id">panel_disc_result</page:param>
			<page:param name="title">变更报告</page:param>
			<page:param name="height"></page:param>
			<page:param name="width">95%</page:param>
			<page:param name="cls">fold</page:param>
			<page:param name="display"></page:param>
		  	<page:param name="content">
				<div class="fold-content">
				  	<div class="border-bottom">
						<div class="find-center"><img id="imgLoading" src="${ctx}/images/loading.gif" width="32" height="32" vspace="6" /><br />
				          		<span id="spLoading">0%</span></div>
					</div>
					<div id="change_result_div"></div>
				</div>
			</page:param>		  
		</page:applyDecorator>
	</div>
	
  </page:param>
</page:applyDecorator>
</body>
</html>
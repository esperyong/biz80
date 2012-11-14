<%--  
 *************************************************************************
 * @source  : profile-event-page.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.31	 huaf     	  集成事件页面
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<title>脚本事件浏览</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/scriptmonitor/scriptRepositorys.js"></script>
<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		loadEventData();
		$("#timeSearch").bind("click",function(){
			loadEventData();
		});
		
		$("#startTime").bind("click",function(){
			WdatePicker({dateFmt:'<%=com.mocha.bsm.i18n.I18CommonData.getFormatDateTime(null)%>'});
		});
		$("#endTime").bind("click",function(){
			WdatePicker({dateFmt:'<%=com.mocha.bsm.i18n.I18CommonData.getFormatDateTime(null)%>'});
		});
	});
	
	function loadEventData(){
			$.ajax({
				url 	: "${ctx}/scriptmonitor/repository/profileEvent.action",
				type  : "POST",
				data 	: $("#conditionForm").serialize(),
				dataType:	"html",
				cache:		false,
				success:	function(data, textStatus){
							var eventContent = $("#eventContent");
							eventContent.find("*").unbind().html("");
							eventContent.html(data);
							dialogResize();
				}
		});
	}
</script>
</head>
<body>
<div id="loading" class="loading for-inline" style="display:none;">
  <span class="vertical-middle loading-img for-inline"></span><span class="suojin1em">正在获取数据，请稍候...</span> 
</div>
<page:applyDecorator name="popwindow" title="脚本事件浏览">
	<page:param name="width">100%</page:param>
	<page:param name="height">500px;</page:param>
	<page:param name="content">
	<form id="conditionForm">
		<input type="hidden" name="height" value="500">
		<input type="hidden" name="pageSize" value="20">
		<div>
			<span>&nbsp;&nbsp;事件产生时间：从：</span><input type="text" id="startTime" name="startTimeStr" readOnly value="${startTimeStr}"/><span>&nbsp;到：</span><input type="text" id="endTime" name="endTimeStr" readOnly value="${endTimeStr}"/>
			<span  id="timeSearch" class="ico" title="搜索" ></span>
		</div>
		<s:hidden name="profileId" value="%{profileId}"/>
	</form>
	<div id="eventContent"></div>
	</page:param>
</page:applyDecorator>
</body>
</html>
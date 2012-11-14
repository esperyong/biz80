<%--  
 *************************************************************************
 * @source  : pollingCountTab.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.4.12   huaf     巡检统计页面
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>

<s:iterator value="countDatas" id="map" status="u"> 
<div class="fold-top"><span class="fold-top-title" id="<s:property value="key"/>" ><s:property value="#u.index+1" /> :<s:property value="key"/></span></div>
<div id="anyChartDiv<s:property value="#u.index+1" />">
	<s:hidden id="anychartData" value="%{value}"/>
	<script>
		//alert($("#anychartData").val());
		var anyChart = new AnyChart("${ctxFlash}/AnyChart.swf");
		anyChart.waitingForDataText = "";
		anyChart.width = "100%";
		anyChart.height = 300;
		anyChart.wMode = "transparent";
		anyChart.setData($("#anychartData").val());
		anyChart.write("anyChartDiv${u.index+1}");
		function openPollingDetail(pollingId,id,startTimeVal,endTimeVal){
			window.open("${ctx}/roomDefine/PollingDetailVisit.action?pollingIndexId="+pollingId+"&Id="+id+"&startTime="+startTimeVal+"&endTime="+startTimeVal,null,"height=480,width=520");
		}
</script>
</div>
</s:iterator>

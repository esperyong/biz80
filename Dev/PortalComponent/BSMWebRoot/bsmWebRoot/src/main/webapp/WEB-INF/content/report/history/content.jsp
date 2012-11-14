<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<%@ include file="/WEB-INF/common/loading.jsp" %>
<script>
 $(document).ready(function(){	
   $.blockUI({message:$('#loading')});
   });
</script>
<div class="grayborder margin8" >
  <div class="margin8" style="height:100%;overflow:auto;position:relative;">
    <div class="txt14 txt-white textalign h1"><s:property value="%{analysisView.name}"/></div>
    <div class="margin3 txt-white" >
      <!-- span class="ico ico-pdf right"></span>
      <span class="ico ico-excel right"></span>
      <span class="ico ico-word right"></span> -->
      <form id="addForm">
     	 指标：${selectMetric }
        <span class="suojin">时间：
        	<input type="radio" name="time" value="0" checked="checked"/>
        	<s:select name="segTime" id="selectSegTime" list="#{'24':'最近24小时','168':'最近7天','720':'最近30天'}"></s:select>
        	<input size="15" type="radio"  name="time" value="1"/>
        	从<input size="18" name="startTime" id="historyStartTime" value=""/>到<input size="18" name="endTime" id="historyEndTime" value=""/>
        </span><span class="ico ico-select" id="search"></span><span class="ico ico-pdf right" id="exportPdf"></span><span class="ico ico-excel right" id="exportExcel"></span>
        <s:hidden name="analysisView.id" value="%{analysisView.id}"/>
     </form>   
   </div>
   <div class="textalign txt-white margin5"><span id="startTimeTxt"><s:property value="%{startTime}"/></span>至<span id="endTimeTxt"><s:property value="%{endTime}"/></span></div>
  <div class="t-right txt-white margin5"> 无此指标或未取到值的资源将不显示</div>
   <!-- flash 图 -->
   <div>
     <ul>
       	<li>
       		<div>
       			<iframe id="contentFlash" name="contentFlash" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" height="" width="100%" src=""></iframe>
       		</div>
       	<li>
       <li class="textalign txt-white margin5">图：<span id="title"></span><span id="danwei1"></span> </li>
      </ul>
   </div>
   <!-- 数据表 -->
		<form id="exportparams">
			<input type="hidden" name="analysisView.id"  value="<s:property value="analysisView.id" />"/> 
			<input type="hidden" name="exportFileName" id="exportFileName" />
			<input type="hidden" name="exportType" id="exportType" />
			<input type="hidden" name="startTime" value="<s:property value="%{startTime}"/>"/>
			<input type="hidden" name="endTime" value="<s:property value="%{endTime}"/>"/>
			<input type="hidden" name="segTime" id="segTime" />
			<input type="hidden" name="time" id="time" />
			<input type="hidden" name="metric" id="metric" />
			<input type="hidden" name="metricName" id="metricName" />
		</form>
		<input type="hidden" id="exportTempFileName" value="<s:property value="%{analysisView.name}"/>"/>
		<div class="separated10"></div>
   <div id="dataTable" style="overflow-x:hidden;overflow-y:hidden">
   		<s:action name="historyContentAction!displayDatas" namespace="/report/history" executeResult="true" flush="false" >
   			<s:param name="analysisView.id"><s:property value="analysisView.id" /></s:param>
   		</s:action>
   </div>
  </div>
</div>
<script type="text/javascript">
$("#exportPdf").bind("click",function(){
	$("#exportType").val("pdf");
	var name=$("#exportTempFileName").val();
	var metric=$("#title").text();
	$("#exportFileName").val(name+"top10-"+metric+".pdf");
	var segTime=$("#selectSegTime").val();
	$("#segTime").val(segTime);
	var time=$("input[name='time']:checked").val();
	$("#time").val(time);
	$("#metric").val($("#metricId").val());
	$("#metricName").val($("#metricId option:selected").html());
	exportReport(); 
});
$("#exportExcel").bind("click",function(){	
	$("#exportType").val("xls");
	var name=$("#exportTempFileName").val();
	var metric=$("#title").text();
	$("#exportFileName").val(name+"top10-"+metric+".xls");
	var segTime=$("#selectSegTime").val();
	$("#segTime").val(segTime);
	var time=$("input[name='time']:checked").val();
	$("#time").val(time);
	$("#metric").val($("#metricId").val());
	$("#metricName").val($("#metricId option:selected").html());
	exportReport(); 
});
function exportReport() {
    $("#exportparams").attr("action", "${ctx}/report/history/historyDown!getDownLoadFile.action");
    $("#exportparams").submit();
}
</script>

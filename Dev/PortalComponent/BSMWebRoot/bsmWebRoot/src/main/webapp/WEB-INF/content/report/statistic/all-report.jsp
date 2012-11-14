<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="main">
<div class="main-right">
<div class="manage-content">
<div class="mid">
		<div class="indentation">
		<div class="h1">
		<span class="field-middle">搜索：</span><span>从</span><input type="text" id="allStartTime" size="30"/>
		<span>到</span><input type="text" id="allEndTime" size="30" /> <input type="text" value="请输入报告名称" id="queryReport" size="30"/><span class="ico ico-select" id="allQueryButton" title="搜索"></span>
		</div>
		</div>
</div>			
<page:applyDecorator name="indexcirgrid">
				<page:param name="id">allReportId</page:param>
				<page:param name="width">100%</page:param>
				<page:param name="height">580px</page:param>
				<page:param name="lineHeight">28px</page:param> 
				<page:param name="tableCls">grid-black</page:param>
				<page:param name="gridhead">[{colId:"reportType", text:"类型"},{colId:"cycle", text:"周期"},{colId:"reportName", text:"报告名称"},{colId:"creator", text:"创建人"},{colId:"createTime", text:"生成时间"},{colId:"exportReport", text:"导出"}]</page:param><!-- ,{colId:"export", text:"导出"} -->
				<page:param name="gridcontent">${reportInfo }</page:param>
</page:applyDecorator>
<div id="pageReport"></div>
</div>
</div>
</div>
<s:form id="allReportPage">
	<input type="hidden"  name="json" value="jsonType"/>
	<input type="hidden"  name="page" value="<s:property value="page" />"/>
	<input type="hidden"  name="userId" value="<s:property value="userId" />"/>
	<input type="hidden"  name="reportType" value="<s:property value="reportType" />"/>
	<input type="hidden"  name="reportID" value="<s:property value="reportID" />"/>
	<input type="hidden"  name="myReport" value="<s:property value="myReport" />"/>
	<input type="hidden"  name="startTime" value="<s:property value="startTime" />"/>
	<input type="hidden"  name="endTime"  value="<s:property value="endTime" />"/>
	<input type="hidden"  name="queryKey" value="<s:property value="queryKey" />"/>
	<input type="hidden"  name="orderTitle" value="<s:property value="orderTitle" />"/>
	<input type="hidden"  name="order" value="<s:property value="order" />"/>
</s:form>
<script type="text/javascript">
//开始时间
$("#allStartTime").click(function(){
	timeBox(this.id);
});
//结束时间    
$("#allEndTime").click(function(){
	timeBox(this.id);
});

$(document).ready(function(){
	var myDate = new Date(); 
	myDate.setDate(myDate.getDate()- 3); 
	$("#allEndTime").val(getDate(null));
	$("#allStartTime").val(getDate(myDate));
	var gp = new GridPanel({id:"allReportId",
		unit:"%",
		columnWidth:{reportType:10,cycle:10,reportName:34,creator:16,createTime:20,exportReport:10},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"reportType",defSorttype:"up"},
		             {index:"cycle"},
		             {index:"reportName"},
		             {index:"creator"},
		{index:"createTime"}
		],
		sortLisntenr:function($sort){
			$.blockUI({message:$('#loading')});
			if($sort.sorttype == "up"){
				$("input[name='order']","#allReportPage").attr("value","ASC");
			}else{
				$("input[name='order']","#allReportPage").attr("value","DESC");
			}	
			$("input[name='orderTitle']","#allReportPage").attr("value",$sort.colId);
			var ajaxParam = $("#allReportPage").serialize();
		     $.ajax({
		 		type: "POST",
		 		dataType:'json',
		 		url: "${ctx}/report/statistic/statisticManage!loadAllReport.action",
		 		data: ajaxParam,
		 		success: function(data, textStatus){    			
		 			gp.loadGridData(data.reportInfo);
		 			$.unblockUI();
		 		}
		 	  });
		}},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});			
gp.rend([{index:"reportType",fn:function(td){
		if(td.html){
			var ips = td.html.split(";");			
			if(ips[0]=="true"){
				$r=$("<span class=\"ico-16 ico-16-book-open\" id=\"ico"+ips[1]+"\" title=\"已阅\"></span><span title=\""+ips[2]+"\">"+ips[2]+"</span>");
			}else{
				$r=$("<span class=\"ico-16 ico-16-book\" id=\"ico"+ips[1]+"\" title=\"未阅\"></span><span title=\""+ips[2]+"\">"+ips[2]+"</span>");
			}		
			return $r;}
}},
{index:"reportName",fn:function(td){
	if(td.html){
		var ips = td.html.split(";");
		$r=$("<span style=\"cursor:pointer;\" id=\"report_"+ips[0]+"\" onclick=\"readReport(this)\" title=\""+ips[1]+"\">[报告]"+ips[1]+"</span>");		
		return $r;}	
}}]);	
	var page = new Pagination({applyId:"pageReport",listeners:{
        pageClick:function(page){
        	if(page==0){
          	  page=1;
            } 
        	$.blockUI({message:$('#loading')});
		  $("input[name='page']","#allReportPage").attr("value",page);
		  var ajaxParam = $("#allReportPage").serialize();
		     $.ajax({
		 		type: "POST",
		 		dataType:'json',
		 		url: "${ctx}/report/statistic/statisticManage!loadAllReport.action",
		 		data: ajaxParam,
		 		success: function(data, textStatus){    			
		 			gp.loadGridData(data.reportInfo);
		 			$.unblockUI();
		 		}
		 	  });
        }
      }});
    page.pageing(${sumPage},0);  
    
    $("#allQueryButton").bind("click",function(){
    	$.blockUI({message:$('#loading')});
    	var startTime=$("#allStartTime").val();
    	$("input[name='startTime']","#allReportPage").attr("value",startTime);
    	var endTime=$("#allEndTime").val();
    	$("input[name='endTime']","#allReportPage").attr("value",endTime);
    	var queryKey=$("#queryReport").val();
    	$("input[name='queryKey']","#allReportPage").attr("value",queryKey);
    	var ajaxParam = $("#allReportPage").serialize();
        $.ajax({
    		type: "POST",
    		dataType:'json',
    		url: "${ctx}/report/statistic/statisticManage!loadAllReport.action",
    		data: ajaxParam,
    		success: function(data, textStatus){  
    			gp.loadGridData(data.reportInfo);
    			$.unblockUI();
    		}
    	  });
    });
    $("#queryReport").bind("click",function(){
    	$(this).val("");
    });
});
</script>

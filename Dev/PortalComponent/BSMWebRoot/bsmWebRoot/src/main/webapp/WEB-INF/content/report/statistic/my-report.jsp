<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="main">
<div class="main-right">
<div class="manage-content">
<div class="mid">
<div class="h1"><span class="bold"><s:property value="customreportvo.getName() " /></span></div>
<div class="indentation">
<div class="h1">
<span>创建人：</span><span id="reportCreator"><s:property value="userName" /></span> 
<span>创建时间：</span><span id="reportCreateTime"><s:date format="yyyy/MM/dd HH:mm" name="customreportvo.getCreateTime()"/></span>
<span>报告周期：</span><span id="reportCyc"><s:property value="customreportvo.getPeriod().getDesc() " /></span>
<br>
<span>搜索： 从</span><input type="text" id="startTime" size="30"/><span>到</span><input type="text" id="endTime" size="30"/> <span class="ico ico-select" id="myQueryButton"></span></div>
</div>
</div>
<p>
<page:applyDecorator name="indexcirgrid">
	<page:param name="id">myReportId</page:param>
	<page:param name="width">100%</page:param>
	<page:param name="height">540px</page:param>
	<page:param name="lineHeight">26px</page:param> 
	<page:param name="tableCls">grid-gray</page:param>
	<page:param name="gridhead">[{colId:"reportType", text:"报告状态"},{colId:"reportName", text:"报告名称"},{colId:"createTime", text:"生成时间"},{colId:"exportReport", text:"导出"}]</page:param><!--  -->
	<page:param name="gridcontent">${myReportInfo }</page:param>
</page:applyDecorator>
<div id="pageReport"></div>
</div>
</div>
</div>
<s:form id="myReportPage">
	<input type="hidden"  name="json" value="jsonType"/>
	<input type="hidden"  name="page" value="<s:property value="page" />"/>
	<input type="hidden"  name="userId" value="<s:property value="userId" />"/>
	<input type="hidden"  name="reportType" value="<s:property value="reportType" />"/>
	<input type="hidden"  name="reportID" value="<s:property value="reportID" />"/>
	<input type="hidden"  name="myReport" value="<s:property value="myReport" />"/>
	<input type="hidden"  name="startTime" value="<s:property value="startTime" />"/>
	<input type="hidden"  name="endTime" value="<s:property value="endTime" />"/>
	<input type="hidden"  name="orderTitle" value="<s:property value="orderTitle" />"/>
	<input type="hidden"  name="order" value="<s:property value="order" />"/>
</s:form>
<script type="text/javascript">
$(function(){
	var myDate = new Date(); 
	myDate.setDate(myDate.getDate()-3); 
	$("#endTime").val(getDate(null));
	$("#startTime").val(getDate(myDate));	
	//开始时间 
	$("#startTime").click(function(){
		timeBox(this.id);
	});
	//结束时间  
	$("#endTime").click(function(){
		timeBox(this.id);
	});
	var gp = new GridPanel({id:"myReportId",
		unit:"%",
		columnWidth:{reportType:10,reportName:45,createTime:30,exportReport:15},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"reportType"},
		             {index:"reportName"},
		{index:"createTime",defSorttype:"down"}
		],
		sortLisntenr:function($sort){
			$.blockUI({message:$('#loading')});
			if($sort.sorttype == "up"){
				$("input[name='order']","#myReportPage").attr("value","ASC");
			}else{
				$("input[name='order']","#myReportPage").attr("value","DESC");
			}	
			$("input[name='orderTitle']","#myReportPage").attr("value",$sort.colId);	
			var ajaxParam = $("#myReportPage").serialize();
		     $.ajax({
		 		type: "POST",
		 		dataType:'json',
		 		url: "${ctx}/report/statistic/statisticManage!loadMyReport.action",
		 		data: ajaxParam,
		 		success: function(data, textStatus){    
		 			$.unblockUI();
		 			gp.loadGridData(data.myReportInfo);
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
	var page = new Pagination({applyId:"pageReport",listeners:{
        pageClick:function(page){
        	if(page==0){
          	  page=1;
            } 
        	$.blockUI({message:$('#loading')});
		  $("input[name='page']","#myReportPage").attr("value",page);
          var ajaxParam = $("#myReportPage").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'json',
      		url: "${ctx}/report/statistic/statisticManage!loadMyReport.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
      			$.unblockUI();
      			gp.loadGridData(data.myReportInfo);
      		}
      	  });
        }
      }});
    page.pageing(${sumPage},${page});
    
    $("#myQueryButton").bind("click",function(){
    	$.blockUI({message:$('#loading')});
    	var startTime=$("#startTime").val();
    	$("input[name='startTime']","#myReportPage").attr("value",startTime);
    	var endTime=$("#endTime").val();
    	$("input[name='endTime']","#myReportPage").attr("value",endTime);
    	var ajaxParam = $("#myReportPage").serialize();
        $.ajax({
    		type: "POST",
    		dataType:'json',
    		url: "${ctx}/report/statistic/statisticManage!loadMyReport.action",
    		data: ajaxParam,
    		success: function(data, textStatus){   
    			$.unblockUI();
    			gp.loadGridData(data.myReportInfo);   			
    		}
    	  });
    });
});


</script>
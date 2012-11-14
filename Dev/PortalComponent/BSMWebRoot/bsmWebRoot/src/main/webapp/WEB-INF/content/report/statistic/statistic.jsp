﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp" %> 
<meta name="decorator" content="headfoot" />
<page:applyDecorator name="headfoot">
	<page:param name="head">
		<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
		<link href="${ctxCss}/master.css"  rel="stylesheet" type="text/css"  />
		<link href="${ctxCss}/jquery-ui/treeview.css" type="text/css" rel="stylesheet"/>
		<link href="${ctxCss}/jquery-ui/jquery.ui.treeview.css" rel="stylesheet"type="text/css">
		<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
		<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />	
		<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
		<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
		<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js" ></script>
		<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>		
        <script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
        <script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
        <script type="text/javascript" src="${ctxJs}/report/statistic/statisticMetric.js"></script>
        <script type="text/javascript" src="${ctxJs}/report/statistic/statisticUtil.js"></script>		
	</page:param>	
	<page:param name="body"> 
	<div id="reportIndex" style="height:672px;" class="main-jk">
		<div class="ui-layout-west main-jk-left" id="locations" style="height:100%">
			<div class="left-panel-open" style="width:215px">
			   <div class="left-panel-l" >
			    <div class="left-panel-r">
			     <div class="left-panel-m">
			      <span class="left-panel-title">统计报告</span>
			     </div> 
			    </div>			    
			 </div>			 
			 <div class="left-panel-content" style="height:100%;">
			 	<div class="location-panel-content">
			     <div class="add-button1 underline-gray02 padding5 style="zoom:1;">
			     	<span title="定制报告" class="r-ico r-ico-add" onclick="loadAdd()"></span>	
			     </div>
			     <div id="statisticTree" style="overflow-x:auto;overflow-y:auto;height:580px;width:195px;"></div>
			 	</div>	
			 </div>			 		
			</div>
		</div>
      	<!-- 详细内容 -->
      	<div class="ui-layout-center main-jk-left" style="height:100%">    	
			<div id="have" style="height:100%" >
				<div id="reportContent" style="width:100%;height:100%;float:left">
				</div>
			</div>
		</div>
	</div>	
	</page:param>
</page:applyDecorator>
<form id="exportparams">
	<input type="hidden" name="reportID" id="reportID"/>
	<input type="hidden" name="exportFileName" id="exportFileName"/>
	<input type="hidden" name="exportFileType" id="exportFileType"/>
</form>
<script type="text/javascript">
var readReportPath;
var popInfo = new information();
var popCon=new confirm_box(); 
$(function(){	
	refresh();
	allReport("","","myreport");
	myLayout = $('#reportIndex').layout({	
//		enable showOverflow on west-pane so popups will overlap north pane
		west__showOverflowOnHover: false
	//	reference only - these options are NOT required because are already the 'default'
	,	closable:				true	// pane can open & close
	,	resizable:				true	// when open, pane can be resized 
	,	slidable:				true	// when closed, pane can 'slide' open over other panes - closes on mouse-out

	//	some resizing/toggling settings
	,	north__slidable:		false	// OVERRIDE the pane-default of 'slidable=true'
	,	north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
	,   north__closable:        false
	,	north__spacing_closed:	0		// big resizer-bar when open (zero height)
	,   north__spacing_open:0
	,	south__resizable:		false	// OVERRIDE the pane-default of 'resizable=true'
			// no resizer-bar when open (zero height)
	,	south__spacing_closed:	8		// big resizer-bar when open (zero height)
	,   south__spacing_open:8
	,   south__togglerLength_open:10
	,   south__togglerLength_closed:10
	//	some pane-size settings
	,   west__size:				215
	,	west__minSize:			100
	,   west__spacing_open:8
	,   west__spacing_closed:8
	,   west__togglerLength_open:36
	,   west__togglerLength_closed:36
	,	east__size:				300
	,	east__minSize:			200
	,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
	});	
});
//所有报告
function allReport(id,type,sign){
	$.blockUI({message:$('#loading')});
	var url="${ctx}/report/statistic/statisticManage!loadAllReport.action";
	var param="userId="+userId+"&reportID="+id+"&reportType="+type+"&myReport="+sign;
	$("#reportContent").load(url,param,function(){$.unblockUI();});	
	cacheReportObj.setShowReport("allReport");//记录调用的方法
	if(objValue.isNotEmpty(type)){
		cacheReportObj.setType(type);//记录调用的报告类型
	}
}
//我的报告
function myReport(id,type,sign){
	$.blockUI({message:$('#loading')});
	var url="${ctx}/report/statistic/statisticManage!loadMyReport.action";
	var param="userId="+userId+"&reportID="+id+"&reportType="+type+"&myReport="+sign;
	$("#reportContent").load(url,param,function(){$.unblockUI();});		
	cacheReportObj.setShowReport("myReport");//记录调用的方法
	if(objValue.isNotEmpty(type)){
		cacheReportObj.setType(type);//记录调用的报告类型
	}
}
//创建报告
function loadAdd() {
	popWindow("${ctx}/report/statistic/statisticManage!loadAddReport.action?userId="+userId,980, 580);
}
//订阅我的报告
function subscribeReport(id,name){
	cacheReportObj.setId(id);
	cacheReportObj.setName(name);
	popWindow("${ctx}/report/statistic/statisticManage!loadMailSubscribe.action?userId="+userId+"&reportID="+id,550,335);
}
//订阅成功后修改对应节点图标
function setIco(flag){
	var node=cacheReportObj.getNode();	
	if(flag=="true"){
		node.setIco("ico-16 ico-16-allmail");
	}else{
		node.setIco("ico-16 ico-16-mailpaper");
	}
	
}
//成功保存报告后刷新页面
function refresh(){	
	loadPage("${ctx}/report/tree/statisticTreeAction.action?userId="+userId+"&treeId=statisticReportTree&root="+cacheReportObj.getRoot()+"&reportType="+cacheReportObj.getType(),"statisticTree");			
}
//导出报告
function showReportInfo(obj){
	var reportId=$("#reportId_"+obj.id).val();	
	var reportName=$("#reportName_"+obj.id).val();	
	var reportType=$("#reportType_"+obj.id).val();	
	var ajaxParam=""
	var url="";
	var classValue=$(obj).attr("class");
	if(classValue=="ico ico-pdf"){		
		$("#reportID").val(obj.id);
		$("#exportFileName").val(reportName + ".pdf");
		$("#exportFileType").val("pdf");
		exportReport();
	}else if(classValue=="ico ico-excel"){
		$("#reportID").val(obj.id);
		$("#exportFileName").val(reportName + ".xls");
		$("#exportFileType").val("xls");
		exportReport();
	}else if(classValue=="ico ico-word"){				
	}else if(classValue=="ico ico-ie"){
		$("#reportID").val(obj.id);
		if(reportType=="Malfunction"){
			$("#exportFileName").val(reportName + ".zip");
			$("#exportFileType").val("zip");
		}else{
			$("#exportFileName").val(reportName + ".html");
			$("#exportFileType").val("html");
		}		
		exportReport();		
	}	
}

function exportReport() {
    $("#exportparams").attr("action", "${ctx}/report/statistic/statisticDown!getDownLoadFile.action");
    $("#exportparams").submit();
}
//在线阅读报告(HTML)
function readReport(obj){
	var url=document.URL;	
	var urls=url.split("/");
	var id=obj.id.split("_")[1];
	var params="height=768, width=1024, top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no"	
	var readUrl="${ctx}/report/statistic/statisticManage!loadReadReport.action?reportID="+id;
	classValue=$("#ico"+id).attr("class");
	if(classValue=="ico-16 ico-16-book"){
		var url="${ctx}/report/statistic/statisticManage!readReport.action";
		ajaxParam="reportID="+id;
		var result=submitFrom(url,ajaxParam);
		if(result){			
			$("#ico"+id).removeClass();
			$("#ico"+id).addClass("ico-16 ico-16-book-open");
			$("#ico"+id).attr("title","已阅");
		}	
	}	
	window.open("http://"+urls[2]+"/"+urls[3]+"/reportxml/"+id + ".html","",params);	
}
</script>
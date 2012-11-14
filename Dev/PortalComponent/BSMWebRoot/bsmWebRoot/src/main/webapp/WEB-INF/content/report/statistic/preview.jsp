<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<page:applyDecorator name="popwindow" title="预览">
	<page:param name="width">100%</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">previewReportID</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>	
	<page:param name="content">
		<div id="loading" class="loading for-inline" style="display:none;">
	  			<span class="vertical-middle loading-img for-inline"></span><span class="suojin1em">载入中，请稍候...</span> 
		</div>
		<div class="pop-m" id="reportPreview" style="height: 570px">			  
		</div>		
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
$(function(){
	$.blockUI({message:$('#loading')});
	var ajaxParam=dialogArguments.previewData;	
	var type=dialogArguments.previewType;	
	var url="${ctx}/report/statistic/statisticOper!savePreviewData.action";	
	if(type=="MachineRoom"){
		url="${ctx}/roomDefine/ReportViewVisit.action";			
	}	
	$.ajax({
		   type: "POST",
		   dataType:'html',
		   url: url,
		   data: ajaxParam,
		   success: function(data, textStatus){	
			   $("#reportPreview").html(data);
			   $.unblockUI();
		   }			
	 });	
});
$("#previewReportID").click(function(){
	window.close(); 
});
</script>
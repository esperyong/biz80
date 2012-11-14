<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />		
<link href="${ctxCss}/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">	
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">	
<link href="${ctxCss}/validationEngine.jquery.css" type="text/css"  rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script src="${ctxJs}/report/realFlash.js"></script>
<script src="${ctxJs}/report/realUtil.js"></script>
<script src="${ctxJs}/AnyChart.js" type="text/javascript"></script>
<page:applyDecorator name="popwindow" title="实时监控">
		<page:param name="width"></page:param>
		<page:param name="topBtn_index_1">1</page:param>
		<page:param name="topBtn_id_1">customizationReportID</page:param>
		<page:param name="topBtn_css_1">win-ico win-close</page:param>
		<page:param name="topBtn_title_1">关闭</page:param>
		<page:param name="content">	
			<div>
			<div class="fold-top"><span class="fold-top-title">刷新频率：5秒钟</span></div>
			<p>
			<div  style="text-align:center;"><b id="flashTitle">${title}</b><b>(</b><b>${unit}</b><b>)</b></div>			
			<div  id="realInstanceFlash"></div>
		</div>			
		</page:param>
</page:applyDecorator>
<script type="text/javascript">
var realChartObj = new AnyChart('${ctxFlash}/AnyChart.swf'); 
realChartObj.height = 300; 
realChartObj.width = 600; 
realChartObj.waitingForDataText="load...";
realChartObj.wMode='transparent';
realChartObj.write("realInstanceFlash");
var metricObj=new ChartData();//缓存保存Flash中的数据
var flashObj=new FlashObj(15);//flash对象
var INTERVAL=1;//flash显示数据时间段1分钟
var category="real";
var stop=0;//
function popShowFlash(metricType,instanceId,title,unit){
	if(objValue.isNotEmpty(unit)){
		metricObj.setUnit(unit);
	}else{
		metricObj.setUnit("-");
	}
	if(objValue.isNotEmpty(title)){
		metricObj.setTitle(title);
	}else{
		metricObj.setTitle("-");
	}
	//setTitle("flashTitle",title);
	realChartObj.setData(getFlashXml(0,0,title));
	if(metricType&&instanceId){
		var ajaxparame="metricType="+metricType+"&selectNodes="+instanceId+"&interval="+INTERVAL;
		var url="${ctx}/report/real/realManage!fectchData.action";
		stop=setInterval("getFlashData(\""+category+"\",\""+url+"\",\""+ajaxparame+"\",\""+instanceId+"\")",5000);
	}		
}
popShowFlash("${metricId}","${instanceId}","${title}","${unit}");
//关闭
$("#customizationReportID").click(function() {	
	window.close(); 
});	
</script>

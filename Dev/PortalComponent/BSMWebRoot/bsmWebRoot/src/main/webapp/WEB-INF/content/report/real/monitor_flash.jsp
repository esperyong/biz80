<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<script src="${ctxJs}/report/realFlash.js"></script>
<script src="${ctxJs}/report/realUtil.js"></script>
<script src="${ctxJs}/AnyChart.js" type="text/javascript"></script>
<div  style="text-align:center;"><b id="flashTitle"></b></div>
<div class="right">刷新频率：5秒钟</div>
<div  id="realInstanceFlash"></div>
<div><span class="sub-panel-tips">实时分析的前提是监控服务器与被监控设备网络连通，否则无法获取实时数据。</span></div>
<script type="text/javascript">
var realChartObj = new AnyChart('${ctxFlash}/AnyChart.swf'); 
realChartObj.height = 220; 
realChartObj.width = 370; 
realChartObj.waitingForDataText="load...";
realChartObj.wMode='transparent';
realChartObj.write("realInstanceFlash");
var metricObj=new ChartData();//缓存保存Flash中的数据
var flashObj=new FlashObj(15);//flash对象
var INTERVAL=1;//flash显示数据时间段1分钟
var category="real";
var stop=0;//
function popShowFlash(metricType,instanceId,title,unit){
	metricObj.setUnit(unit);
	metricObj.setTitle(title);	
	setTitle("flashTitle",title);
	realChartObj.setData(getFlashXml(0,0,title));
	if(metricType&&instanceId){
		var ajaxparame="metricType="+metricType+"&selectNodes="+instanceId+"&interval="+INTERVAL;
		var url="${ctx}/report/real/realManage!fectchData.action";
		stop=setInterval("getFlashData(\""+category+"\",\""+url+"\",\""+ajaxparame+"\",\""+instanceId+"\")",5000);
	}		
}
function stopInterval(){
	realChartObj=null;
	if(stop){
		clearInterval(stop);		
		stop=0;
	}
}
</script>

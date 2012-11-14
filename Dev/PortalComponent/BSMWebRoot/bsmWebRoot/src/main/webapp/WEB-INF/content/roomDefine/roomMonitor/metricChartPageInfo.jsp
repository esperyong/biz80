<!-- 机房-机房监控-监控一览 metricChartPageInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>监控一览</title>
<style>
.lamp-ling-red{ background-position:0 -208px;}
.lamp-ling-grey{ background-position:0 -224px;}
.lamp-ling-green{ background-position:0 -256px;}
</style>
<script type="text/javascript" language="JavaScript" src="${ctx}/js/AnyChart.js"></script>
</head>
  	<ul style="color:#FFFFFF">
	  	<li>
	  	<span>名称：<span class="<s:property value='picColor' />"></span><s:property value="resourceName" /> </span>&nbsp;&nbsp;&nbsp;&nbsp;
	  	<span>类型：<s:property value="catalogName" /></span>&nbsp;&nbsp;&nbsp;&nbsp;
	  	<span>备注：<s:property value="resourceDesc" /></span>
	  	</li>
  	</ul>
	<page:applyDecorator name="indexgrid">  
		<page:param name="id">metricTableId</page:param>
		<page:param name="width"></page:param>
		<page:param name="height">68px</page:param>
		<page:param name="linenum">0</page:param>
		<page:param name="tableCls">grid-gray</page:param>
		<page:param name="gridhead">[{colId:"h1",text:"指标名称"},{colId:"h2",text:"状态"},{colId:"h3",text:"正常区间"},{colId:"h4",text:"当前值"},{colId:"h5",text:"最近采集时间"}]</page:param>
		<page:param name="gridcontent"><s:property value="metricData" escape="false" /></page:param>
	</page:applyDecorator>
	<s:if test="metricData!=null && metricData != '[]'">
	<div style="height:350px;overflow:no">
	<div id="toolsdiv"  style="right:15px;position:relative;top:18px" >
	<ul style="width:100%;" >
	<li>
		<ul style="width:100%;">	
			<li style="display:inline"><span class="ico ico-pdf right" onClick="exportPDF()"> </span></li>
			<li style="display:inline"><span class="ico ico-excel right" onClick="exportExcel()"></span></li>
			<li style="display:inline" id="defineTimeId"><span class="ico ico-clock right" title="自定义时间段"></span></li>
			<li style="display:inline"><span name="freqDiv" id="30d" class="data-l right"><span class="data-r"><span class="data-m"><a id="30" onClick="timeBunClkFun(this);">30d</a></span></span></span></li>
			<li style="display:inline"><span name="freqDiv" id="14d" class="data-l right"><span class="data-r"><span class="data-m"><a id="14" onClick="timeBunClkFun(this);">14d</a></span></span></span></li>
			<li style="display:inline"><span name="freqDiv" id="7d" class="data-l right"><span class="data-r"><span class="data-m"><a id="7" onClick="timeBunClkFun(this);">7d</a></span></span></span></li>
			<li style="display:inline"><span name="freqDiv" id="1d" class="data-l right"><span class="data-r"><span class="data-m"><a id="1" onClick="timeBunClkFun(this);">1d</a></span></span></span></li>
			<li style="display:inline"><span name="freqDiv" id="0d" class="data-on-l right"><span class="data-r"><span class="data-m"><a id="0" onClick="timeBunClkFun(this);">1h</a></span></span></span></li>
	    </ul>
    </li>
    </ul>
    </div>
	<div id="anychartDisplayDivId" style="text-align:center;z-index:-100;overflow:none;top:13px;position:relative"></div>
	<span style="height:10px">&nbsp;</span>
	<div class="grid-gray" id="tabView" name="tabView" style="width:715px;position:relative;top:-9px">
		<div class="formhead" id="barName" name="barName" style="display:none;widht:100%">
			<table style="width:715px;">
				<thead>
					<tr>
						<th style="width:33%">
							<div class="theadbar-name">最大值</div>
						</th>
						<th style="width:33%">
							<div class="theadbar-name">最小值</div>
						</th style="width:30%">
						<th>
							<div class="theadbar-name">平均值</div>
						</th>
						
					</tr></thead></table>
		</div>
		<div class="formcontent" id="numInfor" name="numInfor" style="background:#fff;height:20px;display:none">
			<table>
				<tbody>
					<tr>
						<td style="width:25%"><span id="maxId"><s:property value="max" /></span></td>
						<td style="width:25%"><span id="minId"><s:property value="min" /></span></td>
						<td style="width:25%"><span id="avgId"><s:property value="avg" /></span></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	</s:if>
	
	<textarea id="textareaId" style="display:none"><s:property value="metricChartData" escape="false"/></textarea>
   <form id="metricTableFormID" action="" name="metricTableForm" method="post" namespace="/roomDefine">
   <input type="hidden" name="changeTime" id="changeTime" value="0" />
   <input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
   <input type="hidden" name="catalogId" id="catalogId" value="<s:property value='catalogId' />" />
   <input type="hidden" name="resourceId" id="resourceId" value="<s:property value='resourceId' />" />
   <input type="hidden" name="metricId" id="metricId" value="<s:property value='metricId' />" />
   <input type="hidden" name="metricDefaultId" id="metricDefaultId" />
   <input type="hidden" name="metricName" id="metricName" value="<s:property value='metricName' />" />
   
   
   </form>
   
   <form id="exportForm" name="exportForm">
   		<input type="hidden" name="changeTimeValue" id="changeTimeValue" value="0" />
   		<input type="hidden" name="roomIdValue" id="roomIdValue" value="0" />	
		<input type="hidden" name="catalogIdValue" id="catalogIdValue" value="0" />
		<input type="hidden" name="resourceIdValue" id="resourceIdValue" value="0" />
		<input type="hidden" name="metricIdValue" id="metricIdValue" value="0" />
		<input type="hidden" name="startTime" id="startTime" value="0" />
		<input type="hidden" name="endTime" id="endTime" value="0" />
		<input type="hidden" name="maxValue" id="maxValue" value="0" />
		<input type="hidden" name="minValue" id="minValue" value="0" />
		<input type="hidden" name="avgValue" id="avgValue" value="0" />
   </form>
   
   </div>
<script type="text/javascript">
var toast = new Toast({position:"RT"});

var chartStartTime="<s:property value='startTime'/>";
var chartEndTime="<s:property value='endTime'/>";
var chartChangeTime = "0";
var metricLineChart;

function dingzhiTimeFun(startTime,endTime){
	var changeTime = "self";
	var roomId = $("#roomId").val();
	var catalogId = $("#catalogId").val();
	var resourceId = $("#resourceId").val();
	var metricId = $("#metricId").val();
	if(metricId==null || metricId==""){
		metricId = $("#metricDefaultId").val();
	}

	ajaxDrawFlashFun(roomId,catalogId,resourceId,metricId,changeTime,startTime,endTime);
}

function timeBunClkFun(obj) {
	$("#changeTime").val(obj.id);
	var roomId = $("#roomId").val();
	var catalogId = $("#catalogId").val();
	var resourceId = $("#resourceId").val();
	var metricId = $("#metricId").val();
	if(metricId==null || metricId==""){
		metricId = $("#metricDefaultId").val();
	}
	$("#toolsdiv span[name=freqDiv]").attr("class","data-l right");
    $("#toolsdiv span[id="+obj.id+"d"+"]").attr("class","data-on-l right");

	
	ajaxDrawFlashFun(roomId,catalogId,resourceId,metricId,obj.id,"","");
}

function drawFlash(data) {
	metricLineChart = new AnyChart('${ctxFlash}/AnyChart.swf');
	metricLineChart.waitingForDataText = '正在加载,请稍候';
	metricLineChart.width = 750;
	metricLineChart.height = 300;
	metricLineChart.wMode = 'transparent';
	//metricLineChart.setXMLFile('${ctx}/anychart.xml');
	metricLineChart.setData(data);
	
	metricLineChart.write("anychartDisplayDivId");
	
}

function initdrawXml(){
	var textVal = $("#textareaId").val();
	
	if(null == textVal || textVal == "" ){
		//initdrawXml();
	}else{
		drawFlash(textVal);
	}
}
$("document").ready(function() {

	initdrawXml();
	//drawFlash($("#textareaId").val());
	var gp = new GridPanel({id:"metricTableId",
		unit:"%",
	    columnWidth:{h1:20,h2:20,h3:20,h4:20,h5:20},
	    plugins:[SortPluginIndex,TitleContextMenu],
            sortColumns:[],
            sortLisntenr:function($sort){
                   //alert($sort.colId);
                   //alert($sort.sorttype);
                      //gp.loadGridData();
              //   $.post("gridStore.html",function(data){
                // });
            },
			contextMenu:function(td){
			//alert("=="+td.colId);
		    }
        },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
        );
	gp.rend([{index:"h1",fn:function(td){
		if(td.html!="") {
			var str = td.html;
			var arr = str.split("@@");
			var metricDefaultId = arr[1].split("##")[3];
			if($("#metricDefaultId").val()==""){
				$("#metricDefaultId").val(metricDefaultId);
			}
			var $span = $('<span val="'+arr[1]+'" style="cursor:pointer" >'+arr[0]+'</span>');
			$span.bind("click",function(){
				var arrChild = arr[1].split("##");
				$("#roomId").val(arrChild[0]);
				$("#catalogId").val(arrChild[1]);
				$("#resourceId").val(arrChild[2]);
				$("#metricId").val(arrChild[3]);
				$("#metricDefaultId").val(arrChild[3]);
				$("#metricName").val(arr[0]);
				var changeTime = $("#changeTime").val();
				
				ajaxDrawFlashFun(arrChild[0],arrChild[1],arrChild[2],arrChild[3],changeTime,"","");
			});
			return $span;
	    }else{
		    return null;
	    }
      }
   },{index:"h2",fn:function(td){
	  // alert(td.html);
			if(td.html!="") {
				var $statePic;
				if(td.html == "1") {
			    	$statePic = $('<span class="lamp lamp-linggreen" val="'+td.html+'" style="cursor:default"></span>');
				}else if(td.html == "-1") {
			    	$statePic = $('<span class="lamp lamp-lingred" val="'+td.html+'" style="cursor:default"></span>');
				}else if(td.html == "0") {
			    	$statePic = $('<span  val="'+td.html+'"></span>');
				}else{
					$statePic = "";
				}
		    	return $statePic;
		    }else{
				return null;
		    }
	      }
	   }]);	
	var thisLeft = (screen.width-1000)/2;
	
	   document.getElementById("tabView").style.left = thisLeft;

});

function ajaxDrawFlashFun(roomId,catalogId,resourceId,metricId,changeTime,startTime,endTime) {
    chartChangeTime = changeTime;
	chartStartTime = startTime;
	chartEndTime = endTime;
	
	var metricName = $("#metricName").val();
	$.ajax({
		type: "post",
		dataType:'String', 
		cache:false,
		data:"catalogId="+catalogId+"&resourceId="+resourceId+"&roomId="+roomId+"&metricId="+metricId+"&changeTime="+changeTime+"&startTime="+startTime+"&endTime="+endTime+"&metricName="+metricName, 
		url: "${ctx}/roomDefine/ChangeTreeResPage!drawFlashData.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){

			$("#anychartDisplayDivId").find("*").unbind();
			$("#anychartDisplayDivId").html("");
			var arr = null;
			if(data != null && (data.indexOf("@@")>0)){
				arr = data.split("@@");

				var max = arr[0];
				var min = arr[1];
				var avg = arr[2];
								
				$("#maxId").html(max);
				$("#minId").html(min);
				$("#avgId").html(avg);
				drawFlash(arr[3]);

				chartStartTime = arr[4];
				chartEndTime = arr[5];
				
				if (arr[6]=="true"){
					$("#barName").show();
					$("#numInfor").show();
				}else{
					$("#barName").hide();
					$("#numInfor").hide();
				}
				
			}else{
				$("#barName").hide();
				$("#numInfor").hide();
				drawFlash("");
			}
			
		
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		
			alert("error");
		}
		});
}

$("#defineTimeId").click(function (event){
	var height = "200";
	var width = "400";
	var left = (screen.width-400)/2;
	var top = event.pageY+height/2;
	window.open ("${ctx}/roomDefine/DefineTimeVisit.action", "defineTimeWindowSJ", "height="+height+", width="+width+",left="+left+",top="+top+",toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
});

function exportExcel(){
	var pngImage = metricLineChart.getPng();
	initExportData();
	$.post("${ctx}/roomDefine/MonitorAnalyseExportActionVisit!saveImageData.action",{imageBase64Code:pngImage},
			function(){
				var thisURL = "${ctx}/roomDefine/MonitorAnalyseExportActionVisit!exportExcel.action";
				$("#exportForm").attr("action",thisURL);
				$("#exportForm").submit();
				//window.open("${ctx}/roomDefine/MonitorAnalyseExportActionVisit!exportExcel.action?catalogId="+catalogId+"&resourceId="+resourceId+"&roomId="+roomId+"&metricId="+metricId+"&changeTime="+chartChangeTime+"&startTime="+chartStartTime+"&endTime="+chartEndTime+"&maxValue="+maxValue+"&minValue="+minValue+"&avgValue="+avgValue,"_blank","width=400,height=250");
			});
	
}

function initExportData(){
	$("#roomIdValue").val($("#roomId").val());
	$("#catalogIdValue").val($("#catalogId").val());
	$("#resourceIdValue").val($("#resourceId").val());
	$("#metricIdValue").val($("#metricId").val());
	$("#startTime").val(chartStartTime);
	$("#endTime").val(chartEndTime);
	$("#metricIdValue").val($("#metricDefaultId").val());
}

function exportPDF(){
	var pngImage = metricLineChart.getPng();
	initExportData();

	$.post("${ctx}/roomDefine/MonitorAnalyseExportActionVisit!saveImageData.action",{imageBase64Code:pngImage},
			function(){
				var thisURL = "${ctx}/roomDefine/MonitorAnalyseExportActionVisit!exportPDF.action";
				$("#exportForm").attr("action",thisURL);
				$("#exportForm").submit();
				//window.open("${ctx}/roomDefine/MonitorAnalyseExportActionVisit!exportPDF.action?catalogId="+catalogId+"&resourceId="+resourceId+"&roomId="+roomId+"&metricId="+metricId+"&changeTime="+chartChangeTime+"&startTime="+chartStartTime+"&endTime="+chartEndTime+"&maxValue="+maxValue+"&minValue="+minValue+"&avgValue="+avgValue,"_blank","width=400,height=250");
			});
}



</script> 
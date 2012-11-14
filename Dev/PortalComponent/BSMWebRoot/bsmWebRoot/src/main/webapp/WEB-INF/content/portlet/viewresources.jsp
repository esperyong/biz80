<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<title>资源一览</title>
<style type="text/css">
.focus {
	border: 1px solid #f00;
	background: #fcc;
}

#metricSetting table td {
	vertical-align: middle;
	text-align: center;
}

#metricSetting table th {
	vertical-align: middle;
	text-align: center;
}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/AnyChart.js"></script>
<script type="text/javascript">
var path = "${ctx}";
var currentUserId = userId;
$(document).ready(function() {
	if("true"=="${firstset}"){
		$(".roundedform-content02").html("<div  style='margin:80px 0px 0px;display' class='textalign'>请点击<span style='cursor:default' class='ico-21 ico-21-setting'></span>进行设置。</div>");		
	}else{
		var showTables = eval(${showData});
		var chartUrl = "${chartUrl}";
		var view_type = "${view_type}"
		var resource_type = "${resource_type}";
		var count = 0;
		if(view_type=="changestate"){
			var statelight = new Array("lamp lamp-white","lamp lamp-whitegray");	
		}else{
			var statelight = new Array("lamp lamp-green","ico lampshine-ico lampshine-ico-greenred","ico lampshine-ico lampshine-ico-greenyellow","ico lampshine-ico lampshine-ico-greengray","lamp lamp-red-ncursor","lamp lamp-gray");	
		}
		$(".roundedform-content02").html("<div class='margin8' style=''><div class='left'><div id ='pa_div' class='pa'></div><span class='left' style=' margin-top:6px'>图例：</span> <span class='left box' style=' width:285px;'> <span class='left box' style='margin: 2px 4px'> <span class='green-box' style='height:8px'> </span><span class='lamp lamp-green'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='red-box' style='height:8px'> </span><span class='lamp lamp-red'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='grey-box' style='height:8px'> </span><span class='lamp lamp-grey'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='yellow-box' style='height:8px'> </span><span class='lampshine-ico lampshine-ico-greenyellow'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='blue-box' style='height:8px'> </span><span class='lampshine-ico lampshine-ico-greenred'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='white-box' style='height:8px'> </span><span class='lampshine-ico lampshine-ico-greengray'> </span> </span> </span> </div><div id='right_div' class='right' style='width:120px'><table class='grayhead-table grayborder table-width100' ><thead><tr><th class='vertical-middle bold textalign'>状态</th><th class='vertical-middle bold textalign'>数量</th></tr></thead><tbody id='showtable'></tbody></table></div></div>");
		$("#showtable").html("");
		if(showTables && showTables.length){
			create(showTables,view_type);
			for (var i =0 ; i<showTables.length ; i++){
				
				if(showTables[i]){
					$("#showtable").html($("#showtable").html()+"<tr><td class='textalign'><span  class='"+statelight[i]+"' style='cursor:default;margin-left: 0px;'></span></td><td  class='textalign'><a href='#' id="+showTables[i].state+" onclick='opendetail(this)'>"+showTables[i].value+"</a></td></tr>");
				}
				count = count + parseInt(showTables[i].value);
			}
			
			$("#showtable").html($("#showtable").html()+"<tr><td class='textalign'>合计</td><td  class='textalign'>"+count+"</td></tr>");
		}
		if(resource_type == "Resource"){
			$("#title_div").text("资源一览（全部）");
		}else if(resource_type == "host"){
			$("#title_div").text("资源一览（主机）");	
		}else if(resource_type == "networkdevice"){
			$("#title_div").text("资源一览（网络设备）");	
		}else if(resource_type == "storage"){
			$("#title_div").text("资源一览（存储设备）");	
		}else if(resource_type == "application"){
			$("#title_div").text("资源一览（应用）");	
		}else if(resource_type == "other"){
			$("#title_div").text("资源一览（其它）");	
		}
		$("#showtable tr:odd").attr("class","line");
	}
	//设置资源按钮点击事件
	$("#setting_resource").click(function(){
		var resource_type = $("#resource_type").val();
		var view_type = $("#view_type").val();
		var winOpenObj = {};
	  	winOpenObj.height = '280';
	  	winOpenObj.width = '250';
	  	winOpenObj.name = window;
	  	winOpenObj.url = "${ctx}/portlet/resources!openViewSet.action?resource_type="+resource_type+"&view_type="+view_type+"&userid=<%=userId%>";
	  	winOpenObj.scrollable = false;
	  	winOpenObj.resizeable = false;
	  	modalinOpen(winOpenObj); 
	  
	});
	
});
//自动刷新
function refresh(){
	$.ajax({
		type : "POST",
		dataType : 'json',
		url : "${ctx}/portlet/resources!refreshResources.action",
		data : "userid=<%=userId%>",
		success : function(data, textStatus) {
			try {
				rewrite(data);
			} catch (e) {
			}
		},
		fail : function(data, textStatus) {
			alert('fail');
		}
	});	
}
setInterval('refresh()',30000);
//刷新页面数据
function rewrite(data)
{
	var chartUrl = data.chartUrl;
	var view_type = data.view_type;
	var showTables = eval('(' + data.showData + ')');    
	var count = 0;
	$(".roundedform-content02").html("<div class='margin8' style=''><div class='left'><div id ='pa_div' class='pa'></div><span class='left' style=' margin-top:6px'>图例：</span> <span class='left box' style=' width:285px;'> <span class='left box' style='margin: 2px 4px'> <span class='green-box' style='height:8px'> </span><span class='lamp lamp-green'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='red-box' style='height:8px'> </span><span class='lamp lamp-red'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='grey-box' style='height:8px'> </span><span class='lamp lamp-grey'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='yellow-box' style='height:8px'> </span><span class='lampshine-ico lampshine-ico-greenyellow'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='blue-box' style='height:8px'> </span><span class='lampshine-ico lampshine-ico-greenred'> </span> </span><span class='left box' style='margin: 2px 4px'> <span class='white-box' style='height:8px'> </span><span class='lampshine-ico lampshine-ico-greengray'> </span> </span> </span> </div><div id='right_div' class='right' style='width:120px'><table class='grayhead-table grayborder table-width100' ><thead><tr><th class='vertical-middle bold textalign'>状态</th><th class='vertical-middle bold textalign'>数量</th></tr></thead><tbody id='showtable'></tbody></table></div></div>");
	$("#showtable").html("");
	if(showTables && showTables.length){
		create(showTables,view_type);
		for (var i =0 ; i<showTables.length ; i++){
			if(view_type=="changestate"){
				var statelight = new Array("lamp lamp-white","lamp lamp-whitegray");	
			}else{
				var statelight = new Array("lamp lamp-green","ico lampshine-ico lampshine-ico-greenred","ico lampshine-ico lampshine-ico-greenyellow","ico lampshine-ico lampshine-ico-greengray","lamp lamp-red","lamp lamp-gray");	
			}
			if(showTables[i]){
				$("#showtable").html($("#showtable").html()+"<tr ><td class='textalign'><span class='"+statelight[i]+"' style='cursor:default;margin-left: 0px;'></span></td><td  class='textalign'><a href='#' id="+showTables[i].state+" onclick='opendetail(this)'>"+showTables[i].value+"</a></td></tr>");
			}
			count = count + parseInt(showTables[i].value);
		}
		$("#showtable").html($("#showtable").html()+"<tr ><td class='textalign'>合计</td><td  class='textalign'>"+count+"</td></tr>");
	}
	if(data.resource_type == "Resource"){
		$("#title_div").text("资源一览（全部）");
	}else if(data.resource_type == "host"){
		$("#title_div").text("资源一览（主机）");	
	}else if(data.resource_type == "networkdevice"){
		$("#title_div").text("资源一览（网络设备）");	
	}else if(data.resource_type == "storage"){
		$("#title_div").text("资源一览（存储设备）");	
	}else if(data.resource_type == "application"){
		$("#title_div").text("资源一览（应用）");	
	}else if(data.resource_type == "other"){
		$("#title_div").text("资源一览（其它）");	
	}
	$("#resource_type").val(data.resource_type);
	$("#view_type").val(data.view_type);
	$("#showtable tr:odd").attr("class","line");
}
//打开资源详细信息页面
function opendetail(obj){
	var state = $(obj).attr("id");
	var winOpenObj = {};
	var view_type = $("#view_type").val();
	var resource_type = $("#resource_type").val();
  	winOpenObj.height = '500';
  	winOpenObj.width = '600';
  	winOpenObj.name = window;
  	winOpenObj.url = "${ctx}/monitor/monitorList!getPortletDetailList.action?pointId="+resource_type+"&whichGrid=portlet&whichState="+state+"&currentUserId=<%=userId%>&pointLevel=1&view_type="+view_type;
  	winOpenObj.scrollable = false;
  	winOpenObj.resizeable = false;
  	modalinOpen(winOpenObj);
}
//统计图生成
function createPicture(xml, width, height){
		AnyChart.noDataText = "===";
		var chart = new AnyChart('${ctx}/flash/AnyChart.swf');
		chart.addEventListener('pointClick');
		chart.waitingForDataText='数据量较大,请稍候'; 
		chart.width = width;
		chart.height = height;
		chart.wMode='transparent';
		chart.setData(xml);
		//chart.setXMLFile(xml);
		chart.write("pa_div");
	}
function onPointClick(e) {
		// Read point name
		name=e.data.Name;
		// Read point value
		value=e.data.YValue;
		// Read custom point attribute
		attribute = e.data.Attributes['test'];
		// Write the info to the page
		info = 'Point Name: ' + name + ', Value: ' + value + '<br>' + 'Test Attribute: ' + attribute;
		alert(info);
	}
function create(showTables,view_type){
		if(view_type=="changestate"){
			var CHART_COLOR=new Array("Green","orange");
			var STATE_LIGHT = new Array("未变更","变更");
		}else{
			var CHART_COLOR=new Array("Green","blue","yellow","Gray Cliffs","red","gray");
			var STATE_LIGHT = new Array("可用","警告","次要","严重","不可用","未知");
		}
		var beforeAnychartXml=[];
		beforeAnychartXml.push("<anychart>");
		beforeAnychartXml.push("<settings><animation enabled=\"True\"/></settings>");
		beforeAnychartXml.push("<charts>");
		beforeAnychartXml.push("<chart plot_type=\"Pie\">");
		beforeAnychartXml.push("<data_plot_settings enable_3d_mode=\"falsh\"><pie_series><marker_settings enabled=\"true\"><marker type=\"None\" /><states><hover><marker type=\"Circle\" anchor=\"CenterTop\" /></hover></states></marker_settings></pie_series></data_plot_settings>");
		beforeAnychartXml.push("<data><series name=\"状态统计\" type=\"Pie\">");
		for(var i=0;i<showTables.length;i++){
			  beforeAnychartXml.push('<point name=\"'+STATE_LIGHT[i]+'\" y=\"'+showTables[i].value+'\"  color=\"'+CHART_COLOR[i]+'\" />');
		}
		beforeAnychartXml.push("</series></data>");
		beforeAnychartXml.push("<chart_settings><chart_background enabled=\"true\"/><title enabled=\"true\" padding=\"1\"><text>状态统计</text></title><legend enabled=\"false\" ignore_auto_item=\"true\" position=\"Right\"><title enabled=\"false\"/><items><item source=\"points\" /></items></legend></chart_settings>");
		beforeAnychartXml.push("</chart></charts></anychart>");
		var ANYCHARTXML = beforeAnychartXml.join("");
		createPicture(ANYCHARTXML , '300', '180');
	}

</script>
</head>
<body bgcolor="black">
	<input type="hidden" id="resource_type" value="${resource_type}" />
	<input type="hidden" id="view_type" value="${view_type}" />
	<page:applyDecorator name="portlet" title="资源一览">
		<page:param name="topBtn_index_1">1</page:param>
		<page:param name="topBtn_id_1">setting_resource</page:param>
		<page:param name="topBtn_css_1">ico-21 ico-21-setting right f-absolute</page:param>
		<page:param name="topBtn_style_1">right:0;top:0</page:param>
		<page:param name="topBtn_title_1">设置</page:param>
		<page:param name="content">
			<div style="height: 240px" class="roundedform-content02"
				style="background:white"></div>
		</page:param>
		</div>
	</page:applyDecorator>
</body>
</html>
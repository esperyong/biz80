var CHART_COLOR=new Array("FCFF00","BA00FF","FF0000","00FF1E","2C85FF","FF00AE");
var CHART_UNIT=new Array("%","毫秒","包/秒","Mbps");
var major_interval=30;
var beforeAnychartXml=[];
beforeAnychartXml.push("<anychart>");
beforeAnychartXml.push("<settings><locale><date_time_format><format>%u</format></date_time_format></locale></settings>");
beforeAnychartXml.push("<charts><chart plot_type=\"Scatter\">");
beforeAnychartXml.push("<styles>");
beforeAnychartXml.push("<line_style name=\"style1\"><line enabled=\"true\" thickness=\"2\" /></line_style>");
beforeAnychartXml.push("<marker_style name=\"myMarker\">");
beforeAnychartXml.push("<states><normal><marker size=\"3\" /></normal><hover><marker size=\"6\" /></hover></states>");
beforeAnychartXml.push("</marker_style>");
beforeAnychartXml.push("</styles>");
beforeAnychartXml.push("<data_plot_settings>");
beforeAnychartXml.push("<line_series style=\"style1\"><marker_settings enabled=\"true\" style=\"myMarker\" />");
beforeAnychartXml.push("<tooltip_settings enabled=\"True\"><format>{%SeriesName} {%YValue}");
var ANYCHART_XML_SUFIX=beforeAnychartXml.join("");
var unitAnychartXml=[];
unitAnychartXml.push("{%XValue}{dateTimeFormat:%HH}:{%XValue}{dateTimeFormat:%mm}:{%XValue}{dateTimeFormat:%ss}</format></tooltip_settings>"); 
unitAnychartXml.push("</line_series></data_plot_settings><data>");		
var ANYCHART_XML_UNIT=unitAnychartXml.join("");
var endAnychartXml=[];
endAnychartXml.push("<labels>");
endAnychartXml.push("<format>{%Value}{dateTimeFormat:%HH}:{%Value}{dateTimeFormat:%mm}:{%Value}{dateTimeFormat:%ss}</format>");
endAnychartXml.push("</labels>");
endAnychartXml.push("<title enabled=\"False\"></title></x_axis><y_axis>");
endAnychartXml.push("<title enabled=\"False\" />");
endAnychartXml.push("<scale minimum=\"0\" ></scale></y_axis>");
endAnychartXml.push("</axes>");
endAnychartXml.push("<chart_background enabled=\"True\"><fill><gradient><key color=\"#bbbbbb\"/></gradient></fill></chart_background>");
endAnychartXml.push("</chart_settings>");
endAnychartXml.push("</chart>");
endAnychartXml.push("</charts>");
endAnychartXml.push("</anychart>");
var ANYCHART_XML_END=endAnychartXml.join("");

var endOtherAnychartXml=[];
endOtherAnychartXml.push("<labels>");
endOtherAnychartXml.push("<format>{%Value}{dateTimeFormat:%HH}:{%Value}{dateTimeFormat:%mm}:{%Value}{dateTimeFormat:%ss}</format>");
endOtherAnychartXml.push("</labels>");
endOtherAnychartXml.push("<title enabled=\"False\"></title></x_axis><y_axis>");
endOtherAnychartXml.push("<title enabled=\"False\" />");
endOtherAnychartXml.push("<scale minimum=\"0\" maximum=\"100\"></scale></y_axis>");
endOtherAnychartXml.push("</axes>");
endOtherAnychartXml.push("<chart_background enabled=\"True\"><fill><gradient><key color=\"#bbbbbb\"/></gradient></fill></chart_background>");
endOtherAnychartXml.push("</chart_settings>");
endOtherAnychartXml.push("</chart>");
endOtherAnychartXml.push("</charts>");
endOtherAnychartXml.push("</anychart>");
var ANYCHART_XML_ENDOTHER=endOtherAnychartXml.join("");

function Data(time, value) {
	this.time = time;
	this.value = value;
}
function SeriesData() {
	this.instanceId = null;
	this.name = null;
	this.datas = new Array();
}
function ChartData() {
	this.startTime = null;
	this.endTime = null;
	this.title = null;
	this.unit = null;
	this.series = new Array();	
}
ChartData.prototype={
		setCatchData :function (id,name,time,value) {
			if(name.indexOf("\"")>0||name.indexOf("<")>0||name.indexOf(">")>0||name.indexOf("'")>0||name.indexOf("&")>0)//对xml中双引号,大小号转义
			{
				name=name.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&apos;");
			}			
			if(time.length>10){
				time=time.substring(0,10);
			}			
			if(value!=""&&value!=null){			
				var flag=true;		
				for(var i=0;i<this.series.length;i++){
					var seriesObj= this.series[i];			
					if(seriesObj.instanceId==id){				
						var dataObj=new Data(time,value);
						seriesObj.datas.push(dataObj);
						flag=false;
						break;
					}
				}
				if(flag || this.series.length==0){//添加新的实例							
					var dataObj=new Data(time,value);
					var seriesObj=new SeriesData();
					seriesObj.instanceId=id;
					seriesObj.name=name;
					seriesObj.datas.push(dataObj);
					this.series.push(seriesObj);
				}
			} 
		},
		getSeriesDataById:function(id){
			var seriesObj=null;					
			if(this.series.length!=0){				
				for(var i=0;i<this.series.length;i++){						
					if(this.series[i].instanceId==id){		
						seriesObj= this.series[i];
						break;
					}
				}
			}			
			return seriesObj;
		},		
		deleteSeriesData:function(instanceId) {
			var seriesTemp=new Array();//记录需要删除SeriesData对象	
			for(var i=0;i<this.series.length;i++){
				if(instanceId==this.series[i].instanceId){
					seriesTemp.push(this.series[i]);
				}			
			}
			//删除资源实例中没有节点值的对象
			if(seriesTemp.length>0){
				for(var t=0;t<seriesTemp.length;t++){
					this.series.remove(seriesTemp[t]);
				}
			}
		},	
		/**
		 * instanceIds资源ID用“,”分割
		 */
		getChartXml:function (instanceIds) {
			var xml =[];			
			xml.push(ANYCHART_XML_SUFIX);
			xml.push(this.unit);
			xml.push(ANYCHART_XML_UNIT);
			var ids = instanceIds.split(',');
			for(var i=0;i<ids.length;i++) {
				if(objValue.isNotEmpty(ids[i])){
					for(var j=0;j<this.series.length;j++) {
						var seriesDataObj=this.series[j];
						if(ids[i] == seriesDataObj.instanceId) {
							xml.push("<series name=\""+seriesDataObj.name+"\" type=\"Line\" color=\"#"+CHART_COLOR[i]+"\">");
							xml.push(getServiesData(this.startTime,this.endTime,seriesDataObj));			
							xml.push("</series>");	
						}
					}
				}				
			}		
			xml.push("</data><chart_settings><title enabled=\"false\"><text>"+this.title+"</text></title><axes><x_axis>");
			xml.push("<scale type=\"DateTime\" major_interval=\""+major_interval+"\" minor_interval=\"5\"  minor_interval_unit=\"Second\" major_interval_unit=\"Second\" minimum=\""+this.startTime+"\" maximum=\""+this.endTime+"\"/>");
			if(this.unit=="%"){
				xml.push(ANYCHART_XML_ENDOTHER);		
			}else{
				xml.push(ANYCHART_XML_END);		
			}															
			return xml.join("");
		},
		setStartAndEndTime:function(startTime, endTime){this.startTime = startTime;this.endTime = endTime;},
		cleanData:function(){this.series.length=0;},
		setTitle:function(title){this.title=title;},
		setUnit:function(unit){this.unit=unit;}		
};
//指定数组元素删除
Array.prototype.indexOf = function(val) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == val) return i;
	}
	return -1;
}
Array.prototype.remove = function remove(val) {
	var index = this.indexOf(val);
	if (index > -1) {
		this.splice(index, 1);
	}
}
function setMajor_interval(newInterval)
{
	var major_interval=newInterval
}
/**
 * 获得servies数据
 * @param starttime 开始时间
 * @param endtime  结束时间
 * @param seriesDataObj 
 * @returns {String}
 */
function getServiesData(starttime,endtime,seriesDataObj){
	var seriesData="";
	var dataTemp=new Array();//记录需要删除Data对象
	if(seriesDataObj.datas!=null){	
		for(var j=0;j<seriesDataObj.datas.length;j++){
			var data=seriesDataObj.datas[j];
			var time=parseInt(data.time);
			var starttime=parseInt(starttime);
			var endtime=parseInt(endtime);
			if(time-starttime>=0&&endtime-time>=0&&data.value!=""&&data.value!=null){//判断点是否超时				
				seriesData=seriesData+"<point x=\""+data.time+"\" y=\""+data.value+"\" />";
			}
			else{					
				dataTemp.push(data);
			}
		}			
		if(dataTemp.length>0){//删除坏点
			for(var k=0;k<dataTemp.length;k++){
				seriesDataObj.datas.remove(dataTemp[k]);
			}
		}
	}
	return seriesData;
}
//全局flash对象 
function FlashObj(newInterval){
	this.prediv=null;
	this.flashObj=null;
	major_interval=newInterval
}
FlashObj.prototype={
		getFlashObj :function (div) {
			if(this.prediv!=div||this.prediv==null){
				this.flashObj=(new Function("return "+div+"ChartObj" ))();
			}
			return this.flashObj;
		}
};
//显示Flash
function getFlashXml(startTime,endTime,title){
	var xml=[];
	xml.push(ANYCHART_XML_SUFIX);
	xml.push(" ");
	xml.push(ANYCHART_XML_UNIT);
	xml.push("<series name=\"1\" type=\"Line\" color=\"#FCFF00\">");
	xml.push("<point x=\""+endTime+"\" y=\"\" />");	
	xml.push("</series>");	
	xml.push("</data><chart_settings><title enabled=\"false\"><text>"+title+"</text></title><axes><x_axis>");
	xml.push("<scale type=\"DateTime\" major_interval=\""+major_interval+"\" minor_interval=\"5\"  minor_interval_unit=\"Second\" major_interval_unit=\"Second\" minimum=\""+startTime+"\" maximum=\""+endTime+"\"/>");
	xml.push(ANYCHART_XML_ENDOTHER);														
	return xml.join("");	
}
//获取xml对象
function getXmlDom(xmlData){
	if(objValue.isNotEmpty(xmlData)){
		var xmldom = new ActiveXObject("Msxml2.DOMDocument");
		xmldom.loadXML(xmlData);
		return xmldom;
	}
}
//返回资源节点对象
function getNodeObj(xmlData,xpath){	
	if(objValue.isNotEmpty(xmlData)&&objValue.isNotEmpty(xpath)){
		var instanceinfo=xmlData.replace(/&amp;/g, "&").replace(/&quot;/g, "\"").replace(/&lt;/g, "<").replace(/&gt;/g, ">");	
		var xmldom=getXmlDom(instanceinfo);	
		var instanceNodes=xmldom.getElementsByTagName(xpath);
		return instanceNodes;
	}
	return null;
}
//获得节点值
function getNodeValue(node,xpath){
	var result="";
	if(node!=null){
		var nodeObj=node.getElementsByTagName(xpath)[0];
		if(nodeObj!=null){
			result=nodeObj.text;
		}
	}
	return result;
}
//解析数据
function parseXmlData(xmlData){
	if(objValue.isNotEmpty(xmlData)){		
		var xmldom =getXmlDom(xmlData);
		try{
			var starttime=xmldom.getElementsByTagName('metrics/startime')[0].text;
			var endtime=xmldom.getElementsByTagName('metrics/endtime')[0].text;
			if(objValue.isNotEmpty(starttime)&&objValue.isNotEmpty(endtime)){	
				if(starttime.length>10){
					starttime=starttime.substring(0,10);
				}
				if(endtime.length>10){
					endtime=endtime.substring(0,10);
				}		
				metricObj.setStartAndEndTime(starttime,endtime);
				var instanceNodes=xmldom.getElementsByTagName('metrics/metric/instance');		
				if(instanceNodes!=null){
					for(var i=0;i<instanceNodes.length;i++){
						var instanceNode=instanceNodes[i];											
						var id=getNodeValue(instanceNode,"id");
						var name=getNodeValue(instanceNode,"name");	
						var time=getNodeValue(instanceNode,"time");
						var value=getNodeValue(instanceNode,"value");
						metricObj.setCatchData(id,name,time,value);	
					}
				}				
			}			
		}catch(e){
			return false;
		}	
		return true;
	}
}
//Flash赋值
function setEquipmentChart(instanceId,category) {
	if(objValue.isNotEmpty(instanceId)){
		var chartData=metricObj.getChartXml(instanceId);
		if(objValue.isNotEmpty(chartData)){
			var obj=flashObj.getFlashObj(category);
			if(obj!=null&&stop!=0){
				obj.setData(chartData);
			}
		}
	}	
}
//获取Flash值
function getFlashData(category,url,ajaxparame,instanceId){	
	var sign=category;
	if(isSend){
		isSend=false;//标识已经发送了请求
		if(stop){
			$.ajax({
				type: "POST",
				dataType:'string',
				url: url,
				data:ajaxparame,
				success: function(xmlData, textStatus){					
					if(parseXmlData(xmlData)){
						setEquipmentChart(instanceId,sign);	
						isSend=true;//标识请求已经成功返回
					}					
				}		
			});
		}
	}else{
		if(metricObj.endTime!=null
				&&metricObj.startTime!=null){
			var falg=false;
			var starttime=parseInt(metricObj.startTime);
			var endtime=parseInt(metricObj.endTime);
			var subTime=5;
			if(objValue.isNotEmpty(oldtimevalue)){
				subTime=oldtimevalue/1000;	
			}					
			starttime=starttime+subTime;
			endtime=endtime+subTime;
			metricObj.setStartAndEndTime(starttime,endtime);
			var showTime=endtime-1;
			var instanceIds=instanceId.split(",");
			for(var i=0;i<instanceIds.length;i++) {
				if('' == instanceIds[i]){continue;}
				if(objValue.isNotEmpty(instanceIds[i])){
					var seriesData=metricObj.getSeriesDataById(instanceIds[i]);
					if(seriesData!=null){
						var name=seriesData.name;
						var datas=seriesData.datas;
						if(datas!=null){
							var len=datas.length;
							if(len>0){
								var data=datas[len-1];
								var value=data.value;
								if(objValue.isNotEmpty(value)){
									metricObj.setCatchData(instanceIds[i],name,showTime,value);	
									var falg=true;
								}
							}																			
						}
					}	
				}							
			}
			if(falg){
				setEquipmentChart(instanceId,sign);	
			}			
		}
	}	
}
//设置标题
function setTitle(div,title){
	$("#"+div).html(title);
}
//停止刷新
function stopRefresh(){
	if(stop){
		clearInterval(stop);
		stop=0;
	}	
	isSend=true;
}
//判断是否为空
var objValue={};
objValue.isNotEmpty=function(val){
	if(val==undefined||val==null||val==""){
		return false;		
	}
	return true;
}
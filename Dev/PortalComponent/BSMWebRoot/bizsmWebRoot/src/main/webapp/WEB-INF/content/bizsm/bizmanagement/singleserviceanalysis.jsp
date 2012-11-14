<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<jsp:directive.page import="com.mocha.bsm.event.type.Module"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:单个业务服务分析
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-single-analysis
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务分析</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="/pureportal/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<style type="text/css" media="screen">
 html,body{height:100%;width:100%}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>


<script language="javascript">

	var realWidth = 0, realHeight = 0;


	$(function() {

		realWidth = document.body.clientWidth;
		realHeight = document.body.clientHeight;

		$('#flashContent').css("width", realWidth);

		//$('#bizsrvanalysis').css("width", realWidth-50);
		//$('#bizsrvanalysis').css("height", realHeight);

		$('div[elID="search_el"]').css("width", "735px");
		$('div[elID="search_el"]>div.bg').css("width", "735px");

		//初始化日历组件样式
		$wdate = true;
		var $dateTxt = $('input[id="startDate_txt"],input[id="endDate_txt"]');
		$dateTxt.addClass("WdateGray");//WdateGray
		$dateTxt.css("cursor", "hand");
		$dateTxt.css("border", "0px solid #FF0000");
		$dateTxt.css("border-bottom", "1px solid #CCC");
		$dateTxt.attr("readOnly", true);

		$dateTxt.bind("focus", function(event){
			WdatePicker();//{isShowWeek:true}
		});
		$dateTxt.bind("click", function(event){
			var $this = $(this);
			//$this.focus();//{isShowWeek:true}
			WdatePicker();
		});

		//绑定时间范围radio click事件
		$('input[id="timeArea-1_rdo"],input[id="timeArea-2_rdo"]').click(function(){
			var $this = $(this);
			if($this.attr("value") == "1"){
				$('select[id="timeArea_sel"]').attr("disabled", false);
				$('input[id="startDate_txt"],input[id="endDate_txt"]').attr("disabled", true);

				$dateTxt.removeClass("Wdate");
				$dateTxt.addClass("WdateGray");
			}else{
				$('select[id="timeArea_sel"]').attr("disabled", true);
				$('input[id="startDate_txt"],input[id="endDate_txt"]').attr("disabled", false);

				$dateTxt.removeClass("WdateGray");
				$dateTxt.addClass("Wdate");
			}
		});
		$('input[id="timeArea-1_rdo"]').click();




		$('#startDate_img,#endDate_img').css("cursor", "hand").click(function(){
			var $this = $(this);

			var inputSrcID = "";
			if($this.attr("id") == "startDate_img"){
				inputSrcID = "startDate_txt";
			}else if($this.attr("id") == "endDate_img"){
				inputSrcID = "endDate_txt";
			}
			WdatePicker({el:inputSrcID});
		});

		//分析按钮
		$('#analysis_btn').click(function(){
			if($('input[id="timeArea-2_rdo"]').get(0).checked){
				var s_date = $('input[id="startDate_txt"]').val();
				var e_date = $('input[id="endDate_txt"]').val();
				if(s_date == ""){
					//alert("请选择开始时间！");
					var _information  = top.information();
					_information.setContentText("请选择开始时间！");
					_information.show();
					return false;
				}
				if(e_date == ""){
					//alert("请选择结束时间！");
					var _information  = top.information();
					_information.setContentText("请选择结束时间！");
					_information.show();
					return false;
				}
				var d1 = new Date(s_date.replace(/\-/g, "\/"));
				var d2 = new Date(e_date.replace(/\-/g, "\/"));
				if(d2 < d1) {
					//alert("开始日期不能大于结束日期。");
					var _information  = top.information();
					_information.setContentText("开始日期不能大于结束日期。");
					_information.show();
					return false;
				}
				if(compareDateWithSysDate(d2)){
					//alert("结束日期不能大于系统当前日期。");
					var _information  = top.information();
					_information.setContentText("结束日期不能大于系统当前日期。");
					_information.show();
					return false;
				}
			}
			var kpiValue = $('#kpiIndex_sel>option:selected').attr("value");
			var uriQeuryData = f_makeAnalysisDataStr();
			var uriStr = "${ctx}/bizservice-kpi-statistics/.xml?q="+uriQeuryData;
			//call flash 业务分析分析图标
			analysisChart(uriStr, kpiValue);
		});

		//load flash
		var kpiValue = $('#kpiIndex_sel>option:selected').attr("value");
		var uriQeuryData = f_makeAnalysisDataStr();
		var uriStr = "${ctx}/bizservice-kpi-statistics/.xml?q="+uriQeuryData;
		f_loadCurrFlash(uriStr, kpiValue);

		eventlistInit();

	});

	function f_makeAnalysisDataStr(){
		var uriInfo = '{';

		var serviceIdStr = '"serviceIds":["'+parent.currentServiceID_global+'"]';

		uriInfo += serviceIdStr+',';

		var indexStr =  '"index":"'+$('#kpiIndex_sel>option:selected').attr("value")+'"';

		uriInfo += indexStr+',';

		var rangeStr = '"range":{';
		if($('#timeArea-2_rdo').attr("checked") == "true"
			|| $('#timeArea-2_rdo').attr("checked") == true){
			rangeStr += '"rangeType":"CUSTOM",';
			rangeStr += '"beginTime":"'+$('#startDate_txt').val()+'",';
			rangeStr += '"endTime":"'+$('#endDate_txt').val()+'"';
		}else{
			rangeStr += '"rangeType":"'+ $('#timeArea_sel>option:selected').attr("value")+'"';
		}
		rangeStr += '}';

		uriInfo += rangeStr+',';

		uriInfo += '"interval":'+1440;
		uriInfo += '}';

		return uriInfo;
	}

	 function f_setCursorPos(el){
	   var txtRange = el.createTextRange();
	   txtRange.moveStart("character",el.value.length);
	   txtRange.moveEnd("character",0);
	   txtRange.select();
	}

	function f_loadCurrFlash(chartURI, chartTitle){
		var swfVersionStr = "10.0.0";
		var xiSwfUrlStr = "playerProductInstall.swf";
		var flashvars = {};
		//flashvars["uri"] = "./testAssets/FullData.xml";
		flashvars["webRootPath"] = "${ctx}/";
		flashvars["chartURL"] = encodeURIComponent(chartURI);
		flashvars["chartTitle"] = encodeURIComponent(chartTitle);

		var params = {};
		params.quality = "high";
		params.bgcolor = "#ffffff";
		params.allowscriptaccess = "always";
		params.wmode = 'transparent';
		params.allowfullscreen = "true";
		params.enablejs= "true";

		var attributes = {};
		attributes.id = "BizChartForm";
		attributes.name = "BizChartForm";
		attributes.align = "left";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/BizChartForm.swf", "flashContent",
			realWidth-50, realHeight/2.5,
			swfVersionStr, xiSwfUrlStr,
			flashvars, params, attributes);
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");


		initFlashContentObj("BizChartForm");
	}

	function eventlist(srvId, serverName, startTime, endTime){
		var boxHeight = 0;
		boxHeight = Math.round(realHeight*0.33);

		if(srvId == ""){
			srvId = parent.currentServiceID_global;
			$("#bizsrvanalysis").load("/pureportal/event/extensionEvent!extensionEventList.action",{moduleId:"<%=Module.SERVICE%>",instanceId:srvId,pageSize:"9",height:boxHeight},function(){});
		}else{
			$("#bizsrvanalysis").load("/pureportal/event/extensionEvent!extensionEventList.action",{moduleId:"<%=Module.SERVICE%>",instanceId:srvId,startTime: startTime,endTime:endTime,pageSize:"9",height:boxHeight},function(){});
		}

	}

	function eventlistInit(){
		var boxHeight = 0;
		boxHeight = Math.round(realHeight*0.33);
		$("#bizsrvanalysis").load("/pureportal/event/extensionEvent!extensionEventList.action",{moduleId:"<%=Module.SERVICE%>",pageSize:"9",height:boxHeight},function(){});

	}
</script>
</head>
<body  style="text-align:left;margin:0;">
	<div style="margin-left:5px">
		<table width="70%" border="0">
			<tr>
				<td>
					<!--搜索框-->
					<div elID="search_el" class="business-yl-search">
					  <div class="bg" style="background:#ccc">
							<span class="title">时间间隔：</span>
							&nbsp;天
							<span class="title">时间范围：</span><input type="radio" id="timeArea-1_rdo" name="timeArea" value="1">
							<select style="width:80px" id="timeArea_sel">
								<option value="LASTESTWEEK">最近7天</option>
								<option value="LASTESTMONTH">最近30天</option>
							</select>
							<input type="radio" id="timeArea-2_rdo" name="timeArea" value="2">
							从<input type="text" id="startDate_txt" style="width:80px;">
							至<input type="text" id="endDate_txt" style="width:80px;">
							<span class="title">KPI指标：</span>
							<select style="width:110px;" id="kpiIndex_sel">
								<option value="AVAILABILITY">可用性比率</option>
								<option value="MTBF">MTBF</option>
								<option value="MTTR">MTTR</option>
								<option value="FAILURETIMES">故障次数</option>
							</select>
							<span class="ico" title="查询" id="analysis_btn"></span>
					  </div>
					</div>
				</td>
			</tr>
		</table>
	</span>
	<div id="flashContent" style="position:absolute;top:0px;left:30px;z-index:-101;"></div>
	<div id="bizsrvanalysis" style="position:absolute;top:52%;left:1%;right:2%;z-index:101"></div>
</body>
</html>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<jsp:directive.page import="com.mocha.bsm.event.type.Module"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务分析
	uri:{domainContextPath}/pages/bizanalysisright.jsp
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务分析</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="/pureportal/css/master.css" rel="stylesheet" type="text/css"/>
<link href="/pureportal/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	html,body{height:100%;width:100%}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>


<script language="javascript">

	var realWidth = 0, realHeight = 0;
	$(function(){
		realWidth = document.body.clientWidth;
		realHeight = document.body.clientHeight;

		$('#flashContent').css("width", realWidth);
		//$('#flashContent').css("height", realHeight);
		//$('#bizsrvanalysis').css("width", realWidth-50);
		//f_loadCurrFlash();

	});

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
			realWidth-30, realHeight/2-10,
			swfVersionStr, xiSwfUrlStr,
			flashvars, params, attributes);
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");


		initFlashContentObj("BizChartForm");
	}

	if(window.HP){
		 HP.addActivate(function(){
			alert("invoke addActivate");
		 });
		 HP.addSleep(function(){
			alert("invoke addSleep");
		 });
		 HP.addDestory(function(){
			alert("invoke addDestory");
		 });
	}
	function f_thisEventlist(srvId, serverName, startTime, endTime){
		/*
		if(srvId != "-1"){
			$("#srvText").text(serverName);
		}else{
			$("#srvText").text("");
		}*/

		var boxHeight = Math.round(realHeight/3.3);
		$("#bizsrvanalysis").load("/pureportal/event/extensionEvent!extensionEventList.action",{moduleId:"<%=Module.SERVICE%>",instanceId:srvId,startTime: startTime,endTime:endTime,pageSize:"9",height:boxHeight},function(){});

		//$("#srvName").text("服务名称:");

	}

	function eventlistInit(){
		var boxHeight = Math.round(realHeight/3.3);
		$("#bizsrvanalysis").load("/pureportal/event/extensionEvent!extensionEventList.action",{moduleId:"<%=Module.SERVICE%>",pageSize:"9",height:boxHeight},function(){});

	}

	function eventlist(servArray, startTime, endTime){
		
		$('#serviceList_ana_span').empty();

		if(servArray != null && servArray != "undefined" && servArray.length > 0){

			$('#srvName').text('服务名称：');

			var $servListSel = $('<select id="serviceList_ana_sel" style="width:120px">');
			
			//$('#serviceList_sel').append('<option value="all">全部</option>');
			for(var i=0; i<servArray.length; i++){
				var $option = $('<option value="'+servArray[i].id+'" title="'+servArray[i].name+'">'+servArray[i].name+'</option>');
				$servListSel.append($option);
			}
			$('#serviceList_ana_span').append($servListSel);

			$servListSel.change(function(event){
				//event.stopPropagation();
				//event.preventDefault();
				var $thisOption = $(this).find('>option:selected');
				var servID = $thisOption.attr("value");
				var servName = $thisOption.text();

				f_thisEventlist(servID, servName, startTime, endTime);
			});
			
			f_thisEventlist(servArray[0].id, servArray[0].name, startTime, endTime);

			//if(servArray.length == 1){
			//$($('#serviceList_ana_sel>option').get(0)).attr("selected", true);
			//}
			//$('#serviceList_ana_sel').trigger("change");
		}else{
			$('#srvName').text('服务名称：');
			$('#serviceList_ana_span').append('<font color="white"><b>-</b></font>');
			f_thisEventlist("", "", "", "");
		}
	}

</script>
</head>
<body>
	<div id="flashContent" style="position:absolute;top:0px;left:0px;z-index:101"></div>
	<div style="position:absolute;top:51%;left:1%;z-index:101">
		<span style="font-weight:bold"><font color="white"><b id="srvName"></b></font></span>
		<font color="white" id="srvText"></font>
		<span id="serviceList_ana_span"></span>
	</div>
	<div id="bizsrvanalysis" style="position:absolute;top:56%;left:1%;right:2%;height:100%;z-index:101"></div>
 </body>
</html>
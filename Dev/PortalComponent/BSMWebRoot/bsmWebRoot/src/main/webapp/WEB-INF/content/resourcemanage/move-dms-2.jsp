<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="DMS资源迁移">
    <page:param name="width">400px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">ok_button</page:param>
	<page:param name="bottomBtn_text_1">后台处理</page:param>
	
    <page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">export_button</page:param>
	<page:param name="bottomBtn_text_2">迁移报告</page:param>
	
    <page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">finish_button</page:param>
	<page:param name="bottomBtn_text_3">完成</page:param>
	
	<page:param name="content">
		<div class="fold-blue">
		  <div class="fold-top"> <span class="fold-top-title">2.资源迁移</span> </div>
		  <div class="fold-content">
		    <ul>
		      <li class="dms-loading"><img src="${ctx}/images/loading.gif" width="32" height="32" vspace="6" /><br />
		        <br />
		        <span id="descript">正在处理,请稍后...</span></li>
		      <li class="margin8px"><b class="left">迁移日志:</b><span class="right">耗用时间:<span id="clock">00:00:00</span></span></li>
		      <br/>
		      <li class="margin8px dms-move-list" style="height:200px;">
		      </li>
		    </ul>
		  </div>
		</div>
		<s:form id="movedmsform">
		</s:form>
		<iframe width="0" height="0" name="submitFrame"></iframe>
	</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
var num = 0;
var time = 0;
$(document).ready(function() {
	var instanceIds = dialogArguments.getInstanceIds();
	var distDms = dialogArguments.getDistDmsId();
	var hiddens = "";
	for(var i = 0; i < instanceIds.length; i++){
		hiddens += "<input type='hidden' name='instanceIds' value='" + instanceIds[i] + "'>"
	}
	hiddens += "<input type='hidden' name='distDmsId' value='" + distDms + "'/>";
	$("#movedmsform").html(hiddens);
	$("#topBtn1").click(function() {
		window.close();
  	});
	$("#ok_button").click(function() {
		window.close();
  	});
	$("#export_button").click(function() {
		exportDmsReport();
  	});
	$("#finish_button").click(function() {
		window.close();
  	});
	buttonStyle("export_button","none");
	buttonStyle("finish_button","none");
	moveDms();
	num = setInterval(function(){logDisplay();},1000);
	time = setInterval(function(){getTime();},1000);
});

function moveDms() {
	var ajaxParam = $("#movedmsform").serialize();
	$.ajax({
		type:"POST",
		dataType:'json',
		url:"${ctx}/resourcemanage/resBatchOpertation!moveDMS.action",
		data:ajaxParam,
		success:function(){
			dialogArguments.search();
		}
	});
}

function logDisplay() {
	$.ajax({
		type:"POST",
		dataType:'json',
		url:"${ctx}/resourcemanage/resBatchOpertation!moveDMSLog.action",
		success:function(data, textStatus){
			var logInfo = data.moveDmsLog;
			if("finish" == logInfo){
				clearInterval(num);
				clearInterval(time);
				$("#descript").text("操作结束");
				buttonStyle("export_button","");
				buttonStyle("finish_button","");
				buttonStyle("ok_button","none");
			}else if("" != logInfo){
				$(".dms-move-list").html(logInfo);
			}
		}
	});
}

function buttonStyle(oTarget,display) {
	$("#"+oTarget).css("display",display);
}

function exportDmsReport() {
	var report = $(".dms-move-list").text();
	var reporthidden = "<input type='hidden' name='report' value='" + report + "'>";
	$("#movedmsform").html(reporthidden);
	$("#movedmsform").attr("action", "${ctx}/resourcemanage/resExport!exportDmsReport.action");
	$("#movedmsform").attr("target", "submitFrame");
	$("#movedmsform").submit();
}

var a = 0;
var b = 0;
var c = 0;
function getTime() {
	a++;
	if(a==60){
		a=0;
		b++;
	}
	if(b==60){
		b=0;
		c++;
	}
	var timeStr = "";
	if(c < 10) {
		timeStr += "0" + c + ":";
	} else {
		timeStr += c + ":";
	}
	if(b < 10) {
		timeStr += "0" + b + ":";
	} else {
		timeStr += b + ":";
	}
	if(a < 10) {
		timeStr += "0" + a;
	} else {
		timeStr += a;
	}
	
	$("#clock").html(timeStr);
}
</script>
</html>
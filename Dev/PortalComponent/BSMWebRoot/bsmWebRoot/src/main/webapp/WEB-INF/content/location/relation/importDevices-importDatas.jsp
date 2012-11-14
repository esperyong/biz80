<!-- WEB-INF\content\location\relation\excel-templates-upload.resTypejsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<base target="_self">
<title>导入设备位置信息</title>
<link rel="stylesheet" href="${ctxCss}/common.css"
	type="text/css" />
	<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.select.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function() {
	$("#close,#fulfill").click(function(){
		$.ajax({
			type: "post",
			url: "${ctx}/location/relation/importDevices!stopImport.action"
		});
		window.close();
	})
	
	$("#stop").click(function(){
		$.ajax({
			url: "${ctx}/location/relation/importDevices!stopImport.action",
			success: function(data, textStatus){
				window.clearInterval(timerId);
			}
		});
	})
	$("#anewImport").click(function(){
		if(window.parent.dialogArguments != null && window.parent.dialogArguments != ""){
			window.parent.dialogArguments.clickSpean();
		}
		$("form").submit();
	})

	$("#exportReportId").click(function(){
	    	
    	var elemIF = document.createElement("iframe");   
    	elemIF.src = "${ctx}/location/relation/importDevices!exportReport.action";
    	elemIF.style.display = "none";   
    	document.body.appendChild(elemIF);
    	window.setTimeout(function(){
    		document.body.removeChild(elemIF);
    	},10)
	})
	$("#continueImport").click(function(){
		$.ajax({
			type: "post",
			dataType:'json', //接受数据格式 
			url: "${ctx}/location/relation/importDevices!continueImport.action",
			success: function(data, textStatus){
				timerId = window.setInterval(getFalg,500);
			}
		});
	})
	// 窗口居中
	dialogCenter();
	// 定时取导入结果数据
	timerId = window.setInterval(getFalg,500);
});
var start = new Date();
var current;
var timerId;
function getFalg(){
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		url: "${ctx}/location/relation/importDevices!readOperateFlag.action",
		success: function(data, textStatus){
			updateOperateResult(data.operateFlag);
		}
	});
}
// 更新导入结果的提示信息
function updateOperateResult(operate){
	// 更新用时
	var current = new Date()
	var useDate = new Date(current.getTime() - start.getTime());
	$("#timeDisId").html("00:"+useDate.format("mm:ss"));
	if(operate){
		if(operate.fail+operate.succee==operate.size){
			window.clearInterval(timerId);
		}
		// 更新导入进度
		var schedule = ((operate.fail+operate.succee)/operate.size)*100 + "";
		if(operate.size==0){
			schedule="100";
		}
		if(schedule == "100"){
				$("#loading-image").attr("src","${ctx}/images/loading-end.gif")
			}
		$("#schedule").html(schedule.substring(0,schedule.indexOf(".")>0?schedule.indexOf(".")+3:3) + "%");
		$("#successSpanId").html(operate.succee + "");
		$("#errorSpanId").html(operate.fail + "");
		$("#sumErrorSpanId").html("");
		for(var key in operate.failed){
			var failCase = "";
			if(key=="sameInstanceInBatch"){
				failCase = "和库的资源实例重复;已更新属性"
			} else if(key=="sameInstanceInParameter"){
				failCase = "和参数中的资源实例重复;不做处理."
			} else if(key=="capacityInvaild"){
				failCase = "资源实例能力属性不可用"
			} else if(key=="hasNotIdentifyProperty"){
				failCase = "没有识别属性"
			} else if(key=="parentInstanceError"){
				failCase = "父资源实例识别失败"
			} else {
				failCase = "其他错误 "
			}
			
			$("#sumErrorSpanId").append("<li>"+ failCase+"&nbsp;"+operate.failed[key].length+"条（" + operate.failed[key] +"行）" +"</li>");
		}
		if(operate.succee==operate.size){
		$("#sumErrorSpanId").append("<li>全部导入成功</li>");
		}
		// 重新设置窗口大小
		dialogResize();
	} else {
		window.clearInterval(timerId);
	}
}

/**
* 时间对象的格式化;
* format="YYYY-MM-dd hh:mm:ss";
*/
Date.prototype.format = function(format){
 var o = {
	  "M+" :  this.getMonth()+1,  //month
	  "d+" :  this.getDate(),     //day
	  "h+" :  this.getHours(),    //hour
      "m+" :  this.getMinutes(),  //minute
      "s+" :  this.getSeconds(), //second
      "q+" :  Math.floor((this.getMonth()+3)/3),  //quarter
      "S"  :  this.getMilliseconds() //millisecond
   }
  
   if(/(y+)/.test(format)) {
    format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
   }
 
   for(var k in o) {
    if(new RegExp("("+ k +")").test(format)) {
      format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
    }
   }
 return format;
}
</script>
<body> 
<form action="${ctx}/location/relation/importDevices!uploadFile.action">
<input type="hidden" name="resType" value='${resType}'/>
<input type="hidden" name="tempFileName" value="${tempFileName }"/>
</form>
<page:applyDecorator name="popwindow"  title="导入">
	
	<page:param name="width">560px</page:param>
	<page:param name="height">450px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">anewImport</page:param>
	<page:param name="bottomBtn_text_1">继续导入</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">fulfill</page:param>
	<page:param name="bottomBtn_text_2">完成并退出</page:param>
	
	<page:param name="content">
<div class="panel-titlebg">
<ul class="panel-multili"  style="width: 550px" >
<li><span class="field" >1.选择导入Excel文件</span></li>
</ul>
</div>
<div class="panel-titlebg">
<ul class="panel-multili"  style="width: 550px" >
<li><span class="field" >2.匹配表单项</span></li></ul>
</div>
<div class="panel-titlebg">
<ul class="panel-multili"  style="width: 550px" >
<li><span class="field" >3.导入结果</span></li>
</ul>
</div>
<div>
	<ul style="padding:0 5px">
	
		<li id="loadingId">
	  	<div class="border-bottom">
			<div class="find-center"><img id="loading-image" src="${ctx}/images/loading.gif"></img></div>
			<div class="find-center" id="schedule">1%</div>
		</div></li>
		<li style="white-space:nowrap;word-wrap:break-word">
		<span class="bold" style="display:inline-block;width:63%">导入结果：</span><span class="">耗用时间：<span id="timeDisId">00:00:00</span></span>&nbsp;|&nbsp;<span class="ico ico-excel" id="exportReportId" title="导出报告"></span></li>
	</ul>
	<table class="panel-table" align="center">
  		<tr>
  			<th width="30%">结果</th>
  			<th></th>
  		</tr>
  		<tr>
  			<td width="30%">成功：</td>
            <td><span id="successSpanId" style="margin-left:3px"></span> 条</td>
  		</tr>
  		<tr>
  			<td width="30%">失败：</td>
            <td><span id="errorSpanId" class="red"></span>条</td>
  		</tr>
  		<tr>
  			<td width="30%">原因：</td>
  			<td><ul id="sumErrorSpanId" class="red"/></td>
  		</tr>
  	</table>
</div>
</page:param>
</page:applyDecorator>
</body> 
</html>
<!-- 
	<page:param name="bottomBtn_index_2">2</page:param>	
	<page:param name="bottomBtn_id_2">continueImport</page:param>
	<page:param name="bottomBtn_text_2">继续导入</page:param>
	 -->
<!-- 机房-机房监控-定制时间段 defineTimeInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js" ></script>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<body >
<page:applyDecorator name="popwindow"   title="定制时间段">
	<page:param name="width">400px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
	<s:form id="formID" action="" name="DefineTimeInfoForm" method="post" namespace="/roomDefine">
	<ul class="fieldlist-n">
   		<li>
   			<span  class="field">开始时间：</span>
   			<input type="text" name="startTime" id="startTime" maxlength="19" size="19" readonly="readonly" value="${startTime}"/>
   		</li>
   		<li>
   			<span  class="field">结束时间：</span>
   			<input type="text" name="endTime" id="endTime" maxlength="19" size="19" readonly="readonly" value="${endTime}"/>
   		</li>
	</ul>
	</s:form>
	</page:param>
</page:applyDecorator>
</body>
</html>
<script>

$(document).ready(function() {
	var $startTime = $("input[name='startTime']");
	var $endTime = $("input[name='endTime']");
	$startTime.click(function(){
			WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd'});
	});
	$endTime.click(function(){
		 	//WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
		 	WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd'});
	});
});
function getDate(){
	var now = new Date();
	var year = now.getFullYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
    //var nowdate=year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
    var nowdate=year+"-"+month+"-"+day;
    return nowdate;
}
$("#submit").click(function() {
	var theDays = DateDiff($("#startTime").val(),$("#endTime").val(),"/");
	if (theDays>30){
		alert("时间段请在30天以内");
	}else{
		window.opener.dingzhiTimeFun($("#startTime").val(),$("#endTime").val());
		window.close();
	}
});

$("#cancel").click(function() {
	window.close();
});
$("#closeId").click(function (){
	window.close();
});

function DateDiff(sDate1, sDate2,separatrix){ //sDate1和sDate2是2002-12-18格式
	var aDate, oDate1, oDate2, iDays
	aDate = sDate1.split(separatrix);
	oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]); //转换为12-18-2002格式
	aDate = sDate2.split(separatrix);
	oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);
	iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 /24); //把相差的毫秒数转换为天数
	return iDays
}

</script>
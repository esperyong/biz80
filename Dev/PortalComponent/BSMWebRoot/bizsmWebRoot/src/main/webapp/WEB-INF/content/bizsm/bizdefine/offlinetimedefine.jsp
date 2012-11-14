<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 author:qiaozheng
 description:计划不在线时间
 uri:{domainContextPath}/bizsm/bizservice/ui/offlinetime-define
 -->

<%@ page import="com.mocha.bsm.commonrule.common.ModuleIdCollection" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String currURL = "http://" + request.getServerName() + ":" + request.getServerPort();
	String serviceID = request.getParameter("serviceId");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>计划不在线时间</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script src="${ctx}/js/component/toast/Toast.js" type="text/javascript"></script>
<script language="javascript">
var confirmConfig = {width: 300,height: 80};
var toast  = null;
$(function(){
	toast = new Toast({position:"CT"});
	//初始化日历组件参数
	$wdate = true;

	$('select[elID="week_sel"],input[elID="fixdate_txt"]').hide();

	$('#apply_btn').click(function(){
		var sendData = f_makeSaveData();
		if(sendData == false){
			return false;
		}
			//alert(sendData);
			$.ajax({
				  type: 'PUT',
				  url: "${ctx}/bizsmconf/stop-notification-periods.xml?serviceId=<%=serviceID%>",
				  contentType: "application/xml",
				  data: sendData,
				  processData: false,
				  beforeSend: function(request){
					  httpClient = request;
				  },
				  cache:false,
				  error: function (request) {
						var errorMessage = request.responseXML;
						var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
						$errorObj.each(function(i){
							var fieldId = $(this).find('FieldId').text();
							var field = document.getElementById(fieldId);
							var errorInfo = $(this).find('ErrorInfo').text();
							var _information  = top.information();
							_information.setContentText(errorInfo);
							_information.show();
							//alert(errorInfo);
							field.focus();
						});
				  },
				  success: function(msg){
					  //var uri = httpClient.getResponseHeader("Location");
					//alert("操作成功。");
					//var _information  = top.information();
					//_information.setContentText("操作成功。");
					//_information.show();
					toast.addMessage("保存成功!");
				  }
			});
	});

	//添加数据行
	$('#add_btn_offline').click(function(){
		f_addRowData(null);
	});

	$('#del_btn_offline').click(function(){
		var $dataTbl = $('#bizData_Tbl');
		var dataTblObj = $dataTbl.get(0);
		var $offlineChk = $dataTbl.find('td>input[name="offline_chk"]').filter('input[checked="true"]');
		var dataNum = $dataTbl.find('td>input[name="offline_chk"]').size();
		if(dataNum == 0){
			var _information  = top.information();
			_information.setContentText("没有要删除的记录。");
			_information.show();
			return false;
		}
		if($offlineChk.size() == 0){
			//alert("请选择要操作的数据。");
			var _information  = top.information();
			_information.setContentText("请至少选择一项。");
			_information.show();
			return false;
		}
		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("此操作不可恢复，是否确认执行？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
			$offlineChk.each(function(cnt){
				var $thisChk = $(this);
				if($thisChk.attr("checked") == true){
					var rowIdx = $thisChk.parent('td').parent('tr').get(0).rowIndex;
					dataTblObj.deleteRow(rowIdx);
				}
			});
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
		});

	});

	f_loadPageData();
	//$('div[elID="hour_txt"]').click();
});


function f_bindChkAll(){
	//绑定全选按钮click事件
	var $dataTbl = $('#bizData_Tbl');
	$dataTbl.find('th>input[name="chk_all"]').click(function(event){
		var isChked = $(this).attr("checked");
		$dataTbl.find('td>input[name="offline_chk"]').attr("checked", isChked);
	});
}
function f_bindTimeInput($obj){
	$obj.click(function(){
		f_setCursorPos(this);
		this.select();
	});

	$obj.bind("keypress", function(event){
		if(!(((window.event.keyCode >= 48)
		  && (window.event.keyCode <= 57))
		  || (window.event.keyCode == 13))){
			window.event.keyCode = 0 ;
			return false;
		}
	});

	$obj.bind("keydown", function(event){
		if(window.event.keyCode == 38){
			//|| window.event.keyCode == 104){
			var $this = $(this);
			var elIDStr = $this.attr("elID");
			var valNum = $this.val();
			if(elIDStr == "hour_txt"){
				if(valNum < 23){
					valNum++;
				}else{
					valNum = "00";
				}
			}else if(elIDStr == "minu_txt"
					|| elIDStr == "sec_txt"){
				if(valNum < 59){
					valNum++;
				}else{
					valNum = "00";
				}
			}
			$this.val(valNum);
			$this.click();
		}else if(window.event.keyCode == 40){
			//|| window.event.keyCode == 98){
			var $this = $(this);
			var valNum = $this.val();
			if(valNum > 0){
				valNum--;
			}
			$this.val(valNum);
			$this.click();
		}
	});

	$obj.bind("keyup", function(event){
		var $this = $(this);
		var elIDStr = $this.attr("elID");
		var valNum = $this.val();
		if(elIDStr == "hour_txt"){
			if(valNum > 23){
				window.event.keyCode = 0 ;
				$this.val("00");
				$this.click();
				return false;
			}
		}else if(elIDStr == "minu_txt"
				|| elIDStr == "sec_txt"){
			if(valNum > 59){
				window.event.keyCode = 0 ;
				$this.val("00");
				$this.click();
				return false;
			}
		}
		if(valNum.length < 2){
			//$this.val("0"+valNum);
			//$this.click();
		}
	});

	$obj.bind("change", function(event){
		var $this = $(this);
		var valNum = $this.val();
		if(valNum.length < 2){
			$this.val("0"+valNum);
		}
	});
}

function f_bindDateCompent($dateTxt){
	//绑定日历组件
	//var $dateTxt = $('#fixdate_txt');
	$dateTxt.addClass("Wdate");
	$dateTxt.css("cursor", "hand").attr("readOnly", true);
	$dateTxt.bind("focus", function(event){
		WdatePicker();//{isShowWeek:true}
	});
	$dateTxt.bind("click", function(event){
		var $this = $(this);
		$this.focus();//{isShowWeek:true}
	});
}
function f_bindSelChange(idxStr){
	var $selectTemp = $('#bizData_Tbl #time-sel_'+idxStr);
	//时间段切换
	$selectTemp.bind("change", function(event){
		var $this = $(this);
		var valStr = this.value;
		if(valStr == "everyday"){
			$('#weekset-sel_'+idxStr+',#fixdate-txt_'+idxStr).hide();
		}else if(valStr == "everyweek"){
			$('#fixdate-txt_'+idxStr).hide();
			$('#weekset-sel_'+idxStr).show();
		}else if(valStr == "definitedate"){
			$('#weekset-sel_'+idxStr).hide();
			$('#fixdate-txt_'+idxStr).show();
		}
	});
}
function f_loadPageData(){
	var dataTest = '<StopNotificationPeriods>'
					 +'<periodsId>s-1054208916121464751103211049011300675741734</periodsId>'
					 +'<bizServiceId>s-1054208916121464751103211049011300675741734</bizServiceId>'
					 +'<StopNotificationPeriod>'
						+'<cronExpression>0 2/3 1,9,22 11-26 1-6 ? 2003</cronExpression>'
						+'<expression>everyday NULL 12 15 16 03 12 39</expression>'
					 +'</StopNotificationPeriod>'
					 +'<StopNotificationPeriod>'
						+'<cronExpression>0 2/3 1,9,22 11-26 1-6 ? 2003</cronExpression>'
						+'<expression>everyweek 1 09 10 21 19 11 10</expression>'
					 +'</StopNotificationPeriod>'
					 +'<StopNotificationPeriod>'
						 +'<cronExpression>0 2/3 1,9,22 11-26 1-6 ? 2003</cronExpression>'
						 +'<expression>everyweek 5 10 05 16 11 29 39</expression>'
					 +'</StopNotificationPeriod>'
					 +'<StopNotificationPeriod>'
						+'<cronExpression>0 2/3 1,9,22 11-26 1-6 ? 2003</cronExpression>'
						+'<expression>definitedate 2011-05-01 08 09 16 08 19 20</expression>'
					 +'</StopNotificationPeriod>'
				 +'</StopNotificationPeriods>';

	//var dataDom = func_asXMLDom(dataTest);
	$.get('${ctx}/bizsmconf/stop-notification-periods.xml?serviceId=<%=serviceID%>',{},function(data){

			$('#periodsId_hid').val($(data).find('StopNotificationPeriods>periodsId').text());

			var $dataTbl = $('#bizData_Tbl');
			$dataTbl.empty();
			$dataTbl.append('<tr><th width="5%"><input type="checkbox" name="chk_all"/></th><th width="95%">时间段</th></tr>');

			var $stopNotiPeriod = $(data).find('StopNotificationPeriods>StopNotificationPeriod');
			$stopNotiPeriod.each(function(i){
				var $thisStopNotiPeriod = $(this);

				var expressionTemp = $thisStopNotiPeriod.find('>expression').text();
				var expressionArray = expressionTemp.split(" ");

				f_addRowData(expressionArray);
			});


	});
}
function f_addRowData(dataArray){
	var $bizTbl = $('#bizData_Tbl');
	var idx = $bizTbl.find('tr').size();
	var $trDataDemo = $('#tdDataRoot_div>table tr').clone();

	var $checkbox = $trDataDemo.find('input[type="checkbox"]');
	$checkbox.attr("checked", $('input[name="chk_all"]').attr("checked"));

	var $selTemp = $trDataDemo.find('select[elID="time_sel"]');
	$selTemp.attr("id", "time-sel_"+idx);

	var $timesetDiv = $trDataDemo.find('div[elID="timeset_div"]');
	$timesetDiv.attr("id", "timeset-div_"+idx);

	var $weeksetSel = $trDataDemo.find('select[elID="week_sel"]');
	$weeksetSel.attr("id", "weekset-sel_"+idx);

	var $fixdateTxt = $trDataDemo.find('input[elID="fixdate_txt"]');
	$fixdateTxt.attr("id", "fixdate-txt_"+idx);

	var $startHourTxt = $trDataDemo.find('span[elID="start_time_div"]>input[elID="hour_txt"]');
	$startHourTxt.attr("id", "starthour-txt_"+idx);
	var $startMinuTxt = $trDataDemo.find('span[elID="start_time_div"]>input[elID="minu_txt"]');
	$startMinuTxt.attr("id", "startminu-txt_"+idx);
	var $startSecTxt = $trDataDemo.find('span[elID="start_time_div"]>input[elID="sec_txt"]');
	$startSecTxt.attr("id", "startsec-txt_"+idx);

	var $endHourTxt = $trDataDemo.find('span[elID="end_time_div"]>input[elID="hour_txt"]');
	$endHourTxt.attr("id", "endhour-txt_"+idx);
	var $endMinuTxt = $trDataDemo.find('span[elID="end_time_div"]>input[elID="minu_txt"]');
	$endMinuTxt.attr("id", "endminu-txt_"+idx);
	var $endSecTxt = $trDataDemo.find('span[elID="end_time_div"]>input[elID="sec_txt"]');
	$endSecTxt.attr("id", "endsec-txt_"+idx);

	$('#bizData_Tbl').append($trDataDemo);

	f_bindDateCompent($fixdateTxt);
	f_bindSelChange(idx);
	f_bindTimeInput($startHourTxt.add($startMinuTxt).add($startSecTxt).add($endHourTxt).add($endMinuTxt).add($endSecTxt));
	f_bindChkAll();

	if(dataArray != null && dataArray.length > 0){
		var timeSelValTemp = dataArray[0];
		var timeWayTemp = dataArray[1];
		var startHourTemp = dataArray[2];
		var startMinuTemp = dataArray[3];
		var startSecTemp = dataArray[4];
		var endHourTemp = dataArray[5];
		var endMinuTemp = dataArray[6];
		var endSecTemp = dataArray[7];

		$trDataDemo.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="sec_txt"]').val(startSecTemp);
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="minu_txt"]').val(startMinuTemp);
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="hour_txt"]').val(startHourTemp);

		$trDataDemo.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="sec_txt"]').val(endSecTemp);
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="minu_txt"]').val(endMinuTemp);
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="hour_txt"]').val(endHourTemp);

		if(timeSelValTemp == "everyweek"){
			$trDataDemo.find('select[elID="week_sel"]>option[value="'+timeWayTemp+'"]').attr("selected", true);
		}else if(timeSelValTemp == "definitedate"){
			$trDataDemo.find('div[elID="timeset_div"]>input[elID="fixdate_txt"]').val(timeWayTemp);
		}

		$selTemp.find('>option[value="'+timeSelValTemp+'"]').attr("selected", true);
		$selTemp.change();

	}
	else{
		var date = new Date();

		$trDataDemo.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="sec_txt"]').val(date.getSeconds());
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="minu_txt"]').val(date.getMinutes());
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="hour_txt"]').val(date.getHours());

		$trDataDemo.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="sec_txt"]').val(date.getSeconds());
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="minu_txt"]').val(date.getMinutes());
		$trDataDemo.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="hour_txt"]').val(date.getHours()+1);

		if(timeSelValTemp == "everyweek"){
			$trDataDemo.find('select[elID="week_sel"]>option[value="'+timeWayTemp+'"]').attr("selected", true);
		}else if(timeSelValTemp == "definitedate"){
			$trDataDemo.find('div[elID="timeset_div"]>input[elID="fixdate_txt"]').val(timeWayTemp);
		}

		$selTemp.find('>option[value="'+timeSelValTemp+'"]').attr("selected", true);
		$selTemp.change();
	}

	//设置数据表格隔行换色样式
	$('#bizData_Tbl tr:nth-child(odd)').addClass("black-grid-graybg");
}
/**
	*创建要保存的数据结构
	*
	*return String
	*/
	function f_makeSaveData(){
		var xmlDataStr = '<StopNotificationPeriods>';
		xmlDataStr += '<periodsId>'+$('#periodsId_hid').val()+'</periodsId>';
		xmlDataStr += '<bizServiceId><%=serviceID%></bizServiceId>';

		var validate = true;
		$('#bizData_Tbl tr').each(function(cnt){
			if(cnt != 0){
				var $this = $(this);
				var $dataTd = $($this.find('>td').get(1));
				var time_selVal = $dataTd.find('select[elID="time_sel"]>option:selected').attr("value");

				var startSec = 0,startMinu = 0,startHour=0,endSec=0,endMinu=0,endHour=0;
				var sec_part = "*",minuPart = "*",hourPart = "*";
				var dayPart = "*", monthPart = "*", weekPart = "?", yearPart = "*";

				var timeWay = "";

				startSec = $dataTd.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="sec_txt"]').val();
				startMinu = $dataTd.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="minu_txt"]').val();
				startHour = $dataTd.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="hour_txt"]').val();

				endSec = $dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="sec_txt"]').val();
				endMinu = $dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="minu_txt"]').val();
				endHour = $dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="hour_txt"]').val();

				if(time_selVal == "everyday"){
					timeWay = "NULL";
				}else if(time_selVal == "everyweek"){
					timeWay = $dataTd.find('div[elID="timeset_div"]>select[elID="week_sel"]>option:selected').attr("value");
					weekPart = timeWay;
					dayPart = "?";
				}else if(time_selVal == "definitedate"){
					timeWay = $dataTd.find('div[elID="timeset_div"]>input[elID="fixdate_txt"]').val();
					if(timeWay == ""){
						//alert("固定日期不能为空。");
						var _information  = top.information();
						_information.setContentText("固定日期不能为空。");
						_information.show();
						$dataTd.find('div[elID="timeset_div"]>input[elID="fixdate_txt"]').click();
						validate = false;
						return false;
					}
					dateTemp = timeWay;
					yearPart = dateTemp.substring(0, 4);
					monthPart = dateTemp.substring(5, 7);
					dayPart = dateTemp.substring(8);

					weekPart = "?";
				}

				var t1 = new Date(2011, 1, 01, startHour, startMinu, startSec);
				var t2 = new Date(2011, 1, 01, endHour, endMinu, endSec);

				//var t1 = new Date((startHour+"-"+startMinu+"-"+startSec).replace(/\-/g, "\/"));
				//var t2 = new Date((endHour+"-"+endMinu+"-"+endSec).replace(/\-/g, "\/"));

				if(t2 <= t1) {
					//alert("开始时间必须小于结束时间。");
					var _information  = top.information();
					_information.setContentText("开始时间必须小于结束时间。");
					_information.show();
					$dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="hour_txt"]').click();
					validate = false;
					return false;
				}

				//expression
				var expressionStr = time_selVal+" "+timeWay+" "+startHour+" "+startMinu+" "+startSec+" "+endHour+" "+endMinu+" "+endSec;

				if(f_compareRepeated(cnt, expressionStr)){
					//alert("计划不在线时间规则重复。");
					var _information  = top.information();
					_information.setContentText("计划不在线时间规则重复。");
					_information.show();
					$dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="hour_txt"]').click();
					validate = false;
					return false;
				}

				//cronExpression start.
				startSec = parseInt(startSec);
				startMinu = parseInt(startMinu);
				startHour = parseInt(startHour);
				endSec = parseInt(endSec);
				endMinu = parseInt(endMinu);
				endHour = parseInt(endHour);
				if(endSec < startSec){
					sec_part = startSec+"-"+59+","+0+"-"+endSec;
				}else{
					sec_part = startSec+"-"+endSec;
				}
				if(endMinu < startMinu){
					minuPart = startMinu+"-"+59+","+0+"-"+endMinu;
				}else{
					minuPart = startMinu+"-"+endMinu;
				}
				if(endHour < startHour){
					hourPart = startHour+"-"+23+","+0+"-"+endHour;
				}else{
					hourPart = startHour+"-"+endHour;
				}
				var cronExpressionStr = sec_part+" "+minuPart+" "+hourPart+" "+dayPart+" "+monthPart+" "+weekPart+" "+yearPart;
				//cronExpression end.

				xmlDataStr += '<StopNotificationPeriod>';
				xmlDataStr +='<cronExpression>'+cronExpressionStr+'</cronExpression>';
				xmlDataStr +='<expression>'+expressionStr+'</expression>';
				xmlDataStr += '</StopNotificationPeriod>';
			}
		});
		if(validate == false){
			return false;
		}
		xmlDataStr += '</StopNotificationPeriods>';
		return xmlDataStr;
	}

/**
* 判断之前的数据行是否数据重复
* param int endCnt 遍历边界
* param String compareExpression 比较数据表达式
* return boolean
*/
function f_compareRepeated(endCnt, compareExpression){
	var result = false;
	$('#bizData_Tbl tr').each(function(cnt){
		if(cnt != 0 && cnt < endCnt){
			var $this = $(this);
			var $dataTd = $($this.find('>td').get(1));
			var time_selVal = $dataTd.find('select[elID="time_sel"]>option:selected').attr("value");

			var startSec = 0,startMinu = 0,startHour=0,endSec=0,endMinu=0,endHour=0;
			var sec_part = "*",minuPart = "*",hourPart = "*";
			var dayPart = "*", monthPart = "*", weekPart = "?", yearPart = "*";

			var timeWay = "";

			startSec = $dataTd.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="sec_txt"]').val();
			startMinu = $dataTd.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="minu_txt"]').val();
			startHour = $dataTd.find('div[elID="timeset_div"]>span[elID="start_time_div"]>input[elID="hour_txt"]').val();

			endSec = $dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="sec_txt"]').val();
			endMinu = $dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="minu_txt"]').val();
			endHour = $dataTd.find('div[elID="timeset_div"]>span[elID="end_time_div"]>input[elID="hour_txt"]').val();

			if(time_selVal == "everyday"){
				timeWay = "NULL";
			}else if(time_selVal == "everyweek"){
				timeWay = $dataTd.find('div[elID="timeset_div"]>select[elID="week_sel"]>option:selected').attr("value");
				weekPart = timeWay;
				dayPart = "?";
			}else if(time_selVal == "definitedate"){
				timeWay = $dataTd.find('div[elID="timeset_div"]>input[elID="fixdate_txt"]').val();
				if(timeWay == ""){
					//alert("固定日期不能为空。");
					var _information  = top.information();
					_information.setContentText("固定日期不能为空。");
					_information.show();
					$dataTd.find('div[elID="timeset_div"]>input[elID="fixdate_txt"]').click();
					validate = false;
					return false;
				}
				dateTemp = timeWay;
				yearPart = dateTemp.substring(0, 4);
				monthPart = dateTemp.substring(5, 7);
				dayPart = dateTemp.substring(8);

				weekPart = "?";
			}
			var expressionStr = time_selVal+" "+timeWay+" "+startHour+" "+startMinu+" "+startSec+" "+endHour+" "+endMinu+" "+endSec;
			if(compareExpression == expressionStr){
				result = true;
				return false;
			}
		}
	});
	return result;
}
/**
*
*文本框获得焦点时，光标移到最后。
*
*/
function f_setCursorPos(inputObj){
	var txtRange = inputObj.createTextRange();
	txtRange.moveStart("character", inputObj.value.length);
	txtRange.moveEnd("character", 0);
	txtRange.select();
}
</script>
</head>
<body>
<input type="hidden" id="periodsId_hid">
<div id="tdDataRoot_div" style="display:none">
	<table class="black-grid table-width100">
		<tr>
			<td width="5%"><input type="checkbox" name="offline_chk"/></td>
			<td width="95%">
					<div style="display:inline;zoom:1">
						<select elID="time_sel" style="width:80px">
							<option value="everyday">每天</option>
							<option value="everyweek">每周</option>
							<option value="definitedate">固定日期</option>
						</select>
						<div elID="timeset_div" style="display:inline;">
							<select elID="week_sel" style="width:80px">
								<option value="Mon">星期一</option>
								<option value="Tue">星期二</option>
								<option value="Wed">星期三</option>
								<option value="Thu">星期四</option>
								<option value="Fri">星期五</option>
								<option value="Sat">星期六</option>
								<option value="Sun">星期日</option>
							</select>
							<input type="text" elID="fixdate_txt" style="width:76px;">
							&nbsp;从&nbsp;
							<span elID="start_time_div" style="border:1px solid #CCC;width:90px;display:inline-block;background:white">
								   <input type="text" elID="hour_txt" value="00" maxlength="2" style="ime-mode:disabled;width:15px;border:0px solid #FF0000;">
								 ：<input type="text" elID="minu_txt" value="00" maxlength="2" style="ime-mode:disabled;width:15px;border:0px solid #FF0000;">
								 ：<input type="text" elID="sec_txt"  value="00" maxlength="2" style="ime-mode:disabled;width:15px;border:0px solid #FF0000;">
							</span>
							&nbsp;到&nbsp;
							<span elID="end_time_div" style="border:1px solid #CCC;width:90px;display:inline-block;background:white">
								   <input type="text" elID="hour_txt" value="23" maxlength="2" style="ime-mode:disabled;width:15px;border:0px solid #FF0000;">
								 ：<input type="text" elID="minu_txt" value="59" maxlength="2" style="ime-mode:disabled;width:15px;border:0px solid #FF0000;">
								 ：<input type="text" elID="sec_txt"  value="59" maxlength="2" style="ime-mode:disabled;width:15px;border:0px solid #FF0000;">
							</span>
						</div>
					</div>
			</td>
		</tr>
	</table>
</div>

	<div class="set-panel-content-white">
		<div class="sub-panel-open">
		  <div class="sub-panel-content">
			    <div><span id="del_btn_offline" class="ico ico-delete right" title="删除"></span><span id="add_btn_offline" class="ico ico-add right" title="添加"></span></div>
				<table id="bizData_Tbl" class="black-grid table-width100">
					<tr>
						<th width="5%"><input type="checkbox" name="chk_all"/></th>
						<th width="95%">时间段</th>
					</tr>
				</table>
			    <div><span class="win-button" id="apply_btn"><span class="win-button-border"><a> 应 用 </a></span></span></div>
		  </div>
		</div>
	</div>
</body>
</html>
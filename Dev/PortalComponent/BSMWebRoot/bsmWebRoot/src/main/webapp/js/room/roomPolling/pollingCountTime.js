/**
 *巡检统计时间段查询 
 **/
var newDate = new Date();
var yearHtml="";
	yearHtml += "<select id='pollingTimeYear'>";
	for(var i=2010;i<=2030;i++){
		if(i == newDate.getFullYear()){
			yearHtml += "<option value='"+i+"' selected>"+i+"年</option>";
		}else{
			yearHtml += "<option value='"+i+"'>"+i+"年</option>";
		}
	}
	yearHtml += "</select>";
var monthHtml="";
	monthHtml += "<select id='pollingTimeMonth'>";
	for(var i=1;i<=12;i++){
		if(i == newDate.getMonth()+1){
			monthHtml += "<option value='"+i+"' selected>"+i+"月</option>";
		}else{
			monthHtml += "<option value='"+i+"'>"+i+"月</option>";
		}
	}
	monthHtml += "</select>";
	
var $pollingCountTime = $("#pollingCountTime");
var $yAndMDiv = $("#yAndMDiv");
var $weekDiv = $("#weekDiv");
var $dayDiv = $("#dayDiv");
$yAndMDiv.html(yearHtml+monthHtml);
$pollingCountTime.bind("change",function(){
	if($(this).val() == "month"){
		$yAndMDiv.show();
		$weekDiv.hide();
		$dayDiv.hide();
	}else if($(this).val() == "week"){
		$yAndMDiv.show();
		$weekDiv.show();
		$dayDiv.hide();
		var year = $("#pollingTimeYear").val();
		var month = $("#pollingTimeMonth").val();
		getWeekTime(year,month);
	}else if($(this).val() == "day"){
		var html1 = "<input name='pollingStartTime' type='text' value='"+getDefaultDateTime()+"' readonly='readonly'/>";
		$yAndMDiv.hide();
		$weekDiv.hide();
		$dayDiv.show();
		$dayDiv.html(html1);
		$("input[name='pollingStartTime']").bind("click",function(){
			WdatePicker({startDate:getDate(),dateFmt:'yyyy-MM-dd'});
		});
	}
});

function getDefaultDateTime(){
	var currDate = new Date(); 
	var thisDataStr = ""
	thisDataStr = thisDataStr+currDate.getFullYear();

	if ((currDate.getMonth()+1)<10){
		thisDataStr = thisDataStr+"-0"+(currDate.getMonth()+1);
	} else{
		thisDataStr = thisDataStr+"-"+(currDate.getMonth()+1);
	}

	if (currDate.getDate() < 10){
		thisDataStr = thisDataStr+"-0"+currDate.getDate();
	}else{
		thisDataStr = thisDataStr+"-"+currDate.getDate();
	}

	return thisDataStr;
	
		
}

function getDate(){
	var now = new Date();
	var year = now.getFullYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
    var nowdate=year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
    return nowdate;
}

function getWeekTime(year,month){
	$.ajax({
		url		:	ctx+"/roomDefine/PollingCountTime!getWeekTime.action",
		data	:	"year="+year+"&month="+month,
		dataType:	"html",
		success :	function(data, textStatus){
			var weekHtml = data//data.jsonStr;
			$weekDiv.html(weekHtml);
		},error: function (XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}
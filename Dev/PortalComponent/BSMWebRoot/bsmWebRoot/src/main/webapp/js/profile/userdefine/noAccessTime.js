var natCount = -1;
var _confirm ;

$(function(){
	_confirm = new confirm_box({text:"是否确认删除？"});
	$.timeEntry.setDefaults({show24Hours: true,showSeconds:true,spinnerImage: path+'/images/uicomponent/time/time-select.gif',spinnerSize: [15, 16, 0],spinnerIncDecOnly: true,useMouseWheel: false,defaultTime: '09:00:00',timeSteps: [1, 1, 1]});
	$.validationEngineLanguage.allRules.noAccStartTimeLarge = {
			  "nname":"noAccvalidateTimeRange",
			  "alertText":"<font color='red'>*</font> 起始时间必须小于结束时间"
		}
	$.validationEngineLanguage.allRules.noAccEndTimeSmall = {
		  "nname":"noAccvalidateTimeRange",
		  "alertText":"<font color='red'>*</font> 结束时间必须大于起始时间"
	}
	//alert(isEdit);
	if(!window.isEdit){
		isNonAccessTimes();
		$('#isNonAccessTimes').bind('click',function(){isNonAccessTimes();});
		$('[name$=type]','#natPanel').bind('change',function(){switchNatType($(this),$(this).parent().next());});
	}else{
		$("#addNatLine").hide();
		$("#delNatLine").hide();
	}
	setTimeStyle();
	setDateStyle();
	verdictTableIsNull();
});
function verdictTableIsNull(){
	if($('.monitor-items').find("li").length <= 1){
		$newdiv=$('<div class="roundedform-content"></div>');
		var $table = $('<table class="hundred"  height="255px"><tbody><tr></tr></tbody></table>');
		var $td = $('<td class="nodata"><span class="nodata-l"><span class="nodata-r"><span class="nodata-m"> <span class="icon">当前无数据</span> </span></span></span></td>');
		$('tr',$table).append($td);
		$('#natPanel').append($newdiv.append($table));
	}
}
function noAccvalidateTimeRange(tag) {
	var $self = $(tag);
	var $parentTd = $self.parent().parent();
	//alert($parentTd.html());
	var self = {
				startValue:$parentTd.find('input[id$=startTime]').val()
				,endValue:$parentTd.find('input[id$=endTime]').val()
			};
	//alert(self.startValue+"::"+self.endValue);
	if(self){
		if(self.startValue<self.endValue){
			return false;
		}
	}
	return true;
}

/*
 * 初始化nat.
*/
function isNonAccessTimes(){
	var checked = $('#isNonAccessTimes').is(':checked');
	if(checked){
		$("#checkAll","#natPanel").unbind();
		$("#checkAll","#natPanel").bind("change", function() {
			$("#natPanel").find("tbody").find(":checkbox").attr("checked", $(this).attr("checked"));
		});
	
		$(':input','#natPanel').attr('disabled',false);
		$('#addNatLine').bind('click',function(){
			 addLine();
		});
		$('#delNatLine').bind('click',function(){
			var boxs = $('#natPanel').children(':gt(0)').find(':checked');
			if(boxs.length > 0){
				_confirm.setConfirm_listener(function(){
					delLine();
					_confirm.hide();
				});
				_confirm.show();
			}
		})
	}else{
		$('#addNatLine').unbind();
		$(':input','#natPanel').attr('disabled',true);
	}
	$('#natPanel').find("input[name $= '.inUse']").val(checked);
};

function addLine(){
	if(!$.validate($formObj)){
		return;
	}
	if($('#natPanel').find("div").length==1){
		$('#natPanel').find("div").remove();
	}
	if(natCount == -1){
		natCount = $('li','#natPanel').size() - 1;
	}
	var $newLine = $('<li></li>');
	var $natType = $('#nat_Type').clone();
	var $table = $('<table class="monitor-items-list"><tbody><tr></tr></tbody></table>');
//	<td><input type="checkbox"></td><td></td><td></td>
	var $td = $('<td></td>');
	var $td1 = $td.clone().attr('width','10%');
	var $td2 = $td.clone().attr('width','30%');
	var $td3 = $td.clone().attr('width','60%');
	$td1.append('<input type="checkbox" onclick="cancelChecked()" />');
	$inUser = $('<input type="hidden" />');
	$inUser.attr('name','nonAccessTimes[' + natCount + '].inUse');
	$inUser.attr('value', true);
	$td1.append($inUser);
	
	$td2.append($natType.attr({name:'nonAccessTimes[' + natCount + '].type',id:'nat_Type[' + natCount + ']'}));
	$natType.bind('change',function(){
		switchNatType($(this),$td3);
	});
	$td3.append(getNatDailyPeriod(natCount));
	$('tr',$table).append($td1).append($td2).append($td3);
	$('#natPanel').append($newLine.append($table));
	setTimeStyle();
	natCount++;
};

function setTimeStyle(){
	$('[name$=Time]','#natPanel').timeEntry();
	if(window.isEdit){
		$('[name$=Time]','#natPanel').timeEntry("disable");
	}
}
function setDateStyle(){
	$('[id^=exactTime]','#natPanel').bind('focus',function(){
		var date= new Date();
		var _d = date.getFullYear()+'/'+(date.getMonth()+1)+'/'+date.getDate();
		WdatePicker({dateFmt:'yyyy/MM/dd',minDate:_d,alwaysUseStartDate:true});
	});
}

function getNatDailyPeriod(index){
	var _startTime = getTime();
	var _endTime = getNextTime(_startTime);
	var startTime='<input name="nonAccessTimes[' + index + '].startTime" id="nonAccessTimes[' + index + ']_startTime" size="6" value="'+_startTime+'" class="validate[funcCall[noAccStartTimeLarge]]"/>'
	var endTime='<input name="nonAccessTimes[' + index + '].endTime" id="nonAccessTimes[' + index + ']_endTime"  size="6" value="'+_endTime+'" class="validate[funcCall[noAccEndTimeSmall]]"/>'
	var temp=$('<div/>');
	temp.append('从').append(startTime).append('到').append(endTime);
	return temp.html();
};

function getNatWeeklyPeriod(index){
	var _startTime = getTime();
	var _endTime = getNextTime(_startTime);
	var startTime = $('<input name="nonAccessTimes[' + index + '].startTime" id="nonAccessTimes[' + index + ']_startTime"  size="6" value="'+_startTime+'" class="validate[funcCall[noAccStartTimeLarge]]"/> ');
	var endTime = $('<input name="nonAccessTimes[' + index + '].endTime" id="nonAccessTimes[' + index + ']_endTime" size="6" value="'+_endTime+'" class="validate[funcCall[noAccEndTimeSmall]]"/> ');
	var week = $('<select name="nonAccessTimes[' + index + '].date"></select>');
	week.append('<option value="Mon">星期一</option');
	week.append('<option value="Tue">星期二</option');
	week.append('<option value="Wed">星期三</option');
	week.append('<option value="Thu">星期四</option');
	week.append('<option value="Fri">星期五</option');
	week.append('<option value="Sat">星期六</option');
	week.append('<option value="Sun">星期日</option');
	var temp = $('<div></div>');
	temp.append(week).append('从').append(startTime).append('到').append(endTime);
	return temp.html();
};

function getNatExactTimePeriod(index){
	var _startTime = getTime();
	var _endTime = getNextTime(_startTime);
	var startTime = '<input name="nonAccessTimes[' + index + '].startTime" id="nonAccessTimes[' + index + ']_startTime" size="6" value="'+_startTime+'" class="validate[funcCall[noAccStartTimeLarge]]"/>';
	var endTime = '<input name="nonAccessTimes[' + index + '].endTime"  id="nonAccessTimes[' + index + ']_endTime" size="6" value="'+_endTime+'" class="validate[funcCall[noAccEndTimeSmall]]"/>';
	var exact = '<input name="nonAccessTimes[' + index + '].date" size="10" id="exactTime[' + index + ']"/>';
	var temp = $('<div></div>');
	temp.append(exact).append('从').append(startTime).append('到').append(endTime);
	return temp.html();
};

function switchNatType($type,$td){
	var name = $type.attr('name');
	var m = /\[(\d)\]/;
	var temp = m.exec(name);
	var index = temp[1];
	var value = $type.val();
	if(value == 'Daily'){
		$td.html(getNatDailyPeriod(index));
	}else if(value == 'Weekly'){
		$td.html(getNatWeeklyPeriod(index));
	}else {
		$td.html(getNatExactTimePeriod(index));
	}
	setTimeStyle();
	setDateStyle();
}

function delLine(){
	$('#natPanel').children(':gt(0)').find(':checked').parentsUntil('li').parent().remove();
	//alert($('.monitor-items').find("li").length);
	//alert($('.monitor-items').children(".roundedform-content").length);
	if($('.monitor-items').find("li").length == 1 && $('.monitor-items').children(".roundedform-content").length == 0){
		$newdiv=$('<div class="roundedform-content"></div>');
		var $table = $('<table class="hundred" height="255px"><tbody><tr></tr></tbody></table>');
		var $td = $('<td class="nodata"><span class="nodata-l"><span class="nodata-r"><span class="nodata-m"> <span class="icon">当前无数据</span> </span></span></span></td>');
		$('tr',$table).append($td);
		$('#natPanel').append($newdiv.append($table));
	}
};

function getTime(s){
	var	now = new Date();
    var hour=String(now.getHours());
    var minute=String(now.getMinutes());
    var second=String(now.getSeconds());
    hour = hour.length < 2 ? "0" + hour : hour;
    minute = minute.length < 2 ? "0" + minute : minute;
    second = second.length < 2 ? "0" + second : second;
    var nowTime = hour+":"+minute+":"+second;
    return nowTime;
}

function getNextTime(s){
	var str = s.split(":");
	for(var i in str){
		str[i] = Number(str[i]);
	}
	if(++str[2] == 60){
		str[2]="00";
		if(++str[1] == 60){
		str[1]="00";
			++str[0];
		}
	}
	for(var j in str){
		str[j] = String(str[j]);
		if(str[j].length < 2){
			str[j] = "0" + str[j];
		}
	}
	return str.join(":");
}

function cancelChecked() {
		var list = $("#natPanel").find("tbody").find(":checkbox");
		var flag = true;
		for(var i = 0;i<list.length ; i++){
			if(!$(list[i]).attr('checked')){
				flag = false;
				break;				
			}
		}
		
		$("#checkAll","#natPanel").attr('checked',flag);
	}

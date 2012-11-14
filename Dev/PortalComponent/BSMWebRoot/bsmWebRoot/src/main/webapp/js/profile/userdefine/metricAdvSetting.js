var baseLineCount = -1;
var profileId = $.query.get('profileId');
var metricId = $.query.get('metricId');
	$.timeEntry.setDefaults({show24Hours: true,showSeconds:true,spinnerImage: path+'/images/uicomponent/time/time-select.gif',spinnerSize: [15, 16, 0],spinnerIncDecOnly: true,useMouseWheel: false,defaultTime: '09:00:00',timeSteps: [1, 1, 1]});
var numberSliders = [] ; 
var panelArray = new Array();
var nowBaselineType = null;
$(function(){
	if(baselineTimeArray){
		baselineTimeArray.initializeArrays();
	}
	nowBaselineType = $('[name=baseLineType]:checked').val();
	
	var thresholdInuse = false;
	$("[name$=inUse]").each(function(){
		if($(this).val()){
			thresholdInuse = true;
		}
	})
	$("#activation_threshold").attr("checked",thresholdInuse);
	
	activationThreshold(thresholdInuse);
	
	$("[id^=numberSliderSpan_]").each(function(i,e){
		 var next = $($(e).parent().next().children()[0]);
		 numberSliders[i] = new NumberSlider(
				 {wrapId:$(e).attr('id')
				, sliderId:$(e).attr('id')+i
				, minValue:1
				, maxValue:10
				, bindId:next.attr("id")
				, defaultValue:next.val()
				, sliderWidth:150});
	});
	$(".pop-content").css("overflow","hidden");
	$($(".fold-content")[0]).css({"overflow-y":"auto"});
	$formObj = $("#performance");
	$formObj.validationEngine({
		promptPosition:"topRight", 
		validationEventTriggers:"blur change",
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  }, 
	    beforePrompt:function(tag){
			var div = $(tag).parentsUntil(".fold-blue").parent();
			expendPanelById(div.attr("id"));
		}
	});
	
	$.validationEngineLanguage.allRules.startTimeLarge = {
		  "nname":"validateTimeRange",
		  "alertText":"<font color='red'>*</font> 起始时间必须小于结束时间"
	}
	$.validationEngineLanguage.allRules.endTimeSmall = {
		  "nname":"validateTimeRange",
		  "alertText":"<font color='red'>*</font> 结束时间必须大于起始时间"
	}
	$.validationEngineLanguage.allRules.startDateTimeLarge = {
			"nname":"validateDateTimeRange",
			"alertText":"<font color='red'>*</font> 起始时间必须小于结束时间"
	}
	$.validationEngineLanguage.allRules.endDateTimeSmall = {
			"nname":"validateDateTimeRange",
			"alertText":"<font color='red'>*</font> 结束时间必须大于起始时间"
	}
	$.validationEngineLanguage.allRules.dateTimeInArray = {
			"nname":"validateDateTimeRangeInArray",
			"alertText":"<font color='red'>*</font> 时间段不能重叠。"
	}
	var parent = window.opener;
	if(parent == '' || parent == undefined){
		alert("主窗口异常，点击确认后关闭");
		closeWin();
	}
	$('#metricId').val(metricId);
	$('#profileId').val(profileId);
	/*
	 *	绑定事件 
	 */
	
	
	panelArray[0] = new AccordionPanel( {
			id : "BaseLine"
		}, {
			DomStruFn : "addsub_accordionpanel_DomStruFn",
			DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	panelArray[1] = new AccordionPanel( {
			id : "tab2"
		}, {
			DomStruFn : "addsub_accordionpanel_DomStruFn",
			DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	panelArray[2] = new AccordionPanel( {
			id : "tab3"
		}, {
			DomStruFn : "addsub_accordionpanel_DomStruFn",
			DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	

	function expendPanel(panelArray,currentObj){
		currentObj.$accBtn.unbind();
		currentObj.$accBtn.click(function(){
			$(".formError").remove();
			if(currentObj.state!=="expend"){
				currentObj.expend();
			}
			for(var i in panelArray){
				if(panelArray[i] != currentObj && panelArray[i].state=="expend"){
					panelArray[i].collect();
				}
			}
		});
	}
	for (var i in panelArray) {
		expendPanel(panelArray,panelArray[i]);
	}

	/*
	 * BIND EVENT!
	 * bind Page Event
	 */
	$('#cancel_button').click(function(){closeWin()});
	$('#win-close').click(function(){closeWin()});
	$('#confirm_button').click(function(){submit()});
	/*
	 * 
	 * bind BaseLine Event
	 */
	$('[name=baseLineType]').change(function(){
		if(validateForm( $formObj )){
			chooseBaselineType($(this).val());
		}else{
			$('[name=baseLineType][value='+nowBaselineType+']').attr('checked',true);
		}
	});
	$('input[id=checkAll]').bind('change', function(){
		checkAll($(this).parents('ul').attr('id'),this);
	});
	$('[name$=Time]').each(function(){
		var self = $(this);
		var isDisable = self.attr("disabled");
		self.timeEntry(isDisable?"disable":"enable");
	});
	
	/*
	 * 
	 * bind Frequency Event
	 */
	$('#fre_isPeriodic').click(function(){
		$(this).val($(this).attr("checked"));
		chooseSpecifyFrequency();
		
		if(!validateForm( $formObj )) {
			  return;
		}
	});
	$('#SpeFreType').change(function(){
		var _SpeFreType = $(this).val();
		if(_SpeFreType == 'Daily'){
			$("#_DailyFreSetting").children(":eq(0)").text("每天");
			$("#_DailyFreSetting").children(":eq(1)").text("：");
			$("#_WeeklyFreSetting").hide();
			$("#_WeeklyFreSetting").find(":input").attr("disabled","disabled");
			$("#_MonthlyFreSetting").hide();
			$("#_MonthlyFreSetting").find("select").attr("disabled","disabled");
		}else if(_SpeFreType == 'Weekly'){
			$("#_DailyFreSetting").children("td:lt(2)").empty();
			$("#_WeeklyFreSetting").show();
			$("#_WeeklyFreSetting").find(":input").removeAttr("disabled");
			$("#_MonthlyFreSetting").hide();
			$("#_MonthlyFreSetting").find("select").attr({disabled:"disabled",name:"nouse"});
		}else{
			$("#_DailyFreSetting").children("td:lt(2)").empty();
			$("#_WeeklyFreSetting").hide();
			$("#_WeeklyFreSetting").find(":input").attr({disabled:"disabled",name:"nouse"});
			$("#_MonthlyFreSetting").find("select").removeAttr("disabled").attr("name","selectedFre");
			$("#_MonthlyFreSetting").show();
		}
	});
	$('#SpeFreTime').timeEntry();
	/*$('#isEditFlapping').change(function(){
		$('#isFlapping').val($(this).is(':checked'));
		$(this).parent().parent().find('[name$=flappingCount]').attr('disabled',!$(this).attr('checked'));
	});
	$('#isEditFlapping').change();*/
	
	//TODO
	$('.cue-min-h').click(function(event){
		cue_min_h_Bind(event,this);
	});//阈值
	/*
	 * INIT()
	 * 
	 * run baseLine init
	 */
	
	//chooseBaselineType($('[name=baseLineType]:checked').val());
	/*
	 * Frequency init
	 */
	chooseSpecifyFrequency();
	if(isEdit === true){
		$("[id$=BaseLine]").css("cursor","default");
		$("#performance").children("div.fold-blue").children("div.fold-content").find("*").unbind();
		$(".pop-m .pop-content :input").attr("disabled","disabled");
		$("#confirm_button").hide();
		$("#cancel_button").hide();
		
	}
	
	
	
	$("#activation_threshold").click(function(){
		activationThreshold($(this).attr("checked"));
	});
});

function cue_min_h_Bind(event,tag){
	var self = $(tag);
	if(!checkBaseLineinUse(self)) {
		return;
	}
	var $values = self.prev();
	var $redValue = $values.children('[value=red]').next();
	var unit = $values.children('[name$=unit]').val();
	var $yellowValue = $values.children('[value=yellow]').next();
	SliberPanel.create($redValue.val(),$yellowValue.val(),unit,function(obj){
		var rheight = 30;
		var yheight = 60;
		if('%'===unit){
			rheight = obj.yellow;
			yheight = obj.red;
		}
		self.children("div.cue-content").find("span.cue-min-green").css("width",rheight+'%')
		.children("span").text(obj.yellow+unit);
		self.children("div.cue-content").find("span.cue-min-yellow").css("width",yheight+'%')
		.children("span").text(obj.red+unit);
		$redValue.val(obj.red);
		$redValue.change();
		$yellowValue.val(obj.yellow);
		$yellowValue.change();
	},event.pageX-200,calcPopDivPageY(event,230));
}
function calcPopDivPageY(event, divHeight) {
	var pageHeight = $(document).height();
	if(event.pageY + divHeight > pageHeight) {
		return event.pageY- divHeight;
	}
  return event.pageY;
}
function submit(){
	if(!validateForm( $formObj )) {
		  return;
	}
	setNoDisable();
	var data = $('#performance').serialize();
	$.ajax({
		type:'POST',
		url:'performanceSave.action',
		data:data,
		success:function(){
			try{
				window.opener.location.href=window.opener.location.href;
			}catch(e) {
			}
			closeWin();
		},
		error:function(e){
			//alert(e.responseText);
		}
	});
};
//$()_END
/*
 * BASELINE
*/
function checkAll(baseLineType,tag){
	//alert(baseLineType);
	$('#'+baseLineType).find('tbody').find(':checkbox').attr('checked',$(tag).attr('checked'));
};
var FIELDSET = '_fieldset';

function activationThreshold(isActivation){
	if(isActivation===true){
		$("[name=baseLineType]").attr("disabled",false);
		//加上了:checked因为应该取选中的值
		chooseBaselineType($("[name=baseLineType]:checked").val());
	}else{
		$("[name=baseLineType]").attr("disabled",true);
		unActivationThreshold();
	}
}
function unActivationThreshold(){
	var T = {_daliy:"daliy",_weekly:"weekly",_exactTime:"exactTime"};
	for(var i in T){
			unbindFieldset(T[i]);
	}
}

function chooseBaselineType(type){
	var T = {_daliy:"daliy",_weekly:"weekly",_exactTime:"exactTime"};
	var _self = "_"+type;
	if (T[_self] == type) {
		nowBaselineType = type;
		bindFieldSet(type);
		for(var i in T){
			if(T[i] != type)
				unbindFieldset(T[i]);
		}
		
	}
}

function unbindFieldset(fieldsetid){
	$('#'+fieldsetid).find('[name$=Time]').timeEntry("disable");
	$('#'+fieldsetid).find(':input').attr("disabled",true); 
	$('#'+fieldsetid+FIELDSET).find('span[id$=BaseLine]').unbind().hide();
	$('#'+fieldsetid).find("input[name $= 'inUse']").val(false);
}

function bindFieldSet(fieldsetid){
	var $temp = $('#'+fieldsetid+FIELDSET);
	var addButton = $temp.find('span[id=addBaseLine]');
	var delButton = $temp.find('span[id=delBaseLine]');
	$temp.find('[name$=Time]').timeEntry("enable");
	addButton.unbind();
	addButton.show();
	addButton.bind('click',function(){addBaseLineBind(this)});
	
	delButton.unbind();
	delButton.show();
	delButton.bind('click',function(){delBaseLineBind(this)});
	
	$('#'+fieldsetid).find(':input').removeAttr("disabled");
	$('#'+fieldsetid).find("input[name $= 'inUse']").val(true);
	$('#'+fieldsetid).find('.cue-min-h').click(function(event){
		cue_min_h_Bind(event,this);
	});
}

function addBaseLineBind(tag){
	if(!validateForm($formObj)){
		return;
	}
	var baseLineType = nowBaselineType;
	//$('input[name=baseLineType][checked]','#BaseLine').attr('value');
	//alert("nowBaselineType=="+nowBaselineType);
	//alert("baseLineType=="+baseLineType);
		if(baseLineType === undefined){
			$(tag).parent().parent().parent().find('input[name=baseLineType]').attr('checked',true);
			$(tag).parent().parent().parent().find('input[name=baseLineType]').change();
			baseLineType = $('input[name=baseLineType][checked]','#BaseLine').attr('value');
		}
		addBaseLine(baseLineType);
}
function delBaseLineBind(tag){
	var baseLineType = $('input[name=baseLineType][checked]','#BaseLine').attr('value');
		if(baseLineType == undefined){
			$(tag).parent().parent().parent().find('input[name=baseLineType]').attr('checked',true);
			$(tag).parent().parent().parent().find('input[name=baseLineType]').change();
			baseLineType = $('input[name=baseLineType][checked]','#BaseLine').attr('value');
		}
		delBaseLine(baseLineType);
}
function addBaseLine(baseLineType){
	if(baseLineCount == -1){
		baseLineCount = $('[name=baseLineItem]').size();
	}
	var $li = $('<li></li>');
	$li.attr('name','baseLineItem');
	var $table = $('<table></table>');
	$table.addClass('monitor-items-list');
	var $tbody = $('<tbody></tbody>');
	var $tr = $('<tr></tr>');
	var $td = $('<td></td>');
	var $input = $('<input type=text size=5 value="09:00:00" blType="'+baseLineType+'_fieldset"/>');
	var $input1 = $input.clone();
	$input1.attr({'name':'baseLine['+baseLineCount+'].fromTime','class':'validate[funcCall[startTimeLarge],funcCall[dateTimeInArray]]',id:'baseLine['+baseLineCount+']_fromTime'});
	var $input2 = $input.clone();
	$input2.attr({'name':'baseLine['+baseLineCount+'].toTime','class':'validate[funcCall[endTimeSmall],funcCall[dateTimeInArray]]',id:'baseLine['+baseLineCount+']_toTime',value:'10:00:00'});
	
	$inUser = $('<input type="hidden" />');
	$inUser.attr('name','baseLine['+baseLineCount+'].inUse');
	$inUser.attr('value', true);
	
	if(baseLineType=='daliy'){
		$tbody.attr('id','DailyPeriod');
		var $td1 = $td.clone();
		$td1.css('width','6%');
		$td1.append('<input type=checkbox>');
		$td1.append('<input type=hidden name="baseLine['+baseLineCount+'].periodId" value="DailyPeriod">');
		$td1.append($('#profileId').clone().attr({name:'baseLine['+baseLineCount+'].profileId',id:''}));
		$td1.append($('#metricId').clone().attr({'name':'baseLine['+baseLineCount+'].metricId',id:''}));
		var $td2 = $td.clone();
		$td2.css('width','50%').append($input1).append('至').append($input2).append($inUser);
		$td2.attr("index",baseLineCount);
		$tr.append($td1);
		$tr.append($td2);
		$tr.append(cloneThresholdModelSet(baseLineCount));
	}else if(baseLineType=='weekly'){
		$tbody.attr('id','WeeklyPeriod');
		var $td1 = $td.clone();
		$td1.css('width','6%');
		$td1.append('<input type=checkbox>');
		//$td1.append('<input type=hidden name="baseLine['+baseLineCount+'].periodId" value="WeeklyPeriod">');
		$td1.append($('#profileId').clone().attr({name:'baseLine['+baseLineCount+'].profileId',id:''}));
		$td1.append($('#metricId').clone().attr({'name':'baseLine['+baseLineCount+'].metricId',id:''}));
		var $td2 = $td.clone();
		$td2.css('width','50%');
		$td2.append('每');
		var $dayOfweek = $('<select ></select>');
		$dayOfweek.attr('name','baseLine['+baseLineCount+'].periodId');
		$dayOfweek.append('<option value="MonPeriod">周一</option>');
		$dayOfweek.append('<option value="TuePeriod">周二</option>');
		$dayOfweek.append('<option value="WedPeriod">周三</option>');
		$dayOfweek.append('<option value="ThuPeriod">周四</option>');
		$dayOfweek.append('<option value="FriPeriod">周五</option>');
		$dayOfweek.append('<option value="SatPeriod">周六</option>');
		$dayOfweek.append('<option value="SunPeriod">周日</option>');
		$td2.append($dayOfweek);
		$td2.append($input1);
		$td2.append('至');
		$td2.append($input2);
		$td2.append($inUser);
		$td2.attr("index",baseLineCount);
		
		$tr.append($td1);
		$tr.append($td2);
		$tr.append(cloneThresholdModelSet(baseLineCount));
	}else{
		$tbody.attr('id','ExactTimePeriod');
		var $td1 = $td.clone();
		$td1.css('width','6%');
		$td1.append('<input type=checkbox>');
		$td1.append('<input type=hidden name="baseLine['+baseLineCount+'].periodId" value="ExactTimePeriod">');
		$td1.append($('#profileId').clone().attr({name:'baseLine['+baseLineCount+'].profileId',id:''}));
		$td1.append($('#metricId').clone().attr({'name':'baseLine['+baseLineCount+'].metricId',id:''}));
		var $td2 = $td.clone();
		$td2.css('width','50%');
		var $input_ = $('<input type=text size=8 blType="'+baseLineType+'_fieldset" />');
		var $fromDay = $input_.clone().attr({value:getToday(),name:'baseLine['+baseLineCount+'].formDate','class':'validate[required,funcCall[startDateTimeLarge],funcCall[dateTimeInArray]]',id:'baseLine['+baseLineCount+']_fromDay'});
		$fromDay.click(function(){
			var date= new Date();
			var _d = date.getFullYear()+'/'+(date.getMonth()+1)+'/'+date.getDate();
			WdatePicker({dateFmt:'yyyy/MM/dd',startDate:_d});
		});
		var $toDay = $input_.clone().attr({value:getToday(),size:'8',name:'baseLine['+baseLineCount+'].toDate','class':'validate[required,funcCall[endDateTimeSmall],funcCall[dateTimeInArray]]',id:'baseLine['+baseLineCount+']_toDay'});
		$toDay.click(function(){
			var date= new Date();
			var _d = date.getFullYear()+'/'+(date.getMonth()+1)+'/'+date.getDate();
			WdatePicker({dateFmt:'yyyy/MM/dd',startDate:_d});
		});
		$td2.append($fromDay);
		$td2.append($input1.attr({'class':''}));
		$td2.append('至');
		$td2.append($toDay);
		$td2.append($input2.attr({'class':''}));
		$td2.append($inUser);
		$td2.attr("index",baseLineCount);
		$tr.append($td1);
		$tr.append($td2);
		$tr.append(cloneThresholdModelSet(baseLineCount));
	}
	
	$tbody.append($tr);
	$li.append($table.append($tbody));
	$li.find('.cue-min-h').click(function(event){
		cue_min_h_Bind(event,this);
	});
	$('#'+baseLineType).append($li);
	$('[name$=Time]').timeEntry();
	$("[id^=day]").datepicker({dateFormat:"yy/mm/dd"});
	baseLineCount++;
}

function getTime_adv(s){
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

function getNextTime_adv(s){
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

function getToday(){
	var now     =  new Date();
	var year    =  now.getFullYear();
	var month   =  String(now.getMonth() + 1);
	var day     =  String(now.getDate());
	month = month.length < 2 ? "0" + month : month;
	day = day.length < 2 ? "0" + day : day;
    var nowdate =  year + "/" + month + "/" + day;
    return nowdate;
}
function cloneThresholdModelSet(baseLineCount){
	var $set = $('#Threshold_model_set').clone().css('display','block');
	var html = $set.html();
	html = html.replace(/thresold_models/g,'baseLine['+baseLineCount+'].thresholdSettings');
	var $td = $('<td></td>');
	$td.css('width','44%');
	$td.append(html);
	return $td;
}

function delBaseLine(baseLineType){
	var checkboxs = $('#'+baseLineType).find('tbody').find('input:checked');
	checkboxs.each(function(i,e){
		var self = $(e);
		var td = self.parent().next();
		var index = isNaN(td.attr('index'))?-1:td.attr('index');
		baselineTimeArray.deleteTimeByIndex(index,baseLineType);
		self.parents('li').remove();
	})
	$('#'+baseLineType).find('[id=checkAll]').attr('checked',false);
}
function closeWin(){
	window.opener = null;
	window.open("", "_self");
	window.close();
}
/*
 * FREQUENCY
*/
function chooseSpecifyFrequency(){
	var isPeriodic = !$('#fre_isPeriodic').is(':checked');
	var $specify = $('#specify');
	if(isPeriodic){
		$specify.find(':input').attr('disabled',true);
	}else{
		$specify.find(':input').attr('disabled',false);
	}
}

function setNoDisable() {
	$("input").attr('disabled',false);
	$("select").attr('disabled',false);
	/*$('#specify').find(':input').attr('disabled',false);
	$('#isEditFlapping').parent().parent().find('[name$=flappingCount]').attr('disabled',false);
	$(':input','#natPanel').attr('disabled',false);*/
}
function checkBaseLineinUse(self) {
	var flag = false;
	if(self.parent().parent().find("input[name$='inUse']").val() == 'true') {
		flag = true;
	}
	return flag;
}


/*
 * $.validationEngineLanguage.allRules.startTimeLarge = {
			  "nname":"validateTimeRange",
			  "alertText":"* 起始时间不能大于结束时间"
		}
	$.validationEngineLanguage.allRules.endTimeSmall = {
		  "nname":"validateTimeRange",
		  "alertText":"* 结束时间不能小于起始时间"
	}
 * */

function validateTimeRange(tag) {
	var $self = $(tag);
	var $parentTd = $self.parent().parent();
	//alert($parentTd.html());
	var self = {id:0
				,startValue:$parentTd.find('input[id$=_fromTime]').val()
				,endValue:$parentTd.find('input[id$=_toTime]').val()
			}
	//alert(self.startValue+"::"+self.endValue);
	if(self){
		if(self.startValue<self.endValue){
			$parentTd.find('input[type=text]').each(function(){
				//$.validationEngine.closePrompt(this);
			});
			return false;
		}
	}
	
	return true;
}
function validateDateTimeRange(tag) {
	var $self = $(tag);
	var self_id = $self.attr('id');
	var $parentTd;
	if(self_id.indexOf('Day')>0){
		$parentTd = $self.parent();
	}else{
		$parentTd = $self.parent().parent();
	}
	
	var self = {id:0
			,startValue:$parentTd.find('input[id$=_fromDay]').val()+' '+$parentTd.find('input[id$=_fromTime]').val()
			,endValue:$parentTd.find('input[id$=_toDay]').val()+' '+$parentTd.find('input[id$=_toTime]').val()
	}

	if(self){
		if(self.startValue<self.endValue){
			$parentTd.find(':input').each(function(){
				$.validationEngine.closePrompt(this);
			});
			return false;
		}
		
	}
	return true;
}
function validateDateTimeRangeInArray(tag){
//	alert("当前验证数组里面还有\""+baselineTimeArray.getArray().length+"\"条数据");
	var $self = $(tag);
	var self_id = $self.attr('id');
	var $parentTd;
	if(self_id.indexOf('Day')>0){
		$parentTd = $self.parent();
	}else{
		$parentTd = $self.parent().parent();
	}
	var timeArrayType = $self.attr("blType");
	
	//alert("此条数据的类型为:"+timeArrayType+".");
	
	var timeObj = {
			startTime:($parentTd.find('input[id$=_fromDay]').val()?$parentTd.find('input[id$=_fromDay]').val():"")+' '+$parentTd.find('input[id$=_fromTime]').val()
			,endTime:($parentTd.find('input[id$=_toDay]').val()?$parentTd.find('input[id$=_toDay]').val():"")+' '+$parentTd.find('input[id$=_toTime]').val()
			,day:$parentTd.find("[name$=periodId]").val()?$parentTd.find("[name$=periodId]").val():""
			,type:timeArrayType
			,index:$parentTd.attr("index")
	}
	//alert("此条数据的startTime为:"+timeObj.startTime+".");
	//alert($parentTd.attr("index"));
	
	var flag = baselineTimeArray.putTimeArray(timeObj);
	//alert(flag);
	return !flag;
}
function expendPanelById(currentId){
	for(var i=0;i<panelArray.length;i++){
		if(panelArray[i].getId() != currentId && panelArray[i].state=="expend"){
			panelArray[i].collect();
		}else if(panelArray[i].getId() == currentId && panelArray[i].state!="expend") {
			panelArray[i].expend();
		}
	}
}

validateForm = function(form){
	var settings = {
			promptPosition:"centerRight", 
			inlineValidation: true,
			scroll:true,
			success:false,
			beforePrompt:function(tag){
				
				var div = $(tag).parentsUntil(".fold-blue").parent();
				expendPanelById(div.attr("id"));
			}
			/*,
		    failure : function() { callFailFunction()  } */
	}
  $.validationEngine.onSubmitValid = true;
  if($.validationEngine.submitValidation(form,settings) == false){
       if($.validationEngine.submitForm(form,settings) == true){
       	return false;
       }else{
       	return true;
       }
  }else{
      settings.failure && settings.failure();
      return false;
  }
};
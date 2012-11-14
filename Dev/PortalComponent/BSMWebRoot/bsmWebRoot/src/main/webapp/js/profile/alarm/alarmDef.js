var panel;
var wp;
$(function(){
	$.blockUI({message:$('#loading')});
	
	/*>>>>>>>>>>>>>>>>>展开收缩组件<<<<<<<<<<<<<<<<<<<<<*/
	   var panelArray = new Array();
	   panelArray[0] = new AccordionPanel({id:"one"},{
	    	   DomStruFn:"addsub_accordionpanel_DomStruFn",
	    	   DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
	           });
	   panelArray[1] = new AccordionPanel({id:"two"},{
	    	   DomStruFn:"addsub_accordionpanel_DomStruFn",
	    	   DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
	           });
	   
	   function expendPanel(panelArray,currentObj){
			currentObj.$accBtn.click(function(){
				$(".formError").remove();
				if(currentObj.state=="expend"){
					for(var i in panelArray){
						if(panelArray[i] != currentObj && panelArray[i].state=="expend"){
							panelArray[i].collect();
						}
					}
				}
			});
		}
		function expendPanelById(panelArray,currentId){
			for(var i in panelArray){
				if(panelArray[i].getId() != currentId && panelArray[i].state=="expend"){
					panelArray[i].collect();
				}else if(panelArray[i].getId() == currentId && panelArray[i].state!="expend") {
					panelArray[i].expend();
				}
			}
		}
		for (var i in panelArray) {
			expendPanel(panelArray,panelArray[i]);
		}
		
	initSendTypePreView();
	$("#topBtn1").click(function() {
		window.close();
	});
	/*if(!isSystemAdmin) {
		buttonStyle("confirm_button","none");
		buttonStyle("application_button","none");
		$(':input').attr('disabled','true');
		$('select').attr('disabled','true');
		$("#pre_left").css("cursor","none");
		$("#pre_right").css("cursor","none");
		$(".for-inline").hide();
		$("[id^=addDiv_]").css("cursor","none");
		$.unblockUI();
		return;
	}*/
	var $formObj = $("#formname");
	var $receiveUserNames = $("#receiveUserIds");
	var $upgradeUserNames = $("#upgradeUserIds");
	var $usersObj = $("input[name='users']");
	var $sendFrequency = $("input[name='commonRule.timePeriod.timeFrequency']");
	var $click_btn_type = $("input[name='click_btn_type']");
	var $upgrade_checkbox = $("#upgrade_checkbox");
	var $upgrade_ul = $("#upgrade_ul");
	var toast = new Toast({position:"CT"});
	var $startTime = $('#startTime');
	var $endTime = $('#endTime');
	var userDomainID = $('[name=commonRule.basicInfo.userDomainId]');	
	
	$.timeEntry.setDefaults({show24Hours: true,showSeconds:true,spinnerImage: path+'/images/spinnerUpDown.png',spinnerSize: [15, 16, 0],spinnerIncDecOnly: true,useMouseWheel: false,defaultTime: '09:00:00',timeSteps: [1, 10, 0]});
	$startTime.timeEntry();
	$endTime.timeEntry();
	$.validationEngineLanguage.allRules.duplicateName = {
			  "file":path + "/profile/alarm/duplicateAlarmName.action?ruleId=" + ruleId + "&moduleId=" + moduleId,
			  "alertTextLoad":"* 正在验证，请等待",
			  "alertText":"* 有重复的策略名称"
	}
	$formObj.validationEngine({
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  },
		beforePrompt:function(tag){
	    	var div = $(tag).parentsUntil(".fold-blue").parent();
	    	expendPanelById(panelArray,div.attr("id"));
		}
	});
	
	var selectIdArray = new Array("commonRule_basicInfo_userDomainId");
	SimpleBox.renderTo(selectIdArray);
	
	/*>>>>>>>>>>>>>>>>>选择人员<<<<<<<<<<<<<<<<<<<<<*/	
	$("#common_selectUser_button").click(function(e) {
		$click_btn_type.val("C");
		var panelX = e.pageX-160;
		var panelY = e.pageY-40;
		openViewPage(path+"/profile/alarm/userList.action?domainId="+userDomainID.val(), panelX, panelY);
		//initPerson($usersObj,$receiveUserNames,e);
	});
	$("#upgrade_selectUser_button").click(function(e) {
		$click_btn_type.val("U");
		var panelX = e.pageX-160;
		var panelY = e.pageY-150;
		openViewPage(path+"/profile/alarm/userList.action?domainId="+userDomainID.val(), panelX, panelY);
		//initPerson($usersObj,$upgradeUserNames,e);
	});
	
   /*>>>>>>>>>>>>>>>>>删除人员<<<<<<<<<<<<<<<<<<<<<*/	
   $("#common_deleteUser_button").click(function(e) {
	  $receiveUserNames.find("option:selected").remove();

   });
   $("#upgrade_deleteUser_button").click(function(e) {
	   $upgradeUserNames.find("option:selected").remove();
   });
   
   
   
  var index = parseInt($("input[name='array_index']").val());
  if(isNaN(index)) {index = 0;}
  
  $("#c").click(function(){
		one.expend();
  });

  /*>>>>>>>>>>>>>>>>>报警按钮<<<<<<<<<<<<<<<<<<<<<*/
  $("#confirm_button").click(function(){
	  setAllRecieverSelect(true);
	  if(!$.validate( $formObj )) {
		  setAllRecieverSelect(false);
		  return;
	  }
	  if(checkRepeatSubmit()) {return;}
	  var ajaxParam = $formObj.serialize();
	  $.ajax({
		   type: "POST",
		   url: path+"/profile/alarm/alarmDefSave.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
			  var isNew = false;
			  if($("#ruleId").val() == "") {
				  isNew = true;
			  }
		  	  try{
		  		  var parentUrl = window.opener.location.href;
		  		  if(parentUrl!=undefined && (parentUrl.indexOf("queryProfile.action")>0
		  				  || parentUrl.indexOf("queryCustomProfile.action")>0)){
		  			  window.opener.refreshRuleInfo(data.ruleId,data.commonRule.basicInfo.ruleName);
		  		  }else {
		  			  parent.opener.reloadParentPage(data.ruleId, isNew);
		  		  }
		  	  }catch(e){
		  	  }
		  	  submitFlag = false;
			  window.close();
		   },
		   error: function(data, textStatus) {
			   alert("error");
		   }
	 });
  });
  
  $("#cancel_button").click(function(){
	  window.close();
  });
  
  $("#application_button").click(function(){
	  setAllRecieverSelect(true);
	  if(!$.validate( $formObj )) {
		  setAllRecieverSelect(false);
		  return;
	  }
	  if(checkRepeatSubmit()) {return;}
	  var ajaxParam = $formObj.serialize();
	  $.ajax({
		   type: "POST",
		   url: path+"/profile/alarm/alarmDefSave.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
			  var isNew = false;
			  if($("#ruleId").val() == "") {
				  isNew = true;
			  }
			  $("#ruleId").val(data.ruleId);
			  
		  	  try{
		  		  var parentUrl = window.opener.location.href;
		  		  if(parentUrl!=undefined 
		  				  && (parentUrl.indexOf("queryProfile.action")>0
		  						  || parentUrl.indexOf("queryCustom.action")>0)){
		  			  window.opener.refreshRuleInfo(data.ruleId,data.commonRule.basicInfo.ruleName);
		  			  window.location.href = path+"/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId="+moduleId+"&ruleId="+$("#ruleId").val();
		  		  }else{
		  			  parent.opener.reloadParentPage(data.ruleId, isNew);
		  			  window.location.href = path+"/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId="+moduleId+"&ruleId="+$("#ruleId").val();
		  		  }
		  	  }catch(e){}
		  	  submitFlag = false;
		   },
		   error:function(msg) {
				alert( msg.responseText);
		   }
	 });
  });
  
  $upgrade_checkbox.click(function(){
	  upgradeCheckboxClick();
  });

  /*>>>>>>>>>>>>>>>>>发送告警时间<<<<<<<<<<<<<<<<<<<<<*/
  
  $("#datepicker").bind('focus',function(){
		var date= new Date();
		var _d = date.getFullYear()+'/'+(date.getMonth()+1)+'/'+date.getDate();
		WdatePicker({dateFmt:'yyyy/MM/dd',minDate:_d,alwaysUseStartDate:true});
		if(this.value!=""){
			this.blur();
			}
  });
  
  $sendFrequency.click(function() {
	  sendFrequencyClick();
  });
  
  function sendFrequencyClick() {
		var frequency = $("input[name='commonRule.timePeriod.timeFrequency']:checked").val();
	  	if(frequency == constants_daliy) {
	  		$("#week").hide();
	  		$("#date").hide();
	  	}else if(frequency == constants_weekly) {
	  		$("#date").hide();
	  		$("#week").show();
	  	}else if(frequency == constants_figurely) {
	  		$("#week").hide();
	  		$("#date").show();
	  	}
  }
  
  $("#pre_left").click(function() {
	  $(".addBackground").remove();
  });
  
  $("#pre_right").click(function() {
	  	var frequency = $("input[name='commonRule.timePeriod.timeFrequency']:checked").val();
	  	var datepicker = $("#datepicker").val();
	  	if((datepicker == "") && (frequency == constants_figurely)) {
			$.validationEngine.defaultSetting("#datepicker");
			$.validationEngine.loadValidation("#datepicker");
			return false;
		}
	  	var timeStart = $startTime.val();
	  	var timeEnd = $endTime.val();
	  	if(timeStart>=timeEnd){
	  		alert('timeStart > timeEnd');
	  		return false;
	  	}
	  	
	  	var offLineTime;
	  	var displayText;
	  	if(frequency == constants_figurely) {
	  		offLineTime ="<input type=\"hidden\" name=\"commonRule.timePeriod.onLineTimes["+(index)+"].dateTime\" value=\""+datepicker+"\"/>";
	  		displayText = datepicker+" "+timeStart+"-"+timeEnd;
	  	}else if(frequency == constants_weekly) {
	  		offLineTime ="<input type=\"hidden\" name=\"commonRule.timePeriod.onLineTimes["+(index)+"].dateTime\" value=\""+$("select[name=\"weekly\"]").val()+"\"/>";
	  		displayText = $("select[name=\"weekly\"]").find("option:selected").text()+" "+timeStart+"-"+timeEnd;;
	  	}else if(frequency == constants_daliy) {
	  		var offLineTime ="<input type=\"hidden\" name=\"commonRule.timePeriod.onLineTimes["+(index)+"].dateTime\" value=\"\"/>";
	  		displayText = "每天 "+timeStart+"-"+timeEnd;
	  	}
	  	
  		offLineTime += "<input type=\"hidden\" name=\"commonRule.timePeriod.onLineTimes["+(index)+"].timeFrequency\" value=\""+frequency+"\"/>";
  		offLineTime +="<input type=\"hidden\" name=\"commonRule.timePeriod.onLineTimes["+(index)+"].startTime\" value=\""+timeStart+"\"/>";
  		offLineTime +="<input type=\"hidden\" name=\"commonRule.timePeriod.onLineTimes["+(index)+"].endTime\" value=\""+timeEnd+"\"/>";
  		var offTime_Id = "addDiv_"+index;
	  	$(".right").append("<div id='"+offTime_Id+"' class='h1' style='cursor:pointer;'>"+offLineTime+displayText+"</div>");
	  	index = index+1;
	  	$("#"+offTime_Id).click(function() {
			if($(this).hasClass("addBackground")) {
				$(this).removeClass("addBackground");
			}else {
				$(this).addClass("addBackground");
			}
	    });
  });
  $("#topBtn2").click(function() {
	  $("#selectUser_div").hide();
  });
  
  $('[id^=addDiv_]').bind('click',function(){
	  if($(this).hasClass("addBackground")) {
			$(this).removeClass("addBackground");
		}else {
			$(this).addClass("addBackground");
		}
  });
  $('[id^=sdc_]').each(function(i,e){
		if($(this).val() == null || $(this).val() == "") {
			$(this).val("1");
		}
	});
  $('[id^=max_]').each(function(i,e){
		if($(this).val() == null || $(this).val() == "") {
			$(this).val("1");
		}
	});
  $('[id^=min_]').each(function(i,e){
		if($(this).val() == null || $(this).val() == "") {
			$(this).val("1");
		}
	});
  function setAllRecieverSelect(flag) {
	  $receiveUserNames.children().attr("selected", flag);
	  $upgradeUserNames.children().attr("selected", flag);
  }
  function initSendTypePreView() {
	  $obj = $("input[name='commonRule.basicInfo.sendMethod']");
	  $obj.next().after("<span class='ico ico-view'></span>");
	  //TODO 引用不同的预览页面
	  $(".ico-view").click(function(e) {
		 var value = $(this).prev().prev().val();
		 if(value == "EMAIL") {
			 openAlarmPreView("pic-alarm-mail",e);
		 }else if(value == "SMS") {
			 openAlarmPreView("pic-alarm-message",e);
		 }else if(value == "VOICE") {
			 openAlarmPreView("pic-alarm",e);
		 }else if(value == "ALERT") {
			 openAlarmPreView("pic-alarm-alert",e);
		 }else if(value == "SOUND") {
			 openAlarmPreView("pic-alarm-light",e);
		 }
	  });
  }
  $("input[name='commonRule.timePeriod.timeType']").click(function(){
	  var $twoObj = $("#two").find(".fold-content");
	  var $displayNoneDiv = $("#alarmtimePeriod");
	  if($(this).val() == 'ANYTIME') {
		  $displayNoneDiv.css("display", "none");
		  $twoObj.attr("height", "50px");
		  $twoObj.css("height", "50px");
	  }else {
		  $displayNoneDiv.css("display", "block");
		  $twoObj.attr("height", "300px");
		  $twoObj.css("height", "300px");
	  }
	  
  });
  function upgradeCheckboxClick() {
	  $oneObj = $("#one").find(".fold-content");
	  $con1 = $('input[name="commonRule.commonRuleCondition.overPeriod.checked"]');
	  $con2 = $('input[name="commonRule.commonRuleCondition.periodCount.checked"]');
	  if($upgrade_checkbox.attr("checked") == true) {
		  $oneObj.attr("height", "590px");
		  $oneObj.css("height", "590px");
		  $con1.removeClass().addClass("validate[minCheckbox[1]]");
		  $con2.removeClass().addClass("validate[minCheckbox[1]]");
		  $upgradeUserNames.removeClass().addClass("validate[required]");
		  $upgrade_ul.css("display", "block");
	  }else {
		  $oneObj.attr("height", "480px");
		  $oneObj.css("height", "480px");
		  $upgradeUserNames.removeClass();
		  $con1.removeClass();
		  $con2.removeClass();
		  $upgrade_ul.css("display", "none");
	  }
  }
  
  upgradeCheckboxClick();
  $.unblockUI();
});

function buttonStyle(oTarget,display) {
	$("#"+oTarget).css("display",display);
}

function initPerson(userObj, IdObj, e) {
		userObj.attr("checked", "");
		IdObj.children().each(function(){
			var $checkbox_obj = $("#"+$(this).val()+"_user");
			if($checkbox_obj != null) {
				$checkbox_obj.attr("checked", true);
			}
		});
		var type = $("input[name='click_btn_type']").val();
		if(type == "C") {
			$("#selectUser_div").css("left", e.pageX-160).css("top",e.pageY-40).show();
		}else if(type="U") {
			$("#selectUser_div").css("left", e.pageX-160).css("top",e.pageY-150).show();
		}
}
function validateFigruely(){
	var $dataPicker = $("#datepicker");
	var frequency = $("input[name='commonRule.timePeriod.timeFrequency']:checked").val();
	var datepicker = $dataPicker.val();
	if((datepicker == "") && (frequency == constants_figurely)) {
		return true;
	}
	return false;
}

function openViewPage(url, panelX, panelY) {
	panel = new winPanel( {
		url : url,
		width : 300,
		height: 215,
		x:panelX,
		y:panelY,
		isautoclose: true,
		closeAction: "close",
		listeners : {
			closeAfter : function() {
				panel = null;
			},
			loadAfter : function() {
			}
		}
	}, {
		winpanel_DomStruFn : "blackLayer_winpanel_DomStruFn"
	});
}

function openAlarmPreView(imageClass, event) {
	var html = "<div class=\""+imageClass+"\" ></div>";
	panel = new winPanel({html:html
		,x:150
		,y:event.pageY+10
		,width:430
		,isautoclose: true
		,closeAction: "close"
		, listeners:{ closeAfter:function(){
				//alert("afterClose");
				panel = null; 
				}
			, loadAfter:function(){ 
//				alert("loadAfter"); 
				} 
			} }
		,{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" }); 
}

function panelClose() {
	panel.close("close");
	panel = null;
}

settings = {
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false/*,
	    failure : function() { callFailFunction()  } */
}

$.validate = function(form){
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

var submitFlag = false;
function checkRepeatSubmit() {
	if(submitFlag) {
		toast.addMessage("正在提交，请稍候...");
		return true;
	}else {
		submitFlag = true;
		return false;
	}
}
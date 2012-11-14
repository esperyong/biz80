var _information = null;
$(function(){
	$.blockUI({message:$('#loading')});
	/*>>>>>>>>>>>>>>>>>展开收缩组件<<<<<<<<<<<<<<<<<<<<<*/
	$.validationEngineLanguage.allRules.duplicateName = {
			"file":path + "/wireless/actionDefine/duplicateName.action?actionId="+$("#actionId").val(),
			"alertTextLoad":"* 正在验证，请等待",
			"alertText":"* 有重复的Action名称"
	}
	
    var panelArray = new Array();
	panelArray[0] = new AccordionPanel({id : "one"}, {
		DomStruFn : "addsub_accordionpanel_DomStruFn",
		DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	panelArray[1] = new AccordionPanel({id : "two"}, {
		DomStruFn : "addsub_accordionpanel_DomStruFn",
		DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
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
	  
	
	$actionForm = $("#actionForm");
	$resourceType = $("#resourceType");   
	$resourceValue = $("#resourceValue");   
	$metricType = $("#metricType");   
	$metricValue = $("#metricValue");   
	$eventValue = $("#eventValue");   
	$radioEnable = $("input[name='defineVO.accountInfoVO.enable']");
	$scriptId=$("#script_Id");
	
	$actionForm.validationEngine({
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() {callFailFunction()} , 
		beforePrompt:function(tag){
	    	var div = $(tag).parentsUntil(".fold-blue").parent();
	    	expendPanelById(panelArray,div.attr("id"));
		}
	});
	
	$resourceType.change(function() {
		var ajaxParam = $actionForm.serialize();
		$.ajax({
			type:"POST",
			url: path+"/wireless/actionDefine/changeResourceValues.action",
			data:ajaxParam,
			dataType:'json',
			success: function(data, textStatus) {
				var resourceSelectItems = (new Function("return "+data.resourceSelectItems))();
				$resourceValue.empty();
				if(resourceSelectItems) {
					fillselect(resourceSelectItems,$resourceValue);
				}
				setTimeout($resourceValue.change(), 50);
			},
			error: function(msg) {
				_information = new information({text:"系统异常，请联系管理员。"});
				_information.show();
			}
		});
	});
	$resourceValue.change(function() {
		var ajaxParam = $actionForm.serialize();
		$.ajax({
			type:"POST",
			url: path+"/wireless/actionDefine/changeMetricTypes.action",
			data:ajaxParam,
			dataType:'json',
			success: function(data, textStatus) {
				var metricTypesSelectItems = (new Function("return "+data.metricTypesSelectItems))();
				$metricType.empty();
				if(metricTypesSelectItems) {
					fillselect(metricTypesSelectItems,$metricType);
				}
				setTimeout($metricType.change(), 50);
			},
			error: function(msg) {
				_information = new information({text:"系统异常，请联系管理员。"});
				_information.show();
			}
		});
	});
	$metricType.change(function() {
		var ajaxParam = $actionForm.serialize();
		$.ajax({
			type:"POST",
			url: path+"/wireless/actionDefine/changeMetricValues.action",
			data:ajaxParam,
			dataType:'json',
			success: function(data, textStatus) {
				var metricSelectItems = (new Function("return "+data.metricSelectItems))();
				$metricValue.empty();
				if(metricSelectItems) {
					fillselect(metricSelectItems, $metricValue);
				}
				setTimeout($metricValue.change(), 50);
			},
			error: function(msg) {
				_information = new information({text:"系统异常，请联系管理员。"});
				_information.show();
			}
		});
		
	});
	$metricValue.change(function() {
		var ajaxParam = $actionForm.serialize();
		$.ajax({
			type:"POST",
			url: path+"/wireless/actionDefine/changeEventValues.action",
			data:ajaxParam,
			dataType:'json',
			success: function(data, textStatus) {
				var eventSelectItems = (new Function("return "+data.eventSelectItems))();
				$eventValue.empty();
				if(eventSelectItems) {
					fillselect(eventSelectItems,$eventValue);
				}
			},
			error: function(msg) {
				_information = new information({text:"系统异常，请联系管理员。"});
				_information.show();
			}
		});
	});
	
	$("#confirm_button").click(function() {
		$.blockUI({message:$('#loading')});
		if(!$.validate( $actionForm )) {
			$.unblockUI();
			return;
		}
		var ajaxParam = $actionForm.serialize();
		$.ajax({
			type:"POST",
			url: path+"/wireless/actionDefine/save.action",
			data:ajaxParam,
			dataType:'json',
			success: function(data, textStatus) {
				try{
					opener.changeGrid("/wireless/actionForPage/wirejsonSort.action");
				}catch(e){
				}
				window.close();
			},
			error: function(msg) {
				_information = new information({text:"系统异常，请联系管理员。"});
				_information.show();
			}
		});
	});
	
	$("#application_button").click(function() {
		$.blockUI({message:$('#loading')});
		if(!$.validate( $actionForm )) {
			$.unblockUI();
			return;
		}
		var ajaxParam = $actionForm.serialize();
		$.ajax({
			type:"POST",
			url: path+"/wireless/actionDefine/save.action",
			data:ajaxParam,
			dataType:'json',
			success: function(data, textStatus) {
				$("#actionId").val(data.actionId);
				try{
					opener.changeGrid("/wireless/actionForPage/wirejsonSort.action");
					window.location.href = path+"/wireless/actionDefine/addWireless.action?instanceId="+$("#instanceId").val()+"&actionId="+$("#actionId").val();
				}catch(e){
				}
			},
			error: function(msg) {
				_information = new information({text:"系统异常，请联系管理员。"});
				_information.show();
			}
		});
	});
	
	$("#cancel_button").click(function() {
		window.close();
	});
	$("#win-close").click(function() {
		window.close();
	});
	
	$("#testCommond").click(function(e){
		if($scriptId.val() == null || $scriptId.val() == "") {
			_information = new information({text:"请选择一个脚本."});
			_information.show();
			return;
		}
		$.blockUI({message:$('#loading')});
		var ajaxParam = $actionForm.serialize();
		$.ajax({
			type:"POST",
			url: path+"/wireless/script/testScript.action",
			data:ajaxParam,
			dataType:'html',
			success: function(data, textStatus) {
				panel = new winPanel( {
					html : data,
					width : 400,
					x:e.pageX-230,
					y:e.pageY-50,
					isautoclose: true,
					closeAction: "close",
					listeners : {
						closeAfter : function() {
						},
						loadAfter : function() {
						}
					}
				}, {
					winpanel_DomStruFn : "blackLayer_winpanel_DomStruFn"
				});
				$.unblockUI();
				
			},
			error: function(msg) {
				_information = new information({text:"请选择一个脚本."});
				_information.show();
			}
		});
	});
	$(".ico-find").click(function(e){
		var url = path+"/wireless/script/scriptList.action?scriptId=";
		openViewPage(url,e.pageX-100,e.pageY);
	});
	 $.unblockUI();
});

function checkForm(one,two,actionForm) {
	if(!$.validate( actionForm )) {
		return false;
	}
}

function fillselect(dataArray, object) {
  for(var i=0;i<dataArray.length;i++){
   object.append("<option value='"+dataArray[i].key+"'>"+dataArray[i].value+"</option>");
  }
}

function openViewPage(url,panelX,panelY) {
	$.blockUI({message:$('#loading')});
	panel = new winPanel( {
		url : url,
		width : 250,
		x:panelX,
		y:panelY,
		isautoclose: true,
		closeAction: "close",
		listeners : {
			closeAfter : function() {
			},
			loadAfter : function() {
			}
		}
	}, {
		winpanel_DomStruFn : "blackLayer_winpanel_DomStruFn"
	});
	$.unblockUI();
}

function panelClose() {
	panel.close("close");
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
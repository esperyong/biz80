$(function(){
    var $formObj = $("#alarmListForm");
    
    var $doMainId = $("#domainId");
    var $sendType = $("#sendType");
    win = new confirm_box({title:'提示',text:'此操作不可恢复，是否确认执行此操作？',cancle_listener:function(){win.hide();}});
    $("#add").click(function(){
 	   openEditAlarmDefPage(null);
    });
    $("#delete").click(function(){
    	if(!haveSelectAlarm($("input[name='alarmRuleId']:checked"))) {
    		return;
    	}
    	win.setConfirm_listener(function(){
    		win.hide();
    		var $formObj = $("#alarmListForm");
    		var grid =$("#child_cirgrid");
    		var ajaxParam = $formObj.serialize();
    		 $.ajax({
    			   type: "POST",
    			   dataType:'json',
    			   url:path+"/profile/alarm/alarmListDelete.action",
    			   data: ajaxParam,
    			   success: function(data, textStatus){
    			 		alarmListRefresh();
    		   	   }
    		 });
    	});	
    	win.show();
    });
    
    $doMainId.change(function() {
    	changeGrid("/profile/alarm/jsonSort.action");
    });
    $sendType.change(function() {
    	changeGrid("/profile/alarm/jsonSort.action");
    });
    
    function embellishConditionSelect() {
    	var array = [];
    	array.push($doMainId.attr("id"));
    	array.push($sendType.attr("id"));
    	SimpleBox.renderTo(array);
    }
    embellishConditionSelect();
});



function openEditAlarmDefPage(Id) {
	var winOpenObj = {};
	if(defaultRuleId != Id) {
		var src = path+"/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId=" + moduleId;
		if(Id != null) {
			src+="&ruleId="+Id;
		}
		winOpenObj.height = '600';
		winOpenObj.width = '668';
		winOpenObj.name = 'alarmDef';
		winOpenObj.url = src;
		winOpenObj.scrollable = true;
		winOpen(winOpenObj);
	}else {
		var src = path+"/profile/alarm/defautAlarmDef.action";
		winOpenObj.height = '255';
		winOpenObj.width = '600';
		winOpenObj.name = 'defaultAlarmDef';
		winOpenObj.url = src;
		winOpenObj.scrollable = false;
		winOpen(winOpenObj);
	}
}
function haveSelectAlarm(obj) {
	if(obj.length == 0) {
		var _information = new information({text:"请至少选择一项。"});
		_information.show();
		return false;
	}
	return true;
}

function reloadParentPage(ruleId) {
	alarmListRefresh();
}
function changeGrid(url){
	var $formObj = $("#alarmListForm");
	var grid =$("#child_cirgrid");
	var ajaxParam = $formObj.serialize();
	 $.ajax({
		   type: "POST",
		   dataType:'json',
		   url:path+url,
		   data: ajaxParam,
		   success: function(data, textStatus){
		    if(gp != null) {
		    	gp.loadGridData(data.dataList);
		    	reloadData();
		    }
	   }
	 });
}
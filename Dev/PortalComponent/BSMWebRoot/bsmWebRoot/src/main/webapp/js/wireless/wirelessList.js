var promptInfo = null;
$(function(){
	$formObj = $("#wireListForm");
	$instanceId = $("#instanceId");
	var toast = new Toast({position:"CT"});
	var promptInfo = new confirm_box({title:'提示',text:'此操作不可恢复，是否确认执行此操作？',cancle_listener:function(){win.hide();}});
	$("#win-close").click(function() {
		window.close();
	});
	$(".ico-add").click(function() {
		openDefPage(null,$instanceId.val());
	});
	
	$(".r-ico-delete").click(function() {
		if(!checkSelected($("input[name='actionIds']:checked"),toast)) {
    		return;
    	}
		promptInfo.setConfirm_listener(function(){
			promptInfo.hide();
			changeGrid("/wireless/actionForPage/deleteWireless.action");
		});
		promptInfo.show();
	});
});

function checkSelected(obj,toast) {
	if(obj.length == 0) {
		toast.addMessage("请至少选择一项。");
		return false;
	}
	return true;
}

function openDefPage(actionId, instanceId) {
	var winOpenObj = {};
	var src = path+"/wireless/actionDefine/addWireless.action?instanceId="+instanceId;
	if(actionId != null) {
		src+="&actionId="+actionId;
	}
	winOpenObj.height = '565';
	winOpenObj.width = '550';
	winOpenObj.name = 'actionDefine';
	winOpenObj.url = src;
	winOpenObj.scrollable = false;
	winOpen(winOpenObj);
}

function changeGrid(url) {
	
	var $formObj = $("#wireListForm");
	var ajaxParam = $formObj.serialize();
	$.ajax( {
		type : "POST",
		dataType : 'json',
		url : path + url,
		data : ajaxParam,
		success : function(data, textStatus) {
			if(gp != null) {
		    	gp.loadGridData(data.forPageVO.dataList);
		    	reloadData();
			}
		},
		error: function(msg) {
			alert(msg.responseText);
		}
	});
}
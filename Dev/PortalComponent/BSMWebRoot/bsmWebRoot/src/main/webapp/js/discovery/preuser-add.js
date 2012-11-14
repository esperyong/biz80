$(document).ready(function() {
	var isChangePwd = false;
	$("#form1").validationEngine();
	
	//SimpleBox.renderAll();
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:'domainId', maxHeight:60}]);

	$.validationEngineLanguage.allRules.domainEmpty = {
		"nname" : "domainEmpty",
		"alertText" : "请选择域。"
	}
	
	$("#sp_ok").bind("click", function() {
		if(!$.validate($("#form1"),{promptPosition:"centerRight"})){
	    	return;
	    }
		$.blockUI({message:$('#loading')});
		var url = "preuser-add-adduser.action?isChangePwd="+isChangePwd; 
		if (hashId != null && hashId != "") {
			url = "preuser-add-updateuser.action?hashId=" + hashId +"&isChangePwd="+isChangePwd;
		}
		var formObj = document.getElementById("form1");		
		formObj.action = url;
		formObj.submit();
	});
	
	$("#sp_cancel").bind("click", function() {
		window.close();
	});
	
	$("#closeId").bind("click", function() {
		window.close();
	});
	$("#accountPassword").bind("change",function(){
		isChangePwd = true;
	});
});

/**
 * 域的Select组件校验
 * @return {Boolean}
 */
function domainEmpty(){
	var domainSelect = document.getElementById("domainId");
	if(domainSelect.options.length == 0){
		return true;
	}else{
		return false;
	}
}
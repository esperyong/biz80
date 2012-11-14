$(document).ready(function() {
	
	var _noting  = new information ({text:"没有要删除的记录。"});
	var _information  = new information ({text:"请至少选择一项。"});
	var _confirm = confirm_box({text:"此操作不可恢复，是否确认执行？"});
	_confirm.setConfirm_listener(function(){
		var form1 = document.getElementById("form1");
		form1.action = "instance-list-delete!deleteInstance.action?hashId=" + $hashId;
		form1.submit();
		opener.document.location.reload();
	});
		
	newopt=document.createElement("option");
	newopt.text="请选择资源类型";
	newopt.value="";
	document.getElementById("categoryGroup").options.add(newopt,0);
	if ($categoryGroup == null || $categoryGroup == "")
		document.getElementById("categoryGroup").options[0].selected='selected';
	
	$("#sp_search").bind("click", function() {
		var form1 = document.getElementById("form1");
		form1.action = "instance-list.action?hashId=" + $hashId;
		form1.submit();
	});

	$("#sp_delete").bind("click", function() {
		
		var list = $("input[name='instanceIds']");
		for(var i = 0;i<list.length ; i++){
			if($(list[i]).attr('checked')){
				break;
			}
		}
		if (list.length == 0) {
			_noting.show();
			return;
		}
		if(i == list.length) {
			_information.show();
			return;
		}
		
		_confirm.show();
	});
	
	$("#closeId").bind("click", function() {
		window.close();
	});
	
	$("#checkAll").bind("change", function() {
		$("#instanceListGrid").find("tbody").find(":checkbox").attr("checked", $(this).attr("checked"));
	});
	
});

	function cancelChecked() {
		var list = $("#instanceListGrid").find("tbody").find(":checkbox");
		var flag = true;
		for(var i = 0;i<list.length ; i++){
			if(!$(list[i]).attr('checked')){
				flag = false;
				break;				
			}
		}
		
		$("#checkAll").attr('checked',flag);
	}
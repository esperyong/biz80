$(document).ready(function() {
	
	var _noting  = new information ({text:"没有要删除的记录。"});
	var _information  = new information ({text:"请至少选择一项。"});
	var _confirm = confirm_box({text:"此操作不可恢复，是否确认执行？"});
	_confirm.setConfirm_listener(function(){
		var form1 = document.getElementById("form1");
		form1.action = "preuser-list-deleteuser.action";
		form1.submit();
	});
		
	$("#sp_user_add").bind("click", function() {
//		window.open("preuser-add.action", "null", "width=450,height=270");
		winOpen({url:"preuser-add.action",width:450,height:240,scrollable:false,name:'preuseradd'});
	});
	
	$("#sp_user_delete").bind("click", function() {
		var list = $("input[name='hashId']");
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

	$("#checkAll").bind("change", function() {
		$("#preUserListGrid").find("tbody").find(":checkbox").attr("checked", $(this).attr("checked"));
	});

});

	function cancelChecked() {
		var list = $("#preUserListGrid").find("tbody").find(":checkbox");
		var flag = true;
		for(var i = 0;i<list.length ; i++){
			if(!$(list[i]).attr('checked')){
				flag = false;
				break;				
			}
		}
		
		$("#checkAll").attr('checked',flag);
	}
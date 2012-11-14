$(document).ready(function() {
	
	$("#sp_ok").bind("click", function() {
		//判断重复提交
		if(isSubmit){
			var toast = new Toast({position : "CT"});
			toast.addMessage("正在提交，请稍等。");
			return;
		}
		//加入监控前先校验是否已加入监控
		isSubmit = true;
		
		$.ajax({
			type : "POST",
			dataType : 'html',
			data : "instanceId="+instanceId,
			url : "validate-isexistinstance.action",
			success : function(data) {
				var dataJson = $.parseJSON(data);
				if(!dataJson.value){
					var _information  = new information ({text:"该资源已被删除。",confirm_listener:function(){
						_information.hide(); 
						window.close();
					},close_listener:function(){
						_information.hide(); 
						window.close();
					}});
					_information.offset({top:'0',left:'20'});
					_information.show();
//					var toast = new Toast({position : "CT"});
//					toast.addMessage("该资源已被删除。");
					isSubmit = false;
				}else{
					$.ajax({
						type : "POST",
						dataType : 'html',
						data : "instanceId="+instanceId,
						url : "validate-isjoinmonitor.action",
						success : function(data) {
							var dataJson = $.parseJSON(data);
							if(!dataJson.value){
								//如果策略未启用，提示
								if($("#isEnable").val() != "true"){
									var popCon=confirm_box(); 
									popCon.setContentText("此策略已被禁用，资源加入策略的同时将启用此策略。是否继续？"); //也可以在使用的
									popCon.show();
									popCon.offset({top:'0px',left:'30px'});
									popCon.setConfirm_listener(function(){
										popCon.hide();
										$.blockUI({message:$('#loading')});
										var formObj = document.getElementById("form1");
										formObj.action = "resource-monitor-addprofile!addProfile.action?instanceId=" + instanceId + "&resourceId=" + resourceId;
										formObj.submit();
									});
								}else{
									$.blockUI({message:$('#loading')});
									var formObj = document.getElementById("form1");
									formObj.action = "resource-monitor-addprofile!addProfile.action?instanceId=" + instanceId + "&resourceId=" + resourceId;
									formObj.submit();
								}
							}else{
								var _information  = new information ({text:"该资源已被监控。",confirm_listener:function(){
									_information.hide(); 
									window.close();
								},close_listener:function(){
									_information.hide(); 
									window.close();
								}});
								_information.offset({top:document.body.clientHeight,left:'20'});
								_information.show();
//								var toast = new Toast({position : "CT"});
//								toast.addMessage("该资源已被监控。");
								isSubmit = false;
							}
						}
					});
				}
			}
		});
	});
	
	$("#sp_cancel").bind("click", function() {
		window.close();
	});
	
	$("#closeId").bind("click", function() {
		window.close();
	});
	
	$("#profileId").change(function(){
		if(this.value == defaultProfileFlag){
			$("#isEnable").val("true");
		}else{
			$.ajax({
				type : "POST",
				dataType : 'html',
				data : $("#form1").serialize(),
				url : ctx+"/discovery/validate-isprofileenable.action",
				success : function(data) {
					var dataJson = $.parseJSON(data);
					$("#isEnable").val(dataJson.value);					
				}
			});
		}
	});
});

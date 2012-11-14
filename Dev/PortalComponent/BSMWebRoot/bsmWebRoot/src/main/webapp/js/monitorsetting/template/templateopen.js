if (!window.BSM) {
	window.BSM = {};
}

BSM.Monitorsetting = {};
BSM.Monitorsetting.TemplateOpen = {};
toast = new Toast({position:"CT"});

BSM.Monitorsetting.TemplateOpen.init = function(){
		var self = this;
		

		
		initValidationEngine("templateformname");
		
		$.validationEngineLanguage.allRules.ajaxTemplateName = {
				"file" : ctx + "/monitorsetting/alermtemplate/validate-template.action?alermMethod="+$("#alermMethod").val()+"&domainId="+$("#domainId").val()+"&moduleId="+$("#moduleId").val()+"&eventClass="+$("#eventClass").val(),
				"alertTextLoad" : "* 正在验证，请等待",
				"alertText" : "<font color='red'>*</font> 该模板名称已存在"
		}
		
			$("#templatehelp").click(function (){
			var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
			var obj = {
				height:400,
				width:600,
				name:"",
				url:ctx+"/monitorsetting/alermtemplate/template-help.action?templateId="+templateId 
			};
			winOpen(obj);

		})
	
		$("#closeId").click(function (){
			window.close();
		})
	
		$("#cancel").click(function (){
			window.close();
		})
	
	
		$("#submit").click(function (){
			//alert();
		if(!$.validate($("#templateformname"))){
			
			return false;
		}
		//alert(111);
		if(window.document.getElementById("id").value == '1'){
			toast.addMessage('系统默认模板不可修改');
			//window.close();
			return false;
			
		}
		
		if(window.document.getElementById("templateName").value == ''){
			toast.addMessage('模板名称不可为空');
			return false;
		}
		
		if(window.document.getElementById("alermMethod").value=='EMAIL'){
				
			if(window.document.getElementById("templateZhTitle").value == ''){
				toast.addMessage('中文标题不可为空');
				return false;
			}
		}
		if(window.document.getElementById("templateZhText").value == ''){
			toast.addMessage('中文内容不可为空');
			return false;
		}
		
//		if(window.document.getElementById("alermMethod").value=='EMAIL'){
//			if(window.document.getElementById("templateEnTitle").value == ''){
//				toast.addMessage('英文标题不可为空');
//				return false;
//			}
//		}
//		if(window.document.getElementById("templateEnText").value == ''){
//			toast.addMessage('英文内容不可为空');
//			return false;
//		}
		
		$.ajax({
				type: "POST",
				dataType:'html',
				data:$("#templateformname").serialize(),
				url:ctx+"/monitorsetting/alermtemplate/template-save.action",
				success: function(data){
					try{
						var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
						opener.window.location.href=ctx+"/monitorsetting/alermtemplate/template-list.action?templateId="+templateId+"&domainId="+window.document.getElementById("domainId").value;
						//opener.window.change("${ctx}/monitorsetting/alermtemplate/template-list.action");
						window.close();
					}catch(e){
						//window.close();
					}
				}
		});
	})

}


initValidationEngine= function(formId) {
		$("#" + formId).validationEngine();
		settings = {
			promptPosition : "centerRight",
			validationEventTriggers : "keyup blur change",
			inlineValidation : true,
			scroll : false,
			success : false
		}
		$.validate = function(form) {
			$.validationEngine.onSubmitValid = true;
			if ($.validationEngine.submitValidation(form, settings) == false) {
				if ($.validationEngine.submitForm(form, settings) == true) {
					return false;
				} else {
					return true;
				}
			} else {
				settings.failure && settings.failure();
				return false;
			}
		};
	};
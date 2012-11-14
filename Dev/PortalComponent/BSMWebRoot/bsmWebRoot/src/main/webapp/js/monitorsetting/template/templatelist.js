if (!window.BSM) {
	window.BSM = {};
}

BSM.Monitorsetting = {};
BSM.Monitorsetting.TemplateList = {};
toast = new Toast({position:"CT"});

BSM.Monitorsetting.TemplateList.init = function(){
		var self = this;
		

		
		initValidationEngine("templateformname");
		
		$("div[name='defaulttemplate']").click(function(){
			self.defaulttemplate();
		})
	
		$("div[name='edit']").click(function(){
			self.edit();
		})
		
		$("div[name='deletetemplate']").click(function(){
			self.deletetemplate();
		})
		
		$("div[name='create']").click(function(){
			self.create();
		})

		$("#closeId").click(function (){
			window.close();
		})
	
		$("#cancel").click(function (){
			window.close();
		})
		
		$("#submit").click(function (){
			window.close();
		})
		var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
		var pageEdit = opener.document.getElementById(templateId+'_ZH');
		var pateEditTd = $(pageEdit).parent().parent().children().eq(1);
		if(pateEditTd.html()!=$("#templateName").val())
			pateEditTd.html($("#templateName").val());
}

BSM.Monitorsetting.TemplateList.defaulttemplate = function() {
	var _confirm = new confirm_box({text:"是否确认执行此操作？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			type: "POST",
			dataType:'html',
			data:$("#templateformname").serialize(),
			url:ctx+"/monitorsetting/alermtemplate/template-default.action",
			success: function(data){
				try{
					var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
					window.location.href=ctx+"/monitorsetting/alermtemplate/template-list.action?templateId="+templateId+"&domainId="+window.document.getElementById("domainId").value;
				}catch(e){
				}
			}
		});
	 });
	_confirm.show();
}


BSM.Monitorsetting.TemplateList.edit = function() {
		if(window.document.getElementById("template").value == ''){
			toast.addMessage('请先选择要编辑的模板。');
			return false;
		}
	if(window.document.getElementById("template").value=='1'){
		var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
		
		var obj = {
			height:300,
			width:600,
			name:"",
			url:ctx+"/monitorsetting/alermtemplate/template-open.action?templateId="+templateId+"&domainId="+window.document.getElementById("domainId").value+"&system="+window.document.getElementById("template").value
		};
		winOpen(obj);
		
		//Tools.prototype.openWin('${ctx }/monitorsetting/alermtemplate/template-open.action?templateId='+templateId+"&system="+window.document.getElementById("template").value,'',630,500,'no','no');
	}else{
		var obj = {
			height:300,
			width:600,
			name:"",
			url:ctx+"/monitorsetting/alermtemplate/template-open.action?templateId="+window.document.getElementById("template").value+"&domainId="+window.document.getElementById("domainId").value
		};
		winOpen(obj);
		//Tools.prototype.openWin('${ctx }/monitorsetting/alermtemplate/template-open.action?templateId='+window.document.getElementById("template").value,'',630,500,'no','no');
	}
}


		BSM.Monitorsetting.TemplateList.deletetemplate = function() {
			
			if(window.document.getElementById("template").value == ''){
				toast.addMessage('请先选择要删除的模板。');
				return false;
			}
			if(window.document.getElementById("template").value == '1'){
				toast.addMessage('系统模板不可删除！');
				return false;
			}
			
			var _confirm = new confirm_box({text:"是否执行删除操作？"});
			_confirm.setConfirm_listener(function(){
			  $.ajax({
					type: "POST",
					dataType:'html',
					data:$("#templateformname").serialize(),
					url:ctx+"/monitorsetting/alermtemplate/template-delete.action",
					success: function(data){
						var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
						window.location.href=ctx+"/monitorsetting/alermtemplate/template-list.action?templateId="+templateId+"&domainId="+window.document.getElementById("domainId").value;
					}
				});
			 });
			_confirm.show();
			
//			if(confirm("是否确认执行此操作？")){
//				$.ajax({
//					type: "POST",
//					dataType:'html',
//					data:$("#templateformname").serialize(),
//					url:ctx+"/monitorsetting/alermtemplate/template-delete.action",
//					success: function(data){
//						var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
//						window.location.href=ctx+"/monitorsetting/alermtemplate/template-list.action?templateId="+templateId+"&domainId="+window.document.getElementById("domainId").value;
//					}
//				});
//			}
		}
		BSM.Monitorsetting.TemplateList.create = function() {

			var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
			var obj = {
				height:300,
				width:600,
				name:"",
				url:ctx+"/monitorsetting/alermtemplate/template-open.action?templateId="+templateId+"&domainId="+window.document.getElementById("domainId").value 
			};
			winOpen(obj);

			//Tools.prototype.openWin('${ctx }/monitorsetting/alermtemplate/template-open.action?templateId='+templateId,'',630,500,'no','no');
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
var isNew ;
$(function(){
	var viewId = $('#viewId').val();
	if(viewId == 'REAL_TIME_NOTIFICATION'){
		$('[name=viewName]').attr("disabled", "disabled");
		$('[name=platformId]','#platform').attr('checked','checked').attr("disabled", "disabled");
		$('[name=severities]','#severity','#all_s').attr('checked','checked').attr("disabled", "disabled");
		$('#all_p').attr('checked','checked').attr("disabled", "disabled");
		$('#all_s').attr('checked','checked').attr("disabled", "disabled");
		$('#view_baseInfo_notiobj').hide();
		$('#confirm_button').hide();
		return;
	}
	if(viewId == ''){
		$('#all_p').attr('checked','checked');
		$('#all_s').attr('checked','checked');
	}
//	$("[name=platformId]").addClass("validate[minCheckboxByName[1]]");
//	$("[name=severities]").addClass("validate[minCheckboxByName[1]]");
	isNew = ($('#viewName').val() == '');
	var customItemCount = -1;
	$("#platform_form").validationEngine();
	settings = {
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() {} 
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
	$('#all_s','#severity').click(function(){
		$('[name=severities]','#severity').attr('checked',$(this).attr('checked'));
	})
	$('#all_p','#platform').click(function(){
		$('[name=platformId]','#platform').attr('checked',$(this).attr('checked'));
	})
	
	$('#all_c','#CUSTOM').click(function(){
		$('input[type=checkbox]','[id=customObjectItems]').attr('checked',$(this).attr('checked'));
	})
	$('#confirm_button').click(function(){
		submit();
	})
	$('[name=viewType]').change(function(){
		switchTypeDiv(this.value);
	})
	$('#delCustomObject').click(function(){
		$('[id^=customItem] input[type=checkbox]:checked').parentsUntil('table').find('select').unbind();
		$('[id^=customItem] input[type=checkbox]:checked').parentsUntil('li').remove(); 
	})
	$('[id^=customItem]').find('select').bind('change',function(){switchCustomObject(this);})
	$('#addCustomObject').click(function(){
		if(customItemCount == -1){
			customItemCount = $('[id^=customItem]').size();
		}
		addRow($('#customObjectItems') , customItemCount);
		customItemCount++;
	})

	switchTypeDiv($('[name=viewType]:checked').val());
})
function addRow(tag ,index ){
	
	var line = $('<li id="customItem_' + index + '"><table class="monitor-items-list"><tbody><tr></tr></tbody></table></li>');
	var absTd = $('<td></td>');
	var td1 = absTd.clone().append('<input type="checkbox"/>');
		td1.attr('width','7%')
	var select = $('<select></select>');
//		select.attr('id','customObjectCount');
		select.attr('name','customObjects['+index+'].content');
		select.append('<option value="OBJECT_TYPE" selected="selected">告警对象类型</option>');
		select.append('<option value="INSTANCEID">告警对象</option>');
		select.append('<option value="IPADDRESS">IP地址</option>');
	var td2 = absTd.clone().append(select);
		td2.attr('width','20%');
	var $resCategorys = $('#_resCategorys').clone();
		$resCategorys.attr('name','customObjects['+index+'].value');
		$resCategorys.attr('style','display:block;');
		$resCategorys.attr('id','OBJECT_TYPE_C'+index);
	
	var td3 = absTd.clone();
		td3.append($resCategorys);
		td3.attr('width','73%');
	line.find('tr').append(td1);
	line.find('tr').append(td2);
	line.find('tr').append(td3);
	line.find('select').bind('change',function(){switchCustomObject(this);})
	$(tag).append(line);
}
function switchCustomObject(tag){
	var index = tag.name.substring(tag.name.indexOf('[')+1,tag.name.indexOf(']'));
	var divId = $(tag).val();
	var $nextTd = $(tag).parent('td').next();
	$nextTd.children().remove();
	var input1 = null;
	if(divId == 'OBJECT_TYPE'){
		input1 = $('#_resCategorys').clone();
		input1.attr('id','INSTANCEID_C'+index);
		input1.attr('style','display:block;');
		
	}
	else if(divId == 'IPADDRESS'){
		input1 = $('<input/>');
		input1.attr('id','IPADDRESS_C'+index);
		input1.attr('class','validate[required,length[0,30]]');
	}else {
		input1 = $('<input/>');
		input1.attr('id','OBJECT_TYPE_C'+index);
		input1.attr('class','validate[required,length[0,30]]');
	}
	input1.attr('name','customObjects['+index+'].value');
	$nextTd.append(input1);
}

function submit(){
//	alert($("#platformId").attr("checked"))
//	alert($("#severities").attr("checked"))
	
	/*if($("#platformId").attr('checked') == undefined){ //判断是否已经打勾
		var _information = new information({text:"请选择平台。"});
		_information.show();
		return;
	}
	if($("#severities").attr('checked') == undefined){ //判断是否已经打勾
		var _information = new information({text:"请选择级别。"});
		_information.show();
		return;
	}*/
	
	var platformIdChecked = false;
	$("[name='platformId'][checked]").each(function(){
//		alert($(this).val());
		platformIdChecked=true;
	})
	if(!platformIdChecked){
		var _information = new information({text:"请选择平台。"});
		_information.show();
		return;
	}
	
	var severityChecked = false;
	$("[name='severities'][checked]").each(function(){
//		alert($(this).val());
		severityChecked=true;
	})
	if(!severityChecked){
		var _information = new information({text:"请选择级别。"});
		_information.show();
		return;
	}
	
	
	
	if(!$.validate($("#platform_form"))) {return;}
	var data = $("#platform_form").serialize();
	var viewType = $('[name=viewType]:checked').val();
	var VIEWTYPE = {};
	VIEWTYPE.RESGROUP = 'RESGROUP';
	VIEWTYPE.CUSTOM = 'CUSTOM';
	VIEWTYPE.INSTANCEID = 'INSTANCEID';
	VIEWTYPE.OBJECT_TYPE = 'OBJECT_TYPE';
	if(viewType == VIEWTYPE.RESGROUP){
		var rightResourceGroupTree = new Tree({
			id : "RightResourceGroupTree"
		});
		
		var nodes = rightResourceGroupTree.getNodeById('selectAll').children();
		var resourceGroup = '';
		$.each(nodes,function(i,e){
			resourceGroup += '&resourceGroup=';
			resourceGroup += e.getId();
		});
		data += resourceGroup;
//		$('#LeftResourceGroupTree').find('[nodeid=selectAll]').children('ul').find('')

		if(resourceGroup == ''){
			var _information = new information({text:"请选择资源组。"});
			_information.show();
			return;
		}
	}else if(viewType == VIEWTYPE.INSTANCEID){
		var rightIns = $('#selected_ins');
		var trs = rightIns.find('tr');
		var ins = '';
		$.each(trs,function(i,e){
			ins += '&instance['+i+'].id='+ $(e).attr('insid');
			ins += '&instance['+i+'].moduleId='+ $(e).attr('moduleId');
		});
		data += ins;
		
		if(ins == ''){
			var _information = new information({text:"请选择告警对象。"});
			_information.show();
			return;
		}		
	}else if(viewType == VIEWTYPE.OBJECT_TYPE){
		var rightObjTypeTree = new Tree({id:"rightObjectTypeTree"});
		var nodes = rightObjTypeTree.getNodeById('selectAll').getCheckboxNodes();
		var obj_types = '';
		$.each(nodes,function(i,e){
			if(e.isLeaf()){
				obj_types += '&objectType=';
				obj_types += e.getId();
			}
		});
		data += obj_types;
		
		if(obj_types == ''){
			var _information = new information({text:"请选择告警对象类型。"});
			_information.show();
			return;
		}	
	}else if(viewType == VIEWTYPE.CUSTOM){
		var custom_str = '';
		var objTypeValue = false;
		var objValue = false;
		var ipAddressValue = false;
		$("#custom_lines").children().each(function(i,e){
			var self = $(e);
			var content,condition,value,name;
			if(self.attr("id") == 'ndel'){
				value = $("#obj_type_ids",self).val();
				content = "OBJECT_TYPE";
				condition = "EQUAL";
				name = $("#obj_type_name",self).val();
			}else{
				var tds = self.children();
				content = $(tds[1]).find("select").val();
				condition = $(tds[2]).find("select").val();
				value = $(tds[2]).find("input").val();
				name = "";
			}
			
			//alert("content:"+content+" value:"+value)
			if(content == "OBJECT_TYPE" && value ==''){
				objTypeValue = true;
			}
			if(content == "INSTANCEID" && (value =='' || value == '多个关键字之间用“;”分隔，关系为“或”')){
				objValue = true;
			}
			if(content == "IPADDRESS" && (value =='' || value == '多个关键字之间用“;”分隔，关系为“或”')){
				ipAddressValue = true;
			}
			
			custom_str += '&customObjects['+i+'].content=' + content;
			custom_str += '&customObjects['+i+'].condition=' + condition;
			custom_str += '&customObjects['+i+'].value=' + value;
			custom_str += '&customObjects['+i+'].name=' + name;
			
		});
		if(objTypeValue){
			var _information = new information({text:"请选择告警对象类型。"});
			_information.show();
			return;
		}
		if(objValue){
			var _information = new information({text:"告警对象不允许为空。"});
			_information.show();
			return;
		}
		if(ipAddressValue){
			var _information = new information({text:"IP地址不允许为空。"});
			_information.show();
			return;
		}
//		alert(custom_str);
		data += custom_str;
	}
	$.ajax({
		type : "POST",
		url : path + "/notification/viewEditorSave.action",
		data: data,
		dataType:"json",
		success:function(data){
			var viewName = $('[name=viewName]').val();
			parentPageRefresh(data.viewName,data.viewId);
			closeWin();
		},
		error:function(msg){
			//alert(msg.responseText);
		}

	})
}
function switchTypeDiv(typeId){
	$('#objcontent>div').hide();
	var switchTypeDiv = $('#' + typeId);
	var viewId = $('#viewId').val();
//	alert(path + '/notification/viewEditorTabSwitch.action?switchType='+typeId+'&viewId='+viewId);
	if(switchTypeDiv.children().length == 0){
		switchTypeDiv.load(
			path + '/notification/viewEditorTabSwitch.action',
			{switchType:typeId,viewId:viewId,userId:userId,domains:domainId,isSystemAdmin:isSystemAdmin},
			function(){
				
			}
		);
	}
	switchTypeDiv.show();
}
function parentPageRefresh(viewName,viewId){
	if (window.opener != null ) {
		var url = window.opener.location.href;
		if((url.indexOf('notification/management.action')>0 || url.indexOf('notification/alarm.action')>0) && isNew){
			window.opener.addTab(viewName,viewId);
		}else{
			window.opener.editTab(viewName,viewId);
		}
		window.opener.refreshFlash(
			window.opener.getUserId(),
			viewId,
			window.opener.getTimeId()
		);
		window.opener.init();
		//window.opener.changeGrid("/profile/profileListChild.action?profileId "+profileId);
	}
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
	<div class="white-bg">
	   <h1 class="h1"><span class="r-ico r-ico-delete" id="delPlatForm" title="删除"></span><span class="r-ico r-ico-add" id="addPlatForm" title="添加"></span><span class="ico ico-note"></span><span>请设置本系统能接收哪些平台发送的事件告警。</span></h1>
	 </div>
	<s:form id="platFormList">
	<s:hidden name="orderBy" id="orderBy"/>
	<s:hidden name="orderType" id="orderType"/>
	<page:applyDecorator name="indexcirgrid"> 
		<page:param name="id">tableId</page:param>
		<page:param name="height">100%</page:param>
		<page:param name="tableCls">grid-black</page:param>
		<page:param name="gridhead">[{colId:"platFormId",text:"&nbsp;"},{colId:"platFormName",text:"平台"},{colId:"keyWord",text:"关键字"},{colId:"userDomainIds",text:"所属<s:property value="@com.mocha.bsm.event.common.RangeName@rangeName()"/>"},{colId:"switchSet",text:"屏蔽/开通"},{colId:"tempId",text:"tempId",hidden:"true"}]</page:param>
		<page:param name="gridcontent">${platForms}</page:param>
	</page:applyDecorator>
	</s:form>
<script type="text/javascript">
$(document).ready(function(){
	var toast = new Toast({position:"CT"});
	
	$("#platFormList").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  } 
	});
	
	var gp = new GridPanel({id:"tableId",
		unit:"%",
		columnWidth:{platFormId:4,platFormName:26,keyWord:26,userDomainIds:24,switchSet:20},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"platFormName",defSorttype:"down"},
		{index:"keyWord"}],
		sortLisntenr:function($sort){
			var orderType = "desc";
			if($sort.sorttype == "up"){
				orderType = "asc";
			}
			$("#orderBy").attr("value",$sort.colId);
			$("#orderType").attr("value",orderType);
			var param = "?orderBy="+$sort.colId+"&orderType="+orderType;
	      	$.ajax({
	      		type: "POST",
	      		dataType:'html',
	      		url: "${ctx}/event/platFormSet!platFormSetList.action"+param,
	      		success: function(data, textStatus){
	      			rewrite("platForms",data);
	      		}
	      	});
		}},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	gp.rend([{index:"platFormId",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $font;
		if("MochaBSM" == td.html){
			$font = "";
		}else{
			$font = $('<input type="checkbox" name="platFormIds" id="'+td.html+'_checkbox" value="'+td.html+'"><input type="hidden" name="platForm.platFormId" value="'+td.html+'">');
		}
		return $font;
	}},{index:"platFormName",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $font;
		if("MochaBSM" == td.value.tempId){
			$font = td.html;
		}else{
			$font = $('<font style="cursor:pointer" title="'+td.html+'">'+td.html+'</font>');
			$font.bind("click",function(){
				openEditPlatForm(td.value.tempId);
			});
		}
    	return $font;
	}},{index:"userDomainIds",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $font;
		var array = td.html.split(',');
		if("-" == td.html || array.length == 1){
			$font = $('<font style="cursor:pointer" title="'+td.html+'">'+td.html+'</font>');
		}else{
			var options = "";
			for(var i = 0; i < array.length; i++){
				options += "<option>"+array[i]+"</option>";
			}
			$font = $("<select id='userDomain_" + td.rowIndex + "' style='width:150px'>"+options+"</select>");
		}
    	return $font;
	}},{index:"switchSet",fn:function(td){
		if(td.html == ""){
			return;
		}
		var $font;
		if(td.value.tempId == 'MochaBSM'){
			$font = $('<span>开通</span>');
		}else{
			var onSelect = "";
			var offSelect = "";
			if(td.html == "on"){
				onSelect = "selected";
			}else{
				offSelect = "selected";
			}
			$font = $('<select id="switchSet_' + td.rowIndex + '" name="platForm.switchSet"><option value="on" '+onSelect+'>开通</option><option value="off" '+offSelect+'>屏蔽</option></select>');
		}
    	return $font;
	}}],0,function(){SimpleBox.renderAll();});

	$("#topBtn1").click(function() {
		window.close();
  	});
  	
	$("#cancel_button").click(function() {
		window.close();
  	});
  	
	$("#ok_button").click(function() {
		doSubmit();
		window.close();
  	});
  	
	$("#app_button").click(function() {
		doSubmit();
  	});

	$("#addPlatForm").bind("click", function(){
		openAddPlatForm();
	});

	var win = new confirm_box({title:'提示',text:'是否确认执行此操作？',cancle_listener:function(){win.hide();}});
	$("#delPlatForm").bind("click", function(){
		if(!validateDelete(toast)) return;
		win.setConfirm_listener(function(){
			win.hide();
			var ajaxParam = $("#platFormList").serialize();
			$.ajax({
				type: "POST",
				dataType:'html',
				url: "${ctx}/event/platFormSet!delPlatForm.action",
				data: ajaxParam,
				success: function(data, textStatus){
					rewrite("platForms",data);
				},
				fail: function(data, textStatus) {
					alert('fail');
				}
			});
		});
		win.show();
	});
});

function openAddPlatForm() {
	var orderBy = $("#orderBy").attr("value");
	var orderType = $("#orderType").attr("value");
	var src="${ctx}/event/platFormSet!addPlatForm.action?orderType="+orderType+"&orderBy="+orderBy;
	var width=460;
	var height=240;
	window.open(src,'addPlatForm','height='+height+',width='+width+',scrollbars=yes');
}

function openEditPlatForm(platFormId) {
	var orderBy = $("#orderBy").attr("value");
	var orderType = $("#orderType").attr("value");
	var src="${ctx}/event/platFormSet!editPlatForm.action?platForm.platFormId=" + platFormId+"&orderType="+orderType+"&orderBy="+orderBy;
	var width=460;
	var height=240;
	window.open(src,'editPlatForm','height='+height+',width='+width+',scrollbars=yes');
}

function validateDelete(toast) {
	var $checkarr = $("input[name='platFormIds']:checked");
	if($checkarr.length == 0){
		toast.addMessage("请至少选择一项。");
		return false;
	}
	return true;
}

function rewrite(formId,data){
	$div_obj = $("#" + formId);
	$div_obj.find("*").unbind();
	$div_obj.html(data);
}

function doSubmit() {
	//$.blockUI({message:$('#loading')});
	if(!$.validate( $("#platFormList") )) return;
	var ajaxParam = $("#platFormList").serialize();
	$.ajax({
		type: "POST",
		dataType:'json',
		url: "${ctx}/event/platFormSet!updateSwitchSet.action",
		data: ajaxParam,
		success: function(data, textStatus){
			//alert('success');
			//opener.location.reload();
			//window.close();
		},
		fail: function(data, textStatus) {
			//alert('fail');
		}
	});
	//$.unblockUI();
}

function callFailFunction(){
	  alert("in callFailFunction()");
}

settings = {
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  } 
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
</script>
</html>
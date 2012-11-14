<!-- WEB-INF\content\scriptmonitor\repository\select-parameter.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>选择参数</title>

<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script src="${ctxJs}/scriptmonitor/scriptRepositorys.js"></script>
<script type="text/javascript">
	var $def;
	var defNameIndex = 0;
	
	//表单验证
	$(document).ready(function() {
		
		$("#closeId,#cancel").click(function (){
			window.close();
		});
		
		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"blur",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		
		$.validationEngineLanguage.allRules.<%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_PARAMETER%>={
      		"file":"${ctx}/scriptmonitor/repository/nameValidate.action",
      		"nname":"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_PARAMETER%>",
         	"alertTextLoad":"<font color=\"red\">*</font> 正在验证，请等待",
         	"alertText":"<font color=\"red\">*</font> 参数名称已经存在"
     	}
		
		
		$("#submit").click(function (){
			if(!$.validate($('#addForm'))){
				return false;
			}
			
			$.ajax({
				url:		"${ctx}/scriptmonitor/repository/scriptParameter!saveParamsAndSelectByIds.action",
				data:		$("#addForm").serialize(),
				dataType:  	"json",
				cache:		false,
				success:	function(data,textStatus){
					window.returnValue=data.params;
					window.close();
				}
			});
		});
		
		$("img[id='addImg']").click(bundleAddImg);
		
		$("span[id='deleteImg']").click(doDelete);
		
		$("input[name='existParamprefix']").change(function(){
			var parentObj = $(this).parents("li");
			var defaultValueObj = parentObj.find("input[name='existParamdefaultValue']");
			defaultValueObj.attr("disabled",true);//禁用
			
			var idValue =  parentObj.attr("id");
			var idObj = parentObj.find(":checkbox:first").val();
			var defaultValue = defaultValueObj.val();
			var hiddenId = idValue+'_hidden';
			var hidden = $('#'+hiddenId);
			var passwordValue = parentObj.find(":checkbox:last").val();
			if(hidden.val()){
				hidden.val(idObj+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+this.value+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+defaultValue+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+passwordValue);
			}else{
				hidden = $("<input type='hidden' id='"+hiddenId+"' name='parameterUpdate' value='"+idObj+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+this.value+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+defaultValue+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+passwordValue+"'>");
				parentObj.append(hidden);
			}
			defaultValueObj.attr("disabled",false);//解除禁用
		});
		
		$("input[name='existParamdefaultValue']").change(function(){
			var parentObj = $(this).parents("li");
			var prefixObj = parentObj.find("input[name='existParamprefix']");
			prefixObj.attr("disabled",true);//禁用
			
			var idValue =  parentObj.attr("id");
			var idObj = parentObj.find(":checkbox:first").val();
			var prefixValue = prefixObj.val();
			var hiddenId = idValue+'_hidden';
			var hidden = $('#'+hiddenId);
			var passwordValue = parentObj.find(":checkbox:last").val();
			if(!hidden.val()){
				hidden = $("<input type='hidden' id='"+hiddenId+"' name='parameterUpdate' value='"+idObj+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+prefixValue+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+this.value+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+passwordValue+"'>");
				parentObj.append(hidden);
			}else{
				hidden.val(idObj+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+prefixValue+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+this.value+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+passwordValue);
			}
			prefixObj.attr("disabled",false);//解除禁用
		});
		$("input[name='existPassword']").change(function(){
			var parentObj = $(this).parents("li");
			var prefixObj = parentObj.find("input[name='existParamprefix']");
			var defaultValueObj = parentObj.find("input[name='existParamdefaultValue']");
			//prefixObj.attr("disabled",true);//禁用
			//defaultValueObj.attr("disabled",true);//禁用
			var idValue =  parentObj.attr("id");
			var idObj = parentObj.find(":checkbox").first().val();
			var prefixValue = prefixObj.val();
			var defaultValueObjValue = defaultValueObj.val();
			var hiddenId = idValue+'_hidden';
			var hidden = $('#'+hiddenId);
			if(!hidden.val()){
				hidden = $("<input type='hidden' id='"+hiddenId+"' name='parameterUpdate' value='"+idObj+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+prefixValue+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+defaultValueObjValue+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+$(this).attr("checked")+"'>");
				parentObj.append(hidden);
			}else{
				hidden.val(idObj+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+prefixValue+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+defaultValueObjValue+"<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>"+$(this).attr("checked"));
			}
			
		});
		//选择所有的参数
		$("#allcheck").click(function(){
			var allChecks = $("input[type=checkbox]");
			for(i=0;i<allChecks.length;i++){
				allChecks[i].checked = this.checked;
			}
		});
		
		/*绑定新增参数输入框，为其建立隐藏域*/
		$("input[id='name'],input[id='prefix'],input[id='defaultValue'],input[id='isPassword']").change(function(){
			var parent = $(this).parents("li");
			var nameValue;
			var prefixValue;
			var defaultValue;
			var isPassword;
			var idValue = this.id;
			if(idValue == 'name'){
				nameValue = this.value;
				prefixValue = parent.find("input[id='prefix']").val();
				defaultValue = parent.find("input[id='defaultValue']").val();
				isPassword = parent.find("input[id='isPassword']").val();
			}else if(idValue == 'prefix'){
				prefixValue = this.value;
				nameValue = parent.find("input[id='name']").val();
				defaultValue = parent.find("input[id='defaultValue']").val();
				isPassword = parent.find("input[id='isPassword']").val();
			}else if(idValue == 'defaultValue'){
				defaultValue = this.value;
				nameValue = parent.find("input[id='name']").val();
				prefixValue = parent.find("input[id='prefix']").val();
				isPassword = parent.find("input[id='isPassword']").val();
			}else if(idValue == 'isPassword'){
				isPassword = this.value;
				nameValue = parent.find("input[id='name']").val();
				prefixValue = parent.find("input[id='prefix']").val();
				defaultValue = parent.find("input[id='defaultValue']").val();
			}
			if(nameValue && nameValue !=''){
				idValue =  parent.attr("id");
				var hiddenId = idValue+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>hiddenObj';
				var hiddenObj = $("#"+hiddenId);
				var booleanVal = "false";
				if(isPassword == 0){
					booleanVal = "false";
				}else if(isPassword){
					booleanVal = "true";
				}
				var value = idValue+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+nameValue+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+prefixValue+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+defaultValue+'<%=com.mocha.bsm.script.monitor.bean.ScriptBean.PARAMETER_SPLIT%>'+booleanVal;
				if(hiddenObj.val()){
					hiddenObj.val(value);
				} else {
					hiddenObj = $("<input type='hidden' id='"+hiddenId+"' name='parameterCreate' value='"+value+"'>");
					parent.append(hiddenObj);
				}
				parent.find(":checkbox").val(idValue);
			}
		});
	});
	
	function doDelete(){
			var parentObj = $(this).parents("li");
			var checkBox = parentObj.find(":checkbox");
			var id = checkBox.attr("id");
			if(id == 'extensionParam'){
				parentObj.remove();
				reBuildColors();
				dialogResize();
			}else {
				var value = checkBox.val();
				$.ajax({
					url:		"${ctx}/scriptmonitor/repository/scriptParameter!delParameter.action",
					data:		"deleteParameterId="+value,
					dataType:  	"json",
					cache:		false,
					success:	function(data,textStatus){
						if(data.jsonValidateReturn[2] == "true"){
							parentObj.remove();
							reBuildColors();
							window.dialogArguments.removeOptionByValue(value);
						}else{
							var _information = new information({text:data.jsonValidateReturn[1]});
							_information.show();
						}
					}
				});
			}
	}
	var editedList = new Array();
	function isEditParamterFun(parameterId,textfieldId){
		if(!editedIdExsitFun(textfieldId)){
			var evt = window.event;
			var eventSrc = evt.target || evt.srcElement;
			$.ajax({
				url:		"${ctx}/scriptmonitor/repository/scriptParameter!vaildEditParam.action",
				data:		"deleteParameterId="+parameterId,
				dataType:  	"json",
				cache:		false,
				success:	function(data,textStatus){
					if(data.paramUsed == "true"){
						var _confirm = new confirm_box({text:"脚本参数已经被使用，是否继续编辑？"});
						_confirm.setConfirm_listener(function(){
							editedList.push(textfieldId);
							$("#"+textfieldId).focus();
							_confirm.hide();
						});
						_confirm.setCancle_listener(function(){
							if(eventSrc.type == "checkbox"){
								eventSrc.checked = !eventSrc.checked;
							}
							$("#"+textfieldId).blur();
							_confirm.hide();
						});
						_confirm.show();
					}else{
						$("#textfieldId").focus();
					}
				}
			});
		}
	}
	function editedIdExsitFun(textfieldId){
		for(var i=0;i<editedList.length;i++){
			if(editedList[i] == textfieldId){
				return true;
			}
		}
		return false;
	}
	var nextIndex = ${size};
	function bundleAddImg(){
			var addFormObj = $('#addForm');
			if(!$.validate(addFormObj)){
				return false;
			}
			if(!$def){
				$def = $("#def");
			}
			var cloneDef = $def.clone(true);
			cloneDef.attr("id","defEx"+defNameIndex++);
			if(nextIndex % 2 == 0){
				 cloneDef.addClass("gray");
			}
			nextIndex++;
			var ulObj = $("ul");
			ulObj.append(cloneDef);
			cloneDef.show();
			dialogResize();
	}
	
	function reBuildColors(){
		var lines = $("li");
		for(i=1;i<lines.length;i++){
			  if(i%2==1){
			    $(lines.get(i)).addClass("gray");
			  }else{
			    $(lines.get(i)).removeClass("gray");
			  }
		}
	}
	
	/*
	*验证新增的还没有保存的参数有无重复。
	*/
	function <%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_PARAMETER%>(caller){
		var checkValue = caller.value
		var allBoxs = $("ul input");
		for(i=0;i<allBoxs.length;i++){
			var box = allBoxs[i];
			if(box.id == 'name' && box != caller && box.value == checkValue){
				return true;
			}
		}
		return false;
	}
</script>
</head>

<body >
<div id="addParameterDiv" style="background-color:black;">
<page:applyDecorator name="popwindow"  title="选择参数">
	<page:param name="width">490px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
	<s:form id="addForm">
		<div class="add-button1 margin3" style="text-align:right;"><img id="addImg" src="${ctxImages}/add-button1.gif" style="padding-right:10px;cursor:hand;"  border="0" title="添加一行" /></div>
		<ul class="fieldlist-n" style="margin-left:0px;margin-right:0px;">
			<li style="background:url(${ctxImages}/table/round-table-top.gif) repeat-x left -54px;padding-left:0px;padding-right:0px;">
				<span class="field" style="width:30px;"><input type="checkbox" name="allcheck" id="allcheck"/></span>
				<span class="field" style="width:100px;color:white;text-align:left;">参数名称<span class="red">*</span></span>		
				<span class="field" style="width:100px;color:white;text-align:left;">参数前缀</span>
				<span class="field" style="width:100px;color:white;text-align:left;">默认值</span>
				<span class="field" style="width:100px;color:white;text-align:left;">值不显示为明文</span>
			</li>
			<s:iterator value="params" id="vo" status="f">
			
			<s:if test="#f.odd">
				<li id="params<s:property value="#f.index"/>" style="padding-left:0px;padding-right:0px;" class="gray">
			</s:if>
			<s:else>
				<li id="params<s:property value="#f.index" />" style="padding-left:0px;padding-right:0px;">
			</s:else>
			<span class="field" style="width:30px;padding-left:0px;"><s:checkbox  name="paramIds" id="existParam" fieldValue="%{#vo.key}"/></span>
				<s:if test="#vo.lock">
					<span class="field" style="width:100px;"><s:property value="#vo.name"/>&nbsp;</span>
					<span class="field" style="width:100px;"><s:textfield id="existParamprefix%{#vo.key}" onclick="isEditParamterFun('%{#vo.key}','existParamprefix%{#vo.key}');" name="existParamprefix" value="%{#vo.prefix}" style="width:95px;" disabled="true"/></span>
					<span class="field" style="width:100px;"><s:textfield id="existParamdefaultValue%{#vo.key}" onclick="isEditParamterFun('%{#vo.key}','existParamdefaultValue%{#vo.key}');" name="existParamdefaultValue" value="%{#vo.defaultValue}" style="width:95px;" disabled="true"/></span>				
				</s:if>
				<s:else>
					<span class="field" style="width:100px;"><s:property value="#vo.name"/>&nbsp;</span>
					<span class="field" style="width:100px;"><s:textfield id="existParamprefix%{#vo.key}" onclick="isEditParamterFun('%{#vo.key}','existParamprefix%{#vo.key}');"  name="existParamprefix" value="%{#vo.prefix}" style="width:95px;"/></span>
					<span class="field" style="width:100px;"><s:textfield id="existParamdefaultValue%{#vo.key}" onclick="isEditParamterFun('%{#vo.key}','existParamdefaultValue%{#vo.key}');" name="existParamdefaultValue" value="%{#vo.defaultValue}" style="width:95px;"/></span>
				</s:else>
				<s:if test="#vo.password == false">
					<span class="field" style="width:100px;"><s:checkbox  name="existPassword" onclick="isEditParamterFun('%{#vo.key}','existPassword%{#vo.key}');"  id="existPassword%{#vo.key}" /></span>
				</s:if>
				<s:else>
					<span class="field" style="width:100px;"><s:checkbox  name="existPassword" onclick="isEditParamterFun('%{#vo.key}','existPassword%{#vo.key}');" checked="true"  id="existPassword%{#vo.key}" /></span>
				</s:else>
				<s:if test="#vo.system == false">
				 	<span id="deleteImg" class="ico ico-delete">&nbsp;</span>
				</s:if>
				<s:else>
					<span class="ico ico-delete-grey">&nbsp;</span>
				</s:else>
			</li>
			</s:iterator>
		</ul>
	</s:form>
	</page:param>
</page:applyDecorator>
</div>
<li style="display:none;padding-left:0px;padding-right:0px;" id="def">
	<span class="field" style="width:30px;"><s:checkbox  name="paramIds" id="extensionParam"/></span>
	<span class="field" style="width:100px;"><input id="name" type="text" name="param.name" style="width:95px;" class="validate[required,noSpecialStr,ajax[<%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_PARAMETER%>]],funcCall[<%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_PARAMETER%>]"/></span>		
	<span class="field" style="width:100px;"><s:textfield id="prefix" name="param.prefix" style="width:95px;"/></span>
	<span class="field" style="width:100px;"><s:textfield id="defaultValue" name="param.defaultValue" style="width:95px;"/></span>
	<span class="field" style="width:100px;"><s:checkbox  name="isPassword" id="isPassword" fieldValue="0"/></span>
	<span id="deleteImg" class="ico ico-delete">&nbsp;</span>	
</li>
</body>
</html>
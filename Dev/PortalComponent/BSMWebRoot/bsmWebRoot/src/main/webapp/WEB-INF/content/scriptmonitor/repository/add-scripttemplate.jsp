<%--  
 *************************************************************************
 * @source  : add-scripttemplate.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION 
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.1.13	 huaf     	  添加脚本
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<!-- WEB-INF\content\scriptmonitor\repository\add-scripttemplate.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>

<s:set name="operate" value="#request.operate"/>
<s:set name="success" value="#request.success"/>
<s:if test="\"edit\".equals(#flag)">
	<s:set name="action" value="\"/scriptmonitor/repository/scriptTemplate!updateScriptTemplate.action\"" scope="request"/>
	<s:set name="titleName" value="\"编辑脚本\"" scope="request"/>
</s:if>
<s:else>
	<s:set name="action" value="\"/scriptmonitor/repository/scriptTemplate!addScriptTemplate.action\"" scope="request"/>
	<s:set name="titleName" value="\"新建脚本\"" scope="request"/>
</s:else>

<title>${titleName}</title>

<link href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js" type="text/javascript" ></script>
<script src="${ctxJs}/component/cfncc.js" type="text/javascript" ></script> 
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script src="${ctxJs}/scriptmonitor/scriptRepositorys.js" type="text/javascript" ></script>
<script src="${ctxJs}/component/panel/panel.js" type="text/javascript" ></script>

<s:if test="#success==true">
<script type="text/javascript">
	if("${success}" == "true"){
		//刷新父页面
		window.returnValue="刷新脚本详细信息";
		self.close();
	}
</script>
</s:if>
<s:else>
<script type="text/javascript">
	var panel;
	var timeoutHandler;
	//表单验证
	$(document).ready(function() {
		$("#closeId").click(function (){
			window.close();
		});
		//测试
		$("#test").click(function(){
			var scripPathObj = $("#filePath").get(0);
			var scriptPath = scripPathObj.value;
			if(!scriptPath || scriptPath == ""){
				alert("请输入脚本路径");
				return false;
			}
			$("#parameterIds option").attr("selected", true);
			<s:if test="edit">
				inputScriptParamter(null,$("#addForm").serialize());
			</s:if>
			<s:else>
				scripPathObj.disabled=false;
				inputScriptParamter(null,$("#addForm").serialize());
				scripPathObj.disabled=true;
			</s:else>
		});
		//取消
		$("#cancel").click(function(){
			window.close();
		});
		
		//添加脚本参数与脚本的绑定
		$("#addParameter").click(function(){
			var params = window.showModalDialog("${ctx}/scriptmonitor/repository/scriptParameter!selectParameter.action",window,"help=no;status=no;scroll=no;center=yes");
			if(params){
				var parHtml="";
				for(var i=0;i < params.length;i++){
					parHtml += "<option value="+params[i].key+">"+params[i].name+"</option>";
				}
				$("#parameterIds").html(parHtml);
			}
		});
		
		<s:if test="edit">
		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"blur",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		//确定
		$("#submit").click(function (){
			$("#parameterIds option").attr("selected", true);
			$("#addForm").attr("action","${ctx}${action}");	
			$("#addForm").submit();
		});
		//添加脚本分类
		$("#addGroupByscript").click(function(){
			var value = addScriptGroup("${scriptTemplate.repositoryId}",window.dialogArguments);
			if(value){ //返回成功，添加成功的分类到列表
				var selectGroups = $("#groupId");
				var options = $(selectGroups,"option");
				for(i=0;i<options.length;i++){
					options[i].selected = false;
				}
				var idAndName = value.split(':');
				var newOption = new Option(idAndName[1],idAndName[0],true,true);
				selectGroups.append("<option value='"+idAndName[0]+"' selected='true'>"+idAndName[1]+"</option>");
			}
		});
		
		//取消脚本参数与脚本的绑定
		$("#delParameter").click(function(){
			var $parameter = $("#parameterIds");
			if($parameter.val()){
				$("#parameterIds option").each(function(i){
					if($(this).attr("selected") == true){
						$(this).remove();
					}				
				});
			}else{
				var _information = new information({text:"请选择一个脚本参数"});
				_information.show();
			}
		});
		
		$params = $("#parameterIds");
		//取消脚本参数与脚本的绑定
		$("#up").click(function(){

			var itemOptions = $params[0].options; 
			var index=$params[0].selectedIndex;
			var count = $params.find("option[selected]").length
			var selectedOption; 
			if (count > 1) { 
				var _information = new information({text:"只能选择一个脚本参数！"});
				_information.show();				
				return; 
			}
			if (count == 0) { 
				var _information = new information({text:"请选择脚本参数！"});
				_information.show();				
				return; 
			}
			
			if(index==0)
				return;

			selectedOption = itemOptions[index]; 
			var precedeOption = itemOptions[index-1]; 
			var temp = new Option(selectedOption.text, selectedOption.value); 

			selectedOption.text = precedeOption.text; 
			selectedOption.value = precedeOption.value; 
			selectedOption.selected = false; 

			precedeOption.text = temp.text; 
			precedeOption.value = temp.value; 
			precedeOption.selected = true; 
		});
		
		$("#down").click(function(){
			var itemOptions = $params[0].options; 
			var index=$params[0].selectedIndex;
			var count = $params.find("option[selected]").length
			var selectedOption; 
			if (count > 1) { 
				var _information = new information({text:"只能选择一个脚本参数！"});
				_information.show();	
				return; 
			} 
			if (count == 0) { 
				var _information = new information({text:"请选择脚本参数！"});
				_information.show();
				return; 
			} 
			if(index==itemOptions.length-1)
				return;
			
			selectedOption = itemOptions[index]; 
			var nextOption = itemOptions[index+1]; 
			var temp = new Option(selectedOption.text, selectedOption.value); 

			selectedOption.text = nextOption.text; 
			selectedOption.value = nextOption.value; 
			selectedOption.selected = false; 

			nextOption.text = temp.text; 
			nextOption.value = temp.value; 
			nextOption.selected = true; 
		});
		$.validationEngineLanguage.allRules.<%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_TEMPLATE%>={
      		"file":loadUrl,
         	"alertTextLoad":"<font color='red'>*</font> 正在验证，请等待",
         	"alertText":"<font color='red'>*</font> 脚本名称已经存在"
     	}
     	</s:if>
     	
     	<s:if test="edit == false">
			$.each($(":input"),function(i,n){
				if(n.id != 'parameterIds' && n.type != 'hidden'){
					n.disabled=true;
				}
			});
		</s:if>
	});
	
	function closePanel(){
		if(panel){
			if(timeoutHandler){
				clearTimeout(timeoutHandler);
			}
			panel.close("close");
			panel = null;
		}
	}
	
	function loadUrl(){
		var groupId = $("#groupId").val();
		if(!groupId){
			groupId = -1;
		}
		return "${ctx}/scriptmonitor/repository/nameValidate.action?parentId="+groupId+"&currentId=${scriptTemplate.id}";
	}
	
	function removeOptionByValue(theValue){
		var options = $("#parameterIds option");
		for(i=0;i<options.length;i++){
			var op = options[i];
			if(op.value == theValue){
				$(op).remove();
				break;
			}
		}
	}
</script>
</head>

<body >
<page:applyDecorator name="popwindow"  title="${titleName}">
	
	<page:param name="width">550px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">test</page:param>
	<page:param name="bottomBtn_text_1">测试脚本</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">submit</page:param>
	<page:param name="bottomBtn_text_2">确定</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">cancel</page:param>
	<page:param name="bottomBtn_text_3">取消</page:param>
	
	<page:param name="content">
	<div style="margin-top:10px;">
		<span class="vertical-middle"><img src="${ctxImages}/scriptmonitor/ico-info.gif" border="0"  width="16" height="16" hspace="6" align="absmiddle"/></span>
		<span class="vertical-middle">输入脚本的名称和路径、文件名，${titleName}。</span>
	</div>
	<fieldset class="blue-border-nblock">
    <legend>脚本信息</legend>	
	<s:form id="addForm">
		<s:hidden name="scriptTemplate.id" value="%{scriptTemplate.id}"></s:hidden>
		<s:hidden name="scriptTemplate.repositoryId" value="%{scriptTemplate.repositoryId}"></s:hidden>
		<ul class="fieldlist-n">
			<li>
				<span class="field-middle">脚本所属分类</span><span>：</span>
				<s:select name="scriptTemplate.groupId" cssClass="validate[required]" list="groups" listKey="id" listValue="name" id="groupId"></s:select>
				<span class="red">*</span>
				<span id="addGroupByscript" class="ico ico-add" title="添加脚本分类"></span>
			</li>
			<li>
				<span class="field-middle">脚本显示名称</span><span>：</span>
				<s:textfield name="scriptTemplate.name" cssClass="validate[required,noSpecialStr,length[0,30,脚本显示名称],ajax[duplicateTemplateName]]" value="%{scriptTemplate.name}" title="%{scriptTemplate.name}"></s:textfield>
				<span class="red">*</span>
			</li>
			<li>
				<span class="field-middle">脚本路径</span><span>：</span>
				<s:textfield id="filePath" name="scriptTemplate.filePath" style="width:250px;" cssClass="validate[required,length[0,300,脚本路径]]" value="%{scriptTemplate.filePath}" title="%{scriptTemplate.filePath}"></s:textfield>
				<span class="red">*</span><br>
				<span class="field" style="width:400px;margin-left:108px;">(&nbsp;<font color="red">脚本的绝对路径，包含文件名称。例如：/etc/netsnmp/snmpwalk </font>&nbsp;)</span>
			</li>
			<li>
				<span class="field-middle" style="float:left;">脚本参数</span><span style="float:left;">：</span>
				<s:select style="width:150px;height:120px; y-overflow:scroll;margin-left:10px;float:left;" id="parameterIds" name="parameterIds" size="6" multiple="true"
						list="scriptTemplate.scriptParameters" listKey="parameter.key" listValue="parameter.name">
				</s:select>
				<div style="float:left;width:200px;margin-top:5px;margin-left:5px;"><span id="up" class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>&nbsp;&nbsp;上移&nbsp;&nbsp;</a></span></span></span></div>
				<div style="float:left;width:200px;margin-top:5px;margin-left:5px;"><span id="down" class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>&nbsp;&nbsp;下移&nbsp;&nbsp;</a></span></span></span></div>
				<div style="float:left;width:200px;margin-top:5px;margin-left:5px;"><span id="addParameter" class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a >&nbsp;&nbsp;添加&nbsp;&nbsp;</a></span></span></span></div>
				<div style="float:left;width:200px;margin-top:5px;margin-left:5px;"><span id="delParameter" class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a >&nbsp;&nbsp;删除&nbsp;&nbsp;</a></span></span></span></div>
			</li>
			<li>
				<span class="field-middle">备注</span><span>：</span>
				<s:textarea name="scriptTemplate.remark" value="%{scriptTemplate.remark}" style="width:250px;height:80px;scrolling:auto;" cssClass="validate[length[0,300,备注]]" ></s:textarea>
			</li>
		</ul>
	</s:form>
	</fieldset>
	</page:param>
</page:applyDecorator>
</s:else>
</body>
</html>
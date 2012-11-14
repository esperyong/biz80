<%--  
 *************************************************************************
 * @source  : add-compent.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.19	 huaf     	 新增组件
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self"> 
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:if test="componentId != null">
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!updateScriptGroup.action\"" scope="request"/>
	<s:set name="titleName" value="\"编辑组件\"" scope="request"/>
</s:if>
<s:else>
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!addScriptGroup.action\"" scope="request"/>
	<s:set name="titleName" value="\"新增组件\"" scope="request"/>
</s:else>
<title>${titleName}</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/scriptmonitor/modolExtension.js"></script>
</head>
<script>
	var ctx= "${ctx}";
	if("<s:property value='tip' />"=="success"){
		returnValue="success";
		window.close();
	}
</script>
<body>
	<page:applyDecorator name="popwindow"  title="${titleName}">
	
	<page:param name="width">600px;</page:param>
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
	<div style="height:450px;overflow:auto">
	<form id="formID">
		<div><span class="sub-panel-tips" style="line-height:20px;"></span>新增的资源模型应用于当前版本，不保证适用于所有版本。</div>
		<s:hidden name="resourceCategoryId" value="%resourceCategoryId"/>
		<fieldset class="blue-border-nblock">
		    <legend>基本信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="field-middle" style="width:125px;">组件名称</span><span>：</span>
						<s:textfield name="component.resourceName" value="%{component.resourceName}" cssClass="validate[required],noSpecialStr,length[0,30,组件名称]"></s:textfield><span class="red">*</span>
					</li>
					<li><span class="field-middle" style="width:125px;">备注</span><span>：</span>
						<s:textarea style="width:230px;height:80px;scrolling:auto;" name="component.resourceDescription" value="%{component.resourceDescription}" cssClass="validate[length[0,200,备注]]"></s:textarea>
					</li>
				</ul>
		</fieldset>
		<fieldset class="blue-border-nblock">
		    <legend>取值信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="sub-panel-tips" style="line-height:20px;"></span>定义脚本返回值格式，资源实例的名称必须是返回值的第一列，多个资源实例返回多行。
					</li>
					<li>
						<span class="field-middle" style="width:125px;">对应脚本</span><span>：</span>
						<s:textfield name="scriptTemplateIdForModule" readonly="true" cssClass="validate[required]"></s:textfield><span class="red">*</span><span id="selectScript" style="cursor:hand" class="tree-panel-ico tree-panel-ico-search"></span>
						<s:hidden name="component.scriptTemplateId" value="%{component.scriptTemplateId}"/>
					</li>
					<li>
						<span class="field-middle" style="width:125px;">脚本列分隔符</span><span>：</span>
						<s:if test="component == null || component.dataSeperator == null">
							<s:textfield name="component.dataSeperator"  value=","  size="5" cssClass="validate[required,length[1,5],myNoSpecialStr]"></s:textfield><span class="red">*</span>
						</s:if>
						<s:else>
							<s:textfield name="component.dataSeperator"  value="%{component.dataSeperator}"  size="5" cssClass="validate[required,length[1,5],myNoSpecialStr]"></s:textfield><span class="red">*</span>
						</s:else>
					
					</li>
					<li>
						<span class="field-middle" style="width:125px;">资源实例名称返回值</span><span>：</span>
						<s:textfield name="component.dataColumn" value="1" readOnly="true" size="3" cssClass="validate[required,greaterZeroNumber,length[0,2]]"></s:textfield>列<span class="red">(资源名称必须是返回值的第一列，多个资源返回多行。)</span>
					</li>
				</ul>
		</fieldset>
		<div id="paramValues"></div>
		<s:hidden name="component.parentResourceId" value="%{resourceId}"/>
		<s:hidden name="component.resourceId" value="%{componentId}"/>
		<s:hidden name="isExtension" value="%{resourceModule.extension}"/>
		<s:hidden name="resourceName" value="%{resourceModule.resourceName}"/>
   	</form>
   	</div>
	</page:param>
</page:applyDecorator>
</body>
<script>
	$(document).ready(function(){
		var dataParam = "resourceId="+$("input[name=component.parentResourceId]").val()+"&componentId="+$("input[name=component.resourceId]").val();
		$("#formID").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"blur",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		$.validationEngineLanguage.allRules.greaterZeroNumber={
				"regex":"/^[1-9]+$/",                
				"alertText":"* 请输入大于0的数字."
		}
		$.validationEngineLanguage.allRules.myNoSpecialStr={
				"regex":"/^$|^[^:;'&#<>()%*?！|\"^*]+$/",
				"alertText":"<font color='red'>*</font> ^^^不能输入非法字符 : ; ' & # < > ( ) % * ? ！ | &quot; ^"
		}
		$("#cancel").bind("click",function(){
			window.close();
		});
		$(".win-close").bind("click",function(){
			window.close();
		});
		$("#submit").bind("click",function(){
			$("#formID").attr("action","${ctx}/scriptmonitor/repository/addComponent!saveComponent.action");
			$("#formID").submit();
		});
		var scritpId = $("input[name=component.scriptTemplateId]").val();
		$("#selectScript").click(function (){
			var url;
			if(scritpId){
				url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action?scriptTemplateId="+scritpId;
			}else{
				url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action";
			}
			scritpId = window.showModalDialog(url,"help=no;status=no;scroll=yes;center=yes");
			if(scritpId){
				getScriptTemplateFun(scritpId,dataParam,"component",$("input[name=isExtension]").val(),$("input[name=resourceName]").val(),"${resourceId}","${componentId}");
			}	
		});
		
		var scriptTemplateId = $("input[name=component.scriptTemplateId]").val();
		getScriptTemplateFun(scriptTemplateId,dataParam,"component",$("input[name=isExtension]").val(),$("input[name=resourceName]").val(),"${resourceId}","${componentId}");
	});
</script>
</html>
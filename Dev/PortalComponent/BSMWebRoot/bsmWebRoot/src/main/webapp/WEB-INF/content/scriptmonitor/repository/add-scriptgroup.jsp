<%--  
 *************************************************************************
 * @source  : add-scriptgroup.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.1.12	 huaf     	  添加分类
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<!-- WEB-INF\content\scriptmonitor\repository\add-scriptgroup.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:set name="operate" value="#request.operate"/>
<s:set name="success" value="#request.success"/>
<s:if test="\"edit\".equals(#operate)">
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!updateScriptGroup.action\"" scope="request"/>
	<s:set name="titleName" value="\"编辑分类\"" scope="request"/>
</s:if>
<s:else>
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!addScriptGroup.action\"" scope="request"/>
	<s:set name="titleName" value="\"添加分类\"" scope="request"/>
</s:else>
<title>${titleName}</title>

<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/scriptmonitor/scriptRepositorys.js"></script>
<script type="text/javascript">
	//表单验证
	$(document).ready(function() {
		if("${success}" == "true"){
			//刷新父页面
			window.returnValue="${scriptGroup.id}:${scriptGroup.name}:${scriptGroup.repositoryId}";
			self.close();
			return;
		}
		<s:if test="edit">
		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"blur",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		</s:if>
		$("#closeId").click(function (){
			window.close();
		});
		<s:if test="edit">
		$("#submit").click(function (){
			$("#addForm").attr("action","${ctx}${action}");	
			$("#addForm").submit();
		});
		</s:if>
		$("#cancel").click(function(){
			window.close();
		});
		
		$("#name").keydown(function(event){
			if(event.keyCode == 13){
				return false;
			}
		});
		$.validationEngineLanguage.allRules.<%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_GROUP%>={
      		"file":"${ctx}/scriptmonitor/repository/nameValidate.action?parentId=${scriptGroup.repositoryId}&currentId=${scriptGroup.id}",
         	"alertTextLoad":"<font color='red'>*</font> 正在验证，请等待",
         	"alertText":"<font color='red'>*</font> 分类名称已经存在"
     	}
     	
     	<s:if test="edit == false">
			$.each($(":input"),function(i,n){
				n.disabled=true;
			});
		</s:if>
	});
</script>
</head>

<body >
<page:applyDecorator name="popwindow"  title="脚本库${titleName}">
	
	<page:param name="width">500px</page:param>
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
			<s:hidden name="scriptGroup.id" value="%{scriptGroup.id}"></s:hidden>
			<s:hidden name="scriptGroup.repositoryId" value="%{scriptGroup.repositoryId}"></s:hidden>
			<ul class="fieldlist-n">
				<li>
					<span class="field-middle">脚本库名称</span><span>：</span>
					<span class="field"><s:property value="scriptRepository.name"/></span>
				</li>
				<li>
					<span class="field-middle">分类名称</span><span>：</span>
					<s:textfield id="name" name="scriptGroup.name" cssClass="validate[required,noSpecialStr,length[1,30],ajax[duplicateGroupName]]" value="%{scriptGroup.name}"></s:textfield><span class="red">*</span>
				</li>	
			</ul>
		</s:form>
	</page:param>
</page:applyDecorator>
</body>
</html>
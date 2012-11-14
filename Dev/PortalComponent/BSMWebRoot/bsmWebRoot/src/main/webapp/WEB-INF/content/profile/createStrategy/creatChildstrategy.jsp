<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<%@ page import="com.mocha.bsm.profile.vo.CreateStrategyVoForAction"%>
	<%@ page import="com.mocha.bsm.profile.vo.CreateStrategyVo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>添加子策略</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />

<script type="text/javascript">
    
var path = "${ctx}";
</script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
</style>
</head>
<body>

<%@ include file="/WEB-INF/common/loading.jsp" %>
<page:applyDecorator name="popwindow"  title="添加子策略">

    <page:param name="width">502px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeWindow</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">logout</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitForm</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	
	
<page:param name="content">
<form id="form1" method="post">
	<ul class="fieldlist">
		<li>
			<span class="field">子策略名称</span>
			<span><s:text name="i18n.profile.colon"/></span>
		    <input type="text" id="childStrategyName" name="childStrategyName" class="validate[required[子策略名称],length[0,50,子策略名称],noSpecialStr[子策略名称],ajax[duplicateChildProfileName]]"/> 
			<span class="red">*</span>
			<s:textfield name="parentProfileUserDomain" value="%{parentProfileUserDomain}" style="display:none"/>
		</li>
		<li><span class="field">子策略类型</span>
			<span><s:text name="i18n.profile.colon"/></span>
		    <s:select name="childstrategyType" lable="子策略类型" labelposition="top" list="childstrategyList" listKey="key"  listValue="value" headerValue="--请选择子类型--" cssClass="validate[required[子策略类型]]"/>     
		    <s:textfield name="parentProfileResourceId" value="%{parentProfileResourceId}" style="display:none"/>
		</li>
		<li>
			<span class="field">备注</span>
			<span><s:text name="i18n.profile.colon"/></span>
			<textarea id="childRemark" name="remark" rows="5" cols="40" class="validate[length[0,200,备注]]"/> </textarea>
			<s:textfield name="parentProfileId" value="%{parentProfileId}" style="display:none"/>
		</li>
   </ul>
</form>
</page:param>
</page:applyDecorator>
</body>
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/profile/createStrategy/createChildStrategy.js" type="text/javascript"></script>
</html>

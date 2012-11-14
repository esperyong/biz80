<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>复制监控策略</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />

<script type="text/javascript">
var path = "${ctx}";
var childProfileIdStr = "${childProfileIdStr}";
var childResource = "${copyProfileVO.resourceId}";
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
<page:applyDecorator name="popwindow"  title="复制监控策略">

    <page:param name="width">530px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeWindow</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitForm</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">logout</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	
<page:param name="content">
<form id="form1" onsubmit="return false;">
<input type="hidden" name="copyProfileVO.profileId" value="${copyProfileVO.profileId}"/>
<input type="hidden" name="resourceModleId" value="${resourceModleId}" id="resourceModleId"/>


	<ul class="fieldlist">
					<li><span class="ico ico-tips"></span>将当前策略及子策略复制为新的自定义策略，可以重新命名。</li>
					<li><span class="field" style="float:left;"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/></span>
						 <span style="float:left;"><s:text name="i18n.profile.colon"/></span>
                         <span style="float:left;"><s:select name="copyProfileVO.userDomainId"  list="doMainList" listKey="key"  listValue="value" value="copyProfileVO.userDomainId" style="width:130px;"/></span>    
					</li>
					<li>
						<span class="field" style="float:left;">策略名称</span>
						<span style="float:left;"><s:text name="i18n.profile.colon"/></span>
						<!--<s:textfield name="addstrategy.strategyName" value="%{addstrategy.strategyName}"/> -->
						 <span><input type="text" id="strategyName" name="copyProfileVO.name" class="validate[required[策略名称],length[0,50,策略名称],noSpecialStr[策略名称],ajax[duplicateProfileName]]" value="复件 ${copyProfileVO.name}"/></span> 
						
						<span class="red">*</span>
						
					</li>
					<li><span class="field" style="float:left;">策略类型</span>
						<span style="float:left;"><s:text name="i18n.profile.colon"/></span>
						<!--<s:select list="{'aa','bb','cc'}" theme="simple" headerKey="00" headerValue="00"></s:select>-->
					    <span style="float:left;"><s:select name="strategyType" lable="策略类型" labelposition="top" list="profileTypeList" listKey="key"  listValue="value" value="categoryId" disabled="true" />
					    <select name="level2strategyType" id="level2strategyType"  disabled></select></span>     
					</li>
					<li>
						<span class="field" style="float:left;">监控模型</span>
						<span style="float:left;"><s:text name="i18n.profile.colon"/></span>
						<span style="float:left;"><select name="strategyTypeChild" id="strategyTypeChild" disabled="disabled"></select></span>
					</li>
					<li>
					    <span class="field" style="float:left;">子策略</span>
					    <span style="float:left;"><s:text name="i18n.profile.colon"/></span>
					    <span id="ChildStrategyArea" style="float:left;width: 390px;" class="for-inline"></span>
					</li>
				
					<li>
						<span class="field" style="float:left;">备注</span>
						<span style="float:left;"><s:text name="i18n.profile.colon"/></span>
						<span style="float:left;"><s:textarea id="remark" name="copyProfileVO.description" rows="5" cols="60" cssClass="validate[length[0,200,备注]]"/> </textarea></span>
					</li>
				</ul>
				
				</form>
		</page:param>
			</page:applyDecorator>
</body>
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<script src="${ctx}/js/profile/profilelist/copyProfile.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
</html>
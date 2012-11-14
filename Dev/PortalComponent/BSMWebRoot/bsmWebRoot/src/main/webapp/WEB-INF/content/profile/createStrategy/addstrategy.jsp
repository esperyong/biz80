<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>新建监控策略</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<script type="text/javascript">
var path = "${ctx}";
</script>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<page:applyDecorator name="popwindow"  title="新建监控策略">

    <page:param name="width">530px;</page:param>
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
<form id="form1" onsubmit="return false;"><ul class="fieldlist"><li
		><span class="field" style="float:left;"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/></span
		><span style="float:left;"><s:text name="i18n.profile.colon"/></span
		><span style="float:left;"><s:select name="domain"  list="userDomainList" listKey="key"  listValue="value" style="width:130px;"/></span
		></li><li
		><span class="field" style="float:left;">策略名称</span
		><span style="float:left;"><s:text name="i18n.profile.colon"/></span
		><span style="float:left;"><input type="text" id="strategyName" name="strategyName" class="validate[required[策略名称],length[0,50,策略名称],noSpecialStr[策略名称],ajax[duplicateProfileName]]"/
		><span class="red">*</span></span
		></li><li
		><span class="field" style="float:left;">策略类型</span
		><span style="float:left;"><s:text name="i18n.profile.colon"/></span
		><span style="float:left;"><s:select name="strategyType" lable="策略类型" labelposition="top" list="categoryGroupList" listKey="key"  listValue="value" headerValue="--请选择子类型--"/>
		<select name="level2strategyType" id="level2strategyType"></select></span
		></li><li
		><span class="field" style="float:left;">监控模型</span
		><span style="float:left;"><s:text name="i18n.profile.colon"/></span
		><span style="float:left;"><select name="strategyTypeChild" id="strategyTypeChild" class="validate[required]"></select></span
		></li><li
		><span class="field left">子策略</span><span class="left">：</span><span id="ChildStrategyArea" class="for-inline" style="width: 390px;"></span></li><li
		><span class="field" style="float:left;">备注</span
		><span style="float:left;"><s:text name="i18n.profile.colon"/></span
		><span style="float:left;"><textarea id="remark" name="remark" rows="5" cols="60" class="validate[length[0,200,备注]]"></textarea></span
		></li></ul></form>
		</page:param>
			</page:applyDecorator>
</body>
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<script src="${ctx}/js/profile/createStrategy/createStrategy.js" type="text/javascript"></script>
</html>
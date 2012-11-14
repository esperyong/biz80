<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<s:if test="hashId == null">
<s:set name="module" value="'新建'" scope="request"/>
</s:if>
<s:else>
<s:set name="module" value="'修改'" scope="request"/>
</s:else>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<title>预置账户-${module}预置账户</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js" ></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/preuser-add.js" ></script>
<script>
var hashId = "${hashId}";
<s:if test="success == true">
	var account_page_mark = opener.document.getElementById("account_page_mark");
	if (account_page_mark == null || account_page_mark.value != "discovery-account") {
		opener.document.location.href = "preuser-list.action";
	} else {
		var domainId = opener.$("#domainId").val();
		var url = "${ctx}/discovery/preuser-add-discoveryaccount.action?domainId=" + domainId;
		opener.openViewPage(url, "预置账户");
	}
	window.close();
</s:if>
$(function(){
	$("#loading_text").html("提交中，请稍候...");
});
</script>
</head>
<body class="pop-window">
<form id="form1" name="form1" method="post">
<page:applyDecorator name="popwindow" title="${module}预置账户">
  
  <page:param name="width">450px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">sp_ok</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">sp_cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
  <page:param name="content">

	  <div class="pop-content ">
			<div class="content-padding">
				<ul class="fieldlist-n">
				     <li><span class="field-max">用户名</span><span>：</span>
					     <input id="accountId" name="accountId" type="text" class="validate[required[用户名]]" value="<s:property value="account.accountId"/>">
					     <span class="red">*</span>
				     </li>
				</ul>
				<ul class="fieldlist-n">
				     <li><span class="field-max">密码</span><span>：</span>
					     <input id="accountPassword" name="accountPassword" class="validate[required[密码]]" type="password" value="<s:property value="account.accountPassword"/>">
					     <span class="red">*</span>
				     </li>
				</ul>
				<ul class="fieldlist-n">
				     <li><span class="field-max">确认密码</span><span>：</span>
					     <input id="confirmPassword" name="confirmPassword" class="validate[required[确认密码],confirm[accountPassword]]" type="password" value="<s:property value="account.accountPassword"/>">
					     <span class="red">*</span>
				     </li>
				</ul>
				<ul class="fieldlist-n">
				     <li><span class="field-max">所属<%=domainPageName%></span><span>：</span>
				     	<s:if test="allDomainList.size == 1">
					     <span style="margin-left:2px"><s:property value="allDomainList[0].name" /><input type="hidden" id="domainId" name="domainId" value="${allDomainList[0].ID }"></span>
				     	</s:if>
				     	<s:else>
					     <span style="margin-left:2px"><s:select id="domainId" name="domainId" validate="funcCall[domainEmpty]" list="allDomainList" listKey="ID" listValue="name" value="domainId"></s:select></span>
				     	</s:else>
					     <span class="red">*</span>
				     </li>
				</ul>
				<ul class="fieldlist-n">
				     <li><span class="field-max">备注</span><span>：</span>
					 <textarea id="remarks" name="remarks" rows="3" class="validate[length[0,200,备注]]" cols="40"><s:property value="account.remarks"/></textarea>
				     </li>
				</ul>
			</div>
	  </div>  
	
	<!-- 
	<div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">
			   <span class="win-button" id="sp_cancel"><span class="win-button-border"><a>取消</a></span></span>
			   <span class="win-button" id="sp_ok"><span class="win-button-border"><a>确定 </a></span></span>
			</div>
		</div>
	</div>
	 -->
	 
  </page:param>
</page:applyDecorator>
</form>
</body>
</html>

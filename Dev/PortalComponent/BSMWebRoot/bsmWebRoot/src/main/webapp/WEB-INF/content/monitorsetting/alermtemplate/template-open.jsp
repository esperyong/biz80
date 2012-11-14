<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.bsm.action.monitorsetting.alermtemplate.TemplateConstant"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/manage.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/jquery-ui/jquery.ui.treeview.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctxJs}/monitorsetting/template/templateopen.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow" title="模板">
	<page:param name="width">550px;</page:param>
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
		<form name="templateformname" id="templateformname" method="post">
		<input type="hidden" id="alermMethod" name="alermMethod" value="${templateVO.alermMethod }">
		<input type="hidden" id="moduleId" name="moduleId" value="${templateVO.moduleId }">
		<input type="hidden" id="eventClass" name="eventClass" value="${templateVO.eventClass }">
		<input type="hidden" id="domainId" name="domainId" value="${domainId }">
		<input type="hidden" id="id" name="id" value="${templateVO.id }">
<div><fieldset class="blue-border02" style="width:500px;">
  <legend>模板</legend>
  <ul class="fieldlist-n">
    <li> <span class="field-middle left">模板名称&nbsp;&nbsp;：</span><span class="left">
      <input type="text" size="60" class="validate[required,noSpecialStr,length[0,60],ajax[ajaxTemplateName,模板名称]]" id="templateName" name="templateName" value="${templateVO.templateName }" />
    </span><span class="txt-red padding5 left">*</span></li>
  </ul>
  </ul>
</fieldset></div>
<div>
  <fieldset class="blue-border02" style="width:500px;">
    <legend>模板内容</legend>
    <ul class="fieldlist-n">
    <s:if test=" 'EMAIL' == templateVO.alermMethod ">
      <li> <span class="field-middle left">标题&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span><span class="left">
        <input type="text"  size="60" id="templateZhTitle" name="templateZhTitle" class="validate[required,length[0,100]]" value="${templateVO.templateZhTitle }" /> 
      </span><span class="txt-red padding5 left">*</span></li>
      </s:if>
      <li> <span class="field-middle left" style="margin-top: 20px;">内容&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span><span class="left">
        <textarea cols="62" rows="5" class="inputcheckbox,validate[required]" id="templateZhText" name="templateZhText">${templateVO.templateZhText }</textarea>
      </span><span class="txt-red padding5 left" style="margin-top: 20px;">*</span><span title="帮助" class="r-big-ico r-big-ico-help" id="templatehelp" name="templatehelp" style="margin-top: 20px;margin-right: 30px;"></span></li>
    </ul>

  </fieldset>
  </div>
  </form>
	</page:param>
</page:applyDecorator>
</body>
</html>
<script type="text/javascript">

var ctx = "${ctx}";
$(function(){
	BSM.Monitorsetting.TemplateOpen.init();
})
</script>
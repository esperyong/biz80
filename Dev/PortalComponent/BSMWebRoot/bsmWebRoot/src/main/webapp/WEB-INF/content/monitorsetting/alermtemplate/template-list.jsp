<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.bsm.action.monitorsetting.alermtemplate.TemplateConstant"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctxCss}/portal.css" rel="stylesheet" type="text/css"/>
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
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/monitorsetting/template/templatelist.js"></script>
</head>
<body  class="pop-window">
<page:applyDecorator name="popwindow" title="告警模板设置">
	<page:param name="width">640px;</page:param>
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
		<input type="hidden" id="templateName" name="templateName" value="${templateVO.templateName }">
		<input type="hidden" id="domainId" name="domainId" value="${domainId }">
			<ul class="fieldlist-n">
				<li><span class="field">告警类型</span>：${templateVO.eventName }</li>
				<li><span class="field">当前使用模板</span>：${templateVO.templateName }</li>
				<li><span class="field" style="vertical-align:middle">可用模板</span>：
					<div class="for-textarea" style="height:100px;width:200px;overflow:hidden">
					
		<tbody>

		<select id="template" name="template" size="6" style="width: 200px;height:100px;">
			<s:iterator id="list" value="tabList">
				<option value=<s:property value="#list.id" />>
				<s:if test="#list.default==1"><s:property value="#list.templateName" />(已默认)</s:if>
				<s:else><s:property value="#list.templateName" /></s:else>
				</option>
			</s:iterator>
		</select>
		</tbody>
					
					</div>
					<div class="for-inline" style="width: 200px;">
						<span class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><div name="defaulttemplate" title="设为默认">设为默认</div></span>
							</span>
						</span>
						<span class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><div name="edit" title="编辑">编辑</div></span>
							</span>
						</span>
						<span class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><div name="create" title="添加">添加</div></span>
							</span>
						</span>
						<span class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><div name="deletetemplate" title="删除">删除</div></span>
							</span>
						</span>
					</div>
				</li>
			</ul> 
	</form>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">

var ctx = "${ctx}";
$(function(){
	BSM.Monitorsetting.TemplateList.init();
})

</script>

</body>

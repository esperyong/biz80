<%--  
 *************************************************************************
 * @source  : main-page.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.18	 huaf     	 模型配置页面
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<base target="_self">
<title>模型扩展</title>
<link rel="stylesheet" href="${ctxCss}/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctxCss}/public.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctxCss}/master.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/jquery-ui/treeview.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/UIComponent.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/device-ico.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/custommodel.css?<%=System.currentTimeMillis()%>" type="text/css" />
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script> 
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js" ></script>
<script type="text/javascript">
var tp;
	$(document).ready(function(){
		tp = new TabPanel({id:"modelmytab",
			listeners:{
		        change:function(tab){
		        	$.blockUI({message:$('#loading')});
					var url;
					if(tab.id=="config"){
						url = "sysoidSetting!findSysOidsByConfidtion.action?pageNum=0&pageSize=20&sortColId=resource&sortColType=up";
					}else if(tab.id=="deploy"){
						url = "modelDeploy!showAllDeploy.action";
					}
					tp.loadContent(1,{url:"${ctx}/monitorsetting/model/"+url,callback:function(){$.unblockUI();}});
		        }
	    	}}
		);
	});
</script>
</head>
<body>
<div class="manage-content">
	<div class="top-l">
      <div class="top-r">
        <div class="top-m"> </div>
      </div>
    </div>
    <div class="mid">
		<div class="h1">
			<span class="bold">当前位置：</span>
			<span>监控管理 / 工具 / 模型配置</span>
		</div>
		<page:applyDecorator name="tabPanel">  
			<page:param name="id">modelmytab</page:param>
		   	<page:param name="cls">tab-grounp</page:param>
		   	<page:param name="background">#FFFFFF;</page:param>
		   	<page:param name="current">1</page:param> // 默认显示第几个
		   	<page:param name="tabHander">[{text:"型号配置",id:"config"},{text:"模型部署",id:"deploy"}]</page:param>
		   	<page:param name="content">
				<s:action name="sysoidSetting!findSysOidsByConfidtion" executeResult="true" namespace="/monitorsetting/model" flush="false">
					<!-- 默认显示第1页 -->
					<s:param name="pageNum">0</s:param>
					<!-- 默认显示20行数据 -->
					<s:param name="pageSize">20</s:param>
					<!-- 默认按资源升序 -->
					<s:param name="sortColId">resource</s:param>
					<s:param name="sortColType">up</s:param>
				</s:action>
		   	</page:param>
		</page:applyDecorator>
	</div>
    <div class="bottom-l">
      <div class="bottom-r">
        <div class="bottom-m"> </div>
      </div>
    </div>
</div>
</body></html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <%@ include file="/WEB-INF/common/meta.jsp" %>
	<title><s:text name="detail.page.wintitle" /></title>
	<link rel="stylesheet" type="text/css" href="${ctxCss}/validationEngine.jquery.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/master.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/jquery-ui/white_treeview.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/business-grid.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/datepicker.css"></link>
	<script type="text/javascript">
	  var ctxpath = "${ctx}";
	</script>
	<script type="text/javascript" src="${ctxJs}/<s:text name="js.i18n.file" />"></script>
	<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionPanel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
	<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
	<script type="text/javascript" src="${ctxJs}//component/comm/winopen.js"></script>
  <script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
	<script type="text/javascript" src="${ctxJs}/resourcedetail/childinstancedetail.js"></script>
</head>
<body>

<div class="loading" id="loading" style="display:none;">
  <div class="loading-l">
    <div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.loading.msg" /></span></div>
   </div>
  </div>
</div> 

<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.page.wintitle" /></page:param>
  <page:param name="width">100%</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">close_button</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
  <page:param name="content">
  <!-- content start -->
  <div>
	<page:applyDecorator name="tabPanel">  
		<page:param name="id">instancedetailTab</page:param>
		<page:param name="width">100%</page:param>
		<page:param name="height">100%</page:param>
		<page:param name="cls">tab-grounp</page:param>
		<page:param name="background">#000</page:param>
		<page:param name="current"><s:property value="currentTab" default="1" /></page:param> 
		<page:param name="tabHander">[{text:"<s:text name="detail.commoninfo" />",id:"tab1"},{text:"<s:text name="detail.problemmetric" />",id:"tab2"},{text:"<s:text name="ChangeManage" />",id:"tab3",display:"<s:if test="!isDisplayCMTab()">none</s:if>"},{text:"<s:text name="detail.availmetric" />",id:"tab4",display:"<s:if test="!isDisplayAvailTab()">none</s:if>"},{text:"<s:text name="detail.performmetric" />",id:"tab5",display:"<s:if test="!isDisplayPerformTab()">none</s:if>"},{text:"<s:text name="detail.configmetric" />",id:"tab6",display:"<s:if test="!isDisplayConfigTab()">none</s:if>"}]</page:param>
		
		<page:param name="content_1">
			<s:action name="childinstancedetail!commoninfo"  namespace="/detail"  executeResult="true" ignoreContextParams="true" flush="false">
			  <s:param name="childInstanceId">${childInstanceId}</s:param>
			</s:action> 
		</page:param>
    <page:param name="content_2">
    </page:param>
    <page:param name="content_3">
    </page:param>
    <page:param name="content_4">
    </page:param>
    <page:param name="content_5">
    </page:param>
    <page:param name="content_6">
    </page:param>

	</page:applyDecorator>
	</div>
	<input type="hidden" id="childInstanceId" value="${childInstanceId}" />
  <!-- content end -->
  </page:param>
</page:applyDecorator>

</body>
</html>
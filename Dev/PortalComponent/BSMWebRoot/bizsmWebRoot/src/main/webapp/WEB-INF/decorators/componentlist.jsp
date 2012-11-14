<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<script type="text/javascript">
	  var items={};//存放每种组件相应的gridpanel，page，accordionpanel对象,key为组件资源组ID
	</script>
	<script type="text/javascript" src="${ctxJs}/monitor/componentlist.js"></script>
</head>
<body>
<div style="height:350px;overflow-x:hidden;overflow-y:auto;">
<s:iterator value="list" var="compMap" status="status">
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">panelid_<s:property value="#status.index" /></page:param>
		<page:param name="title"><s:property value="#compMap.childResourceName" />(<s:property value="#compMap.totalCount" />)</page:param>
		<page:param name="width">580px</page:param>
		<page:param name="display"><s:if test="#status.first"></s:if><s:else>collect</s:else></page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
		<!-- content start -->
		  <div style="color:black;">
		    <page:applyDecorator name="indexcirgrid">
		       <page:param name="id">gridid_<s:property value="#status.index" /></page:param>
		       <page:param name="width">580</page:param>
		       <page:param name="linenum">0</page:param>
		       <page:param name="tableCls">roundedform</page:param>
		       <page:param name="gridhead"><s:property value="#compMap.gridhead" escape="false" /></page:param>
		       <page:param name="gridcontent"><s:property value="#compMap.gridcontent" escape="false" /></page:param>
		     </page:applyDecorator>
		     <div id="pageid_<s:property value="#status.index" />"></div>
		  </div>
		<!-- content end -->
		</page:param>
	</page:applyDecorator>
    <script type="text/javascript">
      var gp_<s:property value="#status.index" /> = createGridPanel("gridid_<s:property value="#status.index" />",config);
      var page_<s:property value="#status.index" /> = createPagination("pageid_<s:property value="#status.index" />",url,"<s:property value="#compMap.pageCount" />",gp_<s:property value="#status.index" />);
      var panel_<s:property value="#status.index" /> = createAccordionPanel("panelid_<s:property value="#status.index" />");
      items["<s:property value="#compMap.childResourceId" />"] = {
    	    gridPanel : gp_<s:property value="#status.index" />,
          pagination : page_<s:property value="#status.index" />,
          accordionPanel : panel_<s:property value="#status.index" />
      };
    </script>
</s:iterator>
</div>
</body>
</html>
<!-- 监控列表-搜索-gridSearch.jsp-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >刷新页面</a></span></span></span>
<span id="monitorOperate" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >批量操作</a></span></span></span>
<page:applyDecorator name="indexcirgrid">  
      <page:param name="id">tableMonitor</page:param>
      <page:param name="width">100%</page:param>
      <page:param name="height">100%</page:param>
      <page:param name="tableCls">grid-black</page:param>
      <page:param name="gridhead"><s:property value="titleJson" escape="false" /></page:param>
      <page:param name="gridcontent"><s:property value="gridSearchMonitorJson" escape="false" /></page:param>
</page:applyDecorator>	  
<div id="page"></div>
<script type="text/javascript">
Monitor.Resource.pointId = '<s:property value="pointId"/>';
Monitor.Resource.pointLevel = '<s:property value="pointLevel"/>';
Monitor.Resource.monitor = '<s:property value="monitor"/>';
Monitor.Resource.whichTree = '<s:property value="whichTree"/>';
Monitor.Resource.whichGrid = '<s:property value="whichGrid"/>';
Monitor.Resource.currentTree = '<s:property value="currentTree"/>';
Monitor.Resource.currentResourceTree = '<s:property value="currentResourceTree"/>';
Monitor.Resource.widthJson = <s:property value="widthJson" escape="false" />;
Monitor.Resource.currentPage = '<s:property value="currentPage"/>';
Monitor.Resource.pageSize = '<s:property value="pageSize"/>';
Monitor.Resource.currentUserId = '<s:property value="currentUserId"/>';
Monitor.Resource.currentDomainId = '<s:property value="currentDomainId"/>';
Monitor.Resource.pageName = '<s:property value="pageName"/>';
Monitor.Resource.right.searchMonitorList.paramMap = new Map();
</script>

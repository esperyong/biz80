<!-- 监控列表  gridPc.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
     <div class="tab-content-searchlist">
         <div>
             <div class="left f-relative">
		         <span class="ico ico-note-blue"></span><span class="txt-white">PC不能被监控，只能变更为其他类型设备进行监控。</span>
             </div>
         </div>
     </div>
	 <div class="tab-content-searchlist clear"> 
	      <span id="pcOperate" class="black-btn-l f-right f-relative"><span class="btn-r"><span class="btn-m"><a >批量操作</a><a  class="down"></a></span></span></span>
	      <div class="for-inline">
		      <span class="txt-white" style="float:left;height:21px;line-height:21px;"><%=domainPageName%></span>
		            <select id="domain" name="domain" class="" style="float:left;height:21px;line-height:21px;">
		                   <s:if test="domainMap != null && domainMap.size() > 1">
		                         <option value="">全部</option>
		                   </s:if>
                           <s:iterator value="domainMap" var="map" status="stat">
                                 <option value="<s:property value=" #map.key " />">
                                         <s:property value="#map.value" />
                                 </option>
                           </s:iterator>
                   </select
		           ><select id="searchWhat" name="searchWhat">
		                        <option value="searchIP">IP地址</option>
		                        <option value="searchName">资源名称</option>
		           </select
		           ><input type="text" id="searchPc" style="width:120px;height:20px;line-height:20px;" value="请输入条件搜索" class="inputoff"/><span title="点击进行搜索" id="searchPcBut" class="ico"></span>
          </div>
     </div>
       <div class="clear"></div>
                            <page:applyDecorator name="indexcirgrid">  
                                  <page:param name="id">tablePc</page:param>
                                  <page:param name="width">100%</page:param>
                                  <page:param name="height">530px</page:param>
                                  <page:param name="lineHeight">25px</page:param>
                                  <page:param name="tableCls">grid-black</page:param>
                                  <page:param name="gridhead"><s:property value="titleJson" escape="false" /></page:param>
                                                              <page:param name="gridcontent"><s:property value="gridJson" escape="false" /></page:param>
                            </page:applyDecorator>	  
      <div id="pagePc"></div>
 <script type="text/javascript">
 Monitor.Resource.right.pcList.pointId = '<s:property value="pointId"/>';
 Monitor.Resource.right.pcList.pointLevel = '<s:property value="pointLevel"/>';
 Monitor.Resource.right.pcList.monitor = '<s:property value="monitor"/>';
 Monitor.Resource.right.pcList.whichTree = '<s:property value="whichTree"/>';
 Monitor.Resource.right.pcList.whichGrid = '<s:property value="whichGrid"/>';
 Monitor.Resource.right.pcList.grid = '<s:property value="grid"/>';
 Monitor.Resource.right.pcList.currentTree = '<s:property value="currentTree"/>';
 Monitor.Resource.right.pcList.currentResourceTree = '<s:property value="currentResourceTree"/>';
 Monitor.Resource.right.pcList.widthJson = <s:property value="widthJson" escape="false" />;
 Monitor.Resource.right.pcList.sortJson = <s:property value="sortJson" escape="false" />;
 Monitor.Resource.right.pcList.currentPage = '<s:property value="currentPage"/>';
 Monitor.Resource.right.pcList.pageCount = '<s:property value="pageCount"/>';
 Monitor.Resource.right.pcList.monitorTitile = '<s:property value="monitorTitle"/>';
 Monitor.Resource.right.pcList.monitorCount = '<s:property value="monitorCount"/>';
 Monitor.Resource.right.pcList.noMonitorCount = '<s:property value="noMonitorCount"/>';
 Monitor.Resource.right.pcList.noMonitorTiitle = '<s:property value="noMonitorTitle"/>';
 Monitor.Resource.right.pcList.currentUserId = '<s:property value="currentUserId"/>';
 Monitor.Resource.right.pcList.currentDomainId = '<s:property value="currentDomainId"/>';
 Monitor.Resource.right.pcList.pageName = '<s:property value="pageName"/>';
 Monitor.Resource.right.pcList.paramMap = new Map();
</script>
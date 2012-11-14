<!-- 监控列表  gridNoMonitor.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
    <div class="tab-content-searchlist"             
        ><span id="noMonitorOperate" class="black-btn-l f-right f-relative"><span class="btn-r"><span class="btn-m"><a >批量操作</a><a  class="down"></a></span></span></span
		><span id="startMonitor" class="black-btn-l f-right f-relative"><span class="btn-r"><span class="btn-m"><a>开启监控</a></span></span></span>
		<div class="groupOperate"
	         ><span id="shiftOutGroup" class="black-btn-l f-right f-relative"><span class="btn-r"><span class="btn-m"><a href="javascript:void(0)">移出资源</a></span></span></span
	         ><span id="shiftinGroup" class="black-btn-l f-right f-relative"><span class="btn-r"><span class="btn-m"><a href="javascript:void(0)">移入资源</a></span></span></span
	    ></div
		><div name="isSearch"
		     ><div class="for-inline"><span class="txt-white" style="float:left;height:21px;line-height:21px;"><%=domainPageName%></span
		     ><select id="domain" name="domain" class="" style="float:left;height:21px;line-height:21px;">
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
		               <option value="searchName">显示名称</option>
		      </select
		      ><input type="text" id="searchNoMonitor" style="width:120px;height:20px;line-height:20px;" value="请输入条件搜索" class="inputoff"/><span title="点击进行搜索" id="searchNoMonitorBut" class="ico"></span>
		   </div
    ></div
    ><div class="clear"></div>
    <page:applyDecorator name="indexcirgrid">  
          <page:param name="id">tableNoMonitor</page:param>
          <page:param name="width">100%</page:param>
          <page:param name="height">530px</page:param>
          <page:param name="lineHeight">25px</page:param>
          <page:param name="tableCls">grid-black</page:param>
          <page:param name="gridhead"><s:property value="titleJson" escape="false" /></page:param>
          <page:param name="gridcontent"><s:property value="gridJson" escape="false" /></page:param>
   </page:applyDecorator>	  
   <div id="pageNoMonitor"></div>
 <script type="text/javascript">
 Monitor.Resource.right.noMonitorList.pointId = '<s:property value="pointId"/>';
 Monitor.Resource.right.noMonitorList.pointLevel = '<s:property value="pointLevel"/>';
 Monitor.Resource.right.noMonitorList.monitor = '<s:property value="monitor"/>';
 Monitor.Resource.right.noMonitorList.whichTree = '<s:property value="whichTree"/>';
 Monitor.Resource.right.noMonitorList.whichGrid = '<s:property value="whichGrid"/>';
 Monitor.Resource.right.noMonitorList.grid = '<s:property value="grid"/>';
 Monitor.Resource.right.noMonitorList.currentTree = '<s:property value="currentTree"/>';
 Monitor.Resource.right.noMonitorList.currentResourceTree = '<s:property value="currentResourceTree"/>';
 Monitor.Resource.right.noMonitorList.widthJson = <s:property value="widthJson" escape="false" />;
 Monitor.Resource.right.noMonitorList.sortJson = <s:property value="sortJson" escape="false" />;
 Monitor.Resource.right.noMonitorList.currentPage = '<s:property value="currentPage"/>';
 Monitor.Resource.right.noMonitorList.pageCount = '<s:property value="pageCount"/>';
 Monitor.Resource.right.noMonitorList.monitorTitile = '<s:property value="monitorTitle"/>';
 Monitor.Resource.right.noMonitorList.monitorCount = '<s:property value="monitorCount"/>';
 Monitor.Resource.right.noMonitorList.noMonitorCount = '<s:property value="noMonitorCount"/>';
 Monitor.Resource.right.noMonitorList.noMonitorTiitle = '<s:property value="noMonitorTitle"/>';
 Monitor.Resource.right.noMonitorList.currentUserId = '<s:property value="currentUserId"/>';
 Monitor.Resource.right.noMonitorList.currentDomainId = '<s:property value="currentDomainId"/>';
 Monitor.Resource.right.noMonitorList.pageName = '<s:property value="pageName"/>';
 Monitor.Resource.right.noMonitorList.withoutSearch = '<s:property value="withoutSearch"/>';
 Monitor.Resource.right.noMonitorList.paramMap = new Map();
</script>
<!-- 链路未监控列表 linkGridNoMonitor.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
          <div class="tab-content-searchlist">  
                  <span id="noMonitorOperate" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >批量操作</a><a class="down"></a></span></span></span>
		          <span  id="startMonitor" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a>开启监控</a></span></span></span>
		          <div name="isSearch">
		               <span class="txt-white">域：</span>
		               <select id="domain" name="domain" class="">
                                 <s:iterator value="domainMap" var="map" status="stat">
                                     <option value="<s:property value=" #map.key " />">
                                         <s:property value="#map.value" />
                                     </option>
                                </s:iterator>
                       </select>
		               <select id="searchWhat" name="searchWhat">
		                    <option value="searchSourceIP">源IP地址</option>
		                    <option value="searchDestinationIP">目的IP地址</option>
		               </select>
		               <input type="text" id="searchNoMonitorLink" value="" /><span id="searchNoMonitorBut" class="ico"></span>
		               <input id="showHostLink" type="checkbox" value="showHostLink"/><span class="txt-white">显示连接主机的链路</span>>
                 </div>  
              </div> 
                            <page:applyDecorator name="indexcirgrid">  
                                  <page:param name="id">linkNoMonitorTable</page:param>
                                  <page:param name="width">100%</page:param>
                                  <page:param name="height">100%</page:param>
                                  <page:param name="tableCls">grid-gray</page:param>
                                  <page:param name="gridhead"><s:property value="titleJson" escape="false" /></page:param>
                                                              <page:param name="gridcontent"><s:property value="gridJson" escape="false" /></page:param>
                            </page:applyDecorator>	  
          <div id="pageLinkNoMonitor">
          </div>
 <script type="text/javascript">
 Monitor.Resource.right.linkNoMonitorList.pointId = '<s:property value="pointId"/>';
 Monitor.Resource.right.linkNoMonitorList.pointLevel = '<s:property value="pointLevel"/>';
 Monitor.Resource.right.linkNoMonitorList.monitor = '<s:property value="monitor"/>';
 Monitor.Resource.right.linkNoMonitorList.whichTree = '<s:property value="whichTree"/>';
 Monitor.Resource.right.linkNoMonitorList.whichGrid = '<s:property value="whichGrid"/>';
 Monitor.Resource.right.linkNoMonitorList.currentTree = '<s:property value="currentTree"/>';
 Monitor.Resource.right.linkNoMonitorList.currentResourceTree = '<s:property value="currentResourceTree"/>';
 Monitor.Resource.right.linkNoMonitorList.widthJson = <s:property value="widthJson" escape="false" />;
 Monitor.Resource.right.linkNoMonitorList.currentPage = '<s:property value="currentPage"/>';
 Monitor.Resource.right.linkNoMonitorList.pageSize = '<s:property value="pageSize"/>';
 Monitor.Resource.right.linkNoMonitorList.monitorTitile = '<s:property value="monitorTitle"/>';
 Monitor.Resource.right.linkNoMonitorList.monitorCount = '<s:property value="monitorCount"/>';
 Monitor.Resource.right.linkNoMonitorList.noMonitorCount = '<s:property value="noMonitorCount"/>';
 Monitor.Resource.right.linkNoMonitorList.noMonitorTiitle = '<s:property value="noMonitorTitle"/>';
 Monitor.Resource.right.linkNoMonitorList.paramMap = new Map();
</script>
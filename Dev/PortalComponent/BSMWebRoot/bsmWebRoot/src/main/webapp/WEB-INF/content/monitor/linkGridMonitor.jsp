<!-- 链路监控列表 linkGridMonitor.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
                <div  class="tab-content-searchlist">
                    <div>
                          <span style="cursor:pointer"><span class="linkstate"></span><span class="txt-white">超荷负载</span></span>
	                      <span style="cursor:pointer"><span class="linkstate linkstate-yellow"></span><span class="txt-white">警戒负载</span></span>
	                      <span style="cursor:pointer"><span class="linkstate linkstate-green"></span><span class="txt-white">正常负载</span></span>
	                      <span style="cursor:pointer"><span class="linkstate linkstate-gray"></span><span class="txt-white">无数据</span></span>
	                      <span style="cursor:pointer"><span class="linkstate-off"></span><span class="txt-white">断开</span></span>
	                 </div>
	            </div>
	            <div class="tab-content-searchlist"> 
		               <span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >刷新页面</a></span></span></span>
		               <span id="monitorOperate" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >批量操作</a><a class="down"></a></span></span></span>
		               <span id="alarmSettings" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >告警设置</a></span></span></span>
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
		               <input type="text" id="searchMonitorLink" value="" /><span id="searchMonitorLinkBut" class="ico"></span>
		               <input id="showHostLink" type="checkbox" value="showHostLink"/><span class="txt-white">显示连接主机的链路</span>>
                    </div>
               </div>
               			 <div class="clear"></div>
                            <page:applyDecorator name="indexcirgrid">  
                                  <page:param name="id">linkMonitorTable</page:param>
                                  <page:param name="width">100%</page:param>
                                  <page:param name="height">100%</page:param>
                                  <page:param name="tableCls">grid-gray</page:param>
                                  <page:param name="gridhead"><s:property value="titleJson" escape="false" /></page:param>
                                                              <page:param name="gridcontent"><s:property value="gridJson" escape="false" /></page:param>
                            </page:applyDecorator>	  
          <div id="pageLinkMonitor">
          </div>
<script>
Monitor.Resource.right.linkMonitorList.pointId = '<s:property value="pointId"/>';
Monitor.Resource.right.linkMonitorList.pointLevel = '<s:property value="pointLevel"/>';
Monitor.Resource.right.linkMonitorList.monitor = '<s:property value="monitor"/>';
Monitor.Resource.right.linkMonitorList.whichTree = '<s:property value="whichTree"/>';
Monitor.Resource.right.linkMonitorList.whichGrid = '<s:property value="whichGrid"/>';
Monitor.Resource.right.linkMonitorList.currentTree = '<s:property value="currentTree"/>';
Monitor.Resource.right.linkMonitorList.currentResourceTree = '<s:property value="currentResourceTree"/>';
Monitor.Resource.right.linkMonitorList.widthJson = <s:property value="widthJson" escape="false" />;
Monitor.Resource.right.linkMonitorList.currentPage = '<s:property value="currentPage"/>';
Monitor.Resource.right.linkMonitorList.pageSize = '<s:property value="pageSize"/>';
Monitor.Resource.right.linkMonitorList.monitorTitile = '<s:property value="monitorTitle"/>';
Monitor.Resource.right.linkMonitorList.monitorCount = '<s:property value="monitorCount"/>';
Monitor.Resource.right.linkMonitorList.noMonitorCount = '<s:property value="noMonitorCount"/>';
Monitor.Resource.right.linkMonitorList.noMonitorTiitle = '<s:property value="noMonitorTitle"/>';
</script>

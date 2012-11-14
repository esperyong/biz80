<!-- 监控列表  gridMonitor.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<div id="lampDiv" name="isSearch"
     ><div class="tab-content-searchlist"
           ><div
                ><div class="left f-relative">
	                      <span style="cursor:pointer"><span class="lamp lamp-green" whichState="green" lamp="lamp"></span><span class="txt-white" whichState="green">：<s:property value="greenCountStr"/></span></span>
	                      <span style="cursor:pointer"><span class="lamp lamp-greenblack" whichState="greenblack" lamp="lamp"></span><span class="txt-white" whichState="greenblack">：<s:property value="greenBlackCountStr"/></span></span>
	                      <span style="cursor:pointer"><span class="lampshine-blackbg-ico lampshine-blackbg-ico-greenred" whichState="greenred" lamp="lamp"></span><span class="txt-white" whichState="greenred">：<s:property value="greenRedCountStr"/></span></span>
	                      <span style="cursor:pointer"><span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenred" whichState="alert-greenred" lamp="lamp"></span><span class="txt-white" whichState="alert-greenred">：<s:property value="greenRedBlackCountStr"/></span></span>
	                      <span style="cursor:pointer"><span class="lampshine-blackbg-ico lampshine-blackbg-ico-greenyellow" whichState="greenyellow" lamp="lamp"></span><span class="txt-white" whichState="greenyellow">：<s:property value="greenYelCountStr"/></span> </span>
	                      <span style="cursor:pointer"><span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenyellow" whichState="alert-greenyellow" lamp="lamp"></span><span class="txt-white" whichState="alert-greenyellow">：<s:property value="greenYelBlackCountStr"/></span> </span>
	                      <span style="cursor:pointer"><span class="lampshine-blackbg-ico lampshine-blackbg-ico-greengray" whichState="greengray" lamp="lamp"></span><span class="txt-white" whichState="greengray">：<s:property value="greenWhiteCountStr"/></span>  </span>
	                      <span style="cursor:pointer"><span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greengray" whichState="alert-greengray" lamp="lamp"></span><span class="txt-white" whichState="alert-greengray">：<s:property value="greenWhiteBlackCountStr"/></span>  </span>
	                      <span style="cursor:pointer"><span class="lamp lamp-red" whichState="red" lamp="lamp"></span><span class="txt-white" whichState="red">：<s:property value="redCountStr"/></span></span>
	                      <span style="cursor:pointer"><span class="lamp lamp-gray" whichState="gray" lamp="lamp"></span><span class="txt-white" whichState="gray">：<s:property value="grayCountStr"/></span></span>
	            </div
	       ></div
	  ></div
></div
><div class="tab-content-searchlist"
	  ><div
	       ><div class="right f-relative"
	             ><span class="txt-white">说明：</span
	             ><span class="ico ico-stop" style="cursor:default"></span><span class="txt-white">未监控</span
	             ><span class="ico ico-novalue" style="cursor:default"></span><span class="txt-white">未取值</span
	             ><span class="ico ico-no-indicators" style="cursor:default"></span><span class="txt-white">无此指标</span
	       ></div
	  ></div
></div
><div class="tab-content-searchlist clear" 
	  ><span id="refresh" class="black-btn-l f-right f-relative"><span class="btn-r"><span class="btn-m"><a >刷新页面</a></span></span></span
	  ><span id="monitorOperate" class="black-btn-l f-right f-relative" style="position:relative;"><span class="btn-r"><span class="btn-m"><a >批量操作</a><a  class="down"></a></span></span></span
      ><div  name="groupOperate" class="for-inline f-right f-relative" style="position:relative;"
	        ><span id="shiftinGroup" class="black-btn-l"><span class="btn-r"><span class="btn-m"><a href="javascript:void(0)">移入资源</a></span></span></span
	        ><span id="shiftOutGroup" class="black-btn-l"><span class="btn-r"><span class="btn-m"><a href="javascript:void(0)">移出资源</a></span></span></span
	  ></div>
	  <div name="isSearch"
	       ><div class="for-inline">
		         <span class="txt-white" style="float:left;height:21px;line-height:21px;"><%=domainPageName%></span
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
		               ><input type="text" id="searchMonitor" style="width:120px;height:20px;line-height:20px;" value="请输入条件搜索" class="inputoff"/><span title="点击进行搜索" id="searchMonitorBut" class="ico"></span>
            </div
      ></div
></div
 ><div class="clear"></div>
       <page:applyDecorator name="indexcirgrid">  
             <page:param name="id">tableMonitor</page:param>
             <page:param name="width">100%</page:param>
             <page:param name="height">540px</page:param>
             <page:param name="lineHeight">27px</page:param>
             <page:param name="tableCls">grid-black</page:param>
             <page:param name="gridhead"><s:property value="titleJson" escape="false" /></page:param>
             <page:param name="gridcontent"><s:property value="gridJson" escape="false" /></page:param>
        </page:applyDecorator>	  
<div id="pageMonitor"></div>
<script type="text/javascript">
Monitor.Resource.right.monitorList.pointId = '<s:property value="pointId"/>';
Monitor.Resource.right.monitorList.grid= '<s:property value="grid"/>';
Monitor.Resource.right.monitorList.pointLevel = '<s:property value="pointLevel"/>';
Monitor.Resource.right.monitorList.monitor = '<s:property value="monitor"/>';
Monitor.Resource.right.monitorList.whichTree = '<s:property value="whichTree"/>';
Monitor.Resource.right.monitorList.whichGrid = '<s:property value="whichGrid"/>';
Monitor.Resource.right.monitorList.currentTree = '<s:property value="currentTree"/>';
Monitor.Resource.right.monitorList.currentResourceTree = '<s:property value="currentResourceTree"/>';
Monitor.Resource.right.monitorList.widthJson = <s:property value="widthJson" escape="false" />;
Monitor.Resource.right.monitorList.titleJson = <s:property value="titleJson" escape="false" />;
Monitor.Resource.right.monitorList.sortJson = <s:property value="sortJson" escape="false" />;
Monitor.Resource.right.monitorList.currentPage = '<s:property value="currentPage"/>';
Monitor.Resource.right.monitorList.pageCount = '<s:property value="pageCount"/>';
Monitor.Resource.right.monitorList.monitorTitile = '<s:property value="monitorTitle"/>';
Monitor.Resource.right.monitorList.monitorCount = '<s:property value="monitorCount"/>';
Monitor.Resource.right.monitorList.noMonitorCount = '<s:property value="noMonitorCount"/>';
Monitor.Resource.right.monitorList.noMonitorTiitle = '<s:property value="noMonitorTitle"/>';
Monitor.Resource.right.monitorList.currentUserId = '<s:property value="currentUserId"/>';
Monitor.Resource.right.monitorList.currentDomainId = '<s:property value="currentDomainId"/>';
Monitor.Resource.right.monitorList.pageName = '<s:property value="pageName"/>';
Monitor.Resource.right.monitorList.withoutSearch = '<s:property value="withoutSearch"/>';
</script>

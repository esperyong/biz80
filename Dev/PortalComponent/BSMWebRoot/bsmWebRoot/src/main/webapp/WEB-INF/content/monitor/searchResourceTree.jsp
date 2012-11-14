<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
   <form id="searchResourceForm"><input type="hidden" name="whichGrid" value="resourceGroup"/>
  	         <input type="hidden" name="currentUserId" value="<%=userId%>"/>
  	         <input type="hidden" name="isAdmin" value="<%=isAdmin%>"/>
             <input type="hidden" name="whichTree" value="searchResource"/>
             <input type="hidden" name="currentResourceTree" value="3"/>
             <input type="hidden" name="currentTree" value="0"/>
             <input type="hidden" name="monitor" value="monitor"/>
  <ul class="fieldlist-n">
    <li>
        <span>
		      <select id="domainSearch" name="domain" class="" style="width:70px;float:left;height:21px;line-height:21px;">
		               <option value="">请选择域</option>
		         <s:if test="domainMap != null && domainMap.size() > 1">
		               <option value="">全部</option>
		         </s:if>
		              <s:iterator value="domainMap" var="map"  status="stat">
                               <option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
                      </s:iterator>
		      </select> 
		</span>
    </li>
	<li style="white-space:nowrap">
	       <span>
             <select id="searchWhatSearch" name="searchWhat" style="width:55px;float:left;height:21px;line-height:21px;">
                   <option value="searchIP">IP地址</option>
                   <option value="searchName">显示名称</option>
             </select>
           </span>
        <span>
             <input type="text" id="searchSearch" name="search" style="width:90px;height:19px;line-height:19px;margin-top:-10px;*margin-top:0px;" value="请输入条件搜索" class="inputoff"/>
       </span>
    </li>
    <li>
	   <select id="pointIdSel" name="pointIdSel" style="width:125px">
	        <option value="Resource,0">请选择搜索范围</option>
		    <s:iterator value="scopeMap" var="map"  status="stat">
                 <option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
            </s:iterator>
	    </select>
	</li>
	<li class="last">
	<span title="点击进行搜索" id="searchResourceBut" class="ico" style="float:right"></span>
	</li>
	<li class="line"></li>
	<li>
	    <span class="field">共搜出：</span><span id="searchCount"></span>
	</li>
	<li>
	    <span class="field">已监控：</span><span id="searchMonitorCount"></span>
	</li>
	<li>
	    <span class="field">未监控：</span><span id="searchNoMonitorCount"></span>
	</li>
  </ul>
  </form>

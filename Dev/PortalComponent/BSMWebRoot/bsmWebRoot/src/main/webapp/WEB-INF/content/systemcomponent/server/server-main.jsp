<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.bsm.mmf.type.ResourceType"%>
<%@page import="com.mocha.bsm.system.SystemContext"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
 <style>
 #serverTree {
 	margin:-12px 0px 0px 3px;
 }
 </style>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>System Component</title>
<script type="text/javascript" src="${ctx}/js/systemcomponent/server-main.js"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript">
var RESOURCE_TYPE_ID_CMS = "<%=ResourceType.CMS.ord%>";
var RESOURCE_TYPE_ID_DCH = "<%=ResourceType.DCH.ord%>";
var RESOURCE_TYPE_ID_DMS = "<%=ResourceType.DMS.ord%>";
var RESOURCE_TYPE_NAME_CMS = "<%=ResourceType.CMS.toString()%>";
var RESOURCE_TYPE_NAME_DCH = "<%=ResourceType.DCH.toString()%>";
var RESOURCE_TYPE_NAME_DMS = "<%=ResourceType.DMS.toString()%>";
var toast = new Toast({position:"CT"});
//alert('${serverId}');
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
    <div class="h1"> <span class="bold">当前位置：</span> <span>系统架构 / 系统服务</span> </div>
    <div class="left-content">
      <div class="panel-gray">
        <div class="panel-gray-top" style="width:100%"> <span class="panel-gray-title">系统服务</span> </div>
        <div class="panel-gray-content">
          <div style="overflow:auto;height:530px;width:100%">
            <span class="ico ico-policy-child"/>系统服务
            <% if (!SystemContext.isStandAlone()) { %>
            	<s:if test="serverTree == null">
            	<span id="sp_create" class="ico ico-t-right">
            	</s:if>
            <% } %>
            </span>
            ${serverTree}
          </div>
          </div>
      </div>
    </div>
    <div id="server_right" class="right-content">
    	<s:if test='serverId!=null'>
    		<s:action name="server-info"  namespace="/systemcomponent"  executeResult="true" ignoreContextParams="true" flush="false">
				<s:param name="serverId" value="serverId"/>
			</s:action>
    	</s:if>
    	<s:else>
    	<div class="roundedform-content">
    		<table class="hundred"  height="485px"><tbody><tr>
    			<td class="nodata"><span class="nodata-l"><span class="nodata-r"><span class="nodata-m"> 
    				<span class="icon">当前无数据</span> </span></span></span>
    			</td>
    		</tr></tbody></table>
    	</div>
    	</s:else>
    </div>
    
  </div>
  <div class="bottom-l">
    <div class="bottom-r">
      <div class="bottom-m"> </div>
    </div>
  </div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
 <link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
 <style>
 #agentTree {
 	margin:-12px 0px 0px 3px;
 }
 </style>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<title>System Component</title>
</head>
<body>
<div class="manage-content">
  <div class="top-l">
    <div class="top-r">
      <div class="top-m"> </div>
    </div>
  </div>
  <div class="mid">
    <div class="h1"> <span class="bold">当前位置：</span> <span>系统架构 / Agent</span> </div>
    <div class="left-content">
      <div class="panel-gray">
        <div class="panel-gray-top" style="width:100%"><span class="panel-gray-title">Agent</span> </div>
        <div class="panel-gray-content">
          <div style="overflow:auto;height:530px;width:100%">
            <span class="ico ico-policy-child"/><span>Agent</span><span class="ico ico-t-right" id="openMenu"/>
            ${agentTree}
          </div>
          <!-- <span class="search-ico"></span><span class="bold">检索</span> -->
          </div>
      </div>
    </div>
    <div id="agent_right" class="right-content">
    	<s:if test='agentId!=null'>
    		<s:action name="agent-info"  namespace="/systemcomponent"  executeResult="true" ignoreContextParams="true" flush="false">
				<s:param name="agentId" value="agentId"/>
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
<script type="text/javascript" src="${ctx}/js/systemcomponent/agent-main.js"></script>
</body>
</html>
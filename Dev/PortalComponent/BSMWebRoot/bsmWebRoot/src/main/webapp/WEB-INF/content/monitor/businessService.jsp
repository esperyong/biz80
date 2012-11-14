<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONString"%>
<%@page import="org.apache.struts2.json.JSONResult"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/common/meta.jsp" %>
	<title>业务服务</title>
	<style type="text/css">
	.span_dot_shot{width:125px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
	</style>
</head>
<body>
<s:if test="businessServiceList == null || businessServiceList.size() ==  0">
   <div class="grid-black" style="height:200px;">
	  <div class="formcontent" style="height:200px;">
	    <table style="height:200px;width:100%;">
	      <tbody>
	        <tr>
	         <td class="nodata vertical-middle" style="text-align:center;">
	           <span class="nodata-l">
	              <span class="nodata-r">
	                <span class="nodata-m"> <span class="icon">当前资源未关联任何业务服务</span> </span>
	              </span>
	            </span>
            </td>
          </tr>
	      </tbody>
	    </table>
	  </div>
	</div>
</s:if>
<s:else>
<ul class="fieldlist-n">
    <li><span class="suojin bold span_dot_long">关联业务服务</span></li>
    <li class="line"></li>
</ul>
<div style="height:300px;overflow:auto">
<ul class="fieldlist-n">
	<s:iterator value="businessServiceList" var="businessService" status="status">
	    <li><s:property value="#businessService" escape="false"/></li>
   </s:iterator>
</ul>
</div>
</s:else>
<script type="text/javascript">
var path = "<%=request.getContextPath()%>";
$(document).ready(function() {
     $("span[name='bussinessServiceSpan']").click(function() {
     	var url = $(this).attr('path');
        winOpen({url:url,width:1080,height:626,name:'businessService'});
     });
});
</script>
</body>
</html>
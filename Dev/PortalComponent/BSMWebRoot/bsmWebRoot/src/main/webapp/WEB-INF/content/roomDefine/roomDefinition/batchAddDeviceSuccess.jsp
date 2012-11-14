<!-- 机房-机房定义-监控设置 monitorSetInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>   
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	String roomId = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && "true".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
		if(vs.findValue("roomId") != null){
			roomId = (String)vs.findValue("roomId");
		}
	}
%>
</head>

  <body>
	<s:form id="batchAddDeviceSuccessformID" action="" name="batchAddDeviceSuccessForm" method="post" namespace="/roomDefine" theme="simple">
  	<input type="hidden" name="roomId" value="<%=roomId%>" />
  	<input type="hidden" name="saveFlag" value="<%=saveFlag%>" />
  	</s:form>
<script>
$(document).ready(function() {
	if("<%=saveFlag%>" != null && "<%=saveFlag%>" != "") {
		$("#batchAddDeviceSuccessformID").attr("action","${ctx}/roomDefine/IndexVisit.action");
		$("#batchAddDeviceSuccessformID").submit();
	}
});
</script>

  </body> 


</html>
<script type="text/javascript">




</script>
<!-- 机房-机房定义-监控设置-状态定义 stateDefineTab.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>状态定义</title>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	String roomId = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
		if(vs.findValue("roomId") != null && !"".equals(vs.findValue("roomId"))){
			roomId = (String)vs.findValue("roomId");
		}
	}
%>  
</head>
<script>
if("<%=saveFlag%>" != "" && "<%=saveFlag%>" == "true") {
	try{
		parent.window.ajaxChangeTabPageVisitFun("tab3","<%=roomId%>");
		parent.window.toast.addMessage("应用成功");
		
	}catch(e){
	}
}
</script>
  <body>

    <s:form id="stateDefineFormID" action="" name="StateDefineTabForm" method="post" namespace="/roomDefine" theme="simple">
	<div style="background-color:#F2F2F2;width:100%"><span class="ico ico-note"></span><span>机房环境指标状态和机房设施状态影响机房整体状态。</span></div>
	<div class="clear">
		<ul>
			<li><img src="${ctxImages}/hong.gif" width="13" height="13" />异常
			<span>：<input type="checkbox" name="stateDefineSet" value="statusResource" 
			<s:if test="statusResource=='all'">checked="checked"</s:if> disabled="true"/>任一机房设施状态异常</span>
			</li>
			<li>
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			<input type="checkbox" name="stateDefineSet" value="statusMetric"
				<s:if test="statusMetric=='all'">checked="checked"</s:if>  />任一机房环境指标异常
			</li>
			
		</ul>
		<ul>
			<li><img src="${ctxImages}/lv.gif" width="13" height="13" /> <span
				class="field-max" style="width:200px" >正常：不符合异常则状态为正常</span></li>
		</ul>
		<ul class="panel-button">
			<li><span></span><a  onclick="submitStateDefineFun();">应用</a></li>
	    </ul>
	</div>
	<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId'/>">
	</s:form>
  </body> 
</html>

<script type="text/javascript">
function submitStateDefineFun(){
	$("#stateDefineFormID").attr("action","${ctx}/roomDefine/UpdateStateDefine.action");
	$("#stateDefineFormID").attr("target","submitIframe");
	$("#stateDefineFormID").submit();
}
</script>
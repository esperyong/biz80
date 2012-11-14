<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.mdcl.mocha.bpm.manager.conf.WebFrameListenerConfig"%>
<%@ include file="/modules/common/security.jsp"%>
<%
	String itpm_ip = WebFrameListenerConfig.getInstance().getConfig("itpm_ip");
	String itpm_port = WebFrameListenerConfig.getInstance().getConfig("itpm_port");
	
	//URL.
	String url="http://"+itpm_ip+":"+itpm_port+"/HQ/myportal/HQ/__ac0x3itpmMyWorkAction0x2do/__cm101/__ws0x3HQ/__tprender/__frframe?method=itpmMyWorkIndex";
%>
<IFRAME width='100%' height=620  FRAMEBORDER=0  name="SUBMIT" scrolling=no src="<%=url%>"></IFRAME>
    
<script language="javascript">
 var frameObj = parent.document.getElementById("isBsmContent");
 if(frameObj!= null) {
 	frameObj.height="620";
 }
</script>  
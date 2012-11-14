<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.mdcl.mocha.bpm.manager.conf.WebFrameListenerConfig"%>
<%
	String itpm_ip = WebFrameListenerConfig.getInstance().getConfig("itpm_ip");
	String itpm_port = WebFrameListenerConfig.getInstance().getConfig("itpm_port");
	
	//URL.
	String url="http://"+itpm_ip+":"+itpm_port+"/HQ/myportal/__ac0x3jsp0x3documentation0x3processTail0x2jsp/__cm101/__ws0x3HQ/__tprender/__frframe?BoInsId=";
	url += request.getParameter("boInsId");
%>
  
<script language="javascript">
this.location.href="<%=url%>";
</script>  


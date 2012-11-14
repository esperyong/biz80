<%
	String ip = com.mdcl.mocha.bpm.manager.conf.WebFrameListenerConfig.getInstance().getConfig("itpm_ip");
	String port = com.mdcl.mocha.bpm.manager.conf.WebFrameListenerConfig.getInstance().getConfig("itpm_port");
	String url = "http://"+ip+":"+port+"/HQ/myportal/HQ/__ac0x3itpmMyWorkAction0x2do/__cm101/__ws0x3HQ/__tprender/__frframe?method=staytowork"; 
	//response.sendRedirect(url);
%>
<script>
location.href = "<%=url %>";
</script>
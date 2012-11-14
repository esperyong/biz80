<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page errorPage = "" %>
<jsp:directive.page import="com.mocha.bsm.profile.reload.ReloadLog4j"/>

<%
	String path = request.getContextPath();
	String result1 = "";
	boolean result = ReloadLog4j.getInstance().resetLogConfig();
	if (result) {
		result1 = "Success!";
	} else {
		result1 = "Failure!";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
<h1>Mocha BSM Configuration</h1>
<br/>
<h3>Log4j Configuration</h3>
&nbsp;&nbsp;&nbsp;&nbsp;
<span id="result1"><font color="red"><strong><%=result1%></strong></font></span>
</body>
</html>

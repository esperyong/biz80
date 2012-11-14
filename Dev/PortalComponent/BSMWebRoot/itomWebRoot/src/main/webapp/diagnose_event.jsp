<%@page import="com.mocha.bsm.itomevent.event.ItpmEventPool"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@page import="com.mocha.dev.ReqRes"%>
<%
	ReqRes rr = new ReqRes(request, response);
	rr.encoding("UTF-8").nocache().security();
	String eventId = rr.param("eventId", null);
	if(eventId != null) {
		ItpmEventPool.push_Resource(eventId, null);
		out.println("push resource eventId="+eventId+"<br>");
	}
%>
<form name='form1' method='post' action='diagnose_event.jsp'>
eventId:<input name="eventId" value="" size="40"><br>
<input type='submit' value=' (submit) '>
</form>
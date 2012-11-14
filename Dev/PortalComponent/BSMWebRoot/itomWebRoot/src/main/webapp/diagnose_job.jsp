<%@page import="com.mocha.bsm.itomevent.event.ItpmEventPool"%>
<%@page import="com.mocha.bsm.itomevent.thread.ThreadManager"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<%@page import="com.mocha.dev.Quartz"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<jsp:directive.page import="com.mocha.bsm.itom.job.JobFactory"/>
<jsp:directive.page import="com.mocha.bsm.itom.event.ItomEventWorker"/>


<%
	SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

	Quartz quartz = JobFactory.getInstance().getQuartz();
	if(quartz != null){
		int size = quartz.size();
		boolean running = quartz.running();
%>
Quartz Info:running=<%=running%>, threadsize=<%=size%><br>
<table border='1'>
<tr>
	<td>index</td>
	<td>Running</td>
	<td>nextFireTime</td>
	<td>DateExpected</td>
	<td>DateExecute</td>
	<td>DateEnd</td>
	<td>expression</td>
	<td>jobName</td>
</tr>
<%
	Quartz.MetaJob[] jobs = quartz.getMeta();
	for(int i=0;i<jobs.length;i++){
		Quartz.MetaJob m = jobs[i];
		%>
			<tr>
				<td><%=(i+1) %></td>
				<td><%=m.running %></td>
				<td><%=(m.next != null)? df.format(m.next) :"-" %></td>
				<td><%=(m.dateExpecte != null)? df.format(m.dateExpecte) :"-" %></td>
				<td><%=(m.dateExecute != null)? df.format(m.dateExecute) :"-" %></td>
				<td><%=(m.dateEnd != null)? df.format(m.dateEnd) :"-" %></td>
				<td><%=m.expression %></td>
				<td><%=m.jobName %></td>
			</tr>
		<%
	}
%>
</table>
<%}else{out.print("Itom Job 没有启动！");} %>
<hr>
Itpmcall Info:
<table border='1'>
<tr>
	<td>SetItpmOrItom</td>
	<td>Module_Itpm</td>
	<td>Module_Itom</td>
	<td>Itpm_pool_size</td>
	<td>Itom_pool_size</td>
</tr>
<tr>
	<td><%=ThreadManager.getInstance().isRunning() %></td>
	<td><%=ItpmEventPool.itpm %></td>
	<td><%=ItpmEventPool.itom %></td>
	<td>
	<%=//ItpmEventWorker.getInstance().getItpmPool().size() %>
	</td>
	<td>
	<%=ItomEventWorker.getInstance().getItpmPool().size() %>
	</td>
</tr>
</table>
<hr>
<table border='1'>
  <tr>
    <td>Name</td>
    <td>Running</td>
    <td>InterVal</td>
    <td>StartTime</td>
    <td>LastRunTime</td>
    <td>RunTimes</td>
  </tr>
  <%if(ItomEventWorker.getInstance().getItomTime1() != null){ %>
  <tr>
    <td><%=ItomEventWorker.getInstance().getItomTime1().getName() %></td>
    <td><%=ItomEventWorker.getInstance().getItomTime1().isRunning() %></td>
    <td><%=ItomEventWorker.getInstance().getItomTime1().getInterval() %>(ms)</td>
    <td><%=df.format(new Date(ItomEventWorker.getInstance().getItomTime1().getStartTime())) %></td>
    <td><%=df.format(new Date(ItomEventWorker.getInstance().getItomTime1().getLastRunTime())) %></td>
    <td><%=ItomEventWorker.getInstance().getItomTime1().getRunTimes() %></td>
  </tr>
  <%} %>
  <%if(ItomEventWorker.getInstance().getItomTime2() != null){ %>
    <tr>
    <td><%=ItomEventWorker.getInstance().getItomTime2().getName() %></td>
    <td><%=ItomEventWorker.getInstance().getItomTime2().isRunning() %></td>
    <td><%=ItomEventWorker.getInstance().getItomTime2().getInterval() %>(ms)</td>
    <td><%=df.format(new Date(ItomEventWorker.getInstance().getItomTime2().getStartTime())) %></td>
    <td><%=df.format(new Date(ItomEventWorker.getInstance().getItomTime2().getLastRunTime())) %></td>
    <td><%=ItomEventWorker.getInstance().getItomTime2().getRunTimes() %></td>
  </tr>
  <%} %>
</table>



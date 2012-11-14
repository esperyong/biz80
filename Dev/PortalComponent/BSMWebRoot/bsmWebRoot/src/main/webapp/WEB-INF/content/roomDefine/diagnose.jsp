
<%@page import="com.mocha.bsm.room.mgr.RoomMgr"%>
<%@page import="com.mocha.dev.Quartz"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mocha.dev.ThreadPool"%>
<%@page import="java.util.Date"%>


<%
	SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

	Quartz quartz = RoomMgr.getInstance().getQuartz();
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
<hr>
<%
	ThreadPool pool = RoomMgr.getInstance().getThreadPool();
	size = pool.size();
	running = pool.running();
%>
ThreadPool Info:running=<%=running%>, threadsize=<%=size%><br>
<table border='1'>
<tr>
	<td>index</td>
	<td>starttime</td>
	<td>classname</td>
</tr>
<%
	ThreadPool.MetaThread[] ts= pool.getMeta();
	for(int i=0;i<ts.length;i++){
		%>
		<tr>
			<td><%=(i+1) %></td>
			<td><%=df.format(new Date(ts[i].starttime)) %></td>
			<td><%=ts[i].className %></td>
		</tr>
		<%
	}
%>
</table>
<hr>
<%
	int[] poolsize = RoomMgr.getInstance().size();
%>
Metric to fetch(size=<%=poolsize[0]%>)<br>
MetricValue to process(size=<%=poolsize[1]%>)<br> 
To persisent(size=<%=poolsize[2]%>)
 

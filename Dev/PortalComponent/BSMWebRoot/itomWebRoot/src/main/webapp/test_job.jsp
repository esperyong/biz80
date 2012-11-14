<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="java.util.ResourceBundle"/>
<jsp:directive.page import="java.util.Enumeration"/>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="org.quartz.JobDetail"/>
<jsp:directive.page import="org.quartz.CronTrigger"/>
<jsp:directive.page import="com.mocha.bsm.itom.job.JobFactory"/>
<jsp:directive.page import="com.mocha.dev.Quartz"/>
<jsp:directive.page import="java.util.Date"/>
<%
	ReqRes rr = new ReqRes(request, response);
	rr.encoding("UTF-8").nocache().security();

	String properties_File = rr.param("properties_File", null);
	String job_Prefix = rr.param("job_Prefix", null);
	String init = rr.param("init", "true");
	String class_name = rr.param("class_name", null);
	String new_expression = rr.param("new_expression", null);
	String input_err = null;
	boolean flag = false;

	if(rr.equals("false", init)){
		if(!rr.empty(class_name) && !rr.empty(new_expression)){
			try{
				Quartz quartz = JobFactory.getInstance().getQuartz();
				quartz.deleteJob(class_name, null);

				Class clazz = Class.forName(class_name);
				JobDetail jobDetail = new JobDetail();
				jobDetail.setJobClass(clazz);
				jobDetail.setName(class_name);

				CronTrigger trigger = new CronTrigger();
				trigger.setCronExpression(new_expression);
				trigger.setStartTime(new Date());
				trigger.setName(class_name);
				quartz.scheduleJob(jobDetail, trigger);

				flag = true;
			}catch(Exception e){
			}
		}else{
			input_err = "输入不能为空！";
		}
	}
%>
<html>
<head>
<titel></titel>
</head>
<body>
	<form action="" name="formname" target="" method="post">
		<center>
		<input name="init" type="hidden" value="<%if(!rr.empty(init)){out.print(init);} %>">
		资源文件名：<input name="properties_File" type="text" value="<%if(!rr.empty(properties_File)){out.print(properties_File);} %>">&nbsp;&nbsp;&nbsp;&nbsp;
		Job前缀：<input name="job_Prefix" type="text" value="<%if(!rr.empty(job_Prefix)){out.print(job_Prefix);} %>">&nbsp;&nbsp;&nbsp;&nbsp;
		<img src="sousuo.gif" width="18" height="18" valign="absmiddle" onclick="sousuo();">
		<hr>
		<%
		if(rr.equals("false", init)){
			if(rr.empty(properties_File) || rr.empty(job_Prefix)){
				out.print("输入不能为空！");
			}else{
		%>
		<table border='1'>
			<tr>
				<td>JobName</td>
				<td>CronExpression</td>
			</tr>
			<%
			ResourceBundle bundle = ResourceBundle.getBundle(properties_File);
			Enumeration keys = bundle.getKeys();
			while (keys.hasMoreElements()) {
				String classname = (String) keys.nextElement();
				String expression = bundle.getString(classname);
				if(!classname.startsWith(job_Prefix)) { //跳过非job key
					continue;
				}
			%>
			<tr>
				<td><%=classname %></td>
				<td><%=expression %></td>
			</tr>
			<%
			}
			%>
		</table>
		<hr>
		Job名称：<input name="class_name" type="text" value="<%if(!rr.empty(class_name)){out.print(class_name);} %>">&nbsp;&nbsp;&nbsp;&nbsp;
		触发时间：<input name="new_expression" type="text" value="<%if(!rr.empty(new_expression)){out.print(new_expression);} %>">&nbsp;&nbsp;&nbsp;&nbsp;
		<img src="sousuo.gif" width="18" height="18" valign="absmiddle" onclick="doSubmit();"><br>
		<%
				if(!rr.empty(input_err)){
					out.print(input_err);
				}else if(flag){
					out.print("Job 更新成功！");
				}else{
					out.print("Job 更新失败！");
				}
			}
		}
		%>
		</center>
	</form>
</body>
<script>
function sousuo(){
	document.formname.init.value = "false";
	document.formname.submit();
}

function doSubmit(){
	document.formname.submit();
}
</script>
</html>
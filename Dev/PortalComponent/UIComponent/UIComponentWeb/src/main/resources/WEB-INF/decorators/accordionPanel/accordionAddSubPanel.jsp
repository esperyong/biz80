<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<decorator:usePage id="panel" />
<%
	String [] keys = panel.getPropertyKeys();
	int topbtnCount = 0;
	for(int i=0;i<keys.length;i++){
		String key = keys[i];
		if(key.indexOf("topBtn_Index")!=-1){
			topbtnCount++;
		}
	}
	boolean isFloat = Boolean.valueOf(panel.getProperty("float"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

<div class="<%=panel.getProperty("cls") %>" id="<%=panel.getProperty("id") %>" style="width:<%=panel.getProperty("width") %>">
	<div class="fold-top">
		
		<span class="ico ico-<%if("collect".equals(panel.getProperty("display"))){out.print("plus");}else{out.print("minus");} %> left"></span>
		<span class="fold-top-title left"><%=panel.getProperty("title") %></span>
		    <%
		    	for(int i=1;i<=topbtnCount;i++){
		    %>
	    <span class="black-btn-l  f-right" id="<%=panel.getProperty("topBtn_Id_"+i) %>"  style="margin-top: -2px;">
				<span class="btn-r">
					<span class="btn-m"><a><%=panel.getProperty("topBtn_Text_"+i) %></a></span>
				</span>
		</span>
		    <%
		    	}
		    %>
	</div>
	<%
		String display = panel.getProperty("display");
		String height = panel.getProperty("height");
		String dis_ = "display:block;";
		if("collect".equals(display)){
			height="0";
			dis_ = "display:none;";
		}else{
			height=panel.getProperty("height");
		}
	%>
	<div class="fold-content <%=isFloat?"f-relative":""%>" height="<%=panel.getProperty("height") %>" style="height:<%=height %>;<%=dis_ %>;" state="<%="collect".equals(display)?"collect":"expend"%>">
	  <decorator:getProperty property="content"/>
	</div>
</div>
</body>
</html>
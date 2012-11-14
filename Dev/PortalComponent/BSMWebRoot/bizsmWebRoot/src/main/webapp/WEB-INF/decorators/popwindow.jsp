<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<decorator:head></decorator:head>
<title><decorator:title default="" /></title>
<decorator:usePage id="p" />
<%
	String [] keys = p.getPropertyKeys();
	List<String> tblist  = new ArrayList<String>(); 
	List<String> bblist  = new ArrayList<String>(); 
	for(int i=0;i<keys.length;i++){
		String key = keys[i];
		
		if(key.indexOf("bottomBtn_index")!=-1){
			bblist.add(p.getProperty("bottomBtn_index_" + i));
		}
		if(key.indexOf("topBtn_index")!=-1){
			tblist.add(p.getProperty("topBtn_index_" + i));
		}
	
	}
	
%>
</head>
<!-- manually attach allowOverflow method to pane --> 
<body  class="pop-window" >
<div class="pop" style="width:<decorator:getProperty property="width" />;">
	<div class="pop-top-l">
		<div class="pop-top-r">
			<div class="pop-top-m">
			<% for(int i = 1; i <= tblist.size(); i ++){ %>
				<a class="<%=p.getProperty("topBtn_css_" + i) %>" id="<%=p.getProperty("topBtn_id_" + i)%>"></a>
			  <%}%>
			  <span class="pop-top-title"><decorator:getProperty  property="title" default="&nbsp;"/><!-- 弹出窗口标题 --></span>
			</div>
		</div>
	</div>
	<div class="pop-m">
		<div class="pop-content" style="height:<decorator:getProperty property="height" />;" >
			<decorator:getProperty property="content" />
		</div>  
	</div>
	<div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">
			<%if( bblist != null && !bblist.isEmpty()) {%>
			   <% for(int i = 0; i < bblist.size(); i ++){ %>
			   <span class="win-button">
				   <span class="win-button-border">
				   <a id="<%=p.getProperty("bottomBtn_id_" + (bblist.size()-i)) %>"><%=p.getProperty("bottomBtn_text_" +  (bblist.size()-i)) %></a></span>
			   </span>
			  <%}%>
			<%}	%>
			</div>
		</div>
	</div>
</div>
</body>
</html>

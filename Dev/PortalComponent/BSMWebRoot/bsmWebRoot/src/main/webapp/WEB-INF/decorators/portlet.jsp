<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<decorator:head></decorator:head>
<title><decorator:title default="" /></title>
<decorator:usePage id="p" />
<%
	String [] keys = p.getPropertyKeys();
	List<String> tblist  = new ArrayList<String>(); 
	List<String> bblist  = new ArrayList<String>(); 
	for(int i=0;i<keys.length;i++){
		String key = keys[i];
		if(key.indexOf("topBtn_index")!=-1){
			tblist.add(p.getProperty("topBtn_index_" + i));
		}
	
	}
	
%>
</head>
<!-- manually attach allowOverflow method to pane --> 
<body  class="pop-window" background="black" style="background:#000;">
<div class="roundedform" style="width:<decorator:getProperty property="width" />;">
		<div class="roundedform-top">
		<div class="top-right">
		  <div class="top-min">
				<table class="hundred"><thead>
				<tr>
				<th class="f-relative">
				
				
				<% for(int i = 1; i <= tblist.size(); i ++){ 
				String title = p.getProperty("topBtn_title_" + i);
				if(title != null && !title.equals("")){
					title = "title=\""+title+"\"";
				}
			%>
				<a class="<%=p.getProperty("topBtn_css_" + i) %>" style="<%=p.getProperty("topBtn_style_" + i) %>" id="<%=p.getProperty("topBtn_id_" + i)%>" <%=title %> ></a>
			  <%}%>
				<!-- <span class="ico-21 ico-21-setting right f-absolute" style="right:0;top:0"></span>  -->
				<div class="theadbar">
				        
				<div class="theadbar-name">
					<div id=title_div class="bold"><decorator:getProperty  property="title" default=""/></div>
				</div>
				  </div></th></tr>
				  </thead>
				 </table>
			</div>
		</div>
	</div>
	<div >
		<div style="height:<decorator:getProperty property="height" />;<decorator:getProperty property="style" />" >
			<decorator:getProperty property="content" />
		</div>  
	</div>
	<div class="roundedform-bottom">
		<div class="bottom-right">
			<div class="bottom-min"></div>
		</div>
	</div>
</div>
</body>
</html>

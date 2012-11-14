<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--
    	横向的阈值显示装饰器
     --%>
    <%@page import="org.apache.commons.lang.StringUtils"%>
	<%@ include file="/WEB-INF/common/taglibs.jsp"%>
    <decorator:usePage id="p" />
    <%
	String [] keys = p.getPropertyKeys();
    String unit = "%";

    if(null != p.getProperty("unit")){
    	unit = p.getProperty("unit");
    }
	
	String red_value= p.getProperty("red_value") == null ? "" : p.getProperty("red_value");
	String red_height="66%";
	
	String yellow_value= p.getProperty("yellow_value") == null ? "" : p.getProperty("yellow_value");
	String yellow_height="33%";

	if(unit.equals("%")){
		if(StringUtils.isNotBlank(red_value) && StringUtils.isNumeric(red_value)){
			red_height = red_value + "%";
		}
		
		if(StringUtils.isNotBlank(red_value) && StringUtils.isNumeric(yellow_value)){
			yellow_height = yellow_value + "%";
		}

	}
%>
<div class="cue-min-h">
	<%if(!unit.equals("%")){ %>
    <div class="limit limit-green"></div>
    <%} %>
	<div class="cue-content">
		<span class="cue-min-green" style="width:<%=yellow_height%>">
			<span class="cue-min-h-note cue-min-h-note-yellow" style="right:0px;"><%=yellow_value%><%=StringUtils.isBlank(red_value)?"":unit%></span></span>
		<span class="cue-min-yellow" style="width:<%=red_height%>">
			<span class="cue-min-h-note cue-min-h-note-red" style="right:-22px;"><%=red_value%><%=StringUtils.isBlank(red_value)?"":unit%></span></span>
	    <span class="cue-min-red"><span style="position:absolute;"></span></span>
	</div>
	 <%if(!unit.equals("%")){ %>
	 <div class="limit limit-red"></div>
	 <%} %>
</div>
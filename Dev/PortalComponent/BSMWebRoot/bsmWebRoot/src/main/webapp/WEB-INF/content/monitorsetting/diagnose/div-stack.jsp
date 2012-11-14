<%-- 弹出层:选择部门树 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String str = request.getParameter("value");
	out.println(str.replace(",","</br>"));
%>
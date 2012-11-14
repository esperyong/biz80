<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<decorator:usePage id="gridpage" />
<%
	String title = StringUtils.defaultString(gridpage.getProperty("title"));
	String content = StringUtils.defaultString(gridpage.getProperty("content"));
%>
<div class="panel" style="width:70%;">
	<div class="panel-top-l">
		<div class="panel-top-r">
			<div class="panel-top-m">
				<span class="pop-top-title"><%=title %></span>
			</div>
		</div>
	</div>
<div class="panel-m">
	<div class="panel-m-content"><%=content %></div>
</div>
<div class="panel-bottom-l"><div class="panel-bottom-r"><div class="panel-bottom-m"></div></div></div>
</div>

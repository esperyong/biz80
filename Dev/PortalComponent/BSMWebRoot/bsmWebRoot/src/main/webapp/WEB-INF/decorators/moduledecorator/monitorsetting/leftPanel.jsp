<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<decorator:usePage id="gridpage" />
<%
	String title = StringUtils.defaultString(gridpage.getProperty("title"));
	String content = StringUtils.defaultString(gridpage.getProperty("content"));
%>
<div class="panel" style="width:99%;margin-bottom: 10px;">
	<div class="panel-top-l">
		<div class="panel-top-r">
			<div class="panel-top-m">
				<span class="pop-top-title left"><%=title %></span><span style="margin-top: -3px;margin-bottom: 4px;">&nbsp;</span>
			</div>
		</div>
	</div>
<div class="panel-m" style="width:100%;">
	<div class="panel-m-content"><%=content %></div>
</div>
<div class="panel-bottom-l"><div class="panel-bottom-r"><div class="panel-bottom-m"></div></div></div>
</div>

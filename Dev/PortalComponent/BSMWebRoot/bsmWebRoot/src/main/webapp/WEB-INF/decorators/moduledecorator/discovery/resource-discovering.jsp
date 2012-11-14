<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<decorator:usePage id="gridpage" />
<%
String insertContent = StringUtils.defaultString(gridpage.getProperty("insertContent"));
String timeField = StringUtils.defaultString(gridpage.getProperty("timeField"));
String resultField = StringUtils.defaultString(gridpage.getProperty("resultField"));
%>
<div class="fold-content">
  	<div class="border-bottom">
		<div class="find-center"><img id="imgLoading" src="${ctx}/images/loading.gif" width="32" height="32" vspace="6" /><br />
          		<span id="spLoading">0%</span></div>
	</div>
	<%=insertContent %>
	<div class="h3" id="dis_time_div">
		<div class="f-right">
			<span><%=timeField %>：<span id="compact">00:00:00</span></span>
			<!-- 导出Excel暂时不做 -->
			<!-- span class="ico ico-excel"></span> -->
		</div>
		<span class="bold" id="resultFont"><%=resultField %>：</span>
		<span id="sp_disc_result">&nbsp;</span>
	</div>
	<iframe id="iframe_discovery" name="iframe_discovery" scrolling="no" frameborder="0" marginheight="0" marginwidth="0" width="100%" height="0"></iframe>
</div>
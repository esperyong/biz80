<!-- WEB-INF\content\location\view\relation-map.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:if test="#request.locationFile!=null">
	<img width="830" height="500" id="picture" src="${ctx}/location/relation/electricityMap!downloadPicture.action?location.locationId=${location.locationId}"/>
</s:if>
<s:else>
没有布电图
</s:else>
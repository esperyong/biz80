<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<s:iterator  var="childResIns" value="childResourceInstance"  status="stat">
		<s:iterator value="#childResIns" var="child" status="st0">
		  <s:if test="#st0.index!=0">
		  		<li  class="left-menu">
		  					 <span>&nbsp;&nbsp;&nbsp;</span>
		  					 <input type="checkbox" value="<s:property value="#child.split(',')[0]" />" onclick="choiceSingleResourceInstance(this)"/>
						     <input type="hidden" id="<s:property value="#child.split(',')[0]" />_${sign}" value="<s:property value="#childResIns[0].split(',')[0]" />"/>
						     <span><s:property value="#child.split(',')[1]" /></span>
		  		</li>  			
		  </s:if>
		</s:iterator>
</s:iterator>


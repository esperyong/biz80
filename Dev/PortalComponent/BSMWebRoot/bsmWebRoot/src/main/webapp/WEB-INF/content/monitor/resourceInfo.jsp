<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源信息</title>
<style type="text/css">
.span_dot_long{width:240px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
.span_dot_shot{width:125px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
</style>
</head>
<body>
<ul class="fieldlist-n">
    <li><span class="suojin bold span_dot_long"><s:if test="instanceName=='' || instanceName==null"><s:property value="discoveryIp" /></s:if><s:else><s:property value="instanceName" /></s:else></span></li>
    <li class="line"></li>
</ul>
<ul class="fieldlist-n">
	  <li><span class="field-middle suojin bold" style="width:40%">显示名称</span><span>：</span><span class="span_dot_shot"><s:if test="instanceName=='' || instanceName==null"><s:property value="discoveryIp" /></s:if><s:else><s:property value="instanceName" /></s:else></span></li>
	  <li><span class="field-middle suojin bold" style="width:40%">资源名称</span><span>：</span><span class="span_dot_shot"><s:if test="resourceName=='' || resourceName==null">-</s:if><s:else><s:property value="resourceName" /></s:else></span></li>
	  <li><span class="field-middle suojin bold" style="width:40%">备注</span><span>：</span><span class="span_dot_shot"><s:if test="description=='' || description==null">-</s:if><s:else><s:property value="description" /></s:else></span></li>
	  <li><span class="field-middle suojin bold" style="width:40%">维护人</span><span>：</span><span class="span_dot_shot"><s:if test="userName=='' || userName==null">-</s:if><s:else><s:property value="userName" /></s:else></span></li>
	  <li><span class="field-middle suojin bold" style="width:40%">部门</span><span>：</span><span class="span_dot_shot"><s:if test="department=='' || department==null">-</s:if><s:else><s:property value="department" /></s:else></span></li>
	  <li><span class="field-middle suojin bold" style="width:40%">电话</span><span>：</span><span class="span_dot_shot"><s:if test="telphone=='' || telphone==null">-</s:if><s:else><s:property value="telphone" /></s:else></span></li>
	  <li><span class="field-middle suojin bold" style="width:40%">e-mail</span><span>：</span><span class="span_dot_shot"><s:if test="email=='' || email==null">-</s:if><s:else><s:property value="email" /></s:else></span></li>
	  <s:if test="offLineTimeInfoList == null || offLineTimeInfoList.size() == 0">
	  <li><span class="field-middle suojin bold" style="width:40%">计划不在线时间</span><span>：</span><span>-</span></li>
	  </s:if>
	  <s:else>
	  <s:iterator value="offLineTimeInfoList" var="offlineTime" status="status">
	   <li><s:if test="#status.index == 0"><span class="field-middle suojin bold" style="width:40%">计划不在线时间</span><span>：</span></s:if><s:else><span class="field-middle suojin bold" style="width:44%"></span></s:else><s:property value="#offlineTime" escape="false"/></li>
	   </s:iterator>
	  </s:else>
</ul>
</body>
</html>